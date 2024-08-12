`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:30:06 03/03/2021 
// Design Name: 
// Module Name:    filter_6 
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
module filter_9(
    input      clk,
    input [7:0]sub_max_min,
    input [7:0]din1,
    input [7:0]din2,
    input [7:0]din3,
    input [7:0]din4,
    input [7:0]din5,
    input [7:0]din6,
    input [7:0]din7,
    input [7:0]din8,
    input [7:0]din9,
    output [7:0] dout
    );

reg signed [8:0] sub0 ;
reg signed [8:0] sub1 ;

reg  [7:0] abs_sub0 ;
reg  [7:0] abs_sub1 ;
reg  [7:0] din2_r1 ;
reg  [7:0] din2_r2 ;
reg  [7:0] din5_r1 ;
reg  [7:0] din5_r2 ;
reg  [7:0] din5_r3 ;
reg  [7:0] din5_r4 ;

reg  [8:0] din_add_12 ;
reg  [8:0] din_add_34 ;
reg  [8:0] din_add_67 ;
reg  [8:0] din_add_89 ;
reg  [9:0] din_add_1234 ;
reg  [9:0] din_add_6789 ;
reg  [10:0] din_add_12346789 ;
reg  [10:0] din_add_12346789_r1 ;

reg  [7:0] sub_max_min_r1 ;
reg  [7:0] sub_max_min_r2 ;
reg  [7:0] sub_max_min_r3 ;

always @ (posedge clk)
begin
din_add_12      <= din2 + din1 ;
din_add_34      <= din4 + din3 ;
din_add_67      <= din7 + din6 ;
din_add_89      <= din9 + din8 ;

din_add_1234    <= din_add_12 + din_add_34 ;
din_add_6789    <= din_add_67 + din_add_89 ;

din_add_12346789<= din_add_1234 +  din_add_6789;
din_add_12346789_r1<= din_add_12346789;

din5_r1         <= din5 ;
din5_r2         <= din5_r1 ;
din5_r3         <= din5_r2 ;
din5_r4         <= din5_r3 ;

sub_max_min_r1  <= sub_max_min ;
sub_max_min_r2  <= sub_max_min_r1;
sub_max_min_r3  <= sub_max_min_r2;
end


reg [7:0] dout_sig ;

always @ (posedge clk)
begin
if (sub_max_min_r3 <= 5)
   dout_sig <= din_add_12346789[10:3] + din_add_12346789[2];
else if (sub_max_min_r3 <= 10)
   dout_sig <= (din_add_12346789[10:3] + din5_r3) / 2 ;
else   
   dout_sig <= din5_r3 ;
end   

assign dout = dout_sig ;





endmodule
