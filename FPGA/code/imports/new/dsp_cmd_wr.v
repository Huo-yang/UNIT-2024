`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:43 06/12/2015 
// Design Name: 
// Module Name:    dsp_cmd_wr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dsp_cmd_wr
#(
    parameter           BIT_NUM = 16
)
    (
    input clk,
    input dsp_iowr_en,
    input [11:0] adsp_addr,
    input [BIT_NUM - 1:0] adsp_databus_wr,
    output    reg         adj_ram_wen,
    
output reg [BIT_NUM - 1:0]  cmd_h000 ,   
output reg [BIT_NUM - 1:0]  cmd_h002 ,   
output reg [BIT_NUM - 1:0]  cmd_h004 ,   
output reg [BIT_NUM - 1:0]  cmd_h006 ,   
output reg [BIT_NUM - 1:0]  cmd_h008 ,   
output reg [BIT_NUM - 1:0]  cmd_h00A ,   
output reg [BIT_NUM - 1:0]  cmd_h00C ,   
output reg [BIT_NUM - 1:0]  cmd_h00E ,   
output reg [BIT_NUM - 1:0]  cmd_h010 ,  
output reg [BIT_NUM - 1:0]  cmd_h012 ,  
output reg [BIT_NUM - 1:0]  cmd_h014 ,  
output reg [BIT_NUM - 1:0]  cmd_h016 ,  
output reg [BIT_NUM - 1:0]  cmd_h018 ,  
output reg [BIT_NUM - 1:0]  cmd_h01A ,  
output reg [BIT_NUM - 1:0]  cmd_h01C ,  
output reg [BIT_NUM - 1:0]  cmd_h01E ,  
output reg [BIT_NUM - 1:0]  cmd_h020 ,  
output reg [BIT_NUM - 1:0]  cmd_h022 ,  
output reg [BIT_NUM - 1:0]  cmd_h024 ,  
output reg [BIT_NUM - 1:0]  cmd_h026 ,  
output reg [BIT_NUM - 1:0]  cmd_h028 ,  
output reg [BIT_NUM - 1:0]  cmd_h02A ,  
output reg [BIT_NUM - 1:0]  cmd_h02C ,  
output reg [BIT_NUM - 1:0]  cmd_h02E ,  
output reg [BIT_NUM - 1:0]  cmd_h030 ,  
output reg [BIT_NUM - 1:0]  cmd_h032 ,  
output reg [BIT_NUM - 1:0]  cmd_h034 ,  
output reg [BIT_NUM - 1:0]  cmd_h036 ,  
output reg [BIT_NUM - 1:0]  cmd_h038 ,  
output reg [BIT_NUM - 1:0]  cmd_h03A ,  
output reg [BIT_NUM - 1:0]  cmd_h03C ,  
output reg [BIT_NUM - 1:0]  cmd_h03E ,  
output reg [BIT_NUM - 1:0]  cmd_h040 ,  
output reg [BIT_NUM - 1:0]  cmd_h042 ,  
output reg [BIT_NUM - 1:0]  cmd_h044 ,  
output reg [BIT_NUM - 1:0]  cmd_h046 ,  
output reg [BIT_NUM - 1:0]  cmd_h048 ,  
output reg [BIT_NUM - 1:0]  cmd_h04A ,  
output reg [BIT_NUM - 1:0]  cmd_h04C ,  
output reg [BIT_NUM - 1:0]  cmd_h04E ,  
output reg [BIT_NUM - 1:0]  cmd_h050 ,  
output reg [BIT_NUM - 1:0]  cmd_h052 ,  
output reg [BIT_NUM - 1:0]  cmd_h054 ,  
output reg [BIT_NUM - 1:0]  cmd_h056 ,  
output reg [BIT_NUM - 1:0]  cmd_h058 ,  
output reg [BIT_NUM - 1:0]  cmd_h05A ,  
output reg [BIT_NUM - 1:0]  cmd_h05C ,  
output reg [BIT_NUM - 1:0]  cmd_h05E ,  
output reg [BIT_NUM - 1:0]  cmd_h060 ,  
output reg [BIT_NUM - 1:0]  cmd_h062 ,  
output reg [BIT_NUM - 1:0]  cmd_h064 ,  
output reg [BIT_NUM - 1:0]  cmd_h066 ,  
output reg [BIT_NUM - 1:0]  cmd_h068 ,  
output reg [BIT_NUM - 1:0]  cmd_h06A ,  
output reg [BIT_NUM - 1:0]  cmd_h06C ,  
output reg [BIT_NUM - 1:0]  cmd_h06E ,  
output reg [BIT_NUM - 1:0]  cmd_h070 ,  
output reg [BIT_NUM - 1:0]  cmd_h072 ,  
output reg [BIT_NUM - 1:0]  cmd_h074 ,  
output reg [BIT_NUM - 1:0]  cmd_h076 ,  
output reg [BIT_NUM - 1:0]  cmd_h078 ,  
output reg [BIT_NUM - 1:0]  cmd_h07A ,  
output reg [BIT_NUM - 1:0]  cmd_h07C ,  
output reg [BIT_NUM - 1:0]  cmd_h07E ,  
output reg [BIT_NUM - 1:0]  cmd_h080 ,  
output reg [BIT_NUM - 1:0]  cmd_h082 ,  
output reg [BIT_NUM - 1:0]  cmd_h084 ,  
output reg [BIT_NUM - 1:0]  cmd_h086 ,  
output reg [BIT_NUM - 1:0]  cmd_h088 ,  
output reg [BIT_NUM - 1:0]  cmd_h08A ,  
output reg [BIT_NUM - 1:0]  cmd_h08C ,  
output reg [BIT_NUM - 1:0]  cmd_h08E ,  
output reg [BIT_NUM - 1:0]  cmd_h090 ,  
output reg [BIT_NUM - 1:0]  cmd_h092 ,  
output reg [BIT_NUM - 1:0]  cmd_h094 ,  
output reg [BIT_NUM - 1:0]  cmd_h096 ,  
output reg [BIT_NUM - 1:0]  cmd_h098 ,  
output reg [BIT_NUM - 1:0]  cmd_h09A ,  
output reg [BIT_NUM - 1:0]  cmd_h09C ,  
output reg [BIT_NUM - 1:0]  cmd_h09E ,  
output reg [BIT_NUM - 1:0]  cmd_h0A0 ,  
output reg [BIT_NUM - 1:0]  cmd_h0A2 ,  
output reg [BIT_NUM - 1:0]  cmd_h0A4 ,  
output reg [BIT_NUM - 1:0]  cmd_h0A6 ,  
output reg [BIT_NUM - 1:0]  cmd_h0A8 ,  
output reg [BIT_NUM - 1:0]  cmd_h0AA ,  
output reg [BIT_NUM - 1:0]  cmd_h0AC ,  
output reg [BIT_NUM - 1:0]  cmd_h0AE ,  
output reg [BIT_NUM - 1:0]  cmd_h0B0 ,  
output reg [BIT_NUM - 1:0]  cmd_h0B2 ,  
output reg [BIT_NUM - 1:0]  cmd_h0B4 ,  
output reg [BIT_NUM - 1:0]  cmd_h0B6 ,  
output reg [BIT_NUM - 1:0]  cmd_h0B8 ,  
output reg [BIT_NUM - 1:0]  cmd_h0BA ,  
output reg [BIT_NUM - 1:0]  cmd_h0BC ,  
output reg [BIT_NUM - 1:0]  cmd_h0BE ,  
output reg [BIT_NUM - 1:0]  cmd_h0C0 ,  
output reg [BIT_NUM - 1:0]  cmd_h0C2 ,  
output reg [BIT_NUM - 1:0]  cmd_h0C4 ,  
output reg [BIT_NUM - 1:0]  cmd_h0C6 ,  
output reg [BIT_NUM - 1:0]  cmd_h0C8 ,  
output reg [BIT_NUM - 1:0]  cmd_h0CA ,  
output reg [BIT_NUM - 1:0]  cmd_h0CC ,  
output reg [BIT_NUM - 1:0]  cmd_h0CE ,  
output reg [BIT_NUM - 1:0]  cmd_h0D0 ,  
output reg [BIT_NUM - 1:0]  cmd_h0D2 ,  
output reg [BIT_NUM - 1:0]  cmd_h0D4 ,  
output reg [BIT_NUM - 1:0]  cmd_h0D6 ,  
output reg [BIT_NUM - 1:0]  cmd_h0D8 ,  
output reg [BIT_NUM - 1:0]  cmd_h0DA ,  
output reg [BIT_NUM - 1:0]  cmd_h0DC ,  
output reg [BIT_NUM - 1:0]  cmd_h0DE ,  
output reg [BIT_NUM - 1:0]  cmd_h0E0 ,  
output reg [BIT_NUM - 1:0]  cmd_h0E2 ,  
output reg [BIT_NUM - 1:0]  cmd_h0E4 ,  
output reg [BIT_NUM - 1:0]  cmd_h0E6 ,  
output reg [BIT_NUM - 1:0]  cmd_h0E8 ,  
output reg [BIT_NUM - 1:0]  cmd_h0EA ,  
output reg [BIT_NUM - 1:0]  cmd_h0EC ,  
output reg [BIT_NUM - 1:0]  cmd_h0EE ,  
output reg [BIT_NUM - 1:0]  cmd_h0F0 ,  
output reg [BIT_NUM - 1:0]  cmd_h0F2 ,  
output reg [BIT_NUM - 1:0]  cmd_h0F4 ,  
output reg [BIT_NUM - 1:0]  cmd_h0F6 ,  
output reg [BIT_NUM - 1:0]  cmd_h0F8 ,  
output reg [BIT_NUM - 1:0]  cmd_h0FA ,  
output reg [BIT_NUM - 1:0]  cmd_h0FC ,  
output reg [BIT_NUM - 1:0]  cmd_h0FE ,  
output reg [BIT_NUM - 1:0]  cmd_h100 , 
output reg [BIT_NUM - 1:0]  cmd_h102 , 
output reg [BIT_NUM - 1:0]  cmd_h104 , 
output reg [BIT_NUM - 1:0]  cmd_h106 , 
output reg [BIT_NUM - 1:0]  cmd_h108 , 
output reg [BIT_NUM - 1:0]  cmd_h10A , 
output reg [BIT_NUM - 1:0]  cmd_h10C , 
output reg [BIT_NUM - 1:0]  cmd_h10E , 
output reg [BIT_NUM - 1:0]  cmd_h110 , 
output reg [BIT_NUM - 1:0]  cmd_h112 , 
output reg [BIT_NUM - 1:0]  cmd_h114 , 
output reg [BIT_NUM - 1:0]  cmd_h116 , 
output reg [BIT_NUM - 1:0]  cmd_h118 , 
output reg [BIT_NUM - 1:0]  cmd_h11A , 
output reg [BIT_NUM - 1:0]  cmd_h11C , 
output reg [BIT_NUM - 1:0]  cmd_h11E , 
output reg [BIT_NUM - 1:0]  cmd_h120 , 
output reg [BIT_NUM - 1:0]  cmd_h122 , 
output reg [BIT_NUM - 1:0]  cmd_h124 , 
output reg [BIT_NUM - 1:0]  cmd_h126 , 
output reg [BIT_NUM - 1:0]  cmd_h128 , 
output reg [BIT_NUM - 1:0]  cmd_h12A , 
output reg [BIT_NUM - 1:0]  cmd_h12C , 
output reg [BIT_NUM - 1:0]  cmd_h12E , 
output reg [BIT_NUM - 1:0]  cmd_h130 , 
output reg [BIT_NUM - 1:0]  cmd_h132 , 
output reg [BIT_NUM - 1:0]  cmd_h134 , 
output reg [BIT_NUM - 1:0]  cmd_h136 , 
output reg [BIT_NUM - 1:0]  cmd_h138 , 
output reg [BIT_NUM - 1:0]  cmd_h13A , 
output reg [BIT_NUM - 1:0]  cmd_h13C , 
output reg [BIT_NUM - 1:0]  cmd_h13E , 
output reg [BIT_NUM - 1:0]  cmd_h140 , 
output reg [BIT_NUM - 1:0]  cmd_h142 , 
output reg [BIT_NUM - 1:0]  cmd_h144 , 
output reg [BIT_NUM - 1:0]  cmd_h146 , 
output reg [BIT_NUM - 1:0]  cmd_h148 , 
output reg [BIT_NUM - 1:0]  cmd_h14A , 
output reg [BIT_NUM - 1:0]  cmd_h14C , 
output reg [BIT_NUM - 1:0]  cmd_h14E , 
output reg [BIT_NUM - 1:0]  cmd_h150 , 
output reg [BIT_NUM - 1:0]  cmd_h152 , 
output reg [BIT_NUM - 1:0]  cmd_h154 , 
output reg [BIT_NUM - 1:0]  cmd_h156 , 
output reg [BIT_NUM - 1:0]  cmd_h158 , 
output reg [BIT_NUM - 1:0]  cmd_h15A , 
output reg [BIT_NUM - 1:0]  cmd_h15C , 
output reg [BIT_NUM - 1:0]  cmd_h15E , 
output reg [BIT_NUM - 1:0]  cmd_h160 , 
output reg [BIT_NUM - 1:0]  cmd_h162 , 
output reg [BIT_NUM - 1:0]  cmd_h164 , 
output reg [BIT_NUM - 1:0]  cmd_h166 , 
output reg [BIT_NUM - 1:0]  cmd_h168 , 
output reg [BIT_NUM - 1:0]  cmd_h16A , 
output reg [BIT_NUM - 1:0]  cmd_h16C , 
output reg [BIT_NUM - 1:0]  cmd_h16E , 
output reg [BIT_NUM - 1:0]  cmd_h170 , 
output reg [BIT_NUM - 1:0]  cmd_h172 , 
output reg [BIT_NUM - 1:0]  cmd_h174 , 
output reg [BIT_NUM - 1:0]  cmd_h176 , 
output reg [BIT_NUM - 1:0]  cmd_h178 , 
output reg [BIT_NUM - 1:0]  cmd_h17A , 
output reg [BIT_NUM - 1:0]  cmd_h17C , 
output reg [BIT_NUM - 1:0]  cmd_h17E , 
output reg [BIT_NUM - 1:0]  cmd_h180 , 
output reg [BIT_NUM - 1:0]  cmd_h182 , 
output reg [BIT_NUM - 1:0]  cmd_h184 , 
output reg [BIT_NUM - 1:0]  cmd_h186 , 
output reg [BIT_NUM - 1:0]  cmd_h188 , 
output reg [BIT_NUM - 1:0]  cmd_h18A , 
output reg [BIT_NUM - 1:0]  cmd_h18C , 
output reg [BIT_NUM - 1:0]  cmd_h18E , 
output reg [BIT_NUM - 1:0]  cmd_h190 , 
output reg [BIT_NUM - 1:0]  cmd_h192 , 
output reg [BIT_NUM - 1:0]  cmd_h194 , 
output reg [BIT_NUM - 1:0]  cmd_h196 , 
output reg [BIT_NUM - 1:0]  cmd_h198 , 
output reg [BIT_NUM - 1:0]  cmd_h19A , 
output reg [BIT_NUM - 1:0]  cmd_h19C , 
output reg [BIT_NUM - 1:0]  cmd_h19E , 
output reg [BIT_NUM - 1:0]  cmd_h1A0 , 
output reg [BIT_NUM - 1:0]  cmd_h1A2 , 
output reg [BIT_NUM - 1:0]  cmd_h1A4 , 
output reg [BIT_NUM - 1:0]  cmd_h1A6 , 
output reg [BIT_NUM - 1:0]  cmd_h1A8 , 
output reg [BIT_NUM - 1:0]  cmd_h1AA , 
output reg [BIT_NUM - 1:0]  cmd_h1AC , 
output reg [BIT_NUM - 1:0]  cmd_h1AE , 
output reg [BIT_NUM - 1:0]  cmd_h1B0 , 
output reg [BIT_NUM - 1:0]  cmd_h1B2 , 
output reg [BIT_NUM - 1:0]  cmd_h1B4 , 
output reg [BIT_NUM - 1:0]  cmd_h1B6 , 
output reg [BIT_NUM - 1:0]  cmd_h1B8 , 
output reg [BIT_NUM - 1:0]  cmd_h1BA , 
output reg [BIT_NUM - 1:0]  cmd_h1BC , 
output reg [BIT_NUM - 1:0]  cmd_h1BE , 
output reg [BIT_NUM - 1:0]  cmd_h1C0 , 
output reg [BIT_NUM - 1:0]  cmd_h1C2 , 
output reg [BIT_NUM - 1:0]  cmd_h1C4 , 
output reg [BIT_NUM - 1:0]  cmd_h1C6 , 
output reg [BIT_NUM - 1:0]  cmd_h1C8 , 
output reg [BIT_NUM - 1:0]  cmd_h1CA , 
output reg [BIT_NUM - 1:0]  cmd_h1CC , 
output reg [BIT_NUM - 1:0]  cmd_h1CE , 
output reg [BIT_NUM - 1:0]  cmd_h1D0 , 
output reg [BIT_NUM - 1:0]  cmd_h1D2 , 
output reg [BIT_NUM - 1:0]  cmd_h1D4 , 
output reg [BIT_NUM - 1:0]  cmd_h1D6 , 
output reg [BIT_NUM - 1:0]  cmd_h1D8 , 
output reg [BIT_NUM - 1:0]  cmd_h1DA , 
output reg [BIT_NUM - 1:0]  cmd_h1DC , 
output reg [BIT_NUM - 1:0]  cmd_h1DE , 
output reg [BIT_NUM - 1:0]  cmd_h1E0 , 
output reg [BIT_NUM - 1:0]  cmd_h1E2 , 
output reg [BIT_NUM - 1:0]  cmd_h1E4 , 
output reg [BIT_NUM - 1:0]  cmd_h1E6 , 
output reg [BIT_NUM - 1:0]  cmd_h1E8 , 
output reg [BIT_NUM - 1:0]  cmd_h1EA , 
output reg [BIT_NUM - 1:0]  cmd_h1EC , 
output reg [BIT_NUM - 1:0]  cmd_h1EE , 
output reg [BIT_NUM - 1:0]  cmd_h1F0 , 
output reg [BIT_NUM - 1:0]  cmd_h1F2 , 
output reg [BIT_NUM - 1:0]  cmd_h1F4 , 
output reg [BIT_NUM - 1:0]  cmd_h1F6 , 
output reg [BIT_NUM - 1:0]  cmd_h1F8 , 
output reg [BIT_NUM - 1:0]  cmd_h1FA , 
output reg [BIT_NUM - 1:0]  cmd_h1FC , 
output reg [BIT_NUM - 1:0]  cmd_h1FE ,



output reg [BIT_NUM - 1:0]  cmd_h200 , 
output reg [BIT_NUM - 1:0]  cmd_h202 , 
output reg [BIT_NUM - 1:0]  cmd_h204 , 
output reg [BIT_NUM - 1:0]  cmd_h206 , 
output reg [BIT_NUM - 1:0]  cmd_h208 , 
output reg [BIT_NUM - 1:0]  cmd_h20A , 
output reg [BIT_NUM - 1:0]  cmd_h20C , 
output reg [BIT_NUM - 1:0]  cmd_h20E , 
output reg [BIT_NUM - 1:0]  cmd_h210 , 
output reg [BIT_NUM - 1:0]  cmd_h212 , 
output reg [BIT_NUM - 1:0]  cmd_h214 , 
output reg [BIT_NUM - 1:0]  cmd_h216 , 
output reg [BIT_NUM - 1:0]  cmd_h218 , 
output reg [BIT_NUM - 1:0]  cmd_h21A , 
output reg [BIT_NUM - 1:0]  cmd_h21C , 
output reg [BIT_NUM - 1:0]  cmd_h21E , 
output reg [BIT_NUM - 1:0]  cmd_h220 , 
output reg [BIT_NUM - 1:0]  cmd_h222 , 
output reg [BIT_NUM - 1:0]  cmd_h224 , 
output reg [BIT_NUM - 1:0]  cmd_h226 , 
output reg [BIT_NUM - 1:0]  cmd_h228 , 
output reg [BIT_NUM - 1:0]  cmd_h22A , 
output reg [BIT_NUM - 1:0]  cmd_h22C , 
output reg [BIT_NUM - 1:0]  cmd_h22E , 
output reg [BIT_NUM - 1:0]  cmd_h230 , 
output reg [BIT_NUM - 1:0]  cmd_h232 , 
output reg [BIT_NUM - 1:0]  cmd_h234 , 
output reg [BIT_NUM - 1:0]  cmd_h236 , 
output reg [BIT_NUM - 1:0]  cmd_h238 , 
output reg [BIT_NUM - 1:0]  cmd_h23A , 
output reg [BIT_NUM - 1:0]  cmd_h23C , 
output reg [BIT_NUM - 1:0]  cmd_h23E , 
output reg [BIT_NUM - 1:0]  cmd_h240 , 
output reg [BIT_NUM - 1:0]  cmd_h242 , 
output reg [BIT_NUM - 1:0]  cmd_h244 , 
output reg [BIT_NUM - 1:0]  cmd_h246 , 
output reg [BIT_NUM - 1:0]  cmd_h248 , 
output reg [BIT_NUM - 1:0]  cmd_h24A , 
output reg [BIT_NUM - 1:0]  cmd_h24C , 
output reg [BIT_NUM - 1:0]  cmd_h24E , 
output reg [BIT_NUM - 1:0]  cmd_h250 , 
output reg [BIT_NUM - 1:0]  cmd_h252 , 
output reg [BIT_NUM - 1:0]  cmd_h254 , 
output reg [BIT_NUM - 1:0]  cmd_h256 , 
output reg [BIT_NUM - 1:0]  cmd_h258 , 
output reg [BIT_NUM - 1:0]  cmd_h25A , 
output reg [BIT_NUM - 1:0]  cmd_h25C , 
output reg [BIT_NUM - 1:0]  cmd_h25E , 
output reg [BIT_NUM - 1:0]  cmd_h260 , 
output reg [BIT_NUM - 1:0]  cmd_h262 , 
output reg [BIT_NUM - 1:0]  cmd_h264 , 
output reg [BIT_NUM - 1:0]  cmd_h266 , 
output reg [BIT_NUM - 1:0]  cmd_h268 , 
output reg [BIT_NUM - 1:0]  cmd_h26A , 
output reg [BIT_NUM - 1:0]  cmd_h26C , 
output reg [BIT_NUM - 1:0]  cmd_h26E , 
output reg [BIT_NUM - 1:0]  cmd_h270 , 
output reg [BIT_NUM - 1:0]  cmd_h272 , 
output reg [BIT_NUM - 1:0]  cmd_h274 , 
output reg [BIT_NUM - 1:0]  cmd_h276 , 
output reg [BIT_NUM - 1:0]  cmd_h278 , 
output reg [BIT_NUM - 1:0]  cmd_h27A , 
output reg [BIT_NUM - 1:0]  cmd_h27C , 
output reg [BIT_NUM - 1:0]  cmd_h27E , 
output reg [BIT_NUM - 1:0]  cmd_h280 , 
output reg [BIT_NUM - 1:0]  cmd_h282 , 
output reg [BIT_NUM - 1:0]  cmd_h284 , 
output reg [BIT_NUM - 1:0]  cmd_h286 , 
output reg [BIT_NUM - 1:0]  cmd_h288 , 
output reg [BIT_NUM - 1:0]  cmd_h28A , 
output reg [BIT_NUM - 1:0]  cmd_h28C , 
output reg [BIT_NUM - 1:0]  cmd_h28E , 
output reg [BIT_NUM - 1:0]  cmd_h290 , 
output reg [BIT_NUM - 1:0]  cmd_h292 , 
output reg [BIT_NUM - 1:0]  cmd_h294 , 
output reg [BIT_NUM - 1:0]  cmd_h296 , 
output reg [BIT_NUM - 1:0]  cmd_h298 , 
output reg [BIT_NUM - 1:0]  cmd_h29A , 
output reg [BIT_NUM - 1:0]  cmd_h29C , 
output reg [BIT_NUM - 1:0]  cmd_h29E , 
output reg [BIT_NUM - 1:0]  cmd_h2A0 , 
output reg [BIT_NUM - 1:0]  cmd_h2A2 , 
output reg [BIT_NUM - 1:0]  cmd_h2A4 , 
output reg [BIT_NUM - 1:0]  cmd_h2A6 , 
output reg [BIT_NUM - 1:0]  cmd_h2A8 , 
output reg [BIT_NUM - 1:0]  cmd_h2AA , 
output reg [BIT_NUM - 1:0]  cmd_h2AC , 
output reg [BIT_NUM - 1:0]  cmd_h2AE , 
output reg [BIT_NUM - 1:0]  cmd_h2B0 , 
output reg [BIT_NUM - 1:0]  cmd_h2B2 , 
output reg [BIT_NUM - 1:0]  cmd_h2B4 , 
output reg [BIT_NUM - 1:0]  cmd_h2B6 , 
output reg [BIT_NUM - 1:0]  cmd_h2B8 , 
output reg [BIT_NUM - 1:0]  cmd_h2BA , 
output reg [BIT_NUM - 1:0]  cmd_h2BC , 
output reg [BIT_NUM - 1:0]  cmd_h2BE , 
output reg [BIT_NUM - 1:0]  cmd_h2C0 , 
output reg [BIT_NUM - 1:0]  cmd_h2C2 , 
output reg [BIT_NUM - 1:0]  cmd_h2C4 , 
output reg [BIT_NUM - 1:0]  cmd_h2C6 , 
output reg [BIT_NUM - 1:0]  cmd_h2C8 , 
output reg [BIT_NUM - 1:0]  cmd_h2CA , 
output reg [BIT_NUM - 1:0]  cmd_h2CC , 
output reg [BIT_NUM - 1:0]  cmd_h2CE , 
output reg [BIT_NUM - 1:0]  cmd_h2D0 , 
output reg [BIT_NUM - 1:0]  cmd_h2D2 , 
output reg [BIT_NUM - 1:0]  cmd_h2D4 , 
output reg [BIT_NUM - 1:0]  cmd_h2D6 , 
output reg [BIT_NUM - 1:0]  cmd_h2D8 , 
output reg [BIT_NUM - 1:0]  cmd_h2DA , 
output reg [BIT_NUM - 1:0]  cmd_h2DC , 
output reg [BIT_NUM - 1:0]  cmd_h2DE , 
output reg [BIT_NUM - 1:0]  cmd_h2E0 , 
output reg [BIT_NUM - 1:0]  cmd_h2E2 , 
output reg [BIT_NUM - 1:0]  cmd_h2E4 , 
output reg [BIT_NUM - 1:0]  cmd_h2E6 , 
output reg [BIT_NUM - 1:0]  cmd_h2E8 , 
output reg [BIT_NUM - 1:0]  cmd_h2EA , 
output reg [BIT_NUM - 1:0]  cmd_h2EC , 
output reg [BIT_NUM - 1:0]  cmd_h2EE , 
output reg [BIT_NUM - 1:0]  cmd_h2F0 , 
output reg [BIT_NUM - 1:0]  cmd_h2F2 , 
output reg [BIT_NUM - 1:0]  cmd_h2F4 , 
output reg [BIT_NUM - 1:0]  cmd_h2F6 , 
output reg [BIT_NUM - 1:0]  cmd_h2F8 , 
output reg [BIT_NUM - 1:0]  cmd_h2FA , 
output reg [BIT_NUM - 1:0]  cmd_h2FC , 
output reg [BIT_NUM - 1:0]  cmd_h2FE ,


output reg [BIT_NUM - 1:0]  cmd_h300 , //dk
output reg [BIT_NUM - 1:0]  cmd_h302 , 
output reg [BIT_NUM - 1:0]  cmd_h304 , 
output reg [BIT_NUM - 1:0]  cmd_h306 , 
output reg [BIT_NUM - 1:0]  cmd_h308 , 
output reg [BIT_NUM - 1:0]  cmd_h30A , 
output reg [BIT_NUM - 1:0]  cmd_h30C , 
output reg [BIT_NUM - 1:0]  cmd_h30E , 
output reg [BIT_NUM - 1:0]  cmd_h310 , 
output reg [BIT_NUM - 1:0]  cmd_h312 , 
output reg [BIT_NUM - 1:0]  cmd_h314 , 
output reg [BIT_NUM - 1:0]  cmd_h316 , 
output reg [BIT_NUM - 1:0]  cmd_h318 , 
output reg [BIT_NUM - 1:0]  cmd_h31A , 
output reg [BIT_NUM - 1:0]  cmd_h31C , 
output reg [BIT_NUM - 1:0]  cmd_h31E , 
output reg [BIT_NUM - 1:0]  cmd_h320 , 
output reg [BIT_NUM - 1:0]  cmd_h322 , 
output reg [BIT_NUM - 1:0]  cmd_h324 , 
output reg [BIT_NUM - 1:0]  cmd_h326 , 
output reg [BIT_NUM - 1:0]  cmd_h328 , 
output reg [BIT_NUM - 1:0]  cmd_h32A , 
output reg [BIT_NUM - 1:0]  cmd_h32C , 
output reg [BIT_NUM - 1:0]  cmd_h32E , 
output reg [BIT_NUM - 1:0]  cmd_h330 , 
output reg [BIT_NUM - 1:0]  cmd_h332 , 
output reg [BIT_NUM - 1:0]  cmd_h334 , 
output reg [BIT_NUM - 1:0]  cmd_h336 , 
output reg [BIT_NUM - 1:0]  cmd_h338 , 
output reg [BIT_NUM - 1:0]  cmd_h33A , 
output reg [BIT_NUM - 1:0]  cmd_h33C , 
output reg [BIT_NUM - 1:0]  cmd_h33E , 
output reg [BIT_NUM - 1:0]  cmd_h340 , 
output reg [BIT_NUM - 1:0]  cmd_h342 , 
output reg [BIT_NUM - 1:0]  cmd_h344 , 
output reg [BIT_NUM - 1:0]  cmd_h346 , 
output reg [BIT_NUM - 1:0]  cmd_h348 , 
output reg [BIT_NUM - 1:0]  cmd_h34A , 
output reg [BIT_NUM - 1:0]  cmd_h34C , 
output reg [BIT_NUM - 1:0]  cmd_h34E , 
output reg [BIT_NUM - 1:0]  cmd_h350 , 
output reg [BIT_NUM - 1:0]  cmd_h352 , 
output reg [BIT_NUM - 1:0]  cmd_h354 , 
output reg [BIT_NUM - 1:0]  cmd_h356 , 
output reg [BIT_NUM - 1:0]  cmd_h358 , 
output reg [BIT_NUM - 1:0]  cmd_h35A , 
output reg [BIT_NUM - 1:0]  cmd_h35C , 
output reg [BIT_NUM - 1:0]  cmd_h35E , 
output reg [BIT_NUM - 1:0]  cmd_h360 , 
output reg [BIT_NUM - 1:0]  cmd_h362 , 
output reg [BIT_NUM - 1:0]  cmd_h364 , 
output reg [BIT_NUM - 1:0]  cmd_h366 , 
output reg [BIT_NUM - 1:0]  cmd_h368 , 
output reg [BIT_NUM - 1:0]  cmd_h36A , 
output reg [BIT_NUM - 1:0]  cmd_h36C , 
output reg [BIT_NUM - 1:0]  cmd_h36E , 
output reg [BIT_NUM - 1:0]  cmd_h370 , 
output reg [BIT_NUM - 1:0]  cmd_h372 , 
output reg [BIT_NUM - 1:0]  cmd_h374 , 
output reg [BIT_NUM - 1:0]  cmd_h376 , 
output reg [BIT_NUM - 1:0]  cmd_h378 , 
output reg [BIT_NUM - 1:0]  cmd_h37A , 
output reg [BIT_NUM - 1:0]  cmd_h37C , 
output reg [BIT_NUM - 1:0]  cmd_h37E , 
output reg [BIT_NUM - 1:0]  cmd_h380 , 
output reg [BIT_NUM - 1:0]  cmd_h382 , 
output reg [BIT_NUM - 1:0]  cmd_h384 , 
output reg [BIT_NUM - 1:0]  cmd_h386 , 
output reg [BIT_NUM - 1:0]  cmd_h388 , 
output reg [BIT_NUM - 1:0]  cmd_h38A , 
output reg [BIT_NUM - 1:0]  cmd_h38C , 
output reg [BIT_NUM - 1:0]  cmd_h38E , 
output reg [BIT_NUM - 1:0]  cmd_h390 , 
output reg [BIT_NUM - 1:0]  cmd_h392 , 
output reg [BIT_NUM - 1:0]  cmd_h394 , 
output reg [BIT_NUM - 1:0]  cmd_h396 , 
output reg [BIT_NUM - 1:0]  cmd_h398 , 
output reg [BIT_NUM - 1:0]  cmd_h39A , 
output reg [BIT_NUM - 1:0]  cmd_h39C , 
output reg [BIT_NUM - 1:0]  cmd_h39E , 
output reg [BIT_NUM - 1:0]  cmd_h3A0 , 
output reg [BIT_NUM - 1:0]  cmd_h3A2 , 
output reg [BIT_NUM - 1:0]  cmd_h3A4 , 
output reg [BIT_NUM - 1:0]  cmd_h3A6 , 
output reg [BIT_NUM - 1:0]  cmd_h3A8 , 
output reg [BIT_NUM - 1:0]  cmd_h3AA , 
output reg [BIT_NUM - 1:0]  cmd_h3AC , 
output reg [BIT_NUM - 1:0]  cmd_h3AE , 
output reg [BIT_NUM - 1:0]  cmd_h3B0 , 
output reg [BIT_NUM - 1:0]  cmd_h3B2 , 
output reg [BIT_NUM - 1:0]  cmd_h3B4 , 
output reg [BIT_NUM - 1:0]  cmd_h3B6 , 
output reg [BIT_NUM - 1:0]  cmd_h3B8 , 
output reg [BIT_NUM - 1:0]  cmd_h3BA , 
output reg [BIT_NUM - 1:0]  cmd_h3BC , 
output reg [BIT_NUM - 1:0]  cmd_h3BE , 
output reg [BIT_NUM - 1:0]  cmd_h3C0 , 
output reg [BIT_NUM - 1:0]  cmd_h3C2 , 
output reg [BIT_NUM - 1:0]  cmd_h3C4 , 
output reg [BIT_NUM - 1:0]  cmd_h3C6 , 
output reg [BIT_NUM - 1:0]  cmd_h3C8 , 
output reg [BIT_NUM - 1:0]  cmd_h3CA , 
output reg [BIT_NUM - 1:0]  cmd_h3CC , 
output reg [BIT_NUM - 1:0]  cmd_h3CE , 
output reg [BIT_NUM - 1:0]  cmd_h3D0 , 
output reg [BIT_NUM - 1:0]  cmd_h3D2 , 
output reg [BIT_NUM - 1:0]  cmd_h3D4 , 
output reg [BIT_NUM - 1:0]  cmd_h3D6 , 
output reg [BIT_NUM - 1:0]  cmd_h3D8 , 
output reg [BIT_NUM - 1:0]  cmd_h3DA , 
output reg [BIT_NUM - 1:0]  cmd_h3DC , 
output reg [BIT_NUM - 1:0]  cmd_h3DE , 
output reg [BIT_NUM - 1:0]  cmd_h3E0 , 
output reg [BIT_NUM - 1:0]  cmd_h3E2 , 
output reg [BIT_NUM - 1:0]  cmd_h3E4 , 
output reg [BIT_NUM - 1:0]  cmd_h3E6 , 
output reg [BIT_NUM - 1:0]  cmd_h3E8 , 
output reg [BIT_NUM - 1:0]  cmd_h3EA , 
output reg [BIT_NUM - 1:0]  cmd_h3EC , 
output reg [BIT_NUM - 1:0]  cmd_h3EE , 
output reg [BIT_NUM - 1:0]  cmd_h3F0 , 
output reg [BIT_NUM - 1:0]  cmd_h3F2 , 
output reg [BIT_NUM - 1:0]  cmd_h3F4 , 
output reg [BIT_NUM - 1:0]  cmd_h3F6 , 
output reg [BIT_NUM - 1:0]  cmd_h3F8 , 
output reg [BIT_NUM - 1:0]  cmd_h3FA , 
output reg [BIT_NUM - 1:0]  cmd_h3FC , 
output reg [BIT_NUM - 1:0]  cmd_h3FE 
    );

reg dsp_iowr_en_1q , dsp_iowr_en_2q , dsp_iowr_en_3q;
wire dsp_iowr_en_rising ;
wire dsp_iowr_en_falling ;


reg  [BIT_NUM - 1:0]  cmd_h000_reg  ;    
reg  [BIT_NUM - 1:0]  cmd_h002_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h004_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h006_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h008_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h00A_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h00C_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h00E_reg  ;   
reg  [BIT_NUM - 1:0]  cmd_h010_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h012_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h014_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h016_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h018_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h01A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h01C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h01E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h020_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h022_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h024_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h026_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h028_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h02A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h02C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h02E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h030_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h032_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h034_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h036_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h038_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h03A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h03C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h03E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h040_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h042_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h044_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h046_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h048_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h04A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h04C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h04E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h050_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h052_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h054_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h056_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h058_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h05A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h05C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h05E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h060_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h062_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h064_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h066_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h068_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h06A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h06C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h06E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h070_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h072_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h074_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h076_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h078_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h07A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h07C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h07E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h080_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h082_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h084_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h086_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h088_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h08A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h08C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h08E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h090_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h092_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h094_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h096_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h098_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h09A_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h09C_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h09E_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0A0_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0A2_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0A4_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0A6_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0A8_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0AA_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0AC_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0AE_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0B0_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0B2_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0B4_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0B6_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0B8_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0BA_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0BC_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0BE_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0C0_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0C2_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0C4_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0C6_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0C8_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0CA_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0CC_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0CE_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0D0_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0D2_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0D4_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0D6_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0D8_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0DA_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0DC_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0DE_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0E0_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0E2_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0E4_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0E6_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0E8_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0EA_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0EC_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0EE_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0F0_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0F2_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0F4_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0F6_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0F8_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0FA_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0FC_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h0FE_reg  ;  
reg  [BIT_NUM - 1:0]  cmd_h100_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h102_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h104_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h106_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h108_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h10A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h10C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h10E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h110_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h112_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h114_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h116_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h118_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h11A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h11C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h11E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h120_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h122_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h124_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h126_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h128_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h12A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h12C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h12E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h130_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h132_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h134_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h136_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h138_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h13A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h13C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h13E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h140_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h142_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h144_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h146_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h148_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h14A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h14C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h14E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h150_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h152_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h154_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h156_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h158_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h15A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h15C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h15E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h160_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h162_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h164_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h166_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h168_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h16A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h16C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h16E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h170_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h172_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h174_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h176_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h178_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h17A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h17C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h17E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h180_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h182_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h184_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h186_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h188_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h18A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h18C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h18E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h190_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h192_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h194_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h196_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h198_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h19A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h19C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h19E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1A0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1A2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1A4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1A6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1A8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1AA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1AC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1AE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1B0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1B2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1B4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1B6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1B8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1BA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1BC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1BE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1C0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1C2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1C4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1C6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1C8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1CA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1CC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1CE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1D0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1D2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1D4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1D6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1D8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1DA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1DC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1DE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1E0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1E2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1E4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1E6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1E8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1EA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1EC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1EE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1F0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1F2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1F4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1F6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1F8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1FA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1FC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h1FE_reg  ; 


reg  [BIT_NUM - 1:0]  cmd_h200_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h202_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h204_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h206_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h208_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h20A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h20C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h20E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h210_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h212_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h214_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h216_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h218_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h21A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h21C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h21E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h220_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h222_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h224_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h226_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h228_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h22A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h22C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h22E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h230_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h232_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h234_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h236_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h238_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h23A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h23C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h23E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h240_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h242_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h244_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h246_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h248_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h24A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h24C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h24E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h250_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h252_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h254_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h256_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h258_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h25A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h25C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h25E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h260_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h262_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h264_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h266_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h268_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h26A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h26C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h26E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h270_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h272_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h274_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h276_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h278_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h27A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h27C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h27E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h280_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h282_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h284_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h286_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h288_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h28A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h28C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h28E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h290_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h292_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h294_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h296_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h298_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h29A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h29C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h29E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2A0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2A2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2A4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2A6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2A8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2AA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2AC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2AE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2B0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2B2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2B4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2B6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2B8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2BA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2BC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2BE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2C0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2C2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2C4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2C6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2C8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2CA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2CC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2CE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2D0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2D2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2D4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2D6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2D8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2DA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2DC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2DE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2E0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2E2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2E4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2E6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2E8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2EA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2EC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2EE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2F0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2F2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2F4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2F6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2F8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2FA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2FC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h2FE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3FE_reg  ; 



reg  [BIT_NUM - 1:0]  cmd_h300_reg  ; //dk
reg  [BIT_NUM - 1:0]  cmd_h302_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h304_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h306_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h308_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h30A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h30C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h30E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h310_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h312_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h314_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h316_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h318_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h31A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h31C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h31E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h320_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h322_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h324_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h326_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h328_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h32A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h32C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h32E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h330_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h332_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h334_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h336_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h338_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h33A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h33C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h33E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h340_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h342_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h344_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h346_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h348_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h34A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h34C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h34E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h350_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h352_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h354_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h356_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h358_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h35A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h35C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h35E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h360_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h362_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h364_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h366_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h368_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h36A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h36C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h36E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h370_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h372_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h374_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h376_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h378_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h37A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h37C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h37E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h380_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h382_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h384_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h386_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h388_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h38A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h38C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h38E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h390_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h392_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h394_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h396_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h398_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h39A_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h39C_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h39E_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3A0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3A2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3A4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3A6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3A8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3AA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3AC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3AE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3B0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3B2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3B4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3B6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3B8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3BA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3BC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3BE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3C0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3C2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3C4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3C6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3C8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3CA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3CC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3CE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3D0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3D2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3D4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3D6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3D8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3DA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3DC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3DE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3E0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3E2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3E4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3E6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3E8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3EA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3EC_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3EE_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3F0_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3F2_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3F4_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3F6_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3F8_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3FA_reg  ; 
reg  [BIT_NUM - 1:0]  cmd_h3FC_reg  ; 
// reg  [BIT_NUM - 1:0]  cmd_h3FE_reg  ;

always @ (posedge clk)
begin   
dsp_iowr_en_1q <= dsp_iowr_en ;
dsp_iowr_en_2q <= dsp_iowr_en_1q ;
dsp_iowr_en_3q <= dsp_iowr_en_2q ;
end

assign dsp_iowr_en_rising  = dsp_iowr_en_1q & ~dsp_iowr_en_2q ;
assign dsp_iowr_en_falling = dsp_iowr_en_3q & ~dsp_iowr_en_2q ;


// (* IOB = "TRUE" *)
reg [BIT_NUM - 1:0] dsp_databus_wr ;
// (* IOB = "TRUE" *)
reg [12 - 1:0] dsp_addr ;
reg [12 - 1:0] dsp_addr_d1 ;

reg            dsp_iowr_en_falling_d1 ;

// always @ (posedge clk)
always @ (*)
begin
dsp_databus_wr[BIT_NUM - 1:0]   <= adsp_databus_wr[BIT_NUM - 1:0] ;
dsp_addr                        <= adsp_addr ;
dsp_addr_d1                     <= dsp_addr ;
dsp_iowr_en_falling_d1          <= dsp_iowr_en_falling ;
end

always @ (posedge clk)
begin
adj_ram_wen <= dsp_iowr_en_falling_d1 && (dsp_addr_d1 == 10'h078) ;
end


always @ (posedge clk)
begin   
    if(dsp_iowr_en_falling_d1)
 // if(!dsp_iowr_en_1q)
          case  (dsp_addr_d1[9:0])
            10'H000:    cmd_h000_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;      
            10'H002:    cmd_h002_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H004:    cmd_h004_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H006:    cmd_h006_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H008:    cmd_h008_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H00A:    cmd_h00A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H00C:    cmd_h00C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H00E:    cmd_h00E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;   
            10'H010:    cmd_h010_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H012:    cmd_h012_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H014:    cmd_h014_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H016:    cmd_h016_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H018:    cmd_h018_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H01A:    cmd_h01A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H01C:    cmd_h01C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H01E:    cmd_h01E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H020:    cmd_h020_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H022:    cmd_h022_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H024:    cmd_h024_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H026:    cmd_h026_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H028:    cmd_h028_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H02A:    cmd_h02A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H02C:    cmd_h02C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H02E:    cmd_h02E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H030:    cmd_h030_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H032:    cmd_h032_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H034:    cmd_h034_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H036:    cmd_h036_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H038:    cmd_h038_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H03A:    cmd_h03A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H03C:    cmd_h03C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H03E:    cmd_h03E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H040:    cmd_h040_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H042:    cmd_h042_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H044:    cmd_h044_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H046:    cmd_h046_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H048:    cmd_h048_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H04A:    cmd_h04A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H04C:    cmd_h04C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H04E:    cmd_h04E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H050:    cmd_h050_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H052:    cmd_h052_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H054:    cmd_h054_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H056:    cmd_h056_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H058:    cmd_h058_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H05A:    cmd_h05A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H05C:    cmd_h05C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H05E:    cmd_h05E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H060:    cmd_h060_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H062:    cmd_h062_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H064:    cmd_h064_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H066:    cmd_h066_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H068:    cmd_h068_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H06A:    cmd_h06A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H06C:    cmd_h06C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H06E:    cmd_h06E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H070:    cmd_h070_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H072:    cmd_h072_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H074:    cmd_h074_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H076:    cmd_h076_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H078:    cmd_h078_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H07A:    cmd_h07A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H07C:    cmd_h07C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H07E:    cmd_h07E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H080:    cmd_h080_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H082:    cmd_h082_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H084:    cmd_h084_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H086:    cmd_h086_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H088:    cmd_h088_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H08A:    cmd_h08A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H08C:    cmd_h08C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H08E:    cmd_h08E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H090:    cmd_h090_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H092:    cmd_h092_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H094:    cmd_h094_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H096:    cmd_h096_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H098:    cmd_h098_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H09A:    cmd_h09A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H09C:    cmd_h09C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H09E:    cmd_h09E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0A0:    cmd_h0A0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0A2:    cmd_h0A2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0A4:    cmd_h0A4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0A6:    cmd_h0A6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0A8:    cmd_h0A8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0AA:    cmd_h0AA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0AC:    cmd_h0AC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0AE:    cmd_h0AE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0B0:    cmd_h0B0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0B2:    cmd_h0B2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0B4:    cmd_h0B4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0B6:    cmd_h0B6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0B8:    cmd_h0B8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0BA:    cmd_h0BA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0BC:    cmd_h0BC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0BE:    cmd_h0BE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0C0:    cmd_h0C0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0C2:    cmd_h0C2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0C4:    cmd_h0C4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0C6:    cmd_h0C6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0C8:    cmd_h0C8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0CA:    cmd_h0CA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0CC:    cmd_h0CC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0CE:    cmd_h0CE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0D0:    cmd_h0D0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0D2:    cmd_h0D2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0D4:    cmd_h0D4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0D6:    cmd_h0D6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0D8:    cmd_h0D8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0DA:    cmd_h0DA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0DC:    cmd_h0DC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0DE:    cmd_h0DE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0E0:    cmd_h0E0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0E2:    cmd_h0E2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0E4:    cmd_h0E4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0E6:    cmd_h0E6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0E8:    cmd_h0E8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0EA:    cmd_h0EA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0EC:    cmd_h0EC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0EE:    cmd_h0EE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0F0:    cmd_h0F0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0F2:    cmd_h0F2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0F4:    cmd_h0F4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0F6:    cmd_h0F6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0F8:    cmd_h0F8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0FA:    cmd_h0FA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0FC:    cmd_h0FC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H0FE:    cmd_h0FE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;  
            10'H100:    cmd_h100_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H102:    cmd_h102_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H104:    cmd_h104_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H106:    cmd_h106_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H108:    cmd_h108_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H10A:    cmd_h10A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H10C:    cmd_h10C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H10E:    cmd_h10E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H110:    cmd_h110_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H112:    cmd_h112_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H114:    cmd_h114_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H116:    cmd_h116_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H118:    cmd_h118_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H11A:    cmd_h11A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H11C:    cmd_h11C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H11E:    cmd_h11E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H120:    cmd_h120_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H122:    cmd_h122_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H124:    cmd_h124_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H126:    cmd_h126_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H128:    cmd_h128_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H12A:    cmd_h12A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H12C:    cmd_h12C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H12E:    cmd_h12E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H130:    cmd_h130_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H132:    cmd_h132_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H134:    cmd_h134_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H136:    cmd_h136_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H138:    cmd_h138_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H13A:    cmd_h13A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H13C:    cmd_h13C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H13E:    cmd_h13E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H140:    cmd_h140_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H142:    cmd_h142_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H144:    cmd_h144_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H146:    cmd_h146_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H148:    cmd_h148_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H14A:    cmd_h14A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H14C:    cmd_h14C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H14E:    cmd_h14E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H150:    cmd_h150_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H152:    cmd_h152_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H154:    cmd_h154_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H156:    cmd_h156_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H158:    cmd_h158_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H15A:    cmd_h15A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H15C:    cmd_h15C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H15E:    cmd_h15E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H160:    cmd_h160_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H162:    cmd_h162_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H164:    cmd_h164_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H166:    cmd_h166_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H168:    cmd_h168_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H16A:    cmd_h16A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H16C:    cmd_h16C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H16E:    cmd_h16E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H170:    cmd_h170_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H172:    cmd_h172_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H174:    cmd_h174_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H176:    cmd_h176_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H178:    cmd_h178_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H17A:    cmd_h17A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H17C:    cmd_h17C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H17E:    cmd_h17E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H180:    cmd_h180_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H182:    cmd_h182_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H184:    cmd_h184_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H186:    cmd_h186_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H188:    cmd_h188_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H18A:    cmd_h18A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H18C:    cmd_h18C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H18E:    cmd_h18E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H190:    cmd_h190_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H192:    cmd_h192_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H194:    cmd_h194_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H196:    cmd_h196_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H198:    cmd_h198_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H19A:    cmd_h19A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H19C:    cmd_h19C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H19E:    cmd_h19E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1A0:    cmd_h1A0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1A2:    cmd_h1A2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1A4:    cmd_h1A4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1A6:    cmd_h1A6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1A8:    cmd_h1A8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1AA:    cmd_h1AA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1AC:    cmd_h1AC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1AE:    cmd_h1AE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1B0:    cmd_h1B0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1B2:    cmd_h1B2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1B4:    cmd_h1B4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1B6:    cmd_h1B6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1B8:    cmd_h1B8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1BA:    cmd_h1BA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1BC:    cmd_h1BC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1BE:    cmd_h1BE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1C0:    cmd_h1C0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1C2:    cmd_h1C2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1C4:    cmd_h1C4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1C6:    cmd_h1C6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1C8:    cmd_h1C8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1CA:    cmd_h1CA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1CC:    cmd_h1CC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1CE:    cmd_h1CE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1D0:    cmd_h1D0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1D2:    cmd_h1D2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1D4:    cmd_h1D4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1D6:    cmd_h1D6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1D8:    cmd_h1D8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1DA:    cmd_h1DA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1DC:    cmd_h1DC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1DE:    cmd_h1DE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1E0:    cmd_h1E0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1E2:    cmd_h1E2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1E4:    cmd_h1E4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1E6:    cmd_h1E6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1E8:    cmd_h1E8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1EA:    cmd_h1EA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1EC:    cmd_h1EC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1EE:    cmd_h1EE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1F0:    cmd_h1F0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1F2:    cmd_h1F2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1F4:    cmd_h1F4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1F6:    cmd_h1F6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1F8:    cmd_h1F8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1FA:    cmd_h1FA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1FC:    cmd_h1FC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H1FE:    cmd_h1FE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 



            10'H200: cmd_h200_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H202: cmd_h202_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H204: cmd_h204_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H206: cmd_h206_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H208: cmd_h208_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H20A: cmd_h20A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H20C: cmd_h20C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H20E: cmd_h20E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H210: cmd_h210_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H212: cmd_h212_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H214: cmd_h214_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H216: cmd_h216_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H218: cmd_h218_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H21A: cmd_h21A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H21C: cmd_h21C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H21E: cmd_h21E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H220: cmd_h220_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H222: cmd_h222_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H224: cmd_h224_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H226: cmd_h226_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H228: cmd_h228_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H22A: cmd_h22A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H22C: cmd_h22C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H22E: cmd_h22E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H230: cmd_h230_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H232: cmd_h232_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H234: cmd_h234_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H236: cmd_h236_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H238: cmd_h238_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H23A: cmd_h23A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H23C: cmd_h23C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H23E: cmd_h23E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H240: cmd_h240_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H242: cmd_h242_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H244: cmd_h244_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H246: cmd_h246_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H248: cmd_h248_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H24A: cmd_h24A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H24C: cmd_h24C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H24E: cmd_h24E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H250: cmd_h250_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H252: cmd_h252_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H254: cmd_h254_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H256: cmd_h256_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H258: cmd_h258_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H25A: cmd_h25A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H25C: cmd_h25C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H25E: cmd_h25E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H260: cmd_h260_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H262: cmd_h262_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H264: cmd_h264_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H266: cmd_h266_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H268: cmd_h268_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H26A: cmd_h26A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H26C: cmd_h26C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H26E: cmd_h26E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H270: cmd_h270_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H272: cmd_h272_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H274: cmd_h274_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H276: cmd_h276_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H278: cmd_h278_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H27A: cmd_h27A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H27C: cmd_h27C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H27E: cmd_h27E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H280: cmd_h280_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H282: cmd_h282_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H284: cmd_h284_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H286: cmd_h286_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H288: cmd_h288_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H28A: cmd_h28A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H28C: cmd_h28C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H28E: cmd_h28E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H290: cmd_h290_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H292: cmd_h292_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H294: cmd_h294_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H296: cmd_h296_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H298: cmd_h298_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H29A: cmd_h29A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H29C: cmd_h29C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H29E: cmd_h29E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2A0: cmd_h2A0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2A2: cmd_h2A2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2A4: cmd_h2A4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2A6: cmd_h2A6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2A8: cmd_h2A8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2AA: cmd_h2AA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2AC: cmd_h2AC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2AE: cmd_h2AE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2B0: cmd_h2B0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2B2: cmd_h2B2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2B4: cmd_h2B4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2B6: cmd_h2B6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2B8: cmd_h2B8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2BA: cmd_h2BA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2BC: cmd_h2BC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2BE: cmd_h2BE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2C0: cmd_h2C0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2C2: cmd_h2C2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2C4: cmd_h2C4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2C6: cmd_h2C6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2C8: cmd_h2C8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2CA: cmd_h2CA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2CC: cmd_h2CC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2CE: cmd_h2CE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2D0: cmd_h2D0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2D2: cmd_h2D2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2D4: cmd_h2D4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2D6: cmd_h2D6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2D8: cmd_h2D8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2DA: cmd_h2DA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2DC: cmd_h2DC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2DE: cmd_h2DE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2E0: cmd_h2E0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2E2: cmd_h2E2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2E4: cmd_h2E4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2E6: cmd_h2E6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2E8: cmd_h2E8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2EA: cmd_h2EA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2EC: cmd_h2EC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2EE: cmd_h2EE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2F0: cmd_h2F0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2F2: cmd_h2F2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2F4: cmd_h2F4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2F6: cmd_h2F6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2F8: cmd_h2F8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2FA: cmd_h2FA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2FC: cmd_h2FC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H2FE: cmd_h2FE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            
            
            10'H300: cmd_h300_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; //dk
            10'H302: cmd_h302_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H304: cmd_h304_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H306: cmd_h306_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H308: cmd_h308_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H30A: cmd_h30A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H30C: cmd_h30C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H30E: cmd_h30E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H310: cmd_h310_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H312: cmd_h312_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H314: cmd_h314_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H316: cmd_h316_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H318: cmd_h318_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H31A: cmd_h31A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H31C: cmd_h31C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H31E: cmd_h31E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H320: cmd_h320_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H322: cmd_h322_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H324: cmd_h324_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H326: cmd_h326_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H328: cmd_h328_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H32A: cmd_h32A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H32C: cmd_h32C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H32E: cmd_h32E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H330: cmd_h330_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H332: cmd_h332_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H334: cmd_h334_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H336: cmd_h336_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H338: cmd_h338_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H33A: cmd_h33A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H33C: cmd_h33C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H33E: cmd_h33E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H340: cmd_h340_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H342: cmd_h342_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H344: cmd_h344_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H346: cmd_h346_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H348: cmd_h348_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H34A: cmd_h34A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H34C: cmd_h34C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H34E: cmd_h34E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H350: cmd_h350_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H352: cmd_h352_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H354: cmd_h354_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H356: cmd_h356_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H358: cmd_h358_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H35A: cmd_h35A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H35C: cmd_h35C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H35E: cmd_h35E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H360: cmd_h360_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H362: cmd_h362_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H364: cmd_h364_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H366: cmd_h366_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H368: cmd_h368_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H36A: cmd_h36A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H36C: cmd_h36C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H36E: cmd_h36E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H370: cmd_h370_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H372: cmd_h372_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H374: cmd_h374_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H376: cmd_h376_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H378: cmd_h378_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H37A: cmd_h37A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H37C: cmd_h37C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H37E: cmd_h37E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H380: cmd_h380_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H382: cmd_h382_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H384: cmd_h384_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H386: cmd_h386_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H388: cmd_h388_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H38A: cmd_h38A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H38C: cmd_h38C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H38E: cmd_h38E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H390: cmd_h390_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H392: cmd_h392_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H394: cmd_h394_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H396: cmd_h396_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H398: cmd_h398_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H39A: cmd_h39A_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H39C: cmd_h39C_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H39E: cmd_h39E_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3A0: cmd_h3A0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3A2: cmd_h3A2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3A4: cmd_h3A4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3A6: cmd_h3A6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3A8: cmd_h3A8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3AA: cmd_h3AA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3AC: cmd_h3AC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3AE: cmd_h3AE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3B0: cmd_h3B0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3B2: cmd_h3B2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3B4: cmd_h3B4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3B6: cmd_h3B6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3B8: cmd_h3B8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3BA: cmd_h3BA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3BC: cmd_h3BC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3BE: cmd_h3BE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3C0: cmd_h3C0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3C2: cmd_h3C2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3C4: cmd_h3C4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3C6: cmd_h3C6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3C8: cmd_h3C8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3CA: cmd_h3CA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3CC: cmd_h3CC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3CE: cmd_h3CE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3D0: cmd_h3D0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3D2: cmd_h3D2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3D4: cmd_h3D4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3D6: cmd_h3D6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3D8: cmd_h3D8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3DA: cmd_h3DA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3DC: cmd_h3DC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3DE: cmd_h3DE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3E0: cmd_h3E0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3E2: cmd_h3E2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3E4: cmd_h3E4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3E6: cmd_h3E6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3E8: cmd_h3E8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3EA: cmd_h3EA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3EC: cmd_h3EC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3EE: cmd_h3EE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3F0: cmd_h3F0_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3F2: cmd_h3F2_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3F4: cmd_h3F4_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3F6: cmd_h3F6_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3F8: cmd_h3F8_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3FA: cmd_h3FA_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3FC: cmd_h3FC_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ; 
            10'H3FE: cmd_h3FE_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;      
            default: cmd_h000_reg[BIT_NUM - 1:0] <= dsp_databus_wr[BIT_NUM - 1:0] ;            
        endcase  
end  

always @ (posedge clk)
begin   
            cmd_h000[BIT_NUM - 1:0] <=  cmd_h000_reg[BIT_NUM - 1:0]   ;       
            cmd_h002[BIT_NUM - 1:0] <=  cmd_h002_reg[BIT_NUM - 1:0]   ;   
            cmd_h004[BIT_NUM - 1:0] <=  cmd_h004_reg[BIT_NUM - 1:0]   ;   
            cmd_h006[BIT_NUM - 1:0] <=  cmd_h006_reg[BIT_NUM - 1:0]   ;   
            cmd_h008[BIT_NUM - 1:0] <=  cmd_h008_reg[BIT_NUM - 1:0]   ;   
            cmd_h00A[BIT_NUM - 1:0] <=  cmd_h00A_reg[BIT_NUM - 1:0]   ;   
            cmd_h00C[BIT_NUM - 1:0] <=  cmd_h00C_reg[BIT_NUM - 1:0]   ;   
            cmd_h00E[BIT_NUM - 1:0] <=  cmd_h00E_reg[BIT_NUM - 1:0]   ;   
            cmd_h010[BIT_NUM - 1:0] <=  cmd_h010_reg[BIT_NUM - 1:0]  ;  
            cmd_h012[BIT_NUM - 1:0] <=  cmd_h012_reg[BIT_NUM - 1:0]  ;  
            cmd_h014[BIT_NUM - 1:0] <=  cmd_h014_reg[BIT_NUM - 1:0]  ;  
            cmd_h016[BIT_NUM - 1:0] <=  cmd_h016_reg[BIT_NUM - 1:0]  ;  
            cmd_h018[BIT_NUM - 1:0] <=  cmd_h018_reg[BIT_NUM - 1:0]  ;  
            cmd_h01A[BIT_NUM - 1:0] <=  cmd_h01A_reg[BIT_NUM - 1:0]  ;  
            cmd_h01C[BIT_NUM - 1:0] <=  cmd_h01C_reg[BIT_NUM - 1:0]  ;  
            cmd_h01E[BIT_NUM - 1:0] <=  cmd_h01E_reg[BIT_NUM - 1:0]  ;  
            cmd_h020[BIT_NUM - 1:0] <=  cmd_h020_reg[BIT_NUM - 1:0]  ;  
            cmd_h022[BIT_NUM - 1:0] <=  cmd_h022_reg[BIT_NUM - 1:0]  ;  
            cmd_h024[BIT_NUM - 1:0] <=  cmd_h024_reg[BIT_NUM - 1:0]  ;  
            cmd_h026[BIT_NUM - 1:0] <=  cmd_h026_reg[BIT_NUM - 1:0]  ;  
            cmd_h028[BIT_NUM - 1:0] <=  cmd_h028_reg[BIT_NUM - 1:0]  ;  
            cmd_h02A[BIT_NUM - 1:0] <=  cmd_h02A_reg[BIT_NUM - 1:0]  ;  
            cmd_h02C[BIT_NUM - 1:0] <=  cmd_h02C_reg[BIT_NUM - 1:0]  ;  
            cmd_h02E[BIT_NUM - 1:0] <=  cmd_h02E_reg[BIT_NUM - 1:0]  ;  
            cmd_h030[BIT_NUM - 1:0] <=  cmd_h030_reg[BIT_NUM - 1:0]  ;  
            cmd_h032[BIT_NUM - 1:0] <=  cmd_h032_reg[BIT_NUM - 1:0]  ;  
            cmd_h034[BIT_NUM - 1:0] <=  cmd_h034_reg[BIT_NUM - 1:0]  ;  
            cmd_h036[BIT_NUM - 1:0] <=  cmd_h036_reg[BIT_NUM - 1:0]  ;  
            cmd_h038[BIT_NUM - 1:0] <=  cmd_h038_reg[BIT_NUM - 1:0]  ;  
            cmd_h03A[BIT_NUM - 1:0] <=  cmd_h03A_reg[BIT_NUM - 1:0]  ;  
            cmd_h03C[BIT_NUM - 1:0] <=  cmd_h03C_reg[BIT_NUM - 1:0]  ;  
            cmd_h03E[BIT_NUM - 1:0] <=  cmd_h03E_reg[BIT_NUM - 1:0]  ;  
            cmd_h040[BIT_NUM - 1:0] <=  cmd_h040_reg[BIT_NUM - 1:0]  ;  
            cmd_h042[BIT_NUM - 1:0] <=  cmd_h042_reg[BIT_NUM - 1:0]  ;  
            cmd_h044[BIT_NUM - 1:0] <=  cmd_h044_reg[BIT_NUM - 1:0]  ;  
            cmd_h046[BIT_NUM - 1:0] <=  cmd_h046_reg[BIT_NUM - 1:0]  ;  
            cmd_h048[BIT_NUM - 1:0] <=  cmd_h048_reg[BIT_NUM - 1:0]  ;  
            cmd_h04A[BIT_NUM - 1:0] <=  cmd_h04A_reg[BIT_NUM - 1:0]  ;  
            cmd_h04C[BIT_NUM - 1:0] <=  cmd_h04C_reg[BIT_NUM - 1:0]  ;  
            cmd_h04E[BIT_NUM - 1:0] <=  cmd_h04E_reg[BIT_NUM - 1:0]  ;  
            cmd_h050[BIT_NUM - 1:0] <=  cmd_h050_reg[BIT_NUM - 1:0]  ;  
            cmd_h052[BIT_NUM - 1:0] <=  cmd_h052_reg[BIT_NUM - 1:0]  ;  
            cmd_h054[BIT_NUM - 1:0] <=  cmd_h054_reg[BIT_NUM - 1:0]  ;  
            cmd_h056[BIT_NUM - 1:0] <=  cmd_h056_reg[BIT_NUM - 1:0]  ;  
            cmd_h058[BIT_NUM - 1:0] <=  cmd_h058_reg[BIT_NUM - 1:0]  ;  
            cmd_h05A[BIT_NUM - 1:0] <=  cmd_h05A_reg[BIT_NUM - 1:0]  ;  
            cmd_h05C[BIT_NUM - 1:0] <=  cmd_h05C_reg[BIT_NUM - 1:0]  ;  
            cmd_h05E[BIT_NUM - 1:0] <=  cmd_h05E_reg[BIT_NUM - 1:0]  ;  
            cmd_h060[BIT_NUM - 1:0] <=  cmd_h060_reg[BIT_NUM - 1:0]  ;  
            cmd_h062[BIT_NUM - 1:0] <=  cmd_h062_reg[BIT_NUM - 1:0]  ;  
            cmd_h064[BIT_NUM - 1:0] <=  cmd_h064_reg[BIT_NUM - 1:0]  ;  
            cmd_h066[BIT_NUM - 1:0] <=  cmd_h066_reg[BIT_NUM - 1:0]  ;  
            cmd_h068[BIT_NUM - 1:0] <=  cmd_h068_reg[BIT_NUM - 1:0]  ;  
            cmd_h06A[BIT_NUM - 1:0] <=  cmd_h06A_reg[BIT_NUM - 1:0]  ;  
            cmd_h06C[BIT_NUM - 1:0] <=  cmd_h06C_reg[BIT_NUM - 1:0]  ;  
            cmd_h06E[BIT_NUM - 1:0] <=  cmd_h06E_reg[BIT_NUM - 1:0]  ;  
            cmd_h070[BIT_NUM - 1:0] <=  cmd_h070_reg[BIT_NUM - 1:0]  ;  
            cmd_h072[BIT_NUM - 1:0] <=  cmd_h072_reg[BIT_NUM - 1:0]  ;  
            cmd_h074[BIT_NUM - 1:0] <=  cmd_h074_reg[BIT_NUM - 1:0]  ;  
            cmd_h076[BIT_NUM - 1:0] <=  cmd_h076_reg[BIT_NUM - 1:0]  ;  
            cmd_h078[BIT_NUM - 1:0] <=  cmd_h078_reg[BIT_NUM - 1:0]  ;  
            cmd_h07A[BIT_NUM - 1:0] <=  cmd_h07A_reg[BIT_NUM - 1:0]  ;  
            cmd_h07C[BIT_NUM - 1:0] <=  cmd_h07C_reg[BIT_NUM - 1:0]  ;  
            cmd_h07E[BIT_NUM - 1:0] <=  cmd_h07E_reg[BIT_NUM - 1:0]  ;  
            cmd_h080[BIT_NUM - 1:0] <=  cmd_h080_reg[BIT_NUM - 1:0]  ;  
            cmd_h082[BIT_NUM - 1:0] <=  cmd_h082_reg[BIT_NUM - 1:0]  ;  
            cmd_h084[BIT_NUM - 1:0] <=  cmd_h084_reg[BIT_NUM - 1:0]  ;  
            cmd_h086[BIT_NUM - 1:0] <=  cmd_h086_reg[BIT_NUM - 1:0]  ;  
            cmd_h088[BIT_NUM - 1:0] <=  cmd_h088_reg[BIT_NUM - 1:0]  ;  
            cmd_h08A[BIT_NUM - 1:0] <=  cmd_h08A_reg[BIT_NUM - 1:0]  ;  
            cmd_h08C[BIT_NUM - 1:0] <=  cmd_h08C_reg[BIT_NUM - 1:0]  ;  
            cmd_h08E[BIT_NUM - 1:0] <=  cmd_h08E_reg[BIT_NUM - 1:0]  ;  
            cmd_h090[BIT_NUM - 1:0] <=  cmd_h090_reg[BIT_NUM - 1:0]  ;  
            cmd_h092[BIT_NUM - 1:0] <=  cmd_h092_reg[BIT_NUM - 1:0]  ;  
            cmd_h094[BIT_NUM - 1:0] <=  cmd_h094_reg[BIT_NUM - 1:0]  ;  
            cmd_h096[BIT_NUM - 1:0] <=  cmd_h096_reg[BIT_NUM - 1:0]  ;  
            cmd_h098[BIT_NUM - 1:0] <=  cmd_h098_reg[BIT_NUM - 1:0]  ;  
            cmd_h09A[BIT_NUM - 1:0] <=  cmd_h09A_reg[BIT_NUM - 1:0]  ;  
            cmd_h09C[BIT_NUM - 1:0] <=  cmd_h09C_reg[BIT_NUM - 1:0]  ;  
            cmd_h09E[BIT_NUM - 1:0] <=  cmd_h09E_reg[BIT_NUM - 1:0]  ;  
            cmd_h0A0[BIT_NUM - 1:0] <=  cmd_h0A0_reg[BIT_NUM - 1:0]  ;  
            cmd_h0A2[BIT_NUM - 1:0] <=  cmd_h0A2_reg[BIT_NUM - 1:0]  ;  
            cmd_h0A4[BIT_NUM - 1:0] <=  cmd_h0A4_reg[BIT_NUM - 1:0]  ;  
            cmd_h0A6[BIT_NUM - 1:0] <=  cmd_h0A6_reg[BIT_NUM - 1:0]  ;  
            cmd_h0A8[BIT_NUM - 1:0] <=  cmd_h0A8_reg[BIT_NUM - 1:0]  ;  
            cmd_h0AA[BIT_NUM - 1:0] <=  cmd_h0AA_reg[BIT_NUM - 1:0]  ;  
            cmd_h0AC[BIT_NUM - 1:0] <=  cmd_h0AC_reg[BIT_NUM - 1:0]  ;  
            cmd_h0AE[BIT_NUM - 1:0] <=  cmd_h0AE_reg[BIT_NUM - 1:0]  ;  
            cmd_h0B0[BIT_NUM - 1:0] <=  cmd_h0B0_reg[BIT_NUM - 1:0]  ;  
            cmd_h0B2[BIT_NUM - 1:0] <=  cmd_h0B2_reg[BIT_NUM - 1:0]  ;  
            cmd_h0B4[BIT_NUM - 1:0] <=  cmd_h0B4_reg[BIT_NUM - 1:0]  ;  
            cmd_h0B6[BIT_NUM - 1:0] <=  cmd_h0B6_reg[BIT_NUM - 1:0]  ;  
            cmd_h0B8[BIT_NUM - 1:0] <=  cmd_h0B8_reg[BIT_NUM - 1:0]  ;  
            cmd_h0BA[BIT_NUM - 1:0] <=  cmd_h0BA_reg[BIT_NUM - 1:0]  ;  
            cmd_h0BC[BIT_NUM - 1:0] <=  cmd_h0BC_reg[BIT_NUM - 1:0]  ;  
            cmd_h0BE[BIT_NUM - 1:0] <=  cmd_h0BE_reg[BIT_NUM - 1:0]  ;  
            cmd_h0C0[BIT_NUM - 1:0] <=  cmd_h0C0_reg[BIT_NUM - 1:0]  ;  
            cmd_h0C2[BIT_NUM - 1:0] <=  cmd_h0C2_reg[BIT_NUM - 1:0]  ;  
            cmd_h0C4[BIT_NUM - 1:0] <=  cmd_h0C4_reg[BIT_NUM - 1:0]  ;  
            cmd_h0C6[BIT_NUM - 1:0] <=  cmd_h0C6_reg[BIT_NUM - 1:0]  ;  
            cmd_h0C8[BIT_NUM - 1:0] <=  cmd_h0C8_reg[BIT_NUM - 1:0]  ;  
            cmd_h0CA[BIT_NUM - 1:0] <=  cmd_h0CA_reg[BIT_NUM - 1:0]  ;  
            cmd_h0CC[BIT_NUM - 1:0] <=  cmd_h0CC_reg[BIT_NUM - 1:0]  ;  
            cmd_h0CE[BIT_NUM - 1:0] <=  cmd_h0CE_reg[BIT_NUM - 1:0]  ;  
            cmd_h0D0[BIT_NUM - 1:0] <=  cmd_h0D0_reg[BIT_NUM - 1:0]  ;  
            cmd_h0D2[BIT_NUM - 1:0] <=  cmd_h0D2_reg[BIT_NUM - 1:0]  ;  
            cmd_h0D4[BIT_NUM - 1:0] <=  cmd_h0D4_reg[BIT_NUM - 1:0]  ;  
            cmd_h0D6[BIT_NUM - 1:0] <=  cmd_h0D6_reg[BIT_NUM - 1:0]  ;  
            cmd_h0D8[BIT_NUM - 1:0] <=  cmd_h0D8_reg[BIT_NUM - 1:0]  ;  
            cmd_h0DA[BIT_NUM - 1:0] <=  cmd_h0DA_reg[BIT_NUM - 1:0]  ;  
            cmd_h0DC[BIT_NUM - 1:0] <=  cmd_h0DC_reg[BIT_NUM - 1:0]  ;  
            cmd_h0DE[BIT_NUM - 1:0] <=  cmd_h0DE_reg[BIT_NUM - 1:0]  ;  
            cmd_h0E0[BIT_NUM - 1:0] <=  cmd_h0E0_reg[BIT_NUM - 1:0]  ;  
            cmd_h0E2[BIT_NUM - 1:0] <=  cmd_h0E2_reg[BIT_NUM - 1:0]  ;  
            cmd_h0E4[BIT_NUM - 1:0] <=  cmd_h0E4_reg[BIT_NUM - 1:0]  ;  
            cmd_h0E6[BIT_NUM - 1:0] <=  cmd_h0E6_reg[BIT_NUM - 1:0]  ;  
            cmd_h0E8[BIT_NUM - 1:0] <=  cmd_h0E8_reg[BIT_NUM - 1:0]  ;  
            cmd_h0EA[BIT_NUM - 1:0] <=  cmd_h0EA_reg[BIT_NUM - 1:0]  ;  
            cmd_h0EC[BIT_NUM - 1:0] <=  cmd_h0EC_reg[BIT_NUM - 1:0]  ;  
            cmd_h0EE[BIT_NUM - 1:0] <=  cmd_h0EE_reg[BIT_NUM - 1:0]  ;  
            cmd_h0F0[BIT_NUM - 1:0] <=  cmd_h0F0_reg[BIT_NUM - 1:0]  ;  
            cmd_h0F2[BIT_NUM - 1:0] <=  cmd_h0F2_reg[BIT_NUM - 1:0]  ;  
            cmd_h0F4[BIT_NUM - 1:0] <=  cmd_h0F4_reg[BIT_NUM - 1:0]  ;  
            cmd_h0F6[BIT_NUM - 1:0] <=  cmd_h0F6_reg[BIT_NUM - 1:0]  ;  
            cmd_h0F8[BIT_NUM - 1:0] <=  cmd_h0F8_reg[BIT_NUM - 1:0]  ;  
            cmd_h0FA[BIT_NUM - 1:0] <=  cmd_h0FA_reg[BIT_NUM - 1:0]  ;  
            cmd_h0FC[BIT_NUM - 1:0] <=  cmd_h0FC_reg[BIT_NUM - 1:0]  ;  
            cmd_h0FE[BIT_NUM - 1:0] <=  cmd_h0FE_reg[BIT_NUM - 1:0]  ;  
            cmd_h100[BIT_NUM - 1:0] <=  cmd_h100_reg[BIT_NUM - 1:0] ; 
            cmd_h102[BIT_NUM - 1:0] <=  cmd_h102_reg[BIT_NUM - 1:0] ; 
            cmd_h104[BIT_NUM - 1:0] <=  cmd_h104_reg[BIT_NUM - 1:0] ; 
            cmd_h106[BIT_NUM - 1:0] <=  cmd_h106_reg[BIT_NUM - 1:0] ; 
            cmd_h108[BIT_NUM - 1:0] <=  cmd_h108_reg[BIT_NUM - 1:0] ; 
            cmd_h10A[BIT_NUM - 1:0] <=  cmd_h10A_reg[BIT_NUM - 1:0] ; 
            cmd_h10C[BIT_NUM - 1:0] <=  cmd_h10C_reg[BIT_NUM - 1:0] ; 
            cmd_h10E[BIT_NUM - 1:0] <=  cmd_h10E_reg[BIT_NUM - 1:0] ; 
            cmd_h110[BIT_NUM - 1:0] <=  cmd_h110_reg[BIT_NUM - 1:0] ; 
            cmd_h112[BIT_NUM - 1:0] <=  cmd_h112_reg[BIT_NUM - 1:0] ; 
            cmd_h114[BIT_NUM - 1:0] <=  cmd_h114_reg[BIT_NUM - 1:0] ; 
            cmd_h116[BIT_NUM - 1:0] <=  cmd_h116_reg[BIT_NUM - 1:0] ; 
            cmd_h118[BIT_NUM - 1:0] <=  cmd_h118_reg[BIT_NUM - 1:0] ; 
            cmd_h11A[BIT_NUM - 1:0] <=  cmd_h11A_reg[BIT_NUM - 1:0] ; 
            cmd_h11C[BIT_NUM - 1:0] <=  cmd_h11C_reg[BIT_NUM - 1:0] ; 
            cmd_h11E[BIT_NUM - 1:0] <=  cmd_h11E_reg[BIT_NUM - 1:0] ; 
            cmd_h120[BIT_NUM - 1:0] <=  cmd_h120_reg[BIT_NUM - 1:0] ; 
            cmd_h122[BIT_NUM - 1:0] <=  cmd_h122_reg[BIT_NUM - 1:0] ; 
            cmd_h124[BIT_NUM - 1:0] <=  cmd_h124_reg[BIT_NUM - 1:0] ; 
            cmd_h126[BIT_NUM - 1:0] <=  cmd_h126_reg[BIT_NUM - 1:0] ; 
            cmd_h128[BIT_NUM - 1:0] <=  cmd_h128_reg[BIT_NUM - 1:0] ; 
            cmd_h12A[BIT_NUM - 1:0] <=  cmd_h12A_reg[BIT_NUM - 1:0] ; 
            cmd_h12C[BIT_NUM - 1:0] <=  cmd_h12C_reg[BIT_NUM - 1:0] ; 
            cmd_h12E[BIT_NUM - 1:0] <=  cmd_h12E_reg[BIT_NUM - 1:0] ; 
            cmd_h130[BIT_NUM - 1:0] <=  cmd_h130_reg[BIT_NUM - 1:0] ; 
            cmd_h132[BIT_NUM - 1:0] <=  cmd_h132_reg[BIT_NUM - 1:0] ; 
            cmd_h134[BIT_NUM - 1:0] <=  cmd_h134_reg[BIT_NUM - 1:0] ; 
            cmd_h136[BIT_NUM - 1:0] <=  cmd_h136_reg[BIT_NUM - 1:0] ; 
            cmd_h138[BIT_NUM - 1:0] <=  cmd_h138_reg[BIT_NUM - 1:0] ; 
            cmd_h13A[BIT_NUM - 1:0] <=  cmd_h13A_reg[BIT_NUM - 1:0] ; 
            cmd_h13C[BIT_NUM - 1:0] <=  cmd_h13C_reg[BIT_NUM - 1:0] ; 
            cmd_h13E[BIT_NUM - 1:0] <=  cmd_h13E_reg[BIT_NUM - 1:0] ; 
            cmd_h140[BIT_NUM - 1:0] <=  cmd_h140_reg[BIT_NUM - 1:0] ; 
            cmd_h142[BIT_NUM - 1:0] <=  cmd_h142_reg[BIT_NUM - 1:0] ; 
            cmd_h144[BIT_NUM - 1:0] <=  cmd_h144_reg[BIT_NUM - 1:0] ; 
            cmd_h146[BIT_NUM - 1:0] <=  cmd_h146_reg[BIT_NUM - 1:0] ; 
            cmd_h148[BIT_NUM - 1:0] <=  cmd_h148_reg[BIT_NUM - 1:0] ; 
            cmd_h14A[BIT_NUM - 1:0] <=  cmd_h14A_reg[BIT_NUM - 1:0] ; 
            cmd_h14C[BIT_NUM - 1:0] <=  cmd_h14C_reg[BIT_NUM - 1:0] ; 
            cmd_h14E[BIT_NUM - 1:0] <=  cmd_h14E_reg[BIT_NUM - 1:0] ; 
            cmd_h150[BIT_NUM - 1:0] <=  cmd_h150_reg[BIT_NUM - 1:0] ; 
            cmd_h152[BIT_NUM - 1:0] <=  cmd_h152_reg[BIT_NUM - 1:0] ; 
            cmd_h154[BIT_NUM - 1:0] <=  cmd_h154_reg[BIT_NUM - 1:0] ; 
            cmd_h156[BIT_NUM - 1:0] <=  cmd_h156_reg[BIT_NUM - 1:0] ; 
            cmd_h158[BIT_NUM - 1:0] <=  cmd_h158_reg[BIT_NUM - 1:0] ; 
            cmd_h15A[BIT_NUM - 1:0] <=  cmd_h15A_reg[BIT_NUM - 1:0] ; 
            cmd_h15C[BIT_NUM - 1:0] <=  cmd_h15C_reg[BIT_NUM - 1:0] ; 
            cmd_h15E[BIT_NUM - 1:0] <=  cmd_h15E_reg[BIT_NUM - 1:0] ; 
            cmd_h160[BIT_NUM - 1:0] <=  cmd_h160_reg[BIT_NUM - 1:0] ; 
            cmd_h162[BIT_NUM - 1:0] <=  cmd_h162_reg[BIT_NUM - 1:0] ; 
            cmd_h164[BIT_NUM - 1:0] <=  cmd_h164_reg[BIT_NUM - 1:0] ; 
            cmd_h166[BIT_NUM - 1:0] <=  cmd_h166_reg[BIT_NUM - 1:0] ; 
            cmd_h168[BIT_NUM - 1:0] <=  cmd_h168_reg[BIT_NUM - 1:0] ; 
            cmd_h16A[BIT_NUM - 1:0] <=  cmd_h16A_reg[BIT_NUM - 1:0] ; 
            cmd_h16C[BIT_NUM - 1:0] <=  cmd_h16C_reg[BIT_NUM - 1:0] ; 
            cmd_h16E[BIT_NUM - 1:0] <=  cmd_h16E_reg[BIT_NUM - 1:0] ; 
            cmd_h170[BIT_NUM - 1:0] <=  cmd_h170_reg[BIT_NUM - 1:0] ; 
            cmd_h172[BIT_NUM - 1:0] <=  cmd_h172_reg[BIT_NUM - 1:0] ; 
            cmd_h174[BIT_NUM - 1:0] <=  cmd_h174_reg[BIT_NUM - 1:0] ; 
            cmd_h176[BIT_NUM - 1:0] <=  cmd_h176_reg[BIT_NUM - 1:0] ; 
            cmd_h178[BIT_NUM - 1:0] <=  cmd_h178_reg[BIT_NUM - 1:0] ; 
            cmd_h17A[BIT_NUM - 1:0] <=  cmd_h17A_reg[BIT_NUM - 1:0] ; 
            cmd_h17C[BIT_NUM - 1:0] <=  cmd_h17C_reg[BIT_NUM - 1:0] ; 
            cmd_h17E[BIT_NUM - 1:0] <=  cmd_h17E_reg[BIT_NUM - 1:0] ; 
            cmd_h180[BIT_NUM - 1:0] <=  cmd_h180_reg[BIT_NUM - 1:0] ; 
            cmd_h182[BIT_NUM - 1:0] <=  cmd_h182_reg[BIT_NUM - 1:0] ; 
            cmd_h184[BIT_NUM - 1:0] <=  cmd_h184_reg[BIT_NUM - 1:0] ; 
            cmd_h186[BIT_NUM - 1:0] <=  cmd_h186_reg[BIT_NUM - 1:0] ; 
            cmd_h188[BIT_NUM - 1:0] <=  cmd_h188_reg[BIT_NUM - 1:0] ; 
            cmd_h18A[BIT_NUM - 1:0] <=  cmd_h18A_reg[BIT_NUM - 1:0] ; 
            cmd_h18C[BIT_NUM - 1:0] <=  cmd_h18C_reg[BIT_NUM - 1:0] ; 
            cmd_h18E[BIT_NUM - 1:0] <=  cmd_h18E_reg[BIT_NUM - 1:0] ; 
            cmd_h190[BIT_NUM - 1:0] <=  cmd_h190_reg[BIT_NUM - 1:0] ; 
            cmd_h192[BIT_NUM - 1:0] <=  cmd_h192_reg[BIT_NUM - 1:0] ; 
            cmd_h194[BIT_NUM - 1:0] <=  cmd_h194_reg[BIT_NUM - 1:0] ; 
            cmd_h196[BIT_NUM - 1:0] <=  cmd_h196_reg[BIT_NUM - 1:0] ; 
            cmd_h198[BIT_NUM - 1:0] <=  cmd_h198_reg[BIT_NUM - 1:0] ; 
            cmd_h19A[BIT_NUM - 1:0] <=  cmd_h19A_reg[BIT_NUM - 1:0] ; 
            cmd_h19C[BIT_NUM - 1:0] <=  cmd_h19C_reg[BIT_NUM - 1:0] ; 
            cmd_h19E[BIT_NUM - 1:0] <=  cmd_h19E_reg[BIT_NUM - 1:0] ; 
            cmd_h1A0[BIT_NUM - 1:0] <=  cmd_h1A0_reg[BIT_NUM - 1:0] ; 
            cmd_h1A2[BIT_NUM - 1:0] <=  cmd_h1A2_reg[BIT_NUM - 1:0] ; 
            cmd_h1A4[BIT_NUM - 1:0] <=  cmd_h1A4_reg[BIT_NUM - 1:0] ; 
            cmd_h1A6[BIT_NUM - 1:0] <=  cmd_h1A6_reg[BIT_NUM - 1:0] ; 
            cmd_h1A8[BIT_NUM - 1:0] <=  cmd_h1A8_reg[BIT_NUM - 1:0] ; 
            cmd_h1AA[BIT_NUM - 1:0] <=  cmd_h1AA_reg[BIT_NUM - 1:0] ; 
            cmd_h1AC[BIT_NUM - 1:0] <=  cmd_h1AC_reg[BIT_NUM - 1:0] ; 
            cmd_h1AE[BIT_NUM - 1:0] <=  cmd_h1AE_reg[BIT_NUM - 1:0] ; 
            cmd_h1B0[BIT_NUM - 1:0] <=  cmd_h1B0_reg[BIT_NUM - 1:0] ; 
            cmd_h1B2[BIT_NUM - 1:0] <=  cmd_h1B2_reg[BIT_NUM - 1:0] ; 
            cmd_h1B4[BIT_NUM - 1:0] <=  cmd_h1B4_reg[BIT_NUM - 1:0] ; 
            cmd_h1B6[BIT_NUM - 1:0] <=  cmd_h1B6_reg[BIT_NUM - 1:0] ; 
            cmd_h1B8[BIT_NUM - 1:0] <=  cmd_h1B8_reg[BIT_NUM - 1:0] ; 
            cmd_h1BA[BIT_NUM - 1:0] <=  cmd_h1BA_reg[BIT_NUM - 1:0] ; 
            cmd_h1BC[BIT_NUM - 1:0] <=  cmd_h1BC_reg[BIT_NUM - 1:0] ; 
            cmd_h1BE[BIT_NUM - 1:0] <=  cmd_h1BE_reg[BIT_NUM - 1:0] ; 
            cmd_h1C0[BIT_NUM - 1:0] <=  cmd_h1C0_reg[BIT_NUM - 1:0] ; 
            cmd_h1C2[BIT_NUM - 1:0] <=  cmd_h1C2_reg[BIT_NUM - 1:0] ; 
            cmd_h1C4[BIT_NUM - 1:0] <=  cmd_h1C4_reg[BIT_NUM - 1:0] ; 
            cmd_h1C6[BIT_NUM - 1:0] <=  cmd_h1C6_reg[BIT_NUM - 1:0] ; 
            cmd_h1C8[BIT_NUM - 1:0] <=  cmd_h1C8_reg[BIT_NUM - 1:0] ; 
            cmd_h1CA[BIT_NUM - 1:0] <=  cmd_h1CA_reg[BIT_NUM - 1:0] ; 
            cmd_h1CC[BIT_NUM - 1:0] <=  cmd_h1CC_reg[BIT_NUM - 1:0] ; 
            cmd_h1CE[BIT_NUM - 1:0] <=  cmd_h1CE_reg[BIT_NUM - 1:0] ; 
            cmd_h1D0[BIT_NUM - 1:0] <=  cmd_h1D0_reg[BIT_NUM - 1:0] ; 
            cmd_h1D2[BIT_NUM - 1:0] <=  cmd_h1D2_reg[BIT_NUM - 1:0] ; 
            cmd_h1D4[BIT_NUM - 1:0] <=  cmd_h1D4_reg[BIT_NUM - 1:0] ; 
            cmd_h1D6[BIT_NUM - 1:0] <=  cmd_h1D6_reg[BIT_NUM - 1:0] ; 
            cmd_h1D8[BIT_NUM - 1:0] <=  cmd_h1D8_reg[BIT_NUM - 1:0] ; 
            cmd_h1DA[BIT_NUM - 1:0] <=  cmd_h1DA_reg[BIT_NUM - 1:0] ; 
            cmd_h1DC[BIT_NUM - 1:0] <=  cmd_h1DC_reg[BIT_NUM - 1:0] ; 
            cmd_h1DE[BIT_NUM - 1:0] <=  cmd_h1DE_reg[BIT_NUM - 1:0] ; 
            cmd_h1E0[BIT_NUM - 1:0] <=  cmd_h1E0_reg[BIT_NUM - 1:0] ; 
            cmd_h1E2[BIT_NUM - 1:0] <=  cmd_h1E2_reg[BIT_NUM - 1:0] ; 
            cmd_h1E4[BIT_NUM - 1:0] <=  cmd_h1E4_reg[BIT_NUM - 1:0] ; 
            cmd_h1E6[BIT_NUM - 1:0] <=  cmd_h1E6_reg[BIT_NUM - 1:0] ; 
            cmd_h1E8[BIT_NUM - 1:0] <=  cmd_h1E8_reg[BIT_NUM - 1:0] ; 
            cmd_h1EA[BIT_NUM - 1:0] <=  cmd_h1EA_reg[BIT_NUM - 1:0] ; 
            cmd_h1EC[BIT_NUM - 1:0] <=  cmd_h1EC_reg[BIT_NUM - 1:0] ; 
            cmd_h1EE[BIT_NUM - 1:0] <=  cmd_h1EE_reg[BIT_NUM - 1:0] ; 
            cmd_h1F0[BIT_NUM - 1:0] <=  cmd_h1F0_reg[BIT_NUM - 1:0] ; 
            cmd_h1F2[BIT_NUM - 1:0] <=  cmd_h1F2_reg[BIT_NUM - 1:0] ; 
            cmd_h1F4[BIT_NUM - 1:0] <=  cmd_h1F4_reg[BIT_NUM - 1:0] ; 
            cmd_h1F6[BIT_NUM - 1:0] <=  cmd_h1F6_reg[BIT_NUM - 1:0] ; 
            cmd_h1F8[BIT_NUM - 1:0] <=  cmd_h1F8_reg[BIT_NUM - 1:0] ; 
            cmd_h1FA[BIT_NUM - 1:0] <=  cmd_h1FA_reg[BIT_NUM - 1:0] ; 
            cmd_h1FC[BIT_NUM - 1:0] <=  cmd_h1FC_reg[BIT_NUM - 1:0] ; 
            cmd_h1FE[BIT_NUM - 1:0] <=  cmd_h1FE_reg[BIT_NUM - 1:0] ; 
            
            cmd_h200[BIT_NUM - 1:0] <=  cmd_h200_reg[BIT_NUM - 1:0] ; 
            cmd_h202[BIT_NUM - 1:0] <=  cmd_h202_reg[BIT_NUM - 1:0] ; 
            cmd_h204[BIT_NUM - 1:0] <=  cmd_h204_reg[BIT_NUM - 1:0] ; 
            cmd_h206[BIT_NUM - 1:0] <=  cmd_h206_reg[BIT_NUM - 1:0] ; 
            cmd_h208[BIT_NUM - 1:0] <=  cmd_h208_reg[BIT_NUM - 1:0] ; 
            cmd_h20A[BIT_NUM - 1:0] <=  cmd_h20A_reg[BIT_NUM - 1:0] ; 
            cmd_h20C[BIT_NUM - 1:0] <=  cmd_h20C_reg[BIT_NUM - 1:0] ; 
            cmd_h20E[BIT_NUM - 1:0] <=  cmd_h20E_reg[BIT_NUM - 1:0] ; 
            cmd_h210[BIT_NUM - 1:0] <=  cmd_h210_reg[BIT_NUM - 1:0] ; 
            cmd_h212[BIT_NUM - 1:0] <=  cmd_h212_reg[BIT_NUM - 1:0] ; 
            cmd_h214[BIT_NUM - 1:0] <=  cmd_h214_reg[BIT_NUM - 1:0] ; 
            cmd_h216[BIT_NUM - 1:0] <=  cmd_h216_reg[BIT_NUM - 1:0] ; 
            cmd_h218[BIT_NUM - 1:0] <=  cmd_h218_reg[BIT_NUM - 1:0] ; 
            cmd_h21A[BIT_NUM - 1:0] <=  cmd_h21A_reg[BIT_NUM - 1:0] ; 
            cmd_h21C[BIT_NUM - 1:0] <=  cmd_h21C_reg[BIT_NUM - 1:0] ; 
            cmd_h21E[BIT_NUM - 1:0] <=  cmd_h21E_reg[BIT_NUM - 1:0] ; 
            cmd_h220[BIT_NUM - 1:0] <=  cmd_h220_reg[BIT_NUM - 1:0] ; 
            cmd_h222[BIT_NUM - 1:0] <=  cmd_h222_reg[BIT_NUM - 1:0] ; 
            cmd_h224[BIT_NUM - 1:0] <=  cmd_h224_reg[BIT_NUM - 1:0] ; 
            cmd_h226[BIT_NUM - 1:0] <=  cmd_h226_reg[BIT_NUM - 1:0] ; 
            cmd_h228[BIT_NUM - 1:0] <=  cmd_h228_reg[BIT_NUM - 1:0] ; 
            cmd_h22A[BIT_NUM - 1:0] <=  cmd_h22A_reg[BIT_NUM - 1:0] ; 
            cmd_h22C[BIT_NUM - 1:0] <=  cmd_h22C_reg[BIT_NUM - 1:0] ; 
            cmd_h22E[BIT_NUM - 1:0] <=  cmd_h22E_reg[BIT_NUM - 1:0] ; 
            cmd_h230[BIT_NUM - 1:0] <=  cmd_h230_reg[BIT_NUM - 1:0] ; 
            cmd_h232[BIT_NUM - 1:0] <=  cmd_h232_reg[BIT_NUM - 1:0] ; 
            cmd_h234[BIT_NUM - 1:0] <=  cmd_h234_reg[BIT_NUM - 1:0] ; 
            cmd_h236[BIT_NUM - 1:0] <=  cmd_h236_reg[BIT_NUM - 1:0] ; 
            cmd_h238[BIT_NUM - 1:0] <=  cmd_h238_reg[BIT_NUM - 1:0] ; 
            cmd_h23A[BIT_NUM - 1:0] <=  cmd_h23A_reg[BIT_NUM - 1:0] ; 
            cmd_h23C[BIT_NUM - 1:0] <=  cmd_h23C_reg[BIT_NUM - 1:0] ; 
            cmd_h23E[BIT_NUM - 1:0] <=  cmd_h23E_reg[BIT_NUM - 1:0] ; 
            cmd_h240[BIT_NUM - 1:0] <=  cmd_h240_reg[BIT_NUM - 1:0] ; 
            cmd_h242[BIT_NUM - 1:0] <=  cmd_h242_reg[BIT_NUM - 1:0] ; 
            cmd_h244[BIT_NUM - 1:0] <=  cmd_h244_reg[BIT_NUM - 1:0] ; 
            cmd_h246[BIT_NUM - 1:0] <=  cmd_h246_reg[BIT_NUM - 1:0] ; 
            cmd_h248[BIT_NUM - 1:0] <=  cmd_h248_reg[BIT_NUM - 1:0] ; 
            cmd_h24A[BIT_NUM - 1:0] <=  cmd_h24A_reg[BIT_NUM - 1:0] ; 
            cmd_h24C[BIT_NUM - 1:0] <=  cmd_h24C_reg[BIT_NUM - 1:0] ; 
            cmd_h24E[BIT_NUM - 1:0] <=  cmd_h24E_reg[BIT_NUM - 1:0] ; 
            cmd_h250[BIT_NUM - 1:0] <=  cmd_h250_reg[BIT_NUM - 1:0] ; 
            cmd_h252[BIT_NUM - 1:0] <=  cmd_h252_reg[BIT_NUM - 1:0] ; 
            cmd_h254[BIT_NUM - 1:0] <=  cmd_h254_reg[BIT_NUM - 1:0] ; 
            cmd_h256[BIT_NUM - 1:0] <=  cmd_h256_reg[BIT_NUM - 1:0] ; 
            cmd_h258[BIT_NUM - 1:0] <=  cmd_h258_reg[BIT_NUM - 1:0] ; 
            cmd_h25A[BIT_NUM - 1:0] <=  cmd_h25A_reg[BIT_NUM - 1:0] ; 
            cmd_h25C[BIT_NUM - 1:0] <=  cmd_h25C_reg[BIT_NUM - 1:0] ; 
            cmd_h25E[BIT_NUM - 1:0] <=  cmd_h25E_reg[BIT_NUM - 1:0] ; 
            cmd_h260[BIT_NUM - 1:0] <=  cmd_h260_reg[BIT_NUM - 1:0] ; 
            cmd_h262[BIT_NUM - 1:0] <=  cmd_h262_reg[BIT_NUM - 1:0] ; 
            cmd_h264[BIT_NUM - 1:0] <=  cmd_h264_reg[BIT_NUM - 1:0] ; 
            cmd_h266[BIT_NUM - 1:0] <=  cmd_h266_reg[BIT_NUM - 1:0] ; 
            cmd_h268[BIT_NUM - 1:0] <=  cmd_h268_reg[BIT_NUM - 1:0] ; 
            cmd_h26A[BIT_NUM - 1:0] <=  cmd_h26A_reg[BIT_NUM - 1:0] ; 
            cmd_h26C[BIT_NUM - 1:0] <=  cmd_h26C_reg[BIT_NUM - 1:0] ; 
            cmd_h26E[BIT_NUM - 1:0] <=  cmd_h26E_reg[BIT_NUM - 1:0] ; 
            cmd_h270[BIT_NUM - 1:0] <=  cmd_h270_reg[BIT_NUM - 1:0] ; 
            cmd_h272[BIT_NUM - 1:0] <=  cmd_h272_reg[BIT_NUM - 1:0] ; 
            cmd_h274[BIT_NUM - 1:0] <=  cmd_h274_reg[BIT_NUM - 1:0] ; 
            cmd_h276[BIT_NUM - 1:0] <=  cmd_h276_reg[BIT_NUM - 1:0] ; 
            cmd_h278[BIT_NUM - 1:0] <=  cmd_h278_reg[BIT_NUM - 1:0] ; 
            cmd_h27A[BIT_NUM - 1:0] <=  cmd_h27A_reg[BIT_NUM - 1:0] ; 
            cmd_h27C[BIT_NUM - 1:0] <=  cmd_h27C_reg[BIT_NUM - 1:0] ; 
            cmd_h27E[BIT_NUM - 1:0] <=  cmd_h27E_reg[BIT_NUM - 1:0] ; 
            cmd_h280[BIT_NUM - 1:0] <=  cmd_h280_reg[BIT_NUM - 1:0] ; 
            cmd_h282[BIT_NUM - 1:0] <=  cmd_h282_reg[BIT_NUM - 1:0] ; 
            cmd_h284[BIT_NUM - 1:0] <=  cmd_h284_reg[BIT_NUM - 1:0] ; 
            cmd_h286[BIT_NUM - 1:0] <=  cmd_h286_reg[BIT_NUM - 1:0] ; 
            cmd_h288[BIT_NUM - 1:0] <=  cmd_h288_reg[BIT_NUM - 1:0] ; 
            cmd_h28A[BIT_NUM - 1:0] <=  cmd_h28A_reg[BIT_NUM - 1:0] ; 
            cmd_h28C[BIT_NUM - 1:0] <=  cmd_h28C_reg[BIT_NUM - 1:0] ; 
            cmd_h28E[BIT_NUM - 1:0] <=  cmd_h28E_reg[BIT_NUM - 1:0] ; 
            cmd_h290[BIT_NUM - 1:0] <=  cmd_h290_reg[BIT_NUM - 1:0] ; 
            cmd_h292[BIT_NUM - 1:0] <=  cmd_h292_reg[BIT_NUM - 1:0] ; 
            cmd_h294[BIT_NUM - 1:0] <=  cmd_h294_reg[BIT_NUM - 1:0] ; 
            cmd_h296[BIT_NUM - 1:0] <=  cmd_h296_reg[BIT_NUM - 1:0] ; 
            cmd_h298[BIT_NUM - 1:0] <=  cmd_h298_reg[BIT_NUM - 1:0] ; 
            cmd_h29A[BIT_NUM - 1:0] <=  cmd_h29A_reg[BIT_NUM - 1:0] ; 
            cmd_h29C[BIT_NUM - 1:0] <=  cmd_h29C_reg[BIT_NUM - 1:0] ; 
            cmd_h29E[BIT_NUM - 1:0] <=  cmd_h29E_reg[BIT_NUM - 1:0] ; 
            cmd_h2A0[BIT_NUM - 1:0] <=  cmd_h2A0_reg[BIT_NUM - 1:0] ; 
            cmd_h2A2[BIT_NUM - 1:0] <=  cmd_h2A2_reg[BIT_NUM - 1:0] ; 
            cmd_h2A4[BIT_NUM - 1:0] <=  cmd_h2A4_reg[BIT_NUM - 1:0] ; 
            cmd_h2A6[BIT_NUM - 1:0] <=  cmd_h2A6_reg[BIT_NUM - 1:0] ; 
            cmd_h2A8[BIT_NUM - 1:0] <=  cmd_h2A8_reg[BIT_NUM - 1:0] ; 
            cmd_h2AA[BIT_NUM - 1:0] <=  cmd_h2AA_reg[BIT_NUM - 1:0] ; 
            cmd_h2AC[BIT_NUM - 1:0] <=  cmd_h2AC_reg[BIT_NUM - 1:0] ; 
            cmd_h2AE[BIT_NUM - 1:0] <=  cmd_h2AE_reg[BIT_NUM - 1:0] ; 
            cmd_h2B0[BIT_NUM - 1:0] <=  cmd_h2B0_reg[BIT_NUM - 1:0] ; 
            cmd_h2B2[BIT_NUM - 1:0] <=  cmd_h2B2_reg[BIT_NUM - 1:0] ; 
            cmd_h2B4[BIT_NUM - 1:0] <=  cmd_h2B4_reg[BIT_NUM - 1:0] ; 
            cmd_h2B6[BIT_NUM - 1:0] <=  cmd_h2B6_reg[BIT_NUM - 1:0] ; 
            cmd_h2B8[BIT_NUM - 1:0] <=  cmd_h2B8_reg[BIT_NUM - 1:0] ; 
            cmd_h2BA[BIT_NUM - 1:0] <=  cmd_h2BA_reg[BIT_NUM - 1:0] ; 
            cmd_h2BC[BIT_NUM - 1:0] <=  cmd_h2BC_reg[BIT_NUM - 1:0] ; 
            cmd_h2BE[BIT_NUM - 1:0] <=  cmd_h2BE_reg[BIT_NUM - 1:0] ; 
            cmd_h2C0[BIT_NUM - 1:0] <=  cmd_h2C0_reg[BIT_NUM - 1:0] ; 
            cmd_h2C2[BIT_NUM - 1:0] <=  cmd_h2C2_reg[BIT_NUM - 1:0] ; 
            cmd_h2C4[BIT_NUM - 1:0] <=  cmd_h2C4_reg[BIT_NUM - 1:0] ; 
            cmd_h2C6[BIT_NUM - 1:0] <=  cmd_h2C6_reg[BIT_NUM - 1:0] ; 
            cmd_h2C8[BIT_NUM - 1:0] <=  cmd_h2C8_reg[BIT_NUM - 1:0] ; 
            cmd_h2CA[BIT_NUM - 1:0] <=  cmd_h2CA_reg[BIT_NUM - 1:0] ; 
            cmd_h2CC[BIT_NUM - 1:0] <=  cmd_h2CC_reg[BIT_NUM - 1:0] ; 
            cmd_h2CE[BIT_NUM - 1:0] <=  cmd_h2CE_reg[BIT_NUM - 1:0] ; 
            cmd_h2D0[BIT_NUM - 1:0] <=  cmd_h2D0_reg[BIT_NUM - 1:0] ; 
            cmd_h2D2[BIT_NUM - 1:0] <=  cmd_h2D2_reg[BIT_NUM - 1:0] ; 
            cmd_h2D4[BIT_NUM - 1:0] <=  cmd_h2D4_reg[BIT_NUM - 1:0] ; 
            cmd_h2D6[BIT_NUM - 1:0] <=  cmd_h2D6_reg[BIT_NUM - 1:0] ; 
            cmd_h2D8[BIT_NUM - 1:0] <=  cmd_h2D8_reg[BIT_NUM - 1:0] ; 
            cmd_h2DA[BIT_NUM - 1:0] <=  cmd_h2DA_reg[BIT_NUM - 1:0] ; 
            cmd_h2DC[BIT_NUM - 1:0] <=  cmd_h2DC_reg[BIT_NUM - 1:0] ; 
            cmd_h2DE[BIT_NUM - 1:0] <=  cmd_h2DE_reg[BIT_NUM - 1:0] ; 
            cmd_h2E0[BIT_NUM - 1:0] <=  cmd_h2E0_reg[BIT_NUM - 1:0] ; 
            cmd_h2E2[BIT_NUM - 1:0] <=  cmd_h2E2_reg[BIT_NUM - 1:0] ; 
            cmd_h2E4[BIT_NUM - 1:0] <=  cmd_h2E4_reg[BIT_NUM - 1:0] ; 
            cmd_h2E6[BIT_NUM - 1:0] <=  cmd_h2E6_reg[BIT_NUM - 1:0] ; 
            cmd_h2E8[BIT_NUM - 1:0] <=  cmd_h2E8_reg[BIT_NUM - 1:0] ; 
            cmd_h2EA[BIT_NUM - 1:0] <=  cmd_h2EA_reg[BIT_NUM - 1:0] ; 
            cmd_h2EC[BIT_NUM - 1:0] <=  cmd_h2EC_reg[BIT_NUM - 1:0] ; 
            cmd_h2EE[BIT_NUM - 1:0] <=  cmd_h2EE_reg[BIT_NUM - 1:0] ; 
            cmd_h2F0[BIT_NUM - 1:0] <=  cmd_h2F0_reg[BIT_NUM - 1:0] ; 
            cmd_h2F2[BIT_NUM - 1:0] <=  cmd_h2F2_reg[BIT_NUM - 1:0] ; 
            cmd_h2F4[BIT_NUM - 1:0] <=  cmd_h2F4_reg[BIT_NUM - 1:0] ; 
            cmd_h2F6[BIT_NUM - 1:0] <=  cmd_h2F6_reg[BIT_NUM - 1:0] ; 
            cmd_h2F8[BIT_NUM - 1:0] <=  cmd_h2F8_reg[BIT_NUM - 1:0] ; 
            cmd_h2FA[BIT_NUM - 1:0] <=  cmd_h2FA_reg[BIT_NUM - 1:0] ; 
            cmd_h2FC[BIT_NUM - 1:0] <=  cmd_h2FC_reg[BIT_NUM - 1:0] ; 
            cmd_h2FE[BIT_NUM - 1:0] <=  cmd_h2FE_reg[BIT_NUM - 1:0] ; 
            
            
            cmd_h300[BIT_NUM - 1:0] <=  cmd_h300_reg[BIT_NUM - 1:0] ; //dk
            cmd_h302[BIT_NUM - 1:0] <=  cmd_h302_reg[BIT_NUM - 1:0] ; 
            cmd_h304[BIT_NUM - 1:0] <=  cmd_h304_reg[BIT_NUM - 1:0] ; 
            cmd_h306[BIT_NUM - 1:0] <=  cmd_h306_reg[BIT_NUM - 1:0] ; 
            cmd_h308[BIT_NUM - 1:0] <=  cmd_h308_reg[BIT_NUM - 1:0] ; 
            cmd_h30A[BIT_NUM - 1:0] <=  cmd_h30A_reg[BIT_NUM - 1:0] ; 
            cmd_h30C[BIT_NUM - 1:0] <=  cmd_h30C_reg[BIT_NUM - 1:0] ; 
            cmd_h30E[BIT_NUM - 1:0] <=  cmd_h30E_reg[BIT_NUM - 1:0] ; 
            cmd_h310[BIT_NUM - 1:0] <=  cmd_h310_reg[BIT_NUM - 1:0] ; 
            cmd_h312[BIT_NUM - 1:0] <=  cmd_h312_reg[BIT_NUM - 1:0] ; 
            cmd_h314[BIT_NUM - 1:0] <=  cmd_h314_reg[BIT_NUM - 1:0] ; 
            cmd_h316[BIT_NUM - 1:0] <=  cmd_h316_reg[BIT_NUM - 1:0] ; 
            cmd_h318[BIT_NUM - 1:0] <=  cmd_h318_reg[BIT_NUM - 1:0] ; 
            cmd_h31A[BIT_NUM - 1:0] <=  cmd_h31A_reg[BIT_NUM - 1:0] ; 
            cmd_h31C[BIT_NUM - 1:0] <=  cmd_h31C_reg[BIT_NUM - 1:0] ; 
            cmd_h31E[BIT_NUM - 1:0] <=  cmd_h31E_reg[BIT_NUM - 1:0] ; 
            cmd_h320[BIT_NUM - 1:0] <=  cmd_h320_reg[BIT_NUM - 1:0] ; 
            cmd_h322[BIT_NUM - 1:0] <=  cmd_h322_reg[BIT_NUM - 1:0] ; 
            cmd_h324[BIT_NUM - 1:0] <=  cmd_h324_reg[BIT_NUM - 1:0] ; 
            cmd_h326[BIT_NUM - 1:0] <=  cmd_h326_reg[BIT_NUM - 1:0] ; 
            cmd_h328[BIT_NUM - 1:0] <=  cmd_h328_reg[BIT_NUM - 1:0] ; 
            cmd_h32A[BIT_NUM - 1:0] <=  cmd_h32A_reg[BIT_NUM - 1:0] ; 
            cmd_h32C[BIT_NUM - 1:0] <=  cmd_h32C_reg[BIT_NUM - 1:0] ; 
            cmd_h32E[BIT_NUM - 1:0] <=  cmd_h32E_reg[BIT_NUM - 1:0] ; 
            cmd_h330[BIT_NUM - 1:0] <=  cmd_h330_reg[BIT_NUM - 1:0] ; 
            cmd_h332[BIT_NUM - 1:0] <=  cmd_h332_reg[BIT_NUM - 1:0] ; 
            cmd_h334[BIT_NUM - 1:0] <=  cmd_h334_reg[BIT_NUM - 1:0] ; 
            cmd_h336[BIT_NUM - 1:0] <=  cmd_h336_reg[BIT_NUM - 1:0] ; 
            cmd_h338[BIT_NUM - 1:0] <=  cmd_h338_reg[BIT_NUM - 1:0] ; 
            cmd_h33A[BIT_NUM - 1:0] <=  cmd_h33A_reg[BIT_NUM - 1:0] ; 
            cmd_h33C[BIT_NUM - 1:0] <=  cmd_h33C_reg[BIT_NUM - 1:0] ; 
            cmd_h33E[BIT_NUM - 1:0] <=  cmd_h33E_reg[BIT_NUM - 1:0] ; 
            cmd_h340[BIT_NUM - 1:0] <=  cmd_h340_reg[BIT_NUM - 1:0] ; 
            cmd_h342[BIT_NUM - 1:0] <=  cmd_h342_reg[BIT_NUM - 1:0] ; 
            cmd_h344[BIT_NUM - 1:0] <=  cmd_h344_reg[BIT_NUM - 1:0] ; 
            cmd_h346[BIT_NUM - 1:0] <=  cmd_h346_reg[BIT_NUM - 1:0] ; 
            cmd_h348[BIT_NUM - 1:0] <=  cmd_h348_reg[BIT_NUM - 1:0] ; 
            cmd_h34A[BIT_NUM - 1:0] <=  cmd_h34A_reg[BIT_NUM - 1:0] ; 
            cmd_h34C[BIT_NUM - 1:0] <=  cmd_h34C_reg[BIT_NUM - 1:0] ; 
            cmd_h34E[BIT_NUM - 1:0] <=  cmd_h34E_reg[BIT_NUM - 1:0] ; 
            cmd_h350[BIT_NUM - 1:0] <=  cmd_h350_reg[BIT_NUM - 1:0] ; 
            cmd_h352[BIT_NUM - 1:0] <=  cmd_h352_reg[BIT_NUM - 1:0] ; 
            cmd_h354[BIT_NUM - 1:0] <=  cmd_h354_reg[BIT_NUM - 1:0] ; 
            cmd_h356[BIT_NUM - 1:0] <=  cmd_h356_reg[BIT_NUM - 1:0] ; 
            cmd_h358[BIT_NUM - 1:0] <=  cmd_h358_reg[BIT_NUM - 1:0] ; 
            cmd_h35A[BIT_NUM - 1:0] <=  cmd_h35A_reg[BIT_NUM - 1:0] ; 
            cmd_h35C[BIT_NUM - 1:0] <=  cmd_h35C_reg[BIT_NUM - 1:0] ; 
            cmd_h35E[BIT_NUM - 1:0] <=  cmd_h35E_reg[BIT_NUM - 1:0] ; 
            cmd_h360[BIT_NUM - 1:0] <=  cmd_h360_reg[BIT_NUM - 1:0] ; 
            cmd_h362[BIT_NUM - 1:0] <=  cmd_h362_reg[BIT_NUM - 1:0] ; 
            cmd_h364[BIT_NUM - 1:0] <=  cmd_h364_reg[BIT_NUM - 1:0] ; 
            cmd_h366[BIT_NUM - 1:0] <=  cmd_h366_reg[BIT_NUM - 1:0] ; 
            cmd_h368[BIT_NUM - 1:0] <=  cmd_h368_reg[BIT_NUM - 1:0] ; 
            cmd_h36A[BIT_NUM - 1:0] <=  cmd_h36A_reg[BIT_NUM - 1:0] ; 
            cmd_h36C[BIT_NUM - 1:0] <=  cmd_h36C_reg[BIT_NUM - 1:0] ; 
            cmd_h36E[BIT_NUM - 1:0] <=  cmd_h36E_reg[BIT_NUM - 1:0] ; 
            cmd_h370[BIT_NUM - 1:0] <=  cmd_h370_reg[BIT_NUM - 1:0] ; 
            cmd_h372[BIT_NUM - 1:0] <=  cmd_h372_reg[BIT_NUM - 1:0] ; 
            cmd_h374[BIT_NUM - 1:0] <=  cmd_h374_reg[BIT_NUM - 1:0] ; 
            cmd_h376[BIT_NUM - 1:0] <=  cmd_h376_reg[BIT_NUM - 1:0] ; 
            cmd_h378[BIT_NUM - 1:0] <=  cmd_h378_reg[BIT_NUM - 1:0] ; 
            cmd_h37A[BIT_NUM - 1:0] <=  cmd_h37A_reg[BIT_NUM - 1:0] ; 
            cmd_h37C[BIT_NUM - 1:0] <=  cmd_h37C_reg[BIT_NUM - 1:0] ; 
            cmd_h37E[BIT_NUM - 1:0] <=  cmd_h37E_reg[BIT_NUM - 1:0] ; 
            cmd_h380[BIT_NUM - 1:0] <=  cmd_h380_reg[BIT_NUM - 1:0] ; 
            cmd_h382[BIT_NUM - 1:0] <=  cmd_h382_reg[BIT_NUM - 1:0] ; 
            cmd_h384[BIT_NUM - 1:0] <=  cmd_h384_reg[BIT_NUM - 1:0] ; 
            cmd_h386[BIT_NUM - 1:0] <=  cmd_h386_reg[BIT_NUM - 1:0] ; 
            cmd_h388[BIT_NUM - 1:0] <=  cmd_h388_reg[BIT_NUM - 1:0] ; 
            cmd_h38A[BIT_NUM - 1:0] <=  cmd_h38A_reg[BIT_NUM - 1:0] ; 
            cmd_h38C[BIT_NUM - 1:0] <=  cmd_h38C_reg[BIT_NUM - 1:0] ; 
            cmd_h38E[BIT_NUM - 1:0] <=  cmd_h38E_reg[BIT_NUM - 1:0] ; 
            cmd_h390[BIT_NUM - 1:0] <=  cmd_h390_reg[BIT_NUM - 1:0] ; 
            cmd_h392[BIT_NUM - 1:0] <=  cmd_h392_reg[BIT_NUM - 1:0] ; 
            cmd_h394[BIT_NUM - 1:0] <=  cmd_h394_reg[BIT_NUM - 1:0] ; 
            cmd_h396[BIT_NUM - 1:0] <=  cmd_h396_reg[BIT_NUM - 1:0] ; 
            cmd_h398[BIT_NUM - 1:0] <=  cmd_h398_reg[BIT_NUM - 1:0] ; 
            cmd_h39A[BIT_NUM - 1:0] <=  cmd_h39A_reg[BIT_NUM - 1:0] ; 
            cmd_h39C[BIT_NUM - 1:0] <=  cmd_h39C_reg[BIT_NUM - 1:0] ; 
            cmd_h39E[BIT_NUM - 1:0] <=  cmd_h39E_reg[BIT_NUM - 1:0] ; 
            cmd_h3A0[BIT_NUM - 1:0] <=  cmd_h3A0_reg[BIT_NUM - 1:0] ; 
            cmd_h3A2[BIT_NUM - 1:0] <=  cmd_h3A2_reg[BIT_NUM - 1:0] ; 
            cmd_h3A4[BIT_NUM - 1:0] <=  cmd_h3A4_reg[BIT_NUM - 1:0] ; 
            cmd_h3A6[BIT_NUM - 1:0] <=  cmd_h3A6_reg[BIT_NUM - 1:0] ; 
            cmd_h3A8[BIT_NUM - 1:0] <=  cmd_h3A8_reg[BIT_NUM - 1:0] ; 
            cmd_h3AA[BIT_NUM - 1:0] <=  cmd_h3AA_reg[BIT_NUM - 1:0] ; 
            cmd_h3AC[BIT_NUM - 1:0] <=  cmd_h3AC_reg[BIT_NUM - 1:0] ; 
            cmd_h3AE[BIT_NUM - 1:0] <=  cmd_h3AE_reg[BIT_NUM - 1:0] ; 
            cmd_h3B0[BIT_NUM - 1:0] <=  cmd_h3B0_reg[BIT_NUM - 1:0] ; 
            cmd_h3B2[BIT_NUM - 1:0] <=  cmd_h3B2_reg[BIT_NUM - 1:0] ; 
            cmd_h3B4[BIT_NUM - 1:0] <=  cmd_h3B4_reg[BIT_NUM - 1:0] ; 
            cmd_h3B6[BIT_NUM - 1:0] <=  cmd_h3B6_reg[BIT_NUM - 1:0] ; 
            cmd_h3B8[BIT_NUM - 1:0] <=  cmd_h3B8_reg[BIT_NUM - 1:0] ; 
            cmd_h3BA[BIT_NUM - 1:0] <=  cmd_h3BA_reg[BIT_NUM - 1:0] ; 
            cmd_h3BC[BIT_NUM - 1:0] <=  cmd_h3BC_reg[BIT_NUM - 1:0] ; 
            cmd_h3BE[BIT_NUM - 1:0] <=  cmd_h3BE_reg[BIT_NUM - 1:0] ; 
            cmd_h3C0[BIT_NUM - 1:0] <=  cmd_h3C0_reg[BIT_NUM - 1:0] ; 
            cmd_h3C2[BIT_NUM - 1:0] <=  cmd_h3C2_reg[BIT_NUM - 1:0] ; 
            cmd_h3C4[BIT_NUM - 1:0] <=  cmd_h3C4_reg[BIT_NUM - 1:0] ; 
            cmd_h3C6[BIT_NUM - 1:0] <=  cmd_h3C6_reg[BIT_NUM - 1:0] ; 
            cmd_h3C8[BIT_NUM - 1:0] <=  cmd_h3C8_reg[BIT_NUM - 1:0] ; 
            cmd_h3CA[BIT_NUM - 1:0] <=  cmd_h3CA_reg[BIT_NUM - 1:0] ; 
            cmd_h3CC[BIT_NUM - 1:0] <=  cmd_h3CC_reg[BIT_NUM - 1:0] ; 
            cmd_h3CE[BIT_NUM - 1:0] <=  cmd_h3CE_reg[BIT_NUM - 1:0] ; 
            cmd_h3D0[BIT_NUM - 1:0] <=  cmd_h3D0_reg[BIT_NUM - 1:0] ; 
            cmd_h3D2[BIT_NUM - 1:0] <=  cmd_h3D2_reg[BIT_NUM - 1:0] ; 
            cmd_h3D4[BIT_NUM - 1:0] <=  cmd_h3D4_reg[BIT_NUM - 1:0] ; 
            cmd_h3D6[BIT_NUM - 1:0] <=  cmd_h3D6_reg[BIT_NUM - 1:0] ; 
            cmd_h3D8[BIT_NUM - 1:0] <=  cmd_h3D8_reg[BIT_NUM - 1:0] ; 
            cmd_h3DA[BIT_NUM - 1:0] <=  cmd_h3DA_reg[BIT_NUM - 1:0] ; 
            cmd_h3DC[BIT_NUM - 1:0] <=  cmd_h3DC_reg[BIT_NUM - 1:0] ; 
            cmd_h3DE[BIT_NUM - 1:0] <=  cmd_h3DE_reg[BIT_NUM - 1:0] ; 
            cmd_h3E0[BIT_NUM - 1:0] <=  cmd_h3E0_reg[BIT_NUM - 1:0] ; 
            cmd_h3E2[BIT_NUM - 1:0] <=  cmd_h3E2_reg[BIT_NUM - 1:0] ; 
            cmd_h3E4[BIT_NUM - 1:0] <=  cmd_h3E4_reg[BIT_NUM - 1:0] ; 
            cmd_h3E6[BIT_NUM - 1:0] <=  cmd_h3E6_reg[BIT_NUM - 1:0] ; 
            cmd_h3E8[BIT_NUM - 1:0] <=  cmd_h3E8_reg[BIT_NUM - 1:0] ; 
            cmd_h3EA[BIT_NUM - 1:0] <=  cmd_h3EA_reg[BIT_NUM - 1:0] ; 
            cmd_h3EC[BIT_NUM - 1:0] <=  cmd_h3EC_reg[BIT_NUM - 1:0] ; 
            cmd_h3EE[BIT_NUM - 1:0] <=  cmd_h3EE_reg[BIT_NUM - 1:0] ; 
            cmd_h3F0[BIT_NUM - 1:0] <=  cmd_h3F0_reg[BIT_NUM - 1:0] ; 
            cmd_h3F2[BIT_NUM - 1:0] <=  cmd_h3F2_reg[BIT_NUM - 1:0] ; 
            cmd_h3F4[BIT_NUM - 1:0] <=  cmd_h3F4_reg[BIT_NUM - 1:0] ; 
            cmd_h3F6[BIT_NUM - 1:0] <=  cmd_h3F6_reg[BIT_NUM - 1:0] ; 
            cmd_h3F8[BIT_NUM - 1:0] <=  cmd_h3F8_reg[BIT_NUM - 1:0] ; 
            cmd_h3FA[BIT_NUM - 1:0] <=  cmd_h3FA_reg[BIT_NUM - 1:0] ; 
            cmd_h3FC[BIT_NUM - 1:0] <=  cmd_h3FC_reg[BIT_NUM - 1:0] ; 
            cmd_h3FE[BIT_NUM - 1:0] <=  cmd_h3FE_reg[BIT_NUM - 1:0] ; 
           
end             

endmodule
