`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2024 10:50:55 AM
// Design Name: 
// Module Name: pixel_compression
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


module pixel_compression (
    input logic [9:0] hcounter,       
    input logic [9:0] vcounter,       
    input logic [3:0] r_in,         
    input logic [3:0] g_in,          
    input logic [3:0] b_in,          
    input logic clk_25mhz,            // 25MHz 
    output logic [3:0] r_out,       
    output logic [3:0] g_out,        
    output logic [3:0] b_out        
);
 
   
    localparam H_IMAGE_START = 160; 
    localparam H_IMAGE_END = 480;   
    localparam V_IMAGE_START = 120; 
    localparam V_IMAGE_END = 360;  

    // image dimensions
    localparam H_COMPRESSED_WIDTH = 213;
    localparam V_COMPRESSED_HEIGHT = 159;

    // 3x3 grid
    localparam NUM_FRAMES_X = 3;
    localparam NUM_FRAMES_Y = 3;

    // display dimensions
    localparam FRAME_WIDTH = H_COMPRESSED_WIDTH;
    localparam FRAME_HEIGHT = V_COMPRESSED_HEIGHT;

    logic [9:0] compressed_h, compressed_v;
    logic [3:0] filtered_r, filtered_g, filtered_b;
    logic [1:0] frame_x;
    logic [1:0] frame_y;
    
    // sin & cos lut gen
    logic [7:0] sin_table[0:255];
    logic [7:0] cos_table[0:255];
    initial begin
        integer i;
        for (i = 0; i < 256; i++) begin
            sin_table[i] = $floor(127.5 + 127.5 * $sin(2 * 3.14159265359 * i / 256));
            cos_table[i] = $floor(127.5 + 127.5 * $cos(2 * 3.14159265359 * i / 256));
        end
    end
    
    logic signed [10:0] dx, dy;       // center dist
    logic signed [10:0] swirl_h, swirl_v; // polar coordinates
    logic [7:0] r;                   // radius
    logic [7:0] theta_prime;         // angle for swirl
    logic [10:0] k;                  // swirl strength coeff

    atan2_lut #(
    .RESOLUTION(256) // 256bit resolution
) atan2_instance (
    .x(dx[7:0]),          
    .y(dy[7:0]),           
    .atan2_value(theta) 
);

    always_comb begin
        // hopefully not but
        r_out = 4'b0000;
        g_out = 4'b0000;
        b_out = 4'b0000;

        // pixel mapping when in range
        if ((hcounter >= H_IMAGE_START && hcounter < H_IMAGE_END) &&
            (vcounter >= V_IMAGE_START && vcounter < V_IMAGE_END))
            begin
            compressed_h = (hcounter - H_IMAGE_START) * H_COMPRESSED_WIDTH / (H_IMAGE_END - H_IMAGE_START);
            compressed_v = (vcounter - V_IMAGE_START) * V_COMPRESSED_HEIGHT / (V_IMAGE_END - V_IMAGE_START);
            
            // 3x3 grid selection
            frame_x = (hcounter - H_IMAGE_START) * NUM_FRAMES_X / (H_IMAGE_END - H_IMAGE_START);
            frame_y = (vcounter - V_IMAGE_START) * NUM_FRAMES_Y / (V_IMAGE_END - V_IMAGE_START);
            
            // filters
            case ({frame_y, frame_x})
                    4'b0110: begin //swirl  
                    dx = $signed(compressed_h) - $signed(H_COMPRESSED_WIDTH >> 1);
                    dy = $signed(compressed_v) - $signed(V_COMPRESSED_HEIGHT >> 1);
                    // approx. sqrt w/shifts
                    k = 12;
                    r = (dx * dx + dy * dy) >> 8; //8 bits
                    // get angle from atan2 LUT
                    theta_prime = theta + (k * r); // scale by k
                    // approx. cartesian w/ cos and sine luts
                    swirl_h = (H_COMPRESSED_WIDTH >> 1) + (r * $signed(cos_table[theta_prime]) >> 7);
                    swirl_v = (V_COMPRESSED_HEIGHT >> 1) + (r * $signed(sin_table[theta_prime]) >> 7);
                    filtered_r = (swirl_h >= 0 && swirl_h < H_COMPRESSED_WIDTH &&
                          swirl_v >= 0 && swirl_v < V_COMPRESSED_HEIGHT) ? r_in : b_in;
                    filtered_g = (swirl_h >= 0 && swirl_h < H_COMPRESSED_WIDTH &&
                          swirl_v >= 0 && swirl_v < V_COMPRESSED_HEIGHT) ? g_in : r_in;
                    filtered_b = (swirl_h >= 0 && swirl_h < H_COMPRESSED_WIDTH &&
                    swirl_v >= 0 && swirl_v < V_COMPRESSED_HEIGHT) ? b_in : g_in;
                end

                4'b0000: begin // sepia
                    filtered_r = (((r_in << 2) +r_in) + ((g_in << 2) + (g_in << 1)) + b_in) / 10;
                    filtered_g = ((r_in << 1) + ((g_in << 2)+ g_in) + b_in) / 8;
                    filtered_b = ((r_in  + g_in * 3 + (b_in << 2))) >> 3;
                end
                4'b0001: begin // xray
                    filtered_r = 4'b1111 - ((r_in + g_in + b_in) / 3);
                    filtered_g = filtered_r;
                    filtered_b = filtered_r;
                end
                4'b0010: begin // negative/inv color
                    filtered_r = 4'b1111 - r_in;
                    filtered_g = 4'b1111 - g_in;
                    filtered_b = 4'b1111 - b_in;
                end
                4'b0100: begin // grayscale
                    logic [3:0] gray;
                    gray = ((r_in + g_in + b_in) >> 2); // not bright enough
                    filtered_r = gray;
                    filtered_g = gray;
                    filtered_b = gray;
                end
                4'b0101: begin // og
                    filtered_r = r_in;
                    filtered_g = g_in;
                    filtered_b = b_in;
                end
                4'b1000: begin // mirror
                    filtered_r = r_in;
                    filtered_g = g_in;
                    filtered_b = b_in;
                    compressed_h = H_COMPRESSED_WIDTH - compressed_h - 1; // ? 
                end
                4'b1001: begin // kaleidoscope
                    filtered_r = r_in;
                    filtered_g = g_in;
                    filtered_b = b_in;
                    compressed_h = (compressed_h ^ compressed_v) % H_COMPRESSED_WIDTH; // uhhh
                    compressed_v = (compressed_v ^ compressed_h) % V_COMPRESSED_HEIGHT;
                end
                4'b1010: begin // sharpness boost
                    filtered_r = (r_in > g_in) ? r_in : g_in;
                    filtered_g = (g_in > b_in) ? g_in : b_in;
                    filtered_b = (b_in > r_in) ? b_in : r_in;
                end
                default: begin // no thanks
                    filtered_r = r_in;
                    filtered_g = g_in;
                    filtered_b = b_in;
                end
            endcase
            r_out = filtered_r;
            g_out = filtered_g;
            b_out = filtered_b;
        end
     end
     
     
     
  
endmodule





// arctan LUT for swirl
module atan2_lut #(
    parameter RESOLUTION = 256 // resolution 
) (
    input logic [$clog2(RESOLUTION)-1:0] x,
    input logic [$clog2(RESOLUTION)-1:0] y, 
    output logic [7:0] atan2_value         
);
    // Flattened 2D array for atan2 LUT
    logic [7:0] atanlut [(RESOLUTION*RESOLUTION)-1:0];
    // Initialize the LUT
    initial begin
        integer dx, dy;
        for (integer yi = 0; yi < RESOLUTION; yi++) begin
            for (integer xi = 0; xi < RESOLUTION; xi++) begin
                dx = xi - (RESOLUTION / 2);
                dy = yi - (RESOLUTION / 2);
                // approx again oops
                atanlut[yi * RESOLUTION + xi] = $floor((($atan2(dy, dx) + 3.14159265359) / (2 * 3.14159265359)) * 255);
            end
        end
    end
    always_comb begin
        atan2_value = atanlut[y * RESOLUTION + x];
    end

endmodule

