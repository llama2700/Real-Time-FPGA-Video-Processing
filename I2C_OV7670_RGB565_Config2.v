`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/07 12:03:49
// Design Name: 
// Module Name: I2C_OV7670_RGB565_Config2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// OV7670 I2C Configuration for RGB565
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module I2C_OV7670_RGB565_Config2(input  [7:0]  LUT_INDEX,
                                  output reg [15:0]  LUT_DATA
);

parameter  Read_DATA = 0;            // Read data LUT Address
parameter  SET_OV7670 = 2;           // SET_OV LUT Address

///////////////////// Config Data LUT //////////////////////////
always@(*) begin
    case(LUT_INDEX)
    // Read Data Index
    Read_DATA + 0 :   LUT_DATA = {8'h1C, 8'h7F};   // MIDH - Manufacturer ID (high byte)
    Read_DATA + 1 :   LUT_DATA = {8'h1D, 8'hA2};   // MIDL - Manufacturer ID (low byte)

    // OV7670 : VGA RGB565 Configuration
    SET_OV7670 + 0  : LUT_DATA = 16'h1240;    // Change 14 to 40
    SET_OV7670 + 1  : LUT_DATA = 16'h40D0;    // RGB444
    SET_OV7670 + 2  : LUT_DATA = 16'h3A04;    // Unchanged
    SET_OV7670 + 3  : LUT_DATA = 16'h3D88;    // Change C8 to 88
    SET_OV7670 + 4  : LUT_DATA = 16'h1E07;    // Change 01 to 07
    SET_OV7670 + 5  : LUT_DATA = 16'h6B0A;    // Change 00 to 0A
    SET_OV7670 + 6  : LUT_DATA = 16'h3280;    // Change B6 to 80
    SET_OV7670 + 7  : LUT_DATA = 16'h1711;    // Change 13 to 11
    SET_OV7670 + 8  : LUT_DATA = 16'h1861;    // Change 01 to 61
    SET_OV7670 + 9  : LUT_DATA = 16'h1902;    // Change 02 to 03
    SET_OV7670 + 10 : LUT_DATA = 16'h1A7B;    // Change 7A to 7B
    SET_OV7670 + 11 : LUT_DATA = 16'h0300;    // Change 0A to 00
    SET_OV7670 + 12 : LUT_DATA = 16'h0C00;    // Unchanged
    SET_OV7670 + 13 : LUT_DATA = 16'h3E00;    // Unchanged
    SET_OV7670 + 14 : LUT_DATA = 16'h703A;    // Change 00 to 3A
    SET_OV7670 + 15 : LUT_DATA = 16'h7135;    // Change 00 to 35
    SET_OV7670 + 16 : LUT_DATA = 16'h7211;    // Unchanged
    SET_OV7670 + 17 : LUT_DATA = 16'h7300;    // Unchanged
    SET_OV7670 + 18 : LUT_DATA = 16'hA202;    // Unchanged
    SET_OV7670 + 19 : LUT_DATA = 16'h1100;    // Change 80 to 00
    SET_OV7670 + 20 : LUT_DATA = 16'h7A20;    // Unchanged
    SET_OV7670 + 21 : LUT_DATA = 16'h7B10;    // Change 1C to 10
    SET_OV7670 + 22 : LUT_DATA = 16'h7C1E;    // Change 28 to 1E
    SET_OV7670 + 23 : LUT_DATA = 16'h7D35;    // Change 3C to 35
    SET_OV7670 + 24 : LUT_DATA = 16'h7E5A;    // Change 55 to 5A
    SET_OV7670 + 25 : LUT_DATA = 16'h7F69;    // Change 68 to 69
    SET_OV7670 + 26 : LUT_DATA = 16'h8076;    // Unchanged
    SET_OV7670 + 27 : LUT_DATA = 16'h8180;    // Unchanged
    SET_OV7670 + 28 : LUT_DATA = 16'h8288;    // Unchanged
    SET_OV7670 + 29 : LUT_DATA = 16'h838F;    // Unchanged
    SET_OV7670 + 30 : LUT_DATA = 16'h8496;    // Unchanged
    SET_OV7670 + 31 : LUT_DATA = 16'h85A3;    // Unchanged
    SET_OV7670 + 32 : LUT_DATA = 16'h86AF;    // Unchanged
    SET_OV7670 + 33 : LUT_DATA = 16'h87C4;    // Unchanged
    SET_OV7670 + 34 : LUT_DATA = 16'h88D7;    // Unchanged
    SET_OV7670 + 35 : LUT_DATA = 16'h89E8;    // Unchanged
    SET_OV7670 + 36 : LUT_DATA = 16'h1302;    // Change FF to 02
    SET_OV7670 + 37 : LUT_DATA = 16'h0000;    // Unchanged
    SET_OV7670 + 38 : LUT_DATA = 16'h1008;    // Change 00 to 08
    SET_OV7670 + 39 : LUT_DATA = 16'h0D40;    // Change 00 to 40
    SET_OV7670 + 40 : LUT_DATA = 16'h144A;    // Change 4E to 4A
    SET_OV7670 + 41 : LUT_DATA = 16'hA505;    // Unchanged
    SET_OV7670 + 42 : LUT_DATA = 16'hAB07;    // Unchanged
    SET_OV7670 + 43 : LUT_DATA = 16'h2495;    // Change 75 to 95
    SET_OV7670 + 44 : LUT_DATA = 16'h2533;    // Change 63 to 33
    SET_OV7670 + 45 : LUT_DATA = 16'h26E3;    // Change A5 to E3
    SET_OV7670 + 46 : LUT_DATA = 16'h9F78;    // Unchanged
    SET_OV7670 + 47 : LUT_DATA = 16'hA068;    // Unchanged
    SET_OV7670 + 48 : LUT_DATA = 16'hA103;    // Unchanged
    SET_OV7670 + 49 : LUT_DATA = 16'hA6D8;    // Change DF to D8
    SET_OV7670 + 50 : LUT_DATA = 16'hA7D8;    // Change DF to D8
    SET_OV7670 + 51 : LUT_DATA = 16'hA8F0;    // Unchanged
    SET_OV7670 + 52 : LUT_DATA = 16'hA990;    // Unchanged
    SET_OV7670 + 53 : LUT_DATA = 16'hAA94;    // Unchanged
    SET_OV7670 + 54 : LUT_DATA = 16'h1302;    // Change E5 to 02
    SET_OV7670 + 55 : LUT_DATA = 16'h0E61;    // Unchanged
    SET_OV7670 + 56 : LUT_DATA = 16'h0F43;    // Change 4B to 43
    SET_OV7670 + 57 : LUT_DATA = 16'h1602;    // Unchanged

	SET_OV7670 + 58 : 	LUT_DATA	= 	16'h2102; 	//					?
	SET_OV7670 + 59 : 	LUT_DATA	= 	16'h2291;	//					?
	SET_OV7670 + 60 : 	LUT_DATA	= 	16'h2907;	//					?
	SET_OV7670 + 61 : 	LUT_DATA	= 	16'h3308; 	// changed 0b to 08	>
	SET_OV7670 + 62 : 	LUT_DATA	= 	16'h350b;	//					?
	SET_OV7670 + 63 : 	LUT_DATA	= 	16'h373f;	// unchanged		>
	SET_OV7670 + 64 : 	LUT_DATA	= 	16'h3801;	// unchanged		>
	SET_OV7670 + 65 : 	LUT_DATA	= 	16'h3900;	// unchanged		>
	SET_OV7670 + 66 : 	LUT_DATA	= 	16'h3c68;	// changed 78 to 68	>
	SET_OV7670 + 67 : 	LUT_DATA	= 	16'h4d40;	//					?
	SET_OV7670 + 68	: 	LUT_DATA	= 	16'h4e20;	//					?
	SET_OV7670 + 69	: 	LUT_DATA	= 	16'h6906;	// changed 00 to 06 >
	
	SET_OV7670 + 70 : 	LUT_DATA	= 	16'h7400;	// changed 19 to 00 >
	SET_OV7670 + 71 : 	LUT_DATA	= 	16'h8d4f;	//					?
	SET_OV7670 + 72 : 	LUT_DATA	= 	16'h8e00;	//					?
	SET_OV7670 + 73 : 	LUT_DATA	= 	16'h8f00;	//					?
	SET_OV7670 + 74 : 	LUT_DATA	= 	16'h9000;	//					?
	SET_OV7670 + 75 : 	LUT_DATA	= 	16'h9100;	//					?
	SET_OV7670 + 76 : 	LUT_DATA	= 	16'h9200;	//					?
	SET_OV7670 + 77 : 	LUT_DATA	= 	16'h9600;	// unchanged 		>
	SET_OV7670 + 78 : 	LUT_DATA	= 	16'h9a80;	//					?
	SET_OV7670 + 79 : 	LUT_DATA	= 	16'hb084;	// unchanged 		>
	SET_OV7670 + 80 : 	LUT_DATA	= 	16'hb10c;	// unchanged 		>
	SET_OV7670 + 81 : 	LUT_DATA	= 	16'hb20e;	// unchanged 		>
	SET_OV7670 + 82 : 	LUT_DATA	= 	16'hb382;	// unchanged 		>
	SET_OV7670 + 83	: 	LUT_DATA	= 	16'hb80a;	//					?

	SET_OV7670 + 84  :	LUT_DATA	=	16'h4314;	// unchanged 		>
	SET_OV7670 + 85  :	LUT_DATA	=	16'h44f0; 	// unchanged		>
	SET_OV7670 + 86  :	LUT_DATA	=	16'h4534;	// changed 34 to 45 >
	SET_OV7670 + 87  :	LUT_DATA	=	16'h4661; 	// changed 58 to 61 > 
	SET_OV7670 + 88  :	LUT_DATA	=	16'h4751;	// changed 28 to 51 >
	SET_OV7670 + 89  :	LUT_DATA	=	16'h4879;	// changed 3a to 79 >
	SET_OV7670 + 90  :	LUT_DATA	=	16'h5988;	// 					>
	SET_OV7670 + 91  :	LUT_DATA	=	16'h5a88;	// 					>
	SET_OV7670 + 92  :	LUT_DATA	=	16'h5b44;	// 					>
	SET_OV7670 + 93  :	LUT_DATA	=	16'h5c67;	// 					>
	SET_OV7670 + 94  :	LUT_DATA	=	16'h5d49;	// 					>
	SET_OV7670 + 95  :	LUT_DATA	=	16'h5e0e;	// 					>
	SET_OV7670 + 96  :	LUT_DATA	=	16'h6450; 	// changed 04 to 50 >
	SET_OV7670 + 97  :	LUT_DATA	=	16'h6530;	// changed 20 to 30 >
	SET_OV7670 + 98  :	LUT_DATA	=	16'h6605;	// changed 05 to 00 >
	SET_OV7670 + 99  :	LUT_DATA	=	16'h9450;	// changed 04 to 50 >
	SET_OV7670 + 100 :	LUT_DATA	=	16'h9550;	// changed 08 to 50
	SET_OV7670 + 101 :	LUT_DATA	=	16'h6c02;	// changed 0a to 02	>
	SET_OV7670 + 102 :	LUT_DATA	=	16'h6d55;	// unchanged 		>
	SET_OV7670 + 103 :	LUT_DATA	=	16'h6ec0;	// changed 11 to c0 >
	SET_OV7670 + 104 :	LUT_DATA	=	16'h6f9a;	// changed 9f to 9a >
	SET_OV7670 + 105 :	LUT_DATA	=	16'h6a40;	// changed 40 to 00 > G Gain
	SET_OV7670 + 106 :	LUT_DATA	=	16'h0140;	// changed 40 to 80 > B gain
	SET_OV7670 + 107 :	LUT_DATA	=	16'h0240;	// changed 40 to 80 > R gain
	SET_OV7670 + 108 :	LUT_DATA	=	16'h13ad;	// changed e7 to ad > //! uncommented this line
	SET_OV7670 + 109 :	LUT_DATA	=	16'h1500;	// unchanged 
	
	SET_OV7670 + 110 :	LUT_DATA	= 	16'h4fb3; 	// changed 80 to b3 >
	SET_OV7670 + 111 :	LUT_DATA	= 	16'h50b3; 	// changed 80 to b3 >
	SET_OV7670 + 112 :	LUT_DATA	= 	16'h5100; 	// unchanged 		>
	SET_OV7670 + 113 :	LUT_DATA	= 	16'h523d; 	// changed 22 to 3d	>
	SET_OV7670 + 114 :	LUT_DATA	= 	16'h53a7; 	// changed 5e to a7	>
	SET_OV7670 + 115 :	LUT_DATA	= 	16'h54e4; 	// changed 80 to e4	>
	SET_OV7670 + 116 :	LUT_DATA	= 	16'h589e; 	// unchanged 		>
	
	SET_OV7670 + 117 : 	LUT_DATA	=	16'h4106; 	// changed 08 to 06 >
	SET_OV7670 + 118 : 	LUT_DATA	=	16'h3f00;	// unchanged		>
	SET_OV7670 + 119 : 	LUT_DATA	=	16'h750f;	// changed 05 to 0f >
	SET_OV7670 + 120 : 	LUT_DATA	=	16'h7601;	// changed e1 to 01 >
	SET_OV7670 + 121 : 	LUT_DATA	=	16'h4c00;	// unchanged 		>
	SET_OV7670 + 122 : 	LUT_DATA	=	16'h7702;	// changed 01 to 04 > denoise offset
	
	SET_OV7670 + 123 : 	LUT_DATA	=	16'h4b00;	// changed 09 to 00 >
	SET_OV7670 + 124 : 	LUT_DATA	=	16'hc9c0;	// changed f0 to c0 >
	SET_OV7670 + 125 : 	LUT_DATA	=	16'h4106;	// changed 38 to 06 >
	SET_OV7670 + 126 : 	LUT_DATA	=	16'h5640;	// changed default 40 to 01		> contrast adjust
	
	// 												// some of these unchanged ones are sus	
	SET_OV7670 + 127 : 	LUT_DATA	=	16'h3411;	// unchanged 		>
	SET_OV7670 + 128 : 	LUT_DATA	=	16'h3b00;	// changed 02 to 00 >
	SET_OV7670 + 129 : 	LUT_DATA	=	16'ha479;	// changed 89 to 79 >
	SET_OV7670 + 130 : 	LUT_DATA	=	16'h9600;	// unchanged 		>
	SET_OV7670 + 131 : 	LUT_DATA	=	16'h9730;	// unchanged 		>
	SET_OV7670 + 132 : 	LUT_DATA	=	16'h9820;	// unchanged 		>
	SET_OV7670 + 133 : 	LUT_DATA	=	16'h9930;	// unchanged 		>
	SET_OV7670 + 134 : 	LUT_DATA	=	16'h9a84;	// unchanged 		>
	SET_OV7670 + 135 : 	LUT_DATA	=	16'h9b29;	// unchanged 		>
	SET_OV7670 + 136 : 	LUT_DATA	=	16'h9c03;	// unchanged 		>
	SET_OV7670 + 137 : 	LUT_DATA	=	16'h9d99;	// changed 4c to 99 >
	SET_OV7670 + 138 : 	LUT_DATA	=	16'h9e7f;	// changed 3f to 7f >
	SET_OV7670 + 139 : 	LUT_DATA	=	16'h7804;	// unchanged 		>
	
	//												// need to check what these are	
	SET_OV7670 + 140 :	LUT_DATA	=	16'h7901;
	SET_OV7670 + 141 :	LUT_DATA	= 	16'hc8f0;
	SET_OV7670 + 142 :	LUT_DATA	= 	16'h790f;
	SET_OV7670 + 143 :	LUT_DATA	= 	16'hc800;
	SET_OV7670 + 144 :	LUT_DATA	= 	16'h7910;
	SET_OV7670 + 145 :	LUT_DATA	= 	16'hc87e;
	SET_OV7670 + 146 :	LUT_DATA	= 	16'h790a;
	SET_OV7670 + 147 :	LUT_DATA	= 	16'hc880;
	SET_OV7670 + 148 :	LUT_DATA	= 	16'h790b;
	SET_OV7670 + 149 :	LUT_DATA	= 	16'hc801;
	SET_OV7670 + 150 :	LUT_DATA	= 	16'h790c;
	SET_OV7670 + 151 :	LUT_DATA	= 	16'hc80f;
	SET_OV7670 + 152 :	LUT_DATA	= 	16'h790d;
	SET_OV7670 + 153 :	LUT_DATA	= 	16'hc820;
	SET_OV7670 + 154 :	LUT_DATA	= 	16'h7909;
	SET_OV7670 + 155 :	LUT_DATA	= 	16'hc880;
	SET_OV7670 + 156 :	LUT_DATA	= 	16'h7902;
	SET_OV7670 + 157 :	LUT_DATA	= 	16'hc8c0;
	SET_OV7670 + 158 :	LUT_DATA	= 	16'h7903;
	SET_OV7670 + 159 :	LUT_DATA	= 	16'hc840;
	SET_OV7670 + 160 :	LUT_DATA	= 	16'h7905;
	SET_OV7670 + 161 :	LUT_DATA	= 	16'hc830; 
	SET_OV7670 + 162 :	LUT_DATA	= 	16'h7926;
	
	SET_OV7670 + 163 :	LUT_DATA	= 	16'h0901;	// changed 03 to 01	>
	SET_OV7670 + 164 :	LUT_DATA	= 	16'h3b42;
	SET_OV7670 + 165 : 	LUT_DATA 	= 	16'h5500; 	// brightness control
	//SET_OV7670 + 166 : 	LUT_DATA 	= 	16'h70; 	// test pattern gen test
	SET_OV7670 + 166  : LUT_DATA = 16'h1240;    
    SET_OV7670 + 167  : LUT_DATA = 16'h3A04;    
    SET_OV7670 + 168 : LUT_DATA = 16'h8C02;    
    SET_OV7670 + 169 : LUT_DATA = 16'h40D0;    
    SET_OV7670 + 170  : LUT_DATA = 16'h1E31;    
    SET_OV7670 + 171  : LUT_DATA = 16'h6B4A;    
    SET_OV7670 + 172  : LUT_DATA = 16'h3E00;    

    SET_OV7670 + 173  : LUT_DATA = 16'h0170;    
    SET_OV7670 + 174  : LUT_DATA = 16'h0250;    
    SET_OV7670 + 175  : LUT_DATA = 16'h13E7;
    SET_OV7670 + 176 : LUT_DATA = 16'h5580;    
    SET_OV7670 + 177 : LUT_DATA = 16'h56A0;    
    SET_OV7670 + 178 : LUT_DATA = 16'h76A0;    
    SET_OV7670 + 179 : LUT_DATA = 16'h4B09;   
    SET_OV7670 + 180 : LUT_DATA = 16'h4E20;   
    SET_OV7670 + 181 : LUT_DATA = 16'h4F80;    
    SET_OV7670 + 182 : LUT_DATA = 16'h5080;   
    SET_OV7670 + 183 : LUT_DATA = 16'h1110;    
    SET_OV7670 + 184 : LUT_DATA = 16'h6B4A;    

	default		 :	LUT_DATA	=	0;
    endcase
end

endmodule