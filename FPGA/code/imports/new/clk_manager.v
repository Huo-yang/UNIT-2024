`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 14:18:26
// Design Name: 
// Module Name: clk_manager
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


module clk_manager(
    input  clk_in,//100m
    input  clk_sel,//
    input [1:0] adc_pll_rst,//100m
    input  adc1_dclk_p,
    input  adc1_dclk_n,
    input  adc2_dclk_p,
    input  adc2_dclk_n,
    //input  adc1_clk_rst,
    //input  adc2_clk_rst,

    output  adc1_dclk,
    output  adc2_dclk,	
    output  adc1_dclk_ph0,	
    output  adc2_dclk_ph0,	
    output  clk_250mhz,
    output  clk_500mhz,
    output  clk_10mhz,
    output  clk_100mhz,
    output  clk_200mhz,
    output  clk_62_5mhz,
    output  clk_in_bufg,
    output  clk_to_sram,
    //output  pclk,
    //input   adc_clk_p,
    //input   adc_clk_n,
    output  pll_locked
			
    );
	


/*    
   IBUFDS clkin0_ibufgds
   (.O  (clk_in1_clk_wiz_0),
    .I  (adc1_dclk_p),
    .IB (adc1_dclk_n));  
   
assign  adc1_dclk_ph0 = clk_in1_clk_wiz_0 ;
 
 
  clk_wiz_0 ins_clk_wiz_0
   (
    // Clock out ports
    .clk_out1(adc1_dclk),     // output clk_out1
    // Status and control signals
    .reset   (adc_pll_rst[0]), // input reset
    .locked  (locked_adc1),       // output locked
   // Clock in ports
    .clk_in1 (clk_in1_clk_wiz_0));      // input clk_in1
 
 
    IBUFDS clkin1_ibufgds
   (.O  (clk_in2_clk_wiz_0),
    .I  (adc2_dclk_p),
    .IB (adc2_dclk_n));  
   
assign  adc2_dclk_ph0 = clk_in2_clk_wiz_0 ;
 
  clk_wiz_0 ins_clk_wiz_1
   (
    // Clock out ports
    .clk_out1(adc2_dclk),     // output clk_out1
    // Status and control signals
    .reset   (adc_pll_rst[1]), // input reset
    .locked  (locked_adc2),       // output locked
   // Clock in ports
    .clk_in1 (clk_in2_clk_wiz_0));      // input clk_in1
  */
 
 
 
 
  clk_wiz_0 ins_clk_wiz_0
   (
    // Clock out ports
    .clk_out1 (adc1_dclk),     // output clk_out1
    .clk_out2 (adc1_dclk_ph0),     // output clk_out1
    // Status and control signals
    // .reset    (~osc_clk_locked), // input reset
    .reset    (adc_pll_rst[0]), // input reset
    .locked   (locked_adc1),       // output locked
   // Clock in ports
    .clk_in1_p(adc1_dclk_p),    // input clk_in1_p
    .clk_in1_n(adc1_dclk_n));    // input clk_in1_n
// INST_TAG_END ------ End INSTANTIATION Template ---------	

  clk_wiz_0 ins_clk_wiz_1
   (
    // Clock out ports
    .clk_out1 (adc2_dclk),     // output clk_out1
    .clk_out2 (adc2_dclk_ph0),     // output clk_out1
    // Status and control signals
    // .reset    (~osc_clk_locked), // input reset
    .reset    (adc_pll_rst[1]), // input reset
    .locked   (locked_adc2),       // output locked
   // Clock in ports
    .clk_in1_p(adc2_dclk_p),    // input clk_in1_p
    .clk_in1_n(adc2_dclk_n));    // input clk_in1_n

	
	
reg  pll_rst ;

   IBUFG BUFG_clk_in (
      .O(clk_in_bufg), // 1-bit output: Clock output
      .I(clk_in     )  // 1-bit input: Clock input
   );


  clk_wiz_2 ins_clk_wiz_2
   (
    // Clock out ports
    .clk_out1 (clk_100m_bufg),     // output clk_out1
    // Clock in ports
    .clk_in1  (clk_in_bufg));      // input clk_in1

assign clk_mux = clk_100m_bufg ;


   // BUFGMUX #(
   // )
   // BUFGMUX_inst (
      // .O      (clk_mux      ),   // 1-bit output: Clock output
      // .I0     (clk_100m_bufg), // 1-bit input: Clock input (S=0)
      // .I1     (clk_in_bufg  ), // 1-bit input: Clock input (S=1)
      // .S      (clk_sel      )    // 1-bit input: Clock select
   // );

   
  main_clk ins_main_clk
   (
    // Clock out ports
    .clk_out1(clk_250mhz),     // output clk_out1
    .clk_out2(clk_100mhz),     // output clk_out1
    .clk_out3(clk_200mhz),     // output clk_out1
    .clk_out4(clk_500mhz),     // output clk_out1
    .clk_out5(clk_10mhz),     // output clk_out1
    // Status and control signals
    .reset   (pll_rst), // input reset
    .locked  (osc_clk_locked),       // output locked
   // Clock in ports
    .clk_in1 (clk_mux));      // input clk_in1	
	
assign 	pll_locked = osc_clk_locked ;

reg [31:0] pll_rst_cnt ;

/*   clk_wiz_1 clk_wiz_1
   (
    // Clock out ports
    .clk_out1(pclk),     // output clk_out1
    // Status and control signals
    .reset   (pll_rst), // input reset
    .locked  (),       // output locked
   // Clock in ports
    .clk_in1 (clk_mux));      // input clk_in1
 */


always @(posedge clk_mux or negedge osc_clk_locked)
begin
if (!osc_clk_locked )
   begin
   if (pll_rst_cnt == 10000000) //10ms  
      pll_rst_cnt <= 0 ;
   else  
      pll_rst_cnt <= pll_rst_cnt + 1;
   end
else   
   pll_rst_cnt <= 0 ;  
end

always @(posedge clk_mux)
begin
if ((pll_rst_cnt >= 1) && (pll_rst_cnt < 100))//锁相环如果没锁成功，每等10ms复位�?�?
   pll_rst <= 1'b1 ;
else  
   pll_rst <= 1'b0 ;
end 
	
// clk_div #( .CLK_DIV(100000))  	ins_clk_1khz 	(.clk_in(clk_100m), 	.clk_out(clk_1khz) );
// clk_div #( .CLK_DIV(10))  	    ins_clk_10mhz 	(.clk_in(clk_100m), 	.clk_out(clk_10mhz) );

   // ODDR2 #(
      // .DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
      // .INIT(1'b0),    // Sets initial state of the Q output to 1'b0 or 1'b1
      // .SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
   // ) clock_forward_inst (
      // .Q(clk_to_sram),     // 1-bit DDR output data
      // .C0(clk_200mhz),  // 1-bit clock input
      // .C1(~clk_200mhz), // 1-bit clock input
      // .CE(1'b1),      // 1-bit clock enable input
      // .D0(1'b0), // 1-bit data input (associated with C0)
      // .D1(1'b1), // 1-bit data input (associated with C1)
      // .R(0),   // 1-bit reset input
      // .S(0)   // 1-bit set input
   // );
 
   // OBUFDS #(
      // .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      // .SLEW("SLOW")           // Specify the output slew rate
   // ) OBUFDS_inst (
      // .O(adc_clk_p),     // Diff_p output (connect directly to top-level port)
      // .OB(adc_clk_n),    // Diff_n output (connect directly to top-level port)
      // .I(clk_500mhz)      // Buffer input
   // );
 
 
 
 
 
endmodule
