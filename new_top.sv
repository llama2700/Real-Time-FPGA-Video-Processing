`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 10:00:57 AM
// Design Name: 
// Module Name: new_top
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
// 
//////////////////////////////////////////////////////////////////////////////////


module new_top(
    input sys_Clock,
    input sys_rst_n_pin,

    // CMOS I2C
    output				sioc,	//I2C CLOCK
    inout                siod,    //I2C DATA

    // CMOS Display / Data signals
    input pclk,
    input vsync,
    input href,
    input [7:0] data_pin,
    
    // CMOS control
    output [3:0] led_pin,
    output xclk,
    output pwdn,
    output reset_pin,
    
    // VGA output
    //output h_sync,v_sync,  
    //output [3:0] R,G,B,
    
    // HDMI output
    output hdmi_tmds_clk_n,
    output hdmi_tmds_clk_p,
    output [2:0] hdmi_tmds_data_n,
    output [2:0] hdmi_tmds_data_p
    );
    wire clk_100, clk_25;
    wire sys_clk_pin;
    assign sys_clk_pin = sys_Clock;
    logic [15:0] reset = 0;
    logic rst = 0;
    
    wire full;
    wire wr;
    
    assign led_pin[0] = wr;
    assign led_pin[1] = pclk;
    assign led_pin[2] = vsync;
    assign led_pin[3] = full; //changed from href to full
    assign xclk = clk_25;
    assign pwdn = 0;
    assign reset_pin = 1;
    
    // Reset after booted
    always@(posedge sys_clk_pin) begin
        if(!sys_rst_n_pin) begin
            reset <= 0;
            rst <= 0;
        end
        else begin
        if(reset < 16'hFFFF) begin
            reset <= reset + 1'b1;
            rst <= 0;
            end
        else begin
            reset <= reset;
            rst <= 1;
            end
         
        end
    end
    ///////////////clkgen///////////////////////////////\

    clk_gen_wrapper u_clk_gen_wrapper
       (.clk_100(clk_100),
        .clk_25(clk_25),
        .clk_in1(sys_clk_pin)
        );
        
    // OV7670 Configuration
    ov7670_init u_ov7670_init
    (
        .iCLK(clk_100),		//100MHz
        .iRST_N(rst),        //Global Reset
        
        //I2C Side
        .I2C_SCLK(sioc),    //I2C CLOCK
        .I2C_SDAT(siod),    //I2C DATA
        
        .Config_Done(
        //led_pin[0]
        )//Config Done
        // removed
    );
    
    /////////////////////////////VRAM and CDC /////////////////////////////////////////////////
    
    wire [16:0] capture_addr;
    wire [15:0] capture_data;
    wire [16:0] frame_addr;
    wire [11:0] frame_pixel;
    
    //////////////////////////Clock Domain Crossing/////////////////////////////////////////////
    
    // pclk (CMOS gen clk) to RAM (100 MHz) w/async FIFO
    wire cdc_out_cmos;
    wire data_count_r;
    async_fifo #(.DATA_WIDTH(12),.FIFO_DEPTH_WIDTH(10)) cmos_to_ram //1024x16 FIFO mem
	(
		.rst_n(sys_rst_n_pin),
		.clk_write(clk_100), // clock input from BRAM domain (100MHz)
		.clk_read(pclk), //clock input from CMOS domain (24MHz)
		.write(wr),
		.read(1'b1),//! changed to 1 - might need to check
		.write_data({capture_data[15:12], capture_data[10:7], capture_data[4:1]}), //input FROM write clock domain
		.read_data(cdc_out_cmos), //output TO read clock domain
		.wfull(full),// debug LED
		.rempty(), // unused
		.data_count_r(data_count_r) // unused
    );
    
    ///////////////////////////VRAM wrapper inst////////////////////////////////////////////////
    vram_wrapper u_vram_wrapper
       (
        .BRAM_PORTA_addr(capture_addr),
        .BRAM_PORTA_clk(clk_100),
        .BRAM_PORTA_din(cdc_out_cmos),
        .BRAM_PORTA_en(1'b1),
        .BRAM_PORTA_we(wr),
        .BRAM_PORTB_addr(frame_addr),
        .BRAM_PORTB_clk(clk_100),
        .BRAM_PORTB_dout(frame_pixel),
        .BRAM_PORTB_en(1'b1)
        );
        
        
    logic [7:0] out_r_VGA, out_g_VGA, out_b_VGA;
    
    //////////////////////////Clock Domain Crossing/////////////////////////////////////////////
    
    // clk_100MHz (CMOS gen clk) to VGA (25 MHz) w/async FIFO
    wire frame_pixel_cross;
    //wire data_count_w;
    async_fifo #(.DATA_WIDTH(12),.FIFO_DEPTH_WIDTH(10)) ram_to_vga //1024x16 FIFO mem
	(
		.rst_n(sys_rst_n_pin),
		.clk_write(clk_25), // clock input from VGA  domain(25 MHZ)
		.clk_read(clk_100), //clock input from BRAM  domain (100 MHz)
		.write(wr),
		.read(1'b1),//! changed to 1 - might need to check
		.write_data(frame_pixel), //input FROM write clock domain
		.read_data(frame_pixel_cross), //output TO read clock domain
		.wfull(),// unused 
		.rempty(), // unused
		.data_count_r() // unused
    );
     
    /////////////////////////////VGA module////////////////////////////////////////////////
    logic [3:0] R, G, B;
    logic video_on;
    logic [9:0] supplying_X, supplying_Y;
    logic blank;
    vga u_vga (
        .clk25(clk_25),
        .vga_red(R),
        .vga_green(G),
        .vga_blue(B),
        .vga_hsync(h_sync),
        .vga_vsync(v_sync),
        .frame_addr(frame_addr),
        .vde(video_on),// added
        .frame_pixel(frame_pixel_cross),
        .hCounter(supplying_X),
        .vCounter(supplying_Y),
        .blank(blank)
        );

    ///////////////////////HDMI converter///////////////////////////////////////////////
    // Clocking wizard for VGA -> HDMI
    wire clk_25MHz, clk_125MHz, locked;
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(sys_rst_n_pin),
        .locked(locked),
        .clk_in1(sys_clk_pin)
    );
    
    // Real Digital VGA to HDMI converter
    // desaturation preprocessing
    logic [3:0] comp_r, comp_g, comp_b;
    logic [3:0] scaled_r, scaled_g, scaled_b;
    logic [3:0] proc_out_r, proc_out_g, proc_out_b;
    logic [7:0] L;
    always @(*) begin
        L = ((R * 5) >> 2) + ((G * 2) >> 3) + (B >> 4);
        proc_out_r = R + ((L - R) >> 3);
        proc_out_g = G + ((L - G) >> 3);
        proc_out_b = B + ((L - B) >> 3);
    end
    hdmi_tx_0 vga_to_hdmi (
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        .rst(sys_rst_n_pin),
        .red(scaled_r), // changed from proc_out_r | 4'h1
        .green(scaled_g), // changed from proc_out_g | 4'h1
        .blue(scaled_b), // changed from proc_out_b | 4'h1
        .hsync(h_sync),
        .vsync(v_sync),
        .vde(video_on),
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );
   
   /////////////////////////// new pixel compression///////////////////////////////////////
   
   pixel_compression display_9_create (
   .hcounter(supplying_X),
   .vcounter(supplying_Y),
   .r_in(proc_out_r),
   .g_in(proc_out_g),
   .b_in(proc_out_b),
   .clk_25mhz(clk_25MHz),
   .r_out(comp_r),
   .g_out(comp_g),
   .b_out(comp_b)
   );
   
   upscale upscale_u (
   .clk_25mhz(clk_25MHz),
   .drawX(supplying_X),
   .drawY(supplying_Y),
   .pixel_R_in(comp_r),
   .pixel_G_in(comp_g),
   .pixel_B_in(comp_b),
   .pixel_R_out(scaled_r),
   .pixel_G_out(scaled_g),
   .pixel_B_out(scaled_b)
   );
   
   
   
    /////////////////////////Capturing//////////////////////////////////////////////////
    wire [7:0] data_pin_inv;
    assign data_pin_inv[7] = data_pin[0];
    assign data_pin_inv[6] = data_pin[1];
    assign data_pin_inv[5] = data_pin[2];
    assign data_pin_inv[4] = data_pin[3];
    assign data_pin_inv[3] = data_pin[4];
    assign data_pin_inv[2] = data_pin[5];
    assign data_pin_inv[1] = data_pin[6];
    assign data_pin_inv[0] = data_pin[7];
   ov7670_capture u_ov7670_capture(
        .pclk(pclk),
        .vsync(vsync),
        .href(href),
        .d(data_pin),
        .addr(capture_addr),
        .dout(capture_data),
        .wr(wr)
        );
endmodule

