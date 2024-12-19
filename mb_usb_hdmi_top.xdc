set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {sys_Clock}]


# reset 
set_property IOSTANDARD LVCMOS25 [get_ports sys_rst_n_pin]
set_property PACKAGE_PIN J2 [get_ports sys_rst_n_pin]

# brighness & contrast control switches
# On-board Slide Switches
#set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS25} [get_ports {key[0]}]
#set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS25} [get_ports {key[1]}]
#set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS25} [get_ports {key[2]}]
#set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS25} [get_ports {key[3]}]

# debug LED
# On-board LEDs
set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports {led_pin[0]}]
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports {led_pin[1]}]
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {led_pin[2]}]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports {led_pin[3]}]
set_property -dict {CLOCK_DEDICATED_ROUTE FALSE}         [get_nets led_pin_OBUF[1]]

# UART
#set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_0_rxd]
#set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_0_txd]
#set_property PACKAGE_PIN B16 [get_ports uart_rtl_0_rxd]
#set_property PACKAGE_PIN A16 [get_ports uart_rtl_0_txd]

# USB and GPIO Signals for keyboard
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio_usb_int_tri_i[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports usb_spi_miso]
#set_property IOSTANDARD LVCMOS33 [get_ports usb_spi_mosi]
#set_property IOSTANDARD LVCMOS33 [get_ports usb_spi_sclk]
#set_property PACKAGE_PIN T13 [get_ports {gpio_usb_int_tri_i[0]}]
#set_property PACKAGE_PIN V14 [get_ports usb_spi_sclk]
#set_property PACKAGE_PIN V15 [get_ports usb_spi_mosi]
#set_property PACKAGE_PIN U12 [get_ports usb_spi_miso]
#set_property IOSTANDARD LVCMOS33 [get_ports gpio_usb_rst_tri_o]
#set_property PACKAGE_PIN V13 [get_ports gpio_usb_rst_tri_o]
#set_property PACKAGE_PIN T12 [get_ports usb_spi_ss]
#set_property IOSTANDARD LVCMOS33 [get_ports usb_spi_ss]

#HDMI Signals
set_property -dict { PACKAGE_PIN V17   IOSTANDARD TMDS_33 } [get_ports {hdmi_tmds_clk_n}]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD TMDS_33 } [get_ports {hdmi_tmds_clk_p}]

set_property -dict { PACKAGE_PIN U18   IOSTANDARD TMDS_33  } [get_ports {hdmi_tmds_data_n[0]}]
set_property -dict { PACKAGE_PIN R17   IOSTANDARD TMDS_33  } [get_ports {hdmi_tmds_data_n[1]}]
set_property -dict { PACKAGE_PIN T14   IOSTANDARD TMDS_33  } [get_ports {hdmi_tmds_data_n[2]}]
                                    
set_property -dict { PACKAGE_PIN U17   IOSTANDARD TMDS_33  } [get_ports {hdmi_tmds_data_p[0]}]
set_property -dict { PACKAGE_PIN R16   IOSTANDARD TMDS_33  } [get_ports {hdmi_tmds_data_p[1]}]
set_property -dict { PACKAGE_PIN R14   IOSTANDARD TMDS_33  } [get_ports {hdmi_tmds_data_p[2]}]

# CMOS
# PMOD B Signals 
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports {data_pin[1]}]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {data_pin[3]}]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports {data_pin[5]}]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {data_pin[7]}]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {data_pin[0]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {data_pin[2]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {data_pin[4]}]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {data_pin[6]}]

# PMOD A Signals
# swapped j14 and f15 for pclk to get clock capable pclk 
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports {pwdn}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {xclk}]
set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33} [get_ports {href}]
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {sioc}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {reset_pin}]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {pclk}]
#set_property -dict {CLOCK_DEDICATED_ROUTE FALSE} [get_ports {i_cam_pclk_IBUF}]
set_property -dict {PACKAGE_PIN E14 IOSTANDARD LVCMOS33} [get_ports {vsync}]
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports {siod}]


# DDR3 signals
# Clock w/ diff 
#set_property IO_BUFFER_TYPE NONE [get_ports {sdram_clk}]
#set_property IO_BUFFER_TYPE NONE [get_ports {sdram_clk_n}]

## Data bits
## PadFunction: IO_L1N_T0_34 (SCHEMATIC DDR_DQ0)
#current_instance -quiet
#set_property SLEW FAST [get_ports {ddr3_dq[0]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[0]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[0]}]
#set_property PACKAGE_PIN K2 [get_ports {ddr3_dq[0]}]

