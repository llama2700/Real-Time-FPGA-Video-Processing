# iPad 2 PhotoBooth app recreation using OV7670, Urbana FPGA

Digital Systems Laboratory Final Project

Abhi Alavilli

This project includes a full implementation of the OV7670 camera module on the Urbana FPGA as well as custom filters to display the output image via VGA/HDMI. Filters can be edited in pixel_compression.sv.
A lot of modules are modified (to varying degrees) from [this](https://github.com/Tom-Zheng/OV7670_to_VGA_FPGA) project - Thanks!

## Usage

Note that you may need to upgrade the Xilinx Block RAM generator IP, as the project this is based on used a previous version of the IP. Also, the synthesis settings were modified to ignore constraints, so synthesis results from these files can be used.

Apart from that,  you will need to:
- Check your constraints file if running this on any other board. The pclk line on the CMOS needs to be mapped to a positive-ended Multi-Region Clock Capable (MRCC) pin. Check Xilinx documentation for your FPGA to figure out what those are.
- If using the Urbana board, simply sticking to the default wiring (as in the constraints file) would be simplest, although admittedly it's not organized well.
- Camera register initialization values will likely need to be changed in the ROM to suit your lighting conditions or your actual CMOS - I found the current values to have different degrees of success on two separate modules.

## Upgrades
This project would greatly benefit from being ported to DDR3 memory. This would allow for frame buffering for synchronous filters, and would mean much more complicated math can be used to create better filters. Currently, this project is only able to store enough data in BRAM for a 320x240 image. This can be solved by porting to DDR3, any kind of SDRAM, or simply by using an FPGA with more BRAM available. Figuring out how to do filters in software would also be cool - I tried this using the AMD MicroBlaze softcore, but the time frame of this project was too short to get it done in time. 

Some more filters to potentially try:

Squeeze

Stretch

Light Tunnel (good luck)

Thermal Camera

Comic Book (or some kind of edge detection)
