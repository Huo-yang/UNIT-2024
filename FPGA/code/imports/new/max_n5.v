`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 15:49:45
// Design Name: 
// Module Name: max_5
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


module max_n5#
(
parameter BW = 8
)
(
input              clk,
input              den_in,
input  [BW-1:0]       data_in0,
input  [BW-1:0]       data_in1,
input  [BW-1:0]       data_in2,
input  [BW-1:0]       data_in3,
input  [BW-1:0]       data_in4,

output [BW-1:0]       data_max,
output             den_out
    );
	
	
reg [BW-1:0] data_in4_dly1 ;
reg [BW-1:0] data_in4_dly2 ;
  
  
reg [BW-1:0] data_max_01 ;
reg [BW-1:0] data_max_23 ;
reg [BW-1:0] data_max_0123 ;
reg [BW-1:0] data_max_01234 ;


reg den_in_d1 ,den_in_d2 , den_in_d3 ;
 
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
if (data_max_01 > data_max_23) data_max_0123 <= data_max_01 ;
else                           data_max_0123 <= data_max_23 ;
end

always @ (posedge clk)
begin   
data_in4_dly1 <= data_in4 ;
data_in4_dly2 <= data_in4_dly1 ;
end

always @ (posedge clk)
begin   
if (data_in4_dly2 > data_max_0123)  data_max_01234 <= data_in4_dly2 ;
else                                data_max_01234 <= data_max_0123 ;
end    

assign data_max = data_max_01234 ;


always @ (posedge clk)
begin   
den_in_d1 <= den_in ;
den_in_d2 <= den_in_d1 ;
den_in_d3 <= den_in_d2 ;
end


	
assign den_out  = den_in_d3 ;
	
endmodule
