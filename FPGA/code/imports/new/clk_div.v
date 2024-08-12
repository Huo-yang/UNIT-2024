`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:59 03/26/2014 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div
#(
	 parameter	CLK_DIV = 32
)
	(
    input  clk_in,
    output reg clk_out
    );

reg [31:0] 	cnt ;
reg 			clk_out_sig;

always @ (posedge clk_in)
begin
if (cnt == CLK_DIV / 2 - 1)
	begin
	clk_out_sig <= ~clk_out_sig ;
	cnt 			 <= 0 ;
	end
else	
	cnt 			 <= cnt + 1 ;
end

//assign clk_out = clk_out_sig ;

always @ (posedge clk_in)
begin
clk_out <= clk_out_sig ;
end

endmodule