## PadFunction: IO_L2P_T0_34 (SCHEMATIC DDR_DQ1)
#set_property SLEW FAST [get_ports {ddr3_dq[1]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[1]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[1]}]
#set_property PACKAGE_PIN M4 [get_ports {ddr3_dq[1]}]

## PadFunction: IO_L2N_T0_34 (SCHEMATIC DDR_DQ2)
#set_property SLEW FAST [get_ports {ddr3_dq[2]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[2]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[2]}]
#set_property PACKAGE_PIN K3 [get_ports {ddr3_dq[2]}]

## PadFunction: IO_L4P_T0_34 (SCHEMATIC DDR_DQ3)
#set_property SLEW FAST [get_ports {ddr3_dq[3]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[3]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[3]}]
#set_property PACKAGE_PIN L5 [get_ports {ddr3_dq[3]}]

## PadFunction: IO_L4N_T0_34 (SCHEMATIC DDR_DQ4)
#set_property SLEW FAST [get_ports {ddr3_dq[4]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[4]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[4]}]
#set_property PACKAGE_PIN L6 [get_ports {ddr3_dq[4]}]

## PadFunction: IO_L5P_T0_34 (SCHEMATIC DDR_DQ5)
#set_property SLEW FAST [get_ports {ddr3_dq[5]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[5]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[5]}]
#set_property PACKAGE_PIN M6 [get_ports {ddr3_dq[5]}]

## PadFunction: IO_L5N_T0_34 (SCHEMATIC DDR_DQ6)
#set_property SLEW FAST [get_ports {ddr3_dq[6]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[6]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[6]}]
#set_property PACKAGE_PIN L4 [get_ports {ddr3_dq[6]}]

## PadFunction: IO_L6P_T0_34 (SCHEMATIC DDR_DQ7)
#set_property SLEW FAST [get_ports {ddr3_dq[7]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[7]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[7]}]
#set_property PACKAGE_PIN K6 [get_ports {ddr3_dq[7]}]

## PadFunction: IO_L7N_T1_34 (SCHEMATIC DDR_DQ8)
#set_property SLEW FAST [get_ports {ddr3_dq[8]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[8]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[8]}]
#set_property PACKAGE_PIN N5 [get_ports {ddr3_dq[8]}]

## PadFunction: IO_L8P_T1_34 (SCHEMATIC DDR_DQ9)
#set_property SLEW FAST [get_ports {ddr3_dq[9]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[9]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[9]}]
#set_property PACKAGE_PIN M1 [get_ports {ddr3_dq[9]}]

## PadFunction: IO_L8N_T1_34 (SCHEMATIC DDR_DQ10)
#set_property SLEW FAST [get_ports {ddr3_dq[10]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[10]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[10]}]
#set_property PACKAGE_PIN P1 [get_ports {ddr3_dq[10]}]

## PadFunction: IO_L10P_T1_34 (SCHEMATIC DDR_DQ11)
#set_property SLEW FAST [get_ports {ddr3_dq[11]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[11]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[11]}]
#set_property PACKAGE_PIN N1 [get_ports {ddr3_dq[11]}]

## PadFunction: IO_L10N_T1_34 (SCHEMATIC DDR_DQ12)
#set_property SLEW FAST [get_ports {ddr3_dq[12]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[12]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[12]}]
#set_property PACKAGE_PIN R2 [get_ports {ddr3_dq[12]}]

## PadFunction: IO_L11P_T1_SRCC_34 (SCHEMATIC DDR_DQ13)
#set_property SLEW FAST [get_ports {ddr3_dq[13]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[13]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[13]}]
#set_property PACKAGE_PIN N4 [get_ports {ddr3_dq[13]}]

## PadFunction: IO_L11N_T1_SRCC_34 (SCHEMATIC DDR_DQ14)
#set_property SLEW FAST [get_ports {ddr3_dq[14]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[14]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[14]}]
#set_property PACKAGE_PIN P2 [get_ports {ddr3_dq[14]}]

## PadFunction: IO_L12P_T1_MRCC_34 (SCHEMATIC DDR_DQ15)
#set_property SLEW FAST [get_ports {ddr3_dq[15]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[15]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[15]}]
#set_property PACKAGE_PIN M2 [get_ports {ddr3_dq[15]}]

## Address bits
## PadFunction: IO_L14P_T2_SRCC_34 (SCHEMATIC DDR_A12)
#set_property SLEW FAST [get_ports {ddr3_addr[12]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[12]}]
#set_property PACKAGE_PIN V6 [get_ports {ddr3_addr[12]}]

