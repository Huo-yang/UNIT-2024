`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 15:50:19
// Design Name: 
// Module Name: min_5
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


module min_5(
input              clk,
input              den_in,
input  [7:0]       data_in0,
input  [7:0]       data_in1,
input  [7:0]       data_in2,
input  [7:0]       data_in3,
input  [7:0]       data_in4,

output [7:0]       data_min,
output             den_out
    );
	
reg [7:0] data_in4_dly1 ;
reg [7:0] data_in4_dly2 ;
  
reg [7:0] data_min_01 ;
reg [7:0] data_min_23 ;
reg [7:0] data_min_0123 ;
reg [7:0] data_min_01234 ;

reg den_in_d1 ,den_in_d2 , den_in_d3 ;	


always @ (posedge clk)
begin
if (data_in0 < data_in1)       data_min_01 <= data_in0 ;
else                           data_min_01 <= data_in1 ;
end

always @ (posedge clk)
begin
if (data_in2 < data_in3)       data_min_23 <= data_in2 ;
else                           data_min_23 <= data_in3 ;
end

always @ (posedge clk)
begin
if (data_min_01 < data_min_23) data_min_0123 <= data_min_01 ;
else                           data_min_0123 <= data_min_23 ;
end

always @ (posedge clk)
begin   
data_in4_dly1 <= data_in4 ;
data_in4_dly2 <= data_in4_dly1 ;
end


always @ (posedge clk)
begin   
if (data_in4_dly2 < data_min_0123)  data_min_01234 <= data_in4_dly2 ;
else                                data_min_01234 <= data_min_0123 ;
end    

always @ (posedge clk)
begin   
den_in_d1 <= den_in ;
den_in_d2 <= den_in_d1 ;
den_in_d3 <= den_in_d2 ;
end


assign data_min = data_min_01234 ;

assign den_out  = den_in_d3 ;	
	
	
	
	
	
	
	
	
endmodule
