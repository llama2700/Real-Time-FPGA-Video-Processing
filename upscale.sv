`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 01:38:35 PM
// Design Name: 
// Module Name: upscale
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


module upscale(
    input  logic        clk_25mhz,      // VGA pixel clock
    input  logic [9:0]  drawX,          
    input  logic [9:0]  drawY,        
    input  logic [3:0]  pixel_R_in,   
    input  logic [3:0]  pixel_G_in,    
    input  logic [3:0]  pixel_B_in,     
    output logic [3:0]  pixel_R_out,    
    output logic [3:0]  pixel_G_out,    
    output logic [3:0]  pixel_B_out     
);

    localparam int INPUT_WIDTH  = 320;  // input width
    localparam int INPUT_HEIGHT = 240;  // input height

    
    logic [8:0] inputX; 
    logic [8:0] inputY;  
    assign inputX = drawX >> 1;  // h scale
    assign inputY = drawY >> 1;  // v scale

    always_ff @(posedge clk_25mhz) begin
        if (inputX < INPUT_WIDTH && inputY < INPUT_HEIGHT) begin
            // passthrough
            pixel_R_out <= pixel_R_in;
            pixel_G_out <= pixel_G_in;
            pixel_B_out <= pixel_B_in;
        end else begin
            pixel_R_out <= 4'b0000;
            pixel_G_out <= 4'b0000;
            pixel_B_out <= 4'b0000;
        end
    end

endmodule