## PadFunction: IO_L14N_T2_SRCC_34 (SCHEMATIC DDR_A11)
#set_property SLEW FAST [get_ports {ddr3_addr[11]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[11]}]
#set_property PACKAGE_PIN P5 [get_ports {ddr3_addr[11]}]

## PadFunction: IO_L15P_T2_DQS_34 (SCHEMATIC DDR_A10)
#set_property SLEW FAST [get_ports {ddr3_addr[10]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[10]}]
#set_property PACKAGE_PIN U3 [get_ports {ddr3_addr[10]}]

## PadFunction: IO_L15N_T2_DQS_34 (SCHEMATIC DDR_A9)
#set_property SLEW FAST [get_ports {ddr3_addr[9]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[9]}]
#set_property PACKAGE_PIN U6 [get_ports {ddr3_addr[9]}]

## PadFunction: IO_L16P_T2_34 (SCHEMATIC DDR_A8)
#set_property SLEW FAST [get_ports {ddr3_addr[8]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[8]}]
#set_property PACKAGE_PIN R7 [get_ports {ddr3_addr[8]}]

## PadFunction: IO_L16N_T2_34 (SCHEMATIC DDR_A7)
#set_property SLEW FAST [get_ports {ddr3_addr[7]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[7]}]
#set_property PACKAGE_PIN U7 [get_ports {ddr3_addr[7]}]

## PadFunction: IO_L17P_T2_34 (SCHEMATIC DDR_A6)
#set_property SLEW FAST [get_ports {ddr3_addr[6]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[6]}]
#set_property PACKAGE_PIN V5 [get_ports {ddr3_addr[6]}]

## PadFunction: IO_L17N_T2_34 (SCHEMATIC DDR_A5)
#set_property SLEW FAST [get_ports {ddr3_addr[5]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[5]}]
#set_property PACKAGE_PIN T1 [get_ports {ddr3_addr[5]}]

## PadFunction: IO_L18P_T2_34 (SCHEMATIC DDR_A4)
#set_property SLEW FAST [get_ports {ddr3_addr[4]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[4]}]
#set_property PACKAGE_PIN T6 [get_ports {ddr3_addr[4]}]

## PadFunction: IO_L18N_T2_34 (SCHEMATIC DDR_A3)
#set_property SLEW FAST [get_ports {ddr3_addr[3]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[3]}]
#set_property PACKAGE_PIN T3 [get_ports {ddr3_addr[3]}]

## PadFunction: IO_L19P_T3_34 (SCHEMATIC DDR_A2)
#set_property SLEW FAST [get_ports {ddr3_addr[2]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[2]}]
#set_property PACKAGE_PIN P6 [get_ports {ddr3_addr[2]}]

## PadFunction: IO_L19N_T3_VREF_34 (SCHEMATIC DDR_A1)
#set_property SLEW FAST [get_ports {ddr3_addr[1]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[1]}]
#set_property PACKAGE_PIN R4 [get_ports {ddr3_addr[1]}]

## PadFunction: IO_L20P_T3_34 (SCHEMATIC DDR_A0)
#set_property SLEW FAST [get_ports {ddr3_addr[0]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[0]}]
#set_property PACKAGE_PIN V3 [get_ports {ddr3_addr[0]}]

## Bank Address/BA bits
## PadFunction: IO_L22P_T3_34 (SCHEMATIC DDR_BA1)
#set_property SLEW FAST [get_ports {ddr3_ba[1]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_ba[1]}]
#set_property PACKAGE_PIN V4 [get_ports {ddr3_ba[1]}]

## PadFunction: IO_L22N_T3_34 (SCHEMATIC DDR_BA0)
#set_property SLEW FAST [get_ports {ddr3_ba[0]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_ba[0]}]
#set_property PACKAGE_PIN V2 [get_ports {ddr3_ba[0]}]

## PadFunction: IO_L23P_T3_34 (SCHEMATIC DDR_RAS_B
#set_property SLEW FAST [get_ports ddr3_ras_n]
#set_property IOSTANDARD SSTL135 [get_ports ddr3_ras_n]
#set_property PACKAGE_PIN U2 [get_ports ddr3_ras_n]

## PadFunction: IO_L23N_T3_34 (SCHEMATIC DDR_CAS_B)
#set_property SLEW FAST [get_ports ddr3_cas_n]
#set_property IOSTANDARD SSTL135 [get_ports ddr3_cas_n]
#set_property PACKAGE_PIN U1 [get_ports ddr3_cas_n]

