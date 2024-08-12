`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/12 10:00:39
// Design Name: 
// Module Name: filter_10
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


module filter_10(
    input             clk,
    input             bw_100m,
    input             ch_mode,
    input  [63:0]     data_in,
    output reg [63:0] data_out
    );
	
wire   [7:0]	 d0 ;
wire   [7:0]	 d1 ;
wire   [7:0]	 d2 ;
wire   [7:0]	 d3 ;
wire   [7:0]	 d4 ;
wire   [7:0]	 d5 ;
wire   [7:0]	 d6 ;
wire   [7:0]	 d7 ;

reg    [7:0]	 d0_r1, d0_r2, d0_r3 ;
reg    [7:0]	 d1_r1, d1_r2, d1_r3 ;
reg    [7:0]	 d2_r1, d2_r2, d2_r3 ;
reg    [7:0]	 d3_r1, d3_r2, d3_r3 ;
reg    [7:0]	 d4_r1, d4_r2, d4_r3 ;
reg    [7:0]	 d5_r1, d5_r2, d5_r3 ;
reg    [7:0]	 d6_r1, d6_r2, d6_r3 ;
reg    [7:0]	 d7_r1, d7_r2, d7_r3 ;

assign  d0 = data_in[8*(0+1)-1 : 8*0] ;
assign  d1 = data_in[8*(1+1)-1 : 8*1] ;
assign  d2 = data_in[8*(2+1)-1 : 8*2] ;
assign  d3 = data_in[8*(3+1)-1 : 8*3] ;
assign  d4 = data_in[8*(4+1)-1 : 8*4] ;
assign  d5 = data_in[8*(5+1)-1 : 8*5] ;
assign  d6 = data_in[8*(6+1)-1 : 8*6] ;
assign  d7 = data_in[8*(7+1)-1 : 8*7] ;	
	
always @ (posedge clk)
begin
d0_r1 <= d0 ;
d1_r1 <= d1 ;
d2_r1 <= d2 ;
d3_r1 <= d3 ;
d4_r1 <= d4 ;
d5_r1 <= d5 ;
d6_r1 <= d6 ;
d7_r1 <= d7 ;

d0_r2 <= d0_r1 ;
d1_r2 <= d1_r1 ;
d2_r2 <= d2_r1 ;
d3_r2 <= d3_r1 ;
d4_r2 <= d4_r1 ;
d5_r2 <= d5_r1 ;
d6_r2 <= d6_r1 ;
d7_r2 <= d7_r1 ;

d0_r3 <= d0_r2 ;
d1_r3 <= d1_r2 ;
d2_r3 <= d2_r2 ;
d3_r3 <= d3_r2 ;
d4_r3 <= d4_r2 ;
d5_r3 <= d5_r2 ;
d6_r3 <= d6_r2 ;
d7_r3 <= d7_r2 ;

end

reg [7:0] mult_a1  [0:7] ;
reg [7:0] mult_a2  [0:7] ;
reg [7:0] mult_a3  [0:7] ;
reg [7:0] mult_a4  [0:7] ;
reg [7:0] mult_a5  [0:7] ;
reg [7:0] mult_a6  [0:7] ;
reg [7:0] mult_a7  [0:7] ;
reg [7:0] mult_a8  [0:7] ;
reg [7:0] mult_a9  [0:7] ;
reg [7:0] mult_a10 [0:7] ;

reg signed [15:0] mult_b1 ;
reg signed [15:0] mult_b2 ;
reg signed [15:0] mult_b3 ;
reg signed [15:0] mult_b4 ;
reg signed [15:0] mult_b5 ;



always @ (posedge clk)
begin
//****************************************************************************1G / 100M	                      2G / 100M
    {mult_b1 ,mult_b2 , mult_b3 , mult_b4 ,mult_b5 } <=  ( ch_mode ) ? 80'hFF7A_FE26_0145_0B5C_15BE : 80'h0003_00A7_0407_0AB1_109F;
	
end


always @ (posedge clk)
begin
  mult_a1 [0] <= ( !ch_mode ) ? d3[7:0]    : d0[7:0]    ;
  mult_a2 [0] <= ( !ch_mode ) ? d4[7:0]    : d1[7:0]    ;
  mult_a3 [0] <= ( !ch_mode ) ? d5[7:0]    : d2[7:0]    ;
  mult_a4 [0] <= ( !ch_mode ) ? d6[7:0]    : d3[7:0]    ;
  mult_a5 [0] <= ( !ch_mode ) ? d7[7:0]    : d0_r1[7:0] ;
  mult_a6 [0] <= ( !ch_mode ) ? d0_r1[7:0] : d1_r1[7:0] ;
  mult_a7 [0] <= ( !ch_mode ) ? d1_r1[7:0] : d2_r1[7:0] ;
  mult_a8 [0] <= ( !ch_mode ) ? d2_r1[7:0] : d3_r1[7:0] ;
  mult_a9 [0] <= ( !ch_mode ) ? d3_r1[7:0] : d0_r2[7:0] ;
  mult_a10[0] <= ( !ch_mode ) ? d4_r1[7:0] : d1_r2[7:0] ;
  
  mult_a1 [1] <= ( !ch_mode ) ? d4[7:0]    : d1[7:0]    ;
  mult_a2 [1] <= ( !ch_mode ) ? d5[7:0]    : d2[7:0]    ;
  mult_a3 [1] <= ( !ch_mode ) ? d6[7:0]    : d3[7:0]    ;
  mult_a4 [1] <= ( !ch_mode ) ? d7[7:0]    : d0_r1[7:0] ;
  mult_a5 [1] <= ( !ch_mode ) ? d0_r1[7:0] : d1_r1[7:0] ;
  mult_a6 [1] <= ( !ch_mode ) ? d1_r1[7:0] : d2_r1[7:0] ;
  mult_a7 [1] <= ( !ch_mode ) ? d2_r1[7:0] : d3_r1[7:0] ;
  mult_a8 [1] <= ( !ch_mode ) ? d3_r1[7:0] : d0_r2[7:0] ;
  mult_a9 [1] <= ( !ch_mode ) ? d4_r1[7:0] : d1_r2[7:0] ;
  mult_a10[1] <= ( !ch_mode ) ? d5_r1[7:0] : d2_r2[7:0] ;  
													    
  mult_a1 [2] <= ( !ch_mode ) ? d5[7:0]    : d2[7:0]    ;
  mult_a2 [2] <= ( !ch_mode ) ? d6[7:0]    : d3[7:0]    ;
  mult_a3 [2] <= ( !ch_mode ) ? d7[7:0]    : d0_r1[7:0] ;
  mult_a4 [2] <= ( !ch_mode ) ? d0_r1[7:0] : d1_r1[7:0] ;
  mult_a5 [2] <= ( !ch_mode ) ? d1_r1[7:0] : d2_r1[7:0] ;
  mult_a6 [2] <= ( !ch_mode ) ? d2_r1[7:0] : d3_r1[7:0] ;
  mult_a7 [2] <= ( !ch_mode ) ? d3_r1[7:0] : d0_r2[7:0] ;
  mult_a8 [2] <= ( !ch_mode ) ? d4_r1[7:0] : d1_r2[7:0] ;
  mult_a9 [2] <= ( !ch_mode ) ? d5_r1[7:0] : d2_r2[7:0] ;
  mult_a10[2] <= ( !ch_mode ) ? d6_r1[7:0] : d3_r2[7:0] ;   
													    
  mult_a1 [3] <= ( !ch_mode ) ? d6[7:0]    : d3[7:0]    ;
  mult_a2 [3] <= ( !ch_mode ) ? d7[7:0]    : d0_r1[7:0] ;
  mult_a3 [3] <= ( !ch_mode ) ? d0_r1[7:0] : d1_r1[7:0] ;
  mult_a4 [3] <= ( !ch_mode ) ? d1_r1[7:0] : d2_r1[7:0] ;
  mult_a5 [3] <= ( !ch_mode ) ? d2_r1[7:0] : d3_r1[7:0] ;
  mult_a6 [3] <= ( !ch_mode ) ? d3_r1[7:0] : d0_r2[7:0] ;
  mult_a7 [3] <= ( !ch_mode ) ? d4_r1[7:0] : d1_r2[7:0] ;
  mult_a8 [3] <= ( !ch_mode ) ? d5_r1[7:0] : d2_r2[7:0] ;
  mult_a9 [3] <= ( !ch_mode ) ? d6_r1[7:0] : d3_r2[7:0] ;
  mult_a10[3] <= ( !ch_mode ) ? d7_r1[7:0] : d0_r3[7:0] ;  
 
  mult_a1 [4] <= ( !ch_mode ) ? d7[7:0]    : d4[7:0]    ;
  mult_a2 [4] <= ( !ch_mode ) ? d0_r1[7:0] : d5[7:0]    ;
  mult_a3 [4] <= ( !ch_mode ) ? d1_r1[7:0] : d6[7:0]    ;
  mult_a4 [4] <= ( !ch_mode ) ? d2_r1[7:0] : d7[7:0]    ;
  mult_a5 [4] <= ( !ch_mode ) ? d3_r1[7:0] : d4_r1[7:0] ;
  mult_a6 [4] <= ( !ch_mode ) ? d4_r1[7:0] : d5_r1[7:0] ;
  mult_a7 [4] <= ( !ch_mode ) ? d5_r1[7:0] : d6_r1[7:0] ;
  mult_a8 [4] <= ( !ch_mode ) ? d6_r1[7:0] : d7_r1[7:0] ;
  mult_a9 [4] <= ( !ch_mode ) ? d7_r1[7:0] : d4_r2[7:0] ;
  mult_a10[4] <= ( !ch_mode ) ? d0_r2[7:0] : d5_r2[7:0] ;   
                                           
  mult_a1 [5] <= ( !ch_mode ) ? d0_r1[7:0] : d5[7:0]    ;
  mult_a2 [5] <= ( !ch_mode ) ? d1_r1[7:0] : d6[7:0]    ;
  mult_a3 [5] <= ( !ch_mode ) ? d2_r1[7:0] : d7[7:0]    ;
  mult_a4 [5] <= ( !ch_mode ) ? d3_r1[7:0] : d4_r1[7:0] ;
  mult_a5 [5] <= ( !ch_mode ) ? d4_r1[7:0] : d5_r1[7:0] ;
  mult_a6 [5] <= ( !ch_mode ) ? d5_r1[7:0] : d6_r1[7:0] ;
  mult_a7 [5] <= ( !ch_mode ) ? d6_r1[7:0] : d7_r1[7:0] ;
  mult_a8 [5] <= ( !ch_mode ) ? d7_r1[7:0] : d4_r2[7:0] ;
  mult_a9 [5] <= ( !ch_mode ) ? d0_r2[7:0] : d5_r2[7:0] ;
  mult_a10[5] <= ( !ch_mode ) ? d1_r2[7:0] : d6_r2[7:0] ;  
                                           		    
  mult_a1 [6] <= ( !ch_mode ) ? d1_r1[7:0] : d6[7:0]    ;
  mult_a2 [6] <= ( !ch_mode ) ? d2_r1[7:0] : d7[7:0]    ;
  mult_a3 [6] <= ( !ch_mode ) ? d3_r1[7:0] : d4_r1[7:0] ;
  mult_a4 [6] <= ( !ch_mode ) ? d4_r1[7:0] : d5_r1[7:0] ;
  mult_a5 [6] <= ( !ch_mode ) ? d5_r1[7:0] : d6_r1[7:0] ;
  mult_a6 [6] <= ( !ch_mode ) ? d6_r1[7:0] : d7_r1[7:0] ;
  mult_a7 [6] <= ( !ch_mode ) ? d7_r1[7:0] : d4_r2[7:0] ;
  mult_a8 [6] <= ( !ch_mode ) ? d0_r2[7:0] : d5_r2[7:0] ;
  mult_a9 [6] <= ( !ch_mode ) ? d1_r2[7:0] : d6_r2[7:0] ;
  mult_a10[6] <= ( !ch_mode ) ? d2_r2[7:0] : d7_r2[7:0] ;    
                                           		    
  mult_a1 [7] <= ( !ch_mode ) ? d2_r1[7:0] : d7[7:0]    ;
  mult_a2 [7] <= ( !ch_mode ) ? d3_r1[7:0] : d4_r1[7:0] ;
  mult_a3 [7] <= ( !ch_mode ) ? d4_r1[7:0] : d5_r1[7:0] ;
  mult_a4 [7] <= ( !ch_mode ) ? d5_r1[7:0] : d6_r1[7:0] ;
  mult_a5 [7] <= ( !ch_mode ) ? d6_r1[7:0] : d7_r1[7:0] ;
  mult_a6 [7] <= ( !ch_mode ) ? d7_r1[7:0] : d4_r2[7:0] ;
  mult_a7 [7] <= ( !ch_mode ) ? d0_r2[7:0] : d5_r2[7:0] ;
  mult_a8 [7] <= ( !ch_mode ) ? d1_r2[7:0] : d6_r2[7:0] ;
  mult_a9 [7] <= ( !ch_mode ) ? d2_r2[7:0] : d7_r2[7:0] ;
  mult_a10[7] <= ( !ch_mode ) ? d3_r2[7:0] : d4_r3[7:0] ;    
  end


wire [7:0] dout_f [7:0] ;


genvar i;
generate
  for (i = 0; i <= 7 ; i = i + 1) 
  begin: loop
    fir_10 ins_0 (
        .clk             (clk), 
        .mult_b1         (mult_b1[15:0]), 
        .mult_b2         (mult_b2[15:0]), 
        .mult_b3         (mult_b3[15:0]), 
        .mult_b4         (mult_b4[15:0]), 
        .mult_b5         (mult_b5[15:0]), 
        .mult_a1         (mult_a1 [i]), 
        .mult_a2         (mult_a2 [i]), 
        .mult_a3         (mult_a3 [i]), 
        .mult_a4         (mult_a4 [i]), 
        .mult_a5         (mult_a5 [i]), 
        .mult_a6         (mult_a6 [i]), 
        .mult_a7         (mult_a7 [i]), 
        .mult_a8         (mult_a8 [i]), 
        .mult_a9         (mult_a9 [i]), 
        .mult_a10        (mult_a10[i]), 
        .dout            (dout_f[i])
        );	
	
   end
endgenerate  	

reg [63:0] data_in_r1 ;
reg [63:0] data_in_r2 ;
reg [63:0] data_in_r3 ;
reg [63:0] data_in_r4 ;
reg [63:0] data_in_r5 ;
reg [63:0] data_in_r6 ;
reg [63:0] data_in_r7 ;
reg [63:0] data_in_r8 ;


reg bw_100m_r ;
	
always @ (posedge clk)
begin
data_in_r1 <= data_in ;
data_in_r2 <= data_in_r1 ;
data_in_r3 <= data_in_r2 ;
data_in_r4 <= data_in_r3 ;
data_in_r5 <= data_in_r4 ;
data_in_r6 <= data_in_r5 ;
data_in_r7 <= data_in_r6 ;
data_in_r8 <= data_in_r7 ;
bw_100m_r  <= bw_100m ;
end


always @ (posedge clk)
begin
// if (bw_100m_r)
  begin	
  data_out[8*(0+1)-1 : 8*0]  <= dout_f[0] ;	 
  data_out[8*(1+1)-1 : 8*1]  <= dout_f[1] ;	
  data_out[8*(2+1)-1 : 8*2]  <= dout_f[2] ;	
  data_out[8*(3+1)-1 : 8*3]  <= dout_f[3] ;	
  data_out[8*(4+1)-1 : 8*4]  <= dout_f[4] ;	
  data_out[8*(5+1)-1 : 8*5]  <= dout_f[5] ;	
  data_out[8*(6+1)-1 : 8*6]  <= dout_f[6] ;	
  data_out[8*(7+1)-1 : 8*7]  <= dout_f[7] ;	
  end
// else  
  // begin
  // data_out                   <=  data_in_r8 ;
  // end  
end	
	
	
	
	
	
	
endmodule
