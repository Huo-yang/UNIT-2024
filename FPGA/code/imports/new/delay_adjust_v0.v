`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/14 09:37:10
// Design Name: 
// Module Name: delay_adjust_v0
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


module delay_adjust_v0(
    input             clk,
    input  [2:0]      delay_time,
    input  [31:0]     data_in,
    output reg [31:0] data_out
    );

reg [31:0] data_in_r1 ;
	
always @ (posedge clk)
begin
data_in_r1 <= data_in ;
end	
	
always @ (posedge clk)
begin
if (delay_time == 0)	
	data_out <= data_in[31:0] ;
else if (delay_time == 1)	
	data_out <= {data_in_r1[7:0],data_in[31:8]} ;
else if (delay_time == 2)	
	data_out <= {data_in_r1[15:0],data_in[31:16]} ;	
else if (delay_time == 3)	
	data_out <= {data_in_r1[23:0],data_in[31:24]} ;		
else if (delay_time == 4)	
	data_out <= data_in_r1[31:0] ;	
else	
	data_out <= data_in ;
end	
	
	
endmodule
