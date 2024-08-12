`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/06 15:38:54
// Design Name: 
// Module Name: adc_data_stream
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


module adc_data_stream(
    input           clk,
    input           pll_locked,
    input           adc_dclk,
    input           bw_100m,
    input [2:0]     adc_data_adjust,
    input [7:0]     dqd_p,
    input [7:0]     dqd_n,                    
    input [7:0]     dq_p,
    input [7:0]     dq_n,                    
    input [7:0]     did_p,
    input [7:0]     did_n,                    
    input [7:0]     di_p,
    input [7:0]     di_n,	
	  
    input           adc_fifo_rst,   
    input           pll_clk_rst,      	
    input           rd_en,      	
    input           channel_mode,   
    input  [7:0]    adc_fifo_cmd,    
    
    input  [15:0]   trig_mode,
    input           trig_edge_sel,
	input  [7:0]    trig_data,
	input           arm_rd_done,
	
	input  [7:0]    x_sel,
	
	input  [11:0]  pre_trig_len,
	
	output          freq_done,
	output [63:0]   freq_data,
	
    output          pll_clk_error,
    output [15:0]   wave_data,
    output          fifo_full,
    
    output  [7:0]   max_value,
    output  [7:0]   min_value,
    
    //output  [31:0]  low_freq_data,
    
    output [3:0]   arm_trig_bias
	
    );
    //trig_en
wire [7:0]adc_fifo_cmd ;
wire    fifo_wave_rst;
wire    x_wr_en;
wire [63:0] adc_data ;
wire [31:0] trig_adc_data;
wire [31:0] fifo_wave_data_in;
wire almost_full   ;
wire empty         ;
wire almost_empty  ;
wire valid         ;

reg fifo_full_r1 ;
reg fifo_full_r2 ;
reg no_trig_fifo_full_r1 ;
reg no_trig_fifo_full_r2 ;

wire fifo_full_w ;
reg fifo_full_flag ;
reg no_trig_fifo_full_flag;
wire wave_rst  ;
reg arm_wave_rst=1;
wire wr_en;
wire [11 : 0] rd_data_count ;
wire [10 : 0] wr_data_count ;
wire    fifo_wave_wr_en;
//***************************************************
/*display_cnt ins_display_cnt(
       //input
       .clk                 (clk),
       .rst_n               (pll_locked),
       .fifo_wave_wr_en     (wr_en),
       .split_screen_mode   (split_screen_mode),
       
       
       //output
       .screen2_fifo_w_en   (screen2_fifo_w_en),
       
      
    );*/


//********************************************************

always@(posedge clk)
begin
    fifo_full_r1 <= fifo_full_w ;
    fifo_full_r2 <= fifo_full_r1 ;
end	




always@(posedge clk)
begin
    if(adc_fifo_cmd == 8'h01)//
        arm_wave_rst <= 0 ;
    else if(adc_fifo_cmd == 8'h02)
        arm_wave_rst <= 1 ;
end



//always@(posedge clk)
//begin
//    if(fifo_full)
//        wr_en <= 0 ;     
//    else if((adc_fifo_cmd == 8'h01)&&(empty))
//        wr_en <= 1 ;
//end
  




always@(posedge clk)
begin
if (arm_wave_rst)
  fifo_full_flag <= 1'b0 ;
else if (fifo_full_r1 & ~fifo_full_r2) 
  fifo_full_flag <= 1'b1 ;
end


always@(posedge clk)
begin
if (arm_rd_done)
  no_trig_fifo_full_flag <= 1'b0 ;
else if (fifo_full_r1 & ~fifo_full_r2) 
  no_trig_fifo_full_flag <= 1'b1 ;
end
//trig_mode=0不触发，=1自动触发，=2正常触发

wire fifo_full_debug;
wire full_trig;
wire no_trig_sign;
reg wr_en_r;
reg [31:0] fifo_wave_data_in_r;
//***********************************这里的信号都是第二个fifo的*****************************************↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
assign  wave_rst = (trig_mode==0) ? arm_wave_rst : fifo_wave_rst ;
//assign  wr_en = (trig_modde==0) ? (~fifo_full_flag&&x_wr_en) : (no_trig_sign ? fifo_wave_wr_en )  ;
//assign  fifo_wave_data_in = (trig_modde==0) ? adc_data[31:0] : trig_adc_data ;  
always@(posedge clk)
    case(trig_mode)
        'd0:begin
                wr_en_r <= ~fifo_full_flag&&x_wr_en;
                fifo_wave_data_in_r <= adc_data[63:32];
            end
        'd1:begin
                if(no_trig_sign) begin
                    wr_en_r <=~no_trig_fifo_full_flag&&x_wr_en;
                    fifo_wave_data_in_r <= adc_data[63:32];
                end
                else begin
                    wr_en_r <= fifo_wave_wr_en;
                    fifo_wave_data_in_r <= trig_adc_data;
                end
            end
        
        'd2:begin
                wr_en_r <= fifo_wave_wr_en;
                fifo_wave_data_in_r <= trig_adc_data;
            end
      endcase
                                              
assign wr_en =wr_en_r;
assign fifo_wave_data_in=fifo_wave_data_in_r;

assign full_trig=(wr_data_count==11'b1111_1111_111) ? 1'b1 : 1'b0;
assign fifo_full_debug =(trig_mode==0) ?  fifo_full_flag : full_trig ;
assign fifo_full=fifo_full_debug;
//assign wr_en = (~fifo_full_flag || trig_fifo_wr_en) && x_wr_en; //组合逻辑，fifo写使能
//assign wr_en = ~fifo_full_flag || trig_fifo_wr_en; //组合逻辑，fifo写使能
//***********************************这里的信号都是第二个fifo的*****************************************↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑


wire    fifo_trig_rst;

wire    fifo_trig_wr_en;
wire    fifo_trig_rd_en;

wire    trig_pulse0;
wire    trig_pulse1;
wire    trig_pulse2;
wire    trig_pulse3;
wire [11:0] fifo_trig_data_count;
//trig_en
fifo_control fifo_control(
       .clk              (clk),
       .rst_n            (pll_locked),
       .trig_mode          (trig_mode),
       
       .trig_pulse0       (trig_pulse0),
       .trig_pulse1       (trig_pulse1),
       .trig_pulse2       (trig_pulse2),
       .trig_pulse3       (trig_pulse3),
       
       
       .fifo_wave_wr_data_count   (wr_data_count),
       .arm_rd_done      (arm_rd_done),
       .pre_trig_len     (pre_trig_len),
       .fifo_trig_wr_data_count (fifo_trig_data_count),
    
       .x_wr_en           (x_wr_en),
    
      .fifo_wave_rst     (fifo_wave_rst),
      .fifo_trig_rst     (fifo_trig_rst),
      .fifo_wave_wr_en   (fifo_wave_wr_en),
      .fifo_trig_wr_en   (fifo_trig_wr_en),
      .fifo_trig_rd_en   (fifo_trig_rd_en),
      
      
      .arm_trig_bias          (arm_trig_bias),
      
      .no_trig_sign           (no_trig_sign)
    );



wire fifo_trig_full;


fifo_trig fifo_trig (//*********************************************************************************中间fifo,充当移位寄存器
  .clk(clk),       // input wire rd_rst
  .srst(fifo_trig_rst&&pll_locked ),                // input wire wr_rst           
  .din(adc_data[63:32]),           // input wire [63 : 0] din  
  .wr_en(fifo_trig_wr_en),                      // input wire wr_en
  .rd_en(fifo_trig_rd_en),                      // input wire rd_en
  .dout(trig_adc_data),               // output wire [15 : 0] dout //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  .full(fifo_trig_full),                    // output wire full
  .empty(),                  // output wire empty
  .data_count(fifo_trig_data_count)   // output wire [10 : 0] wr_data_count
);




fifo_wave fifo_wave (
  .wr_clk(clk),                   // input wire wr_clk
  .wr_rst(wave_rst),                // input wire wr_rst
  .rd_clk(clk),                   // input wire rd_clk
  .rd_rst(wave_rst),               // input wire rd_rst
  .din(fifo_wave_data_in),           // input wire [63 : 0] din  
  // .wr_en(wr_en & ~fifo_full_flag),                      // input wire wr_en
  .wr_en(wr_en ),                      // input wire wr_en
  .rd_en(rd_en),                      // input wire rd_en
//  .dout(wave_data),               // output wire [15 : 0] dout
  .dout({wave_data[7:0],wave_data[15:8]}),               // output wire [15 : 0] dout 
  .full(fifo_full_w),                    // output wire full
  .almost_full(almost_full),      // output wire almost_full
  .empty(empty),                  // output wire empty
  .almost_empty(almost_empty),    // output wire almost_empty
  .valid(valid),                  // output wire valid
  .rd_data_count(rd_data_count),  // output wire [11 : 0] rd_data_count
  .wr_data_count(wr_data_count)   // output wire [10 : 0] wr_data_count
);
wire rst_max_min_val;
wire max_min_en;
assign rst_max_min_val=wave_rst;
assign max_min_en=wr_en;

wire clk_fx;

trig trig_ch1(
    .clk(clk),
    .adc_data_ch1(adc_data[63:32]),
    //.pll_locked(pll_locked),
    //.wr_data_count(wr_data_count),
    
    //.trig_en(trig_en),
    .trig_edge_sel(trig_edge_sel),
    .trig_data(trig_data),
    //.rst_max_min_val(rst_max_min_val),
    .max_min_en(max_min_en),
    //.arm_rd_done(arm_rd_done),
    
    //.trig_state(trig_state),
    .trig_pulse0       (trig_pulse0),
    .trig_pulse1       (trig_pulse1),
    .trig_pulse2       (trig_pulse2),
    .trig_pulse3       (trig_pulse3),
    
    //.trig_fifo_rst(trig_fifo_rst),
    //.trig_fifo_wr_en(trig_fifo_wr_en),
    
    .max_value(max_value),
    .min_value(min_value),
    .square_wave1(clk_fx)
    
 
);

freq_counter2 freq_cnt_ch1(
    .clk_fs (clk),
    .rst_n  (pll_locked),
    .clk_fx(clk_fx),
    .freq_done(freq_done),
    .frequency_data(freq_data)
);

// 抽值

x_base x_base(
    .clk(clk),
    .x_sel(x_sel),
    .x_wr_en(x_wr_en)
);


adc_data_rx ins_adc1 (
    .adc_clk                       (adc_dclk),  
    .dclk_real                     (clk), 
    .bw_100m                       (bw_100m), 
    .ch_mode                       (channel_mode),  
    .adc_fifo_rst                  (adc_fifo_rst),  
    .pll_clk_rst                   (pll_clk_rst),  
    .adc_data_adjust               (adc_data_adjust),  
    .id_adjust                     (0  ),
    .qd_adjust                     (0  ),
    .adc_data_relation             (0),  
    .dqd_p                         (dqd_p[7:0]), 
    .dqd_n                         (dqd_n[7:0]), 
    .dq_p                          (dq_p[7:0]), 
    .dq_n                          (dq_n[7:0]), 
    .did_p                         (did_p[7:0]), 
    .did_n                         (did_n[7:0]), 
    .di_p                          (di_p[7:0]), 
    .di_n                          (di_n[7:0]), 
    .pll_clk_error                 (pll_clk_error), 
    .data_out                      (adc_data[63:0] ) // ch1 ->[31:0]  // ch2 ->[63:32]  //拼合模式CH1在先
    );   
    


endmodule