## PadFunction: IO_L24P_T3_34 (SCHEMATIC DDR_WE_B)
#set_property SLEW FAST [get_ports ddr3_we_n]
#set_property IOSTANDARD SSTL135 [get_ports ddr3_we_n]
#set_property PACKAGE_PIN T2 [get_ports ddr3_we_n]

## PadFunction: IO_L6N_T0_VREF_34 (SCHEMATIC DDR_RESET_B)
#set_property SLEW FAST [get_ports ddr3_reset_n]
#set_property IOSTANDARD SSTL135 [get_ports ddr3_reset_n]
#set_property PACKAGE_PIN M5 [get_ports ddr3_reset_n]

## PadFunction: IO_L24N_T3_34 (SCHEMATIC DDR_CKE)
#set_property SLEW FAST [get_ports {ddr3_cke[0]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_cke[0]}]
#set_property PACKAGE_PIN T5 [get_ports {ddr3_cke[0]}]

## PadFunction: IO_25_34 (SCHEMATIC DDR_ODT)
#set_property SLEW FAST [get_ports {ddr3_odt[0]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_odt[0]}]
#set_property PACKAGE_PIN P7 [get_ports {ddr3_odt[0]}]

## Data Mask (DQM on SDRAM, DM on DDR3)
## PadFunction: IO_L1P_T0_34 (SCHEMATIC DDR_LDM)
#set_property SLEW FAST [get_ports {ddr3_dm[0]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dm[0]}]
#set_property PACKAGE_PIN K4 [get_ports {ddr3_dm[0]}]

## PadFunction: IO_L7P_T1_34 (SCHEMATIC DDR_UDM)
#set_property SLEW FAST [get_ports {ddr3_dm[1]}]
#set_property IOSTANDARD SSTL135 [get_ports {ddr3_dm[1]}]
#set_property PACKAGE_PIN M3 [get_ports {ddr3_dm[1]}]

## PadFunction: IO_L12P_T1_MRCC_35 (SCHEMATIC DDR_REF_CLK_P)
#set_property IOSTANDARD LVDS_25 [get_ports sys_clk_p]

## PadFunction: IO_L12N_T1_MRCC_35 (SCHEMATIC DDR_REF_CLK_N)
#set_property IOSTANDARD LVDS_25 [get_ports sys_clk_n]
#set_property PACKAGE_PIN C1 [get_ports sys_clk_p]
#set_property PACKAGE_PIN B1 [get_ports sys_clk_n]

## PadFunction: IO_L21N_T3_DQS_35 (SCHEMATIC SW0)
#set_property IOSTANDARD LVCMOS25 [get_ports sys_rst]
#set_property PACKAGE_PIN G1 [get_ports sys_rst]

## PadFunction: IO_L3P_T0_DQS_34 (SCHEMATIC DDR_LDQS_P)
#set_property SLEW FAST [get_ports {ddr3_dqs_p[0]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_p[0]}]
#set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_p[0]}]

## PadFunction: IO_L3N_T0_DQS_34 (SCHEMATIC DDR_LDQS_N)
#set_property SLEW FAST [get_ports {ddr3_dqs_n[0]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_n[0]}]
#set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_n[0]}]
#set_property PACKAGE_PIN K1 [get_ports {ddr3_dqs_p[0]}]
#set_property PACKAGE_PIN L1 [get_ports {ddr3_dqs_n[0]}]

## PadFunction: IO_L9P_T1_DQS_34 (SCHEMATIC DDR_UDQS_P)
#set_property SLEW FAST [get_ports {ddr3_dqs_p[1]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_p[1]}]
#set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_p[1]}]

## PadFunction: IO_L9N_T1_DQS_34 (SCHEMATIC DDR_UDQS_N)
#set_property SLEW FAST [get_ports {ddr3_dqs_n[1]}]
#set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_n[1]}]
#set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_n[1]}]
#set_property PACKAGE_PIN N3 [get_ports {ddr3_dqs_p[1]}]
#set_property PACKAGE_PIN N2 [get_ports {ddr3_dqs_n[1]}]

## PadFunction: IO_L21P_T3_DQS_34 (SCHEMATIC DDR_CLK_P)
#set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
#set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_ck_p[0]}]

## PadFunction: IO_L21N_T3_DQS_34 (SCHEMATIC DDR_CLK_N)
#set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
#set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_ck_n[0]}]
#set_property PACKAGE_PIN R5 [get_ports {ddr3_ck_p[0]}]
#set_property PACKAGE_PIN T4 [get_ports {ddr3_ck_n[0]}]

#set_property INTERNAL_VREF 0.675 [get_iobanks 34]
#set_property CFGBS VCCO