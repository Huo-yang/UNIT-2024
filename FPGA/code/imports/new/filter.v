`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/15 13:32:14
// Design Name: 
// Module Name: filter
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


module filter(
    input             clk,
    input             ch_mode,
    input  [63:0]     data_in,
    output [63:0]     data_out
    );
	
wire   [7:0]	 d0 ;
wire   [7:0]	 d1 ;
wire   [7:0]	 d2 ;
wire   [7:0]	 d3 ;
wire   [7:0]	 d4 ;
wire   [7:0]	 d5 ;
wire   [7:0]	 d6 ;
wire   [7:0]	 d7 ;


assign  d0 = data_in[8*(0+1)-1 : 8*0] ;
assign  d1 = data_in[8*(1+1)-1 : 8*1] ;
assign  d2 = data_in[8*(2+1)-1 : 8*2] ;
assign  d3 = data_in[8*(3+1)-1 : 8*3] ;
assign  d4 = data_in[8*(4+1)-1 : 8*4] ;
assign  d5 = data_in[8*(5+1)-1 : 8*5] ;
assign  d6 = data_in[8*(6+1)-1 : 8*6] ;
assign  d7 = data_in[8*(7+1)-1 : 8*7] ;



wire [31:0] data_out_d0  ;
wire [31:0] data_out_d1  ;
wire [63:0] data_out_s  ;
	
	
d_filter d_filter0 (
    .clk     (clk), 
    .data_in ({d3,d2,d1,d0}), 
    .data_out(data_out_d0[31:0])
    );
	
d_filter d_filter1 (
    .clk     (clk), 
    .data_in ({d7,d6,d5,d4}), 
    .data_out(data_out_d1[31:0])
    );	

d_filter_9 d_filter_9 (
    .clk     (clk), 
    .data_in ({d7,d6,d5,d4,d3,d2,d1,d0}), 
    .data_out(data_out_s[63:0])
    );	

	
assign data_out = !ch_mode ? data_out_s[63:0] : {data_out_d1[31:0],data_out_d0[31:0]} ;



	
endmodule
