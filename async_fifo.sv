`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhi Alavilli
//
// Create Date: 12/02/2024 11:21:21 AM
// Design Name: OV7670 Camera Interface: Utility Modules
// Module Name: async_fifo
// Project Name: Real-time video DSP
// Target Devices: Urbana FPGA
// Tool Versions:
// Description: This parameterized async FIFO module is used for clock domain
// crossing in our design to cross clock domains from 100MHz "SCCB" (I2C) communiation
// with the OV7670 Camera module to the 165MHz DDR3 interface. It is also used to read
// pixel data out of DDR3 into the 25MHz VGA Pixel clock for the 640x480 VGA display
// part of the design.
//
// Dependencies: Xilinx BRAM inference template (dual port sync BRAM) used for memory
// Additional Comments:
// References:
// Design:
// http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf
// https://zipcpu.com/blog/2018/07/06/afifo.html
// https://docs.amd.com/r/en-US/ug901-vivado-synthesis/RAM-HDL-Coding-Guidelines
// Verification:
// https://vlsiverify.com/verilog/verilog-codes/asynchronous-fifo/ (testbench)
//////////////////////////////////////////////////////////////////////////////////


module async_fifo
  #( parameter  DATA_WIDTH = 12, //! Data Width
  FIFO_DEPTH_WIDTH=10 //! FIFO Depth
   )
  (
    input rst_n, //! active low reset
    input clk_write, //! clock input from input domain
    input clk_read, //! clock input from output domain
    input write, //! operation signal write
    input read, //! operation signal write
    input [DATA_WIDTH-1:0] write_data, //! write clock domain input data

    output [DATA_WIDTH-1:0] read_data, //! read clock domain output data
    output logic wfull, //! sync to write clock
    output logic rempty, //! sync to read clock
    output logic [FIFO_DEPTH_WIDTH-1:0] data_count_w, //! data spots left in FIFO (seen by write clock)
    output logic [FIFO_DEPTH_WIDTH-1:0] data_count_r //! data spots left in FIFO (seen by read clock)
  );



  localparam FIFO_DEPTH=2**FIFO_DEPTH_WIDTH; //! total depth
  logic [3:0] i; //! loop count
  logic we; //! wren for BRAM



  ////    WRITE DOMAIN      ////
  logic [FIFO_DEPTH_WIDTH:0] w_pointer = 0;   //! write pointer counter
  logic [FIFO_DEPTH_WIDTH:0] rd_pointer_sync;  //! read pointer bin sync, write clk
  logic [FIFO_DEPTH_WIDTH:0] w_gray, w_gray_next; //! write gray counter state bits
  logic [FIFO_DEPTH_WIDTH:0] rd_gray_sync;    //! read pointer sync to write clock

  // combinational
  always_comb
  begin: assign_write
    w_gray = (w_pointer >> 1) ^ w_pointer; // convert bin to gray
    w_gray_next = ((w_pointer + 1'b1) >> 1) ^ (w_pointer + 1'b1);
    we = (write && !wfull);
  end

  // sequential
  always_ff @ (posedge clk_write or negedge rst_n)
  begin: reg_write
    if (!rst_n)
    begin
      w_pointer <= 0;
      wfull <= 1'b0;
    end
    else
    begin
      if (write && !wfull) // if we can still write
      begin // increment counter and update full flag
        w_pointer <= w_pointer + 1'b1;
        wfull <= (w_gray_next == {~rd_gray_sync[FIFO_DEPTH_WIDTH:FIFO_DEPTH_WIDTH-1]
                                ,rd_gray_sync[FIFO_DEPTH_WIDTH-2:0]});  // use n-1 gray code
      end
      else // cannot write, update full flag
      begin
        wfull <= w_gray == {~rd_gray_sync[FIFO_DEPTH_WIDTH:FIFO_DEPTH_WIDTH-1]
                           ,rd_gray_sync[FIFO_DEPTH_WIDTH-2:0]};
      end
      for (i = 0; i <= FIFO_DEPTH_WIDTH; i = i + 1)
      begin
        rd_pointer_sync [i] = ^(rd_gray_sync >> i); // convert gray back to bin
      end
      // wpoint - rdpoint for data count
      data_count_w <= (w_pointer >= rd_pointer_sync) ?(w_pointer - rd_pointer_sync)
                   : (FIFO_DEPTH-rd_pointer_sync+w_pointer); // if pointer has wrapped around
    end
    end
    ////   END WRITE DOMAIN    ////



    ////        READ DOMAIN     ////
  logic [FIFO_DEPTH_WIDTH:0] w_point_sync; //! write pointer bin sync
  logic [FIFO_DEPTH_WIDTH:0] w_point_gray; //! write pointer gray sync
  logic [FIFO_DEPTH_WIDTH:0] rd_pointer = 0; //! binary read pointer
  logic [FIFO_DEPTH_WIDTH:0] rd_pointer_in; //! read pointer comb. out
  logic [FIFO_DEPTH_WIDTH:0] rd_gray, rd_gray_next; //! rd gray counter state bits

  // combinational
  always_comb
  begin: assign_read
    rd_gray = (rd_pointer >> 1) ^ rd_pointer; // convert bin pointer
    rd_gray_next = (rd_pointer + 1'b1) ^ ((rd_pointer + 1'b1) >> 1);
    rd_pointer_in = (read && !rempty) ? (rd_pointer + 1'b1) : rd_pointer;
  end

  // sequential
  always_ff @(posedge clk_read or negedge rst_n)
  begin : reg_read
    if (!rst_n) // reset: reset read pointer, assert FIFO empty
    begin
      rd_pointer <= 0;
      rempty <= 1'b1;
    end
    else
    begin
      rd_pointer <= rd_pointer_in;
      if (read && !rempty)
        rempty <= (rd_gray_next == w_point_gray); // if FIFO is empty
      else
        rempty <= rd_gray == w_point_gray;
      for (i = 0; i <= FIFO_DEPTH_WIDTH; i = i + 1)
      begin
        w_point_sync[i] <= ^(w_point_gray >> i); // convert gray back to binary
      end
      // assign read domain data count
      data_count_r <= (w_pointer >= rd_pointer_sync) ?
                   // wpoint-rdpoint for data count
                   (w_pointer-rd_pointer_sync)
                   // if pointer wraps around
                   :(FIFO_DEPTH-rd_pointer_sync+w_pointer);
    end
    end
    ////    END READ DOMAIN     ////



    ////  CLOCK DOMAIN CROSSING   ////
    // with 1 FF delay
     logic [FIFO_DEPTH_WIDTH:0] r_gray_cross; //! temp to reduce odds of metastable ff
     logic [FIFO_DEPTH_WIDTH:0] w_gray_cross; //! same for write domain
     always_ff @ (posedge clk_write)
     begin: cross_write
         r_gray_cross <= rd_gray;
         rd_gray_sync <= r_gray_cross;
     end
     always_ff @ (posedge clk_read)
     begin: cross_read
         w_gray_cross <= w_gray;
         w_point_gray <= w_gray_cross;
     end
    // END CLOCK DOMAIN CROSSING ////




    ////  CLOCK DOMAIN CROSSING   ////
    // with 0 FF delay
    // always_ff @ (posedge clk_write)
    // begin: cross_write
    //     rd_gray_sync <= rd_gray;
    // end
    // always_ff @ (posedge clk_read)
    // begin: cross_read
    //     w_point_gray <= w_gray;
    // end
    //// END CLOCK DOMAIN CROSSING ////


    ////  CLOCK DOMAIN CROSSING   ////
    // with 2 FF delay
//    logic [FIFO_DEPTH_WIDTH:0] r_gray_cross_0; //! temp0  for read domain
//    logic [FIFO_DEPTH_WIDTH:0] w_gray_cross_0; //! temp0 for write domain
//    logic [FIFO_DEPTH_WIDTH:0] r_gray_cross_1; //! temp1  for read domain
//    logic [FIFO_DEPTH_WIDTH:0] w_gray_cross_1; //! temp1 for write domain
//    always_ff @ (posedge clk_write)
//    begin: cross_write
//        r_gray_cross_0 <= rd_gray;
//        r_gray_cross_1 <= r_gray_cross_0;
//        rd_gray_sync <= r_gray_cross_1;
//    end
//    always_ff @ (posedge clk_read)
//    begin: cross_read
//        w_gray_cross_0 <= w_gray;
//        w_gray_cross_1 <= w_gray_cross_0;
//        w_point_gray <= w_gray_cross_1;
//    end
    //// END CLOCK DOMAIN CROSSING ////






  ////       FIFO MEMORY        ////

  // instantiate Xilnx dual port sync BRAM
  dual_port_sync #(.ADDR_WIDTH(FIFO_DEPTH_WIDTH) , .DATA_WIDTH(DATA_WIDTH)) m0
                 (
                   .clk_r(clk_read),
                   .clk_w(clk_write),
                   .we(we),
                   .din(write_data),
                   .addr_a(w_pointer[FIFO_DEPTH_WIDTH-1:0]), //write address
                   .addr_b(rd_pointer_in[FIFO_DEPTH_WIDTH-1:0] ), //read address - using input since bram has internal buffer
                   .dout(read_data)
                 );

endmodule

// inference template for dual port sync BRAM from Xilinx docs
module dual_port_sync
  #(
     parameter ADDR_WIDTH=11, //2K x 8, 16K BRAM
     DATA_WIDTH=8
   )
   (
     input clk_r,
     input clk_w,
     input we,
     input[DATA_WIDTH-1:0] din,
     input[ADDR_WIDTH-1:0] addr_a,addr_b, //a used to write, b used to read
     output[DATA_WIDTH-1:0] dout
   );

  logic [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
  logic [ADDR_WIDTH-1:0] addr_b_q;

  always @(posedge clk_w)
  begin
    if(we)
      ram[addr_a]<=din;
  end
  always @(posedge clk_r)
  begin
    addr_b_q<=addr_b;
  end
  assign dout=ram[addr_b_q];

endmodule