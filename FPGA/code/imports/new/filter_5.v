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
module filter_5(
    input      clk,
    input [7:0]sub_max_min,
    input [7:0]din1,
    input [7:0]din2,
    input [7:0]din3,
    input [7:0]din4,
    input [7:0]din5,
    output [7:0] dout
    );
	
// always @ (posedge clk)
// begin
// data_ar <= $signed(data_a); 	
// end


reg signed [8:0] sub0 ;
reg signed [8:0] sub1 ;

reg  [7:0] abs_sub0 ;
reg  [7:0] abs_sub1 ;
reg  [7:0] din2_r1 ;
reg  [7:0] din2_r2 ;
reg  [7:0] din3_r1 ;
reg  [7:0] din3_r2 ;
reg  [7:0] din3_r3 ;
reg  [7:0] din3_r4 ;


reg  [8:0] din_add_12 ;
reg  [8:0] din_add_45 ;
reg  [9:0] din_add_1245 ;
reg  [7:0] din_add_1245_r1 ;

reg  [7:0] sub_max_min_r1 ;
reg  [7:0] sub_max_min_r2 ;
reg  [7:0] sub_max_min_r3 ;
reg  [7:0] sub_max_min_r4 ;


wire [17:0] p ;
wire [17:0] acout ;
wire [8:0] acout_h ;
reg  [8:0] acout_h_r1 ;
reg  [8:0] acout_h_r2 ;

// dsp_add dsp_add (
  // .clk(clk), // input clk
  // .a  ({1'b0,din2[7:0],1'b0,din1[7:0]}), // input [17 : 0] a
  // .d  ({1'b0,din5[7:0],1'b0,din4[7:0]}), // input [17 : 0] d
  // .p  (p[17:0]) // output [27 : 0] p
// );
//(D + B) * A + C //DLAY 4

always @ (posedge clk)
begin

din_add_12      <= din2 + din1 ;
din_add_45      <= din5 + din4 ;
din_add_1245    <= din_add_12 + din_add_45 ;
// din_add_1245    <= p[17:9]+ p[8:0] ;
din_add_1245_r1 <= din_add_1245[9:2] + din_add_1245[1];
din3_r1         <= din3 ;
din3_r2         <= din3_r1 ;
din3_r3         <= din3_r2 ;

sub_max_min_r1  <= sub_max_min ;
sub_max_min_r2  <= sub_max_min_r1;
sub_max_min_r3  <= sub_max_min_r2;
end

reg [7:0] dout_sig ;

always @ (posedge clk)
begin
if (sub_max_min_r3 <= 5)
   dout_sig <= din_add_1245_r1;
else if (sub_max_min_r3 <= 10)
   dout_sig <= (din_add_1245_r1 + din3_r3) / 2; 
else   
   dout_sig <= din3_r3 ;
end   

assign dout = dout_sig ;

endmodule
