`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:04 03/03/2021 
// Design Name: 
// Module Name:    d_filter 
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
//137   12    -21

//////////////////////////////////////////////////////////////////////////////////
module d_filter(
    input         clk,
    input  [31:0] data_in,
    output reg [31:0] data_out
    );

reg [31:0] data_d1 ;
reg [31:0] data_d2 ;
reg [31:0] data_d3 ;
reg [31:0] data_d4 ;
reg [31:0] data_d5 ;
reg [31:0] data_d6 ;
reg [31:0] data_d7 ;
reg [31:0] data_d8 ;

always @ (posedge clk)
begin
data_d1 <= data_in ;
data_d2 <= data_d1 ;
data_d3 <= data_d2 ;
data_d4 <= data_d3 ;
data_d5 <= data_d4 ;
data_d6 <= data_d5 ;
data_d7 <= data_d6 ;
data_d8 <= data_d7 ;
end

wire [7:0] dout_f0 ;
wire [7:0] dout_f1 ;
wire [7:0] dout_f2 ;
wire [7:0] dout_f3 ;


wire [7:0] data_d3_max_0123 ;
wire [7:0] data_d3_min_0123 ;

wire [7:0] data_d2_max_0123 ;
wire [7:0] data_d2_min_0123 ;

max_n5 

ins_max_d2 (
                        .clk           (clk), 
                        .den_in        (1), 
                        .data_in0      (data_d2[8*4-1 :8*3]), 
                        .data_in1      (data_d2[8*3-1 :8*2]), 
                        .data_in2      (data_d2[8*2-1 :8*1]), 
                        .data_in3      (data_d2[8*1-1 :8*0]), 
                        .data_in4      (0),
						
                        .data_max      (data_d2_max_0123)
                        ); 

min_5 

ins_min_d2 (
                        .clk           (clk), 
                        .den_in        (1), 
                        .data_in0      (data_d2[8*4-1 :8*3]), 
                        .data_in1      (data_d2[8*3-1 :8*2]), 
                        .data_in2      (data_d2[8*2-1 :8*1]), 
                        .data_in3      (data_d2[8*1-1 :8*0]), 
                        .data_in4      (255),
						
                        .data_min      (data_d2_min_0123) 
                        );

reg [7:0] data_d2_max_0123_r1 ;
reg [7:0] data_d2_max_0123_r2 ;
reg [7:0] data_d2_min_0123_r1 ;
reg [7:0] data_d2_min_0123_r2 ;

always @ (posedge clk)
begin
data_d2_max_0123_r1 <= data_d2_max_0123 ;
data_d2_max_0123_r2 <= data_d2_max_0123_r1 ;
data_d2_min_0123_r1 <= data_d2_min_0123 ;
data_d2_min_0123_r2 <= data_d2_min_0123_r1 ;
end

reg [7:0] data_max_01234567 ; 
reg [7:0] data_max_01234567_r ; 

always @ (posedge clk)
begin
if (data_d2_max_0123_r1 >  data_d2_max_0123)
   data_max_01234567 <= data_d2_max_0123_r1 ;
else
   data_max_01234567 <= data_d2_max_0123 ;
end

always @ (posedge clk)
begin
if (data_max_01234567 >  data_d2_max_0123_r2)
   data_max_01234567_r <= data_max_01234567 ;
else
   data_max_01234567_r <= data_d2_max_0123_r2 ;
end


reg [7:0] data_min_01234567 ; 
reg [7:0] data_min_01234567_r ; 


always @ (posedge clk)
begin
if (data_d2_min_0123_r1 >  data_d2_min_0123)
   data_min_01234567 <= data_d2_min_0123 ;
else
   data_min_01234567 <= data_d2_min_0123_r1 ;
end

always @ (posedge clk)
begin
if (data_min_01234567 <  data_d2_min_0123_r2)
   data_min_01234567_r <= data_min_01234567 ;
else
   data_min_01234567_r <= data_d2_min_0123_r2 ;
end


reg [7:0] sub_max_min ; 

always @ (posedge clk)
begin
sub_max_min <= (data_max_01234567 - data_min_01234567) ;
end

// filter_9 filter_9_0 (
    // .clk (clk), 
    // .sub_max_min (sub_max_min), 
    // .din1(data_d8[8*4-1 :8*3]), 
    // .din2(data_d8[8*3-1 :8*2]), 
    // .din3(data_d8[8*2-1 :8*1]),  
    // .din4(data_d8[8*1-1 :8*0]),  
    // .din5(data_d7[8*4-1 :8*3]),  
    // .din6(data_d7[8*3-1 :8*2]),  
    // .din7(data_d7[8*2-1 :8*1]),  
    // .din8(data_d7[8*1-1 :8*0]),  
    // .din9(data_d6[8*4-1 :8*3]),  
    // .dout(dout_f0)
    // );

// filter_9 filter_9_1 (
    // .clk (clk), 
    // .sub_max_min (sub_max_min), 
    // .din1(data_d8[8*3-1 :8*2]), 
    // .din2(data_d8[8*2-1 :8*1]), 
    // .din3(data_d8[8*1-1 :8*0]), 
    // .din4(data_d7[8*4-1 :8*3]), 
    // .din5(data_d7[8*3-1 :8*2]), 
    // .din6(data_d7[8*2-1 :8*1]),  
    // .din7(data_d7[8*1-1 :8*0]),  
    // .din8(data_d6[8*4-1 :8*3]),  
    // .din9(data_d6[8*3-1 :8*2]),  	
    // .dout(dout_f1)
    // );

// filter_9 filter_9_2 (
    // .clk (clk), 
    // .sub_max_min (sub_max_min), 
    // .din1(data_d8[8*2-1 :8*1]), 
    // .din2(data_d8[8*1-1 :8*0]), 
    // .din3(data_d7[8*4-1 :8*3]), 
    // .din4(data_d7[8*3-1 :8*2]), 
    // .din5(data_d7[8*2-1 :8*1]), 
    // .din6(data_d7[8*1-1 :8*0]),  
    // .din7(data_d6[8*4-1 :8*3]),  
    // .din8(data_d6[8*3-1 :8*2]),  
    // .din9(data_d6[8*2-1 :8*1]),  	
    // .dout(dout_f2)
    // );

// filter_9 filter_9_3 (
    // .clk (clk), 
    // .sub_max_min (sub_max_min), 
    // .din1(data_d8[8*1-1 :8*0]), 
    // .din2(data_d7[8*4-1 :8*3]), 
    // .din3(data_d7[8*3-1 :8*2]), 
    // .din4(data_d7[8*2-1 :8*1]), 
    // .din5(data_d7[8*1-1 :8*0]),
    // .din6(data_d6[8*4-1 :8*3]),  
    // .din7(data_d6[8*3-1 :8*2]),  
    // .din8(data_d6[8*2-1 :8*1]),  
    // .din9(data_d6[8*1-1 :8*0]),  	
    // .dout(dout_f3)
    // );


wire [7:0] data_w0 ;
wire [7:0] data_w1 ;
wire [7:0] data_w2 ;
wire [7:0] data_w3 ;
wire [7:0] data_w4 ;
wire [7:0] data_w5 ;
wire [7:0] data_w6 ;
wire [7:0] data_w7 ;
wire [7:0] data_w8 ;
wire [7:0] data_w9 ;

assign  data_w0 = data_d8[8*4-1 :8*3];
assign  data_w1 = data_d8[8*3-1 :8*2];
assign  data_w2 = data_d8[8*2-1 :8*1];
assign  data_w3 = data_d8[8*1-1 :8*0];
assign  data_w4 = data_d7[8*4-1 :8*3];
assign  data_w5 = data_d7[8*3-1 :8*2];
assign  data_w6 = data_d7[8*2-1 :8*1];
assign  data_w7 = data_d7[8*1-1 :8*0];
assign  data_w8 = data_d6[8*4-1 :8*3];
assign  data_w9 = data_d6[8*3-1 :8*2];

filter_5 filter_5_0 (
    .clk (clk), 
    .sub_max_min (sub_max_min), 
    .din1(data_w0), 
    .din2(data_w1), 
    .din3(data_w2),  
    .din4(data_w3),  
    .din5(data_w4),  
    .dout(dout_f0)
    );

filter_5 filter_5_1 (
    .clk (clk), 
    .sub_max_min (sub_max_min), 
    .din1(data_w1), 
    .din2(data_w2), 
    .din3(data_w3), 
    .din4(data_w4), 
    .din5(data_w5), 
    .dout(dout_f1)
    );

filter_5 filter_5_2 (
    .clk (clk), 
    .sub_max_min (sub_max_min), 
    .din1(data_w2), 
    .din2(data_w3), 
    .din3(data_w4), 
    .din4(data_w5), 
    .din5(data_w6), 
    .dout(dout_f2)
    );

filter_5 filter_5_3 (
    .clk (clk), 
    .sub_max_min (sub_max_min), 
    .din1(data_w3), 
    .din2(data_w4), 
    .din3(data_w5), 
    .din4(data_w6), 
    .din5(data_w7), 
    .dout(dout_f3)
    );

always @ (posedge clk)
begin
data_out <= {dout_f0,dout_f1,dout_f2, dout_f3} ;
end







endmodule
