`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/12 10:02:53
// Design Name: 
// Module Name: fir_10
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


module fir_10(
    input                        clk,
	
    input     signed    [15:0]   mult_b1,
    input     signed    [15:0]   mult_b2,
    input     signed    [15:0]   mult_b3,
    input     signed    [15:0]   mult_b4,
    input     signed    [15:0]   mult_b5,	
	
    input               [7:0]    mult_a1,
    input               [7:0]    mult_a2,
    input               [7:0]    mult_a3,
    input               [7:0]    mult_a4,
    input               [7:0]    mult_a5,
    input               [7:0]    mult_a6,
    input               [7:0]    mult_a7,
    input               [7:0]    mult_a8,
    input               [7:0]    mult_a9,
    input               [7:0]    mult_a10,
	
    output              [7:0]    dout
    );
	
wire signed [24 : 0]	 p1 ;
wire signed [24 : 0]	 p2 ;
wire signed [24 : 0]	 p3 ;
wire signed [24 : 0]	 p4 ;
wire signed [24 : 0]	 p5 ;
	
	
	
dsp48_macro_fir_10 ins1 (
  .CLK(clk),  // input wire CLK
  .A  ({1'b0,mult_a1[7:0]}),      // input wire [8 : 0] A
  .B  (mult_b1[15:0]),      // input wire [15 : 0] B
  .D  ({1'b0,mult_a10[7:0]}),      // input wire [8 : 0] D
  .P  (p1[24 : 0])      // output wire [24 : 0] P
);	
	
dsp48_macro_fir_10 ins2 (
  .CLK(clk),  // input wire CLK
  .A  ({1'b0,mult_a2[7:0]}),      // input wire [8 : 0] A
  .B  (mult_b2[15:0]),      // input wire [15 : 0] B
  .D  ({1'b0,mult_a9[7:0]}),      // input wire [8 : 0] D
  .P  (p2[24 : 0])      // output wire [24 : 0] P
);	


dsp48_macro_fir_10 ins3 (
  .CLK(clk),  // input wire CLK
  .A  ({1'b0,mult_a3[7:0]}),      // input wire [8 : 0] A
  .B  (mult_b3[15:0]),      // input wire [15 : 0] B
  .D  ({1'b0,mult_a8[7:0]}),      // input wire [8 : 0] D
  .P  (p3[24 : 0])      // output wire [24 : 0] P
);	


dsp48_macro_fir_10 ins4 (
  .CLK(clk),  // input wire CLK
  .A  ({1'b0,mult_a4[7:0]}),      // input wire [8 : 0] A
  .B  (mult_b4[15:0]),      // input wire [15 : 0] B
  .D  ({1'b0,mult_a7[7:0]}),      // input wire [8 : 0] D
  .P  (p4[24 : 0])      // output wire [24 : 0] P
);


dsp48_macro_fir_10 ins5 (
  .CLK(clk),  // input wire CLK
  .A  ({1'b0,mult_a5[7:0]}),      // input wire [8 : 0] A
  .B  (mult_b5[15:0]),      // input wire [15 : 0] B
  .D  ({1'b0,mult_a6[7:0]}),      // input wire [8 : 0] D
  .P  (p5[24 : 0])      // output wire [24 : 0] P
);

reg signed [24 : 0] p5_r1 ;
reg signed [24 : 0] p5_r2 ;

always @ (posedge clk) 
begin
p5_r1 <= p5 ;
p5_r2 <= p5_r1 ;
end

reg signed [24 : 0] s12 ;
reg signed [24 : 0] s34 ;
reg signed [24 : 0] s1234 ;
reg signed [24 : 0] s12345 ;

always @ (posedge clk) 
begin
s12[24 : 0]    <= p1[24 : 0]    + p2[24 : 0] ;
s34[24 : 0]    <= p3[24 : 0]    + p4[24 : 0] ;
s1234[24 : 0]  <= s12[24 : 0]   + s34[24 : 0] ;
s12345[24 : 0] <= s1234[24 : 0] + p5_r2[24 : 0] ;
end

reg  [7 : 0] data_out_sig ;

always @ (posedge clk)
begin
if (s12345[24])
   data_out_sig <= 8'd0;
else if (|s12345[23 : 22]) 
   data_out_sig <= 8'd255;
else    
   data_out_sig <= s12345[(15+6): (15-1)];
end

assign dout = data_out_sig ;


	
endmodule
