# iPad 2 PhotoBooth app using OV7670, Urbana FPGA

Digital Systems Laboratory Final Project

Abhi Alavilli

This project includes a full implementation of the OV7670 camera module on the Urbana FPGA as well as custom filters to display the output image via VGA/HDMI. Filters can be edited in pixel_compression.sv.

## Usage

Note that you may need to upgrade the Xilinx Block RAM generator, as the project this is based on used a previous version of the IP. Also, the synthesis settings were modified to ignore constraints, so synthesis results from these files can be used.

Apart from that,  you will need to:
- Check your constraints file if running this on any other board. The pclk line on the CMOS needs to be mapped to a positive-ended Multi-Clock Capable pin. Check Xilinx documentation for your FPGA to figure out what those pins are.
- If using the Urbana board, simply sticking to the default wiring (as written in the constraints file) would be simplest, although it is admittedly not the most well organized.

## Upgrades
This project would greatly benefit from being ported to DDR3 memory. This would allow for frame buffering for synchronous filters, and would mean much more complicated logic can be used to create better filters. Currently, this project is only able to store enough data in BRAM for a 320x240 image. This can be solved by porting to DDR3, any kind of SDRAM, or simply by using an FPGA with more BRAM available.
