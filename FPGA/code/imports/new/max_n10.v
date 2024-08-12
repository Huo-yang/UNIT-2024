`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 09:46:55
// Design Name: 
// Module Name: max_n10
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


module max_n10#
(
parameter BW = 8
)
(
input                 clk,
input                 den_in,
input  [BW-1:0]       data_in0,
input  [BW-1:0]       data_in1,
input  [BW-1:0]       data_in2,
input  [BW-1:0]       data_in3,
input  [BW-1:0]       data_in4,
input  [BW-1:0]       data_in5,
input  [BW-1:0]       data_in6,
input  [BW-1:0]       data_in7,
input  [BW-1:0]       data_in8,
input  [BW-1:0]       data_in9,

output [BW-1:0]       data_max,
output                den_out
    );
	
	
reg [BW-1:0] data_in4_dly1 ;
reg [BW-1:0] data_in4_dly2 ;
  
  
reg [BW-1:0] data_max_01 ;
reg [BW-1:0] data_max_23 ;
reg [BW-1:0] data_max_45 ;
reg [BW-1:0] data_max_67 ;
reg [BW-1:0] data_max_89 ;

reg [BW-1:0] data_max_0123 ;
reg [BW-1:0] data_max_01234 ;


reg den_in_d1 ,den_in_d2 , den_in_d3 , den_in_d4 ;
 
always @ (posedge clk)
begin
if (data_in0 > data_in1)       data_max_01 <= data_in0 ;
else                           data_max_01 <= data_in1 ;
end

always @ (posedge clk)
begin
if (data_in2 > data_in3)       data_max_23 <= data_in2 ;
else                           data_max_23 <= data_in3 ;
end

always @ (posedge clk)
begin
if (data_in4 > data_in5)       data_max_45 <= data_in4 ;
else                           data_max_45 <= data_in5 ;
end

always @ (posedge clk)
begin
if (data_in6 > data_in7)       data_max_67 <= data_in6 ;
else                           data_max_67 <= data_in7 ;
end

always @ (posedge clk)
begin
if (data_in8 > data_in9)       data_max_89 <= data_in8 ;
else                           data_max_89 <= data_in9 ;
end


//*******************************************************

// reg [BW-1:0] data_max_0123  , data_max_4567 ;
 reg [BW-1:0]  data_max_4567 ;
reg [BW-1:0] data_max_89_r1 , data_max_89_r2 ;


always @ (posedge clk)
begin
if (data_max_01 > data_max_23) data_max_0123 <= data_max_01 ;
else                           data_max_0123 <= data_max_23 ;
end

always @ (posedge clk)
begin
if (data_max_45 > data_max_67) data_max_4567 <= data_max_45 ;
else                           data_max_4567 <= data_max_67 ;
end

always @ (posedge clk)
begin
 data_max_89_r1 <= data_max_89 ;
end

//*******************************
reg [BW-1:0] data_max_01234567  ;

always @ (posedge clk)
begin
if (data_max_0123 > data_max_4567) data_max_01234567 <= data_max_0123 ;
else                               data_max_01234567 <= data_max_4567 ;
end

always @ (posedge clk)
begin
 data_max_89_r2 <= data_max_89_r1 ;
end

//******************************************
reg [BW-1:0] data_max_all ;


always @ (posedge clk)
begin   
if (data_max_89_r2 > data_max_01234567)  data_max_all <= data_max_89_r2 ;
else                                     data_max_all <= data_max_01234567 ;
end    

assign data_max = data_max_all ;


always @ (posedge clk)
begin   
den_in_d1 <= den_in ;
den_in_d2 <= den_in_d1 ;
den_in_d3 <= den_in_d2 ;
den_in_d4 <= den_in_d3 ;
end


	
assign den_out  = den_in_d4 ;
	
endmodule

