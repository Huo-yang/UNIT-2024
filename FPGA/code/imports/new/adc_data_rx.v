`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/15 14:27:20
// Design Name: 
// Module Name: adc_data_rx
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
//***********************************   
// 7 Series FPGAs
// SelectIO Resources
// User Guide
// UG471 (v1.8) September 27, 2016
// PAGE 110
//***********************************
//////////////////////////////////////////////////////////////////////////////////


module adc_data_rx(
    input           dclk_real,//250M
    input           adc_clk,  //125M
    input           bw_100m,  //125M

    input [2:0]     adc_data_adjust,
    input [7:0]     id_adjust ,
    input [7:0]     qd_adjust ,
    input           adc_data_relation,
    input           ch_mode,
    input           adc_fifo_rst,
    input           pll_clk_rst,
  
    input [7:0]     dqd_p,
    input [7:0]     dqd_n,
                    
    input [7:0]     dq_p,
    input [7:0]     dq_n,
                    
    input [7:0]     did_p,
    input [7:0]     did_n,
                    
    input [7:0]     di_p,
    input [7:0]     di_n,
    
    output          pll_clk_error,
    output [63:0]   data_out
        
    );

wire [63:0] adc_sync_data ;
wire [63:0] data_after_adjust ;
wire [7:0] dqd ;
wire [7:0] dq ;
wire [7:0] did ;
wire [7:0] di ;
wire adc_clk ;
reg adc_fifo_rst_r1 ;
reg adc_fifo_rst_r2 ;
 (* max_fanout=5 *)reg adc_fifo_rst_r3 ;
 reg [63:0] data_sync ; 
 reg [63:0] fifo_dout_r1 ; 
 reg [63:0] fifo_dout_r2 ; 
 
 
 
always@(posedge adc_clk)
begin 
adc_fifo_rst_r1 <= adc_fifo_rst ;
adc_fifo_rst_r2 <= adc_fifo_rst_r1 ;
adc_fifo_rst_r3 <= adc_fifo_rst_r2 ;
end 
   

genvar i;
generate
for (i = 0; i <= 7; i = i + 1)
begin: loop0    
   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst0 (
      .O(dqd[i]),  // Buffer output
      .I(dqd_p[i]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(dqd_n[i])  // Diff_n buffer input (connect directly to top-level port)
   );
   
    IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst1 (
      .O(dq[i]),  // Buffer output
      .I(dq_p[i]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(dq_n[i])  // Diff_n buffer input (connect directly to top-level port)
   );
       
   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst2 (
      .O(did[i]),  // Buffer output
      .I(did_p[i]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(did_n[i])  // Diff_n buffer input (connect directly to top-level port)
   );
      
    IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst3 (
      .O(di[i]),  // Buffer output
      .I(di_p[i]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(di_n[i])  // Diff_n buffer input (connect directly to top-level port)
   );  
end
endgenerate 
    

(*Mark_debug = "TRUE"*)wire [7:0] dqd_r ;
(*Mark_debug = "TRUE"*)wire [7:0] dqd_f ;
(*Mark_debug = "TRUE"*)wire [7:0] dq_r ;
(*Mark_debug = "TRUE"*)wire [7:0] dq_f ;
(*Mark_debug = "TRUE"*)wire [7:0] did_r ;
(*Mark_debug = "TRUE"*)wire [7:0] did_f ;
(*Mark_debug = "TRUE"*)wire [7:0] di_r ;
(*Mark_debug = "TRUE"*)wire [7:0] di_f ;

assign iddr_rst = 0 ;
    
genvar j;
generate
for (j = 0; j <= 7; j = j + 1)
begin: loop00   

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_inst0 (
      .Q1(dqd_r[j]), // 1-bit output for positive edge of clock 
      .Q2(dqd_f[j]), // 1-bit output for negative edge of clock
      .C(adc_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(dqd[j]),   // 1-bit DDR data input
      .R(iddr_rst),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_inst1 (
      .Q1(dq_r[j]), // 1-bit output for positive edge of clock 
      .Q2(dq_f[j]), // 1-bit output for negative edge of clock
      .C(adc_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(dq[j]),   // 1-bit DDR data input
      .R(iddr_rst),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_inst2 (
      .Q1(did_r[j]), // 1-bit output for positive edge of clock 
      .Q2(did_f[j]), // 1-bit output for negative edge of clock
      .C (adc_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(did[j]),   // 1-bit DDR data input
      .R(iddr_rst),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );


   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_inst3 (
      .Q1(di_r[j]), // 1-bit output for positive edge of clock 
      .Q2(di_f[j]), // 1-bit output for negative edge of clock
      .C(adc_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(di[j]),   // 1-bit DDR data input
      .R(iddr_rst),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );
   
end
endgenerate 


//            ________________________________________________________________________________
//di         :______________|__D1_|__D3_|__D5_|__D6_|__D9_|_D11_|_.........___________________
//            ________________________________________________________________________________
//did        :______________|__D0_|__D2_|__D4_|__D5_|__D8_|_D10_|_.........___________________
//
//adc_clk       :_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~ 
//            ________________________________________________________________________________
//di_r       :_________________|_____D1____|_____D5____|_____D9____|_...............
//            ________________________________________________________________________________
//did_r      :_________________|_____D0____|_____D4____|_____D8____|..................
//            ________________________________________________________________________________
//di_f       :_______________________|_____D3____|_____D7____|_____D11___|_...............
//            ________________________________________________________________________________
//did_f      :_______________________|_____D2____|_____D6____|_____D10___|_...............

reg [7:0] did_r_reg ;
reg [7:0] did_f_reg ;

reg [7:0] di_r_reg ;
reg [7:0] di_f_reg ;

reg [7:0] dqd_r_reg ;
reg [7:0] dqd_f_reg ;

reg [7:0] dq_r_reg ;
reg [7:0] dq_f_reg ;

// ila_0 my_ila_0 (
    // .clk(adc_clk), // input wire clk


    // .probe0({
             // did_r_reg[7:0],    
             // di_r_reg[7:0],    
             // dq_r_reg[7:0],    
             // dqd_r_reg[7:0]        
            // }) // input wire [99:0] probe0
// );


always @ (posedge adc_clk)
begin
did_r_reg <= did_r[7:0] ;
did_f_reg <= did_f[7:0] ;

di_r_reg  <= di_r[7:0] ;
di_f_reg  <= di_f[7:0] ;

dqd_r_reg <= dqd_r[7:0] ;
dqd_f_reg <= dqd_f[7:0] ;

dq_r_reg  <= dq_r[7:0] ;
dq_f_reg  <= dq_f[7:0] ;
end

// data_out_sig[63:32] <= {dqd_r_reg , dq_r_reg ,dqd_f_reg ,dq_f_reg } ;

reg [63:0] data_out_sig ;
reg [63:0] data_out_sig_r1 ;
reg [63:0] data_out_sig_r2 ;
reg [63:0] data_out_reg ;


wire [63:0] adc_din ;
wire [63:0] fifo_dout ;

assign adc_din[63:0] = {dqd_r_reg , dq_r_reg ,dqd_f_reg ,dq_f_reg ,did_r_reg , di_r_reg ,did_f_reg ,di_f_reg } ;

always @ (posedge adc_clk)//CH1---Q   CH2---I
begin//采样先后顺序        1           2          3         4
data_out_sig[63:32] <= {dqd_r_reg , dq_r_reg ,dqd_f_reg ,dq_f_reg } ;//ch1
data_out_sig[31:0]  <= {did_r_reg , di_r_reg ,did_f_reg ,di_f_reg } ;//ch2
data_out_sig_r1     <= data_out_sig    ;
data_out_sig_r2     <= data_out_sig_r1 ;
data_out_reg        <= data_out_sig_r2 ;
end


assign t_port = 0 ;

// reg [7:0] adc_data_adjust_s ;
// reg adc_data_relation_s ;
// always@(posedge adc_clk)
// begin 
// adc_data_adjust_s    <= adc_data_adjust ;
// adc_data_relation_s  <= adc_data_relation ;
// end

// data_adjust data_adjust(
    // .adc_data_in            (data_out_reg[63:0]      ),
    // .adc_data_adjust        (adc_data_adjust_s[7:0]  ),
    // .id_adjust              (id_adjust[7:0]          ),
    // .qd_adjust              (qd_adjust[7:0]          ),
    // .ch_mode                (ch_mode                 ),
    // .adc_clk                (adc_clk                 ),
    // .adc_data_en            (1'b1                    ),
    // .adc_data_relation      (adc_data_relation_s     ),
    // .data_after_adjust      (data_after_adjust[63:0] ),
    // .data_en_after_adjust   ()

    // );

//***************************************   
    
reg [7:0 ]  ch1_d0 , ch1_d1 , ch1_d2 , ch1_d3 ;
reg [7:0 ]  ch2_d0 , ch2_d1 , ch2_d2 , ch2_d3 ;

wire [7:0]    ch1_d0_dly , ch1_d1_dly , ch1_d2_dly , ch1_d3_dly ;
wire [7:0]    ch2_d0_dly , ch2_d1_dly , ch2_d2_dly , ch2_d3_dly ;
   
always @ (posedge adc_clk)//CH1---Q   CH2---I
begin
{ch1_d0 , ch1_d1 , ch1_d2 , ch1_d3} <= {dqd_r_reg , dq_r_reg ,dqd_f_reg ,dq_f_reg } ;//ch1
{ch2_d0 , ch2_d1 , ch2_d2 , ch2_d3} <= {did_r_reg , di_r_reg ,did_f_reg ,di_f_reg } ;//ch2  
end


delay_adjust_v0 delay_adjust0(
    .clk                    (adc_clk),
    .delay_time             (adc_data_adjust  ),
    .data_in                ({ch1_d0 , ch1_d1 , ch1_d2 , ch1_d3}  ),
    .data_out               ({ch1_d0_dly , ch1_d1_dly , ch1_d2_dly , ch1_d3_dly}  )
	
    );	
delay_adjust_v0 delay_adjust1(
    .clk                    (adc_clk      ),
    .delay_time             (adc_data_adjust),
    .data_in                ({ch2_d0 , ch2_d1 , ch2_d2 , ch2_d3}  ),
    .data_out               ({ch2_d0_dly , ch2_d1_dly , ch2_d2_dly , ch2_d3_dly}  )
    );


reg  [63:0] data_64b ;

// assign  data_64b = {ch1_d0 , ch1_d1 , ch2_d0 , ch2_d1 ,ch1_d2 , ch1_d3 , ch2_d2 , ch2_d3 }   ;

always @ (posedge adc_clk)//CH1---Q   CH2---I
begin
data_64b <=  !ch_mode ? {ch1_d0_dly,ch2_d0_dly,ch1_d1_dly,ch2_d1_dly,ch1_d2_dly,ch2_d2_dly,ch1_d3_dly,ch2_d3_dly } :
                        {ch2_d0_dly,ch2_d1_dly,ch2_d2_dly,ch2_d3_dly,ch1_d0_dly,ch1_d1_dly,ch1_d2_dly,ch1_d3_dly } ;
end

// wire [7:0] D0 ;
// wire [7:0] D1 ;
// wire [7:0] D2 ;
// wire [7:0] D3 ;
// wire [7:0] D4 ;
// wire [7:0] D5 ;
// wire [7:0] D6 ;

// assign D0 = fifo_dout_r2[7:0] ;
// assign D1 = fifo_dout_r2[15:8] ;
// assign D2 = fifo_dout_r2[23:16] ;
// assign D3 = fifo_dout_r2[31:24] ;

// ila_0 my_ila_0 (
    // .clk(adc_clk), // input wire clk


    // .probe0({
             // ch1_d0[7:0],    
             // ch1_d1[7:0],    
             // ch1_d2[7:0],    
             // ch1_d3[7:0]        
            // }) // input wire [99:0] probe0
// );
    
fifo_adc_in fifo_adc_in (
    .rst                    (adc_fifo_rst_r1),        // input wire rst
    .wr_clk                 (adc_clk),    // input wire wr_clk
    .rd_clk                 (dclk_real),  // input wire rd_clk
    .din                    (data_64b[63:0]),        // input wire [63 : 0] din
    // .din                    ({8{t_cnt}}),        // input wire [63 : 0] din
    .wr_en                  (~full),    // input wire wr_en
    .rd_en                  (~empty),    // input wire rd_en
    .dout                   (fifo_dout[63:0]),      // output wire [63 : 0] dout
    .full                   (full ),      // output wire full
    .empty                  (empty ),    // output wire empty
    .valid                  ( )    // output wire valid
); 

reg pll_clk_error_sig ;

always @ (posedge dclk_real)
begin
if (pll_clk_rst)
   pll_clk_error_sig <= 1'b0 ;
else if (full | empty)   
   pll_clk_error_sig <= 1'b1 ;
end

assign pll_clk_error = pll_clk_error_sig ;



wire [4:0]	 A ;
wire [63:0]	 fifo_dout_dly ;


// vio_0 your_instance_name (
  // .clk(dclk_real),                // input wire clk
  // .probe_out0(A[4:0])  // output wire [7 : 0] probe_out0
// );


genvar k;
generate
for (k = 0; k <= 63; k = k + 1)
begin: loop000 
  
   SRLC32E #(
      .INIT(32'h00000000) // Initial Value of Shift Register
   ) SRLC32E_inst1 (
      .Q(fifo_dout_dly[k]),     // SRL data output
      .Q31(), // SRL cascade output pin
      .A(6),     // 5-bit shift depth select input
      .CE(1),   // Clock enable input
      .CLK(dclk_real), // Clock input
      .D(fifo_dout[k])      // SRL data input
   );        
end
endgenerate  

wire [63:0] fifo_f0 ;
wire [63:0] fifo_f1 ;

filter_10 ins_filter_10 (
    .clk        (dclk_real), 
    .ch_mode    (ch_mode), 
    .data_in    (fifo_dout_dly[63:0]), 
    .data_out   (fifo_f0[63:0])
    );


filter ins_filter (
    .clk       (dclk_real), 
    .ch_mode   (ch_mode), 
    .data_in   (fifo_dout_dly[63:0]), 
    .data_out  (fifo_f1[63:0])
    );



always@(posedge dclk_real)
begin 
fifo_dout_r1   <= bw_100m ? fifo_f0 : fifo_f1  ;
fifo_dout_r2   <= fifo_dout_r1 ;                          
end 

    
assign data_out = fifo_dout_r1 ;

    
endmodule
