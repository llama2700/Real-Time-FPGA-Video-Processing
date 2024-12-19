`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2024 02:37:31 PM
// Design Name: 
// Module Name: fifo_verif
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// heavily modified (testbench only) 
// taken from: https://vlsiverify.com/verilog/verilog-codes/asynchronous-fifo/
///////////////////////////////////////////////////////////////////////////////////

module async_fifo_verif;

  parameter DATA_WIDTH = 12;

  wire [DATA_WIDTH-1:0] data_out;
  wire full;
  wire empty;
  reg [DATA_WIDTH-1:0] data_in;
  reg w_en, wclk, wrst_n;
  reg r_en, rclk, rrst_n;
  wire [9:0] wcount, rcount;

  // Declare wdata_q as a queue
  reg [DATA_WIDTH-1:0] wdata_q[$];
  reg [DATA_WIDTH-1:0] wdata;

//  async_fifo as_fifo (
//    .rst_n(wrst_n|rrst_n),
//    .clk_write(wclk),
//    .clk_read(rclk),
//    .write(w_en),
//    .read(r_en),
//    .data_write(data_in),
//    .data_read(data_out),
//    .full(full),
//    .empty(empty),
//    .data_count_w(wcount),
//    .data_count_r(rcount)
//  );


  async_fifo #(.DATA_WIDTH(DATA_WIDTH),.FIFO_DEPTH_WIDTH(10))m0(
    .rst_n(wrst_n|rrst_n),
    .clk_write(wclk),
    .clk_read(rclk),
    .write(w_en),
    .read(r_en),
    .write_data(data_in),
    .read_data(data_out),
    .wfull(full),
    .rempty(empty),
    .data_count_w(wcount),
    .data_count_r(rcount)
  );

  always #10 wclk = ~wclk;
  always #4 rclk = ~rclk;
  
  initial begin
    wclk = 1'b0; wrst_n = 1'b0;
    w_en = 1'b0;
    data_in = 0;
    
    repeat(10) @(posedge wclk);
    wrst_n = 1'b1;

    repeat(2) begin
      for (integer i = 0; i < 30; i++) begin
        @(posedge wclk); if (!full) begin
          w_en = (i % 2 == 0) ? 1'b1 : 1'b0;
          if (w_en) begin
            data_in = $urandom % (2**DATA_WIDTH);
            wdata_q.push_back(data_in);  // Using push_back on a queue
          end
        end
      end
      #50;
    end
  end

  initial begin
    rclk = 1'b0; rrst_n = 1'b0;
    r_en = 1'b0;

    repeat(20) @(posedge rclk);
    rrst_n = 1'b1;

    repeat(2) begin
      for (integer i = 0; i < 30; i++) begin
        @(posedge rclk); if (!empty) begin
          r_en = (i % 2 == 0) ? 1'b1 : 1'b0;
          if (r_en) begin 
            wdata = wdata_q.pop_front();  // Using pop_front on a queue
            if (data_out !== wdata) begin
              $error("Time = %0t: Comparison Failed: expected wr_data = %h, rd_data = %h", $time, wdata, data_out);
            end else begin
              $display("Time = %0t: Comparison Passed: wr_data = %h and rd_data = %h", $time, wdata, data_out);
            end
          end
        end
      end
      #50;
    end

    $finish;
  end
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule