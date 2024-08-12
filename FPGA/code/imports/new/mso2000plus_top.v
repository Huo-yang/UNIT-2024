`timescale 1ns / 1ps
`define BUS_TRIG 

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 08:50:10
// Design Name: 
// Module Name: mso2000_top
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
// set_param general.maxThreads 8
// get_param  general.maxThreads
//////////////////////////////////////////////////////////////////////////////////

module mso2000plus_top#
(
   parameter ADDR_WIDTH       = 27 ,
   parameter nCK_PER_CLK      = 2 ,
   parameter PAYLOAD_WIDTH    = 64 

)

(
    input           fpga_usercclk,
    input           clk_sel,
    // input        adc_clk_p,
    // input        adc_clk_n,
    
    
    inout [15:0]    am_gpmc_d,
    input [9:0]     am_gpmc_a,  
    input           gpmc_nwe,
    input           gpmc_nre,
    input  [15:0]   la_d_p ,
    input  [15:0]   la_d_n ,
//********************************************
    output          adc2_sdata,
    output          adc2_sclk,
    output          adc2_cs,
    output          adc2_dclk_rst,

    output          adc2_pdq,
    output          adc2_pd,
	
    output          adc2_cal,    

    input           adc2_dclk_p,
    input           adc2_dclk_n,

    input [7:0]     adc2_dqd_p,
    input [7:0]     adc2_dqd_n,
                    
    input [7:0]     adc2_dq_p,
    input [7:0]     adc2_dq_n,
                    
    input [7:0]     adc2_did_p,
    input [7:0]     adc2_did_n,
                    
    input [7:0]     adc2_di_p,
    input [7:0]     adc2_di_n,

//*************************************
    output          adc1_sdata,
    /*
    在扩展控制模式下，此引脚作为串行数据输入�?(SDATA)�?
    */
    output          adc1_sclk,  
    /*输出电压幅度和串行接口时钟�?�为高电平时，表示正常差分输出数据幅�?,
    为低电平时，表示降低差分输出幅度和降低功耗�?�当扩展控制模，SCLK 作为串行数据的输入时钟�??
    */
    output          adc1_cs, //串行接口片�??
    output          adc1_dclk_rst, //复位。当引脚输入正脉冲用于复位和同步多个转换器的时序 DCLK�?
    
    output          adc1_pdq,   //掉电模式，高电平时设置Q通道为掉电模�?
    output          adc1_pd,    //掉电模式，高电平时为掉电模式
    output          adc1_cal,  //校准模式启动信号
    
    input           adc1_dclk_p,
    input           adc1_dclk_n,
    /*
    差分时钟输出。用于锁存输出数据�?�这些引脚可以�?�择延时或不延时
    以便输出同步，在单�?�数据率 SDR 模式下，这些信号的�?�度为输入时
    钟的 1/2，在双�?�数据率 DDR 模式下，这些信号的�?�度为输入时钟的
    1/4。在校准周期�? DCLK 不被�?活�??
    */

    input [7:0]     adc1_dqd_p,
    input [7:0]     adc1_dqd_n,//Q通道LVDS差分输出，时间靠�?
                       
    input [7:0]     adc1_dq_p,//Q通道LVDS差分输出
    input [7:0]     adc1_dq_n,
                       
    input [7:0]     adc1_did_p,//I通道LVDS差分输出，时间靠�?
    input [7:0]     adc1_did_n,
                       
    input [7:0]     adc1_di_p,//I通道LVDS差分输出，时间靠�?
    input [7:0]     adc1_di_n,
    
//************************************
//*******************************************   
    output          dso_1khz,//Y8    //DATA
    output          dac_din,
    output          dac_clk,
    output          dac3_cs,
    output          dac2_cs,
    output          dac1_cs,

    input           pll_muxout,
    output          fpga_int,
    output          pll_le,
    output          adc1_caldly,
    output          adc2_caldly,
    
    output          pass_fail_out      //V6 //CS




    );
 
`include "top_define.txt" 




(* IOB = "TRUE" *)reg adc1_dclk_rst_sync1 ;
reg adc1_pd_sync ;
(* IOB = "TRUE" *)reg adc1_pd_sync1 ;
reg adc1_pdq_sync ;
(* IOB = "TRUE" *)reg adc1_pdq_sync1 ;
reg adc1_cal_sync ;
(* IOB = "TRUE" *)reg adc1_cal_sync1 ;

(* IOB = "TRUE" *)reg adc2_dclk_rst_sync1 ;
reg adc2_pd_sync ;
(* IOB = "TRUE" *)reg adc2_pd_sync1 ;
reg adc2_pdq_sync ;
(* IOB = "TRUE" *)reg adc2_pdq_sync1 ;
reg adc2_cal_sync ;
(* IOB = "TRUE" *)reg adc2_cal_sync1 ;

wire adc1_dclk_ph0 ;
wire adc2_dclk_ph0 ;
wire dclk ;
wire pll_fpga_le;

assign adc1_dclk_rst =  adc1_dclk_rst_sync1 ;
assign adc1_pd       =  adc1_pd_sync1       ;
assign adc1_pdq      =  adc1_pdq_sync1      ;
assign adc1_cal      =  adc1_cal_sync1      ;

assign adc2_dclk_rst =  adc2_dclk_rst_sync1;
assign adc2_pd       =  adc2_pd_sync1      ;
assign adc2_pdq      =  adc2_pdq_sync1     ;
assign adc2_cal      =  adc2_cal_sync1     ;

assign pll_le        = pll_fpga_le;
assign adc1_caldly   = 0;
assign adc2_caldly   = 0;

//always @(posedge dclk) 
always @(posedge adc1_dclk_ph0) 
begin
adc2_dclk_rst_sync  <= adc_dclk_rst[1];
adc2_dclk_rst_sync1 <= adc2_dclk_rst_sync;

adc2_pd_sync        <= cmd_h3FE[9];
adc2_pd_sync1       <= adc2_pd_sync;

adc2_pdq_sync       <= cmd_h3FE[8];
adc2_pdq_sync1      <= adc2_pdq_sync;

adc2_cal_sync       <= cmd_h3FE[10];
adc2_cal_sync1      <= adc2_cal_sync;
end


 //always @(posedge  adc2_dclk_ph0) 
always @(posedge  dclk) 
begin
adc1_dclk_rst_sync  <= adc_dclk_rst[0];
adc1_dclk_rst_sync1 <= adc1_dclk_rst_sync;

adc1_pd_sync        <= cmd_h3FE[1];
adc1_pd_sync1       <= adc1_pd_sync;

adc1_pdq_sync       <= cmd_h3FE[0];
adc1_pdq_sync1      <= adc1_pdq_sync;

adc1_cal_sync       <= cmd_h3FE[2];
adc1_cal_sync1      <= adc1_cal_sync;

end




clk_manager ins_clk_manager (
    .clk_in                        (fpga_usercclk),
    .clk_sel                       (clk_sel    ),
    .adc1_dclk_p                   (adc1_dclk_p),
    .adc1_dclk_n                   (adc1_dclk_n),
    .adc2_dclk_p                   (adc2_dclk_p),
    .adc2_dclk_n                   (adc2_dclk_n),
    .adc_pll_rst                   ({cmd_h3FE[11],cmd_h3FE[3]}),
                                   
    .adc1_dclk                     (adc1_dclk),
    .adc2_dclk                     (adc2_dclk),                                 
    .adc1_dclk_ph0                 (adc1_dclk_ph0),                                 
    .adc2_dclk_ph0                 (adc2_dclk_ph0),                                 
    .clk_250mhz                    (clk_250mhz),
    .clk_62_5mhz                   (clk_62_5mhz),
    .clk_10mhz                     (clk_10mhz),
    .clk_100mhz                    (clk_100mhz),
    .clk_200mhz                    (clk_200mhz),
    .clk_500mhz                    (clk_500mhz),
    .clk_in_bufg                   (clk_in_bufg),
    .clk_to_sram                   (clk_to_sram),

    .pll_locked                    (pll_locked)
    );  


assign dclk  = clk_250mhz ;
assign p_clk = clk_250mhz ;

probe_sig ins_probe_sig0 (
    //i
    .clk                            (adc2_dclk), 
    .probe_select                   (2'b10),
    //o                                          
    .probe_out                      (dso_1khz)
    );

 
cpu_databus_mg ins_cpu_databus_mg  (
    //input                        
    .dsp_iord_en                   (gpmc_nre              ), // <-----
    .dsp_iowr_en                   (gpmc_nwe              ), // <-----                                  
    .adsp_databus_rd               (adsp_databus_rd[15:0] ), // <==16==                                  
    //inout                         
    .adsp_d                        (am_gpmc_d[15:0]       ), // <==16==>
    //output                        
    .adsp_databus_wr               (adsp_databus_wr[15:0] )  //==16==>
    );
	
wire [7:0] x_sel;
wire [15:0] trig_mode;
dsp_cmd_wr ins_dsp_cmd_wr (
    .clk                           (clk_100mhz           ), 
    .dsp_iowr_en                   (gpmc_nwe             ), 
    .adsp_addr                     (am_gpmc_a[9:0]       ), 
    .adsp_databus_wr               (adsp_databus_wr[15:0]), 



    .cmd_h002                      (sys_rst),// 0~3 => ch1~ch3;高电平复位采集状态，清楚�?有数�?,没用�?
    .cmd_h004                      (dac_send_en),// bit[0]高电平有�?
    .cmd_h006                      (dac_send_sel[4:0]),//[3:0]:每个BIT对应相应的�?�道，高电平有效
    .cmd_h008                      (dac_send_data[15:0]),
    .cmd_h00A                      (dac_send_data[23:16]),
    .cmd_h00C                      ({pass_out_sel,pass_fail_wire}),//[0] pass/fail, [1] 1:TriggerOutput,
//    .cmd_h010                      (trig_edge_sel), //触发边沿�?0：rise �?1：fall
    .cmd_h012                      (test_reg[15:0]), //[0]强制触发:上升沿有�?
    
    
    
    .cmd_h014                      (adc_send_en),
    .cmd_h016                      (adc_send_sel[1:0]),
    .cmd_h018                      (adc_send_data[15:0]),
    .cmd_h01A                      (adc_send_data[31:16]),
    .cmd_h01C                      (dvga_send_en),
    .cmd_h01E                      (dvga_send_sel[3:0]),
    .cmd_h020                      (dvga_send_data[15:0]),
    .cmd_h022                      (dvga_send_data[23:16]),
    
    
    .cmd_h024                      (pll_clk_rst), 
    // .cmd_h032                      (channel_mode),
    .cmd_h098                      (run_ddr_offset_length[15:0]),//*********       
    .cmd_h09A                      (run_ddr_offset_length[31:16]),//*********       
    .cmd_h09C                      (down_ddr_offset_length[15:0]), //*********      
    .cmd_h09E                      (down_ddr_offset_length[31:16]),//*********
    .cmd_h0AA                      (dsp_rd_sel[15:0]),
    .cmd_h0AC                      ({adc_dclk_rst[2],adc_dclk_rst[3],adc_dclk_rst[0],adc_dclk_rst[1]}),//adc_fifo_rst
    .cmd_h0BE                      (deep_pre_depth[15:0]),
    .cmd_h0C0                      (deep_pre_depth[31:16]),
    .cmd_h0C2                      (pos_depth[15:0]),
    .cmd_h0C4                      (pos_depth[31:16]),
    .cmd_h128                      (run_ddr_offset_length[39:32]),
    .cmd_h12A                      (down_ddr_offset_length[39:32]),
    .cmd_h12C                      (deep_pre_depth[39:32]),
    .cmd_h12E                      (pos_depth[39:32]),
    .cmd_h158                      ({region1_cross,region0_cross}),
    
    .cmd_h160                       (acq_clear),
    .cmd_h162                      (adc_fifo_cmd),// eFRA_FORCE_ARM_READ_EN


    .cmd_h166                      (bw_100m),
    
    .cmd_h170                      (trig_mode), //触发使能 
    .cmd_h172                      (trig_data), //触发数据
    .cmd_h178                      (trig_edge_sel), //触发边沿选择
    .cmd_h176                      (arm_rd_done),//arm读fifo完成标志
	
	.cmd_h180					   (x_sel),
	
    .cmd_h3FE                      ({cmd_h3FE[7:0],cmd_h3FE[15:8]})	
);

assign channel_mode = 1 ;



wire trigged_flag;

assign pass_fail_out  =  pass_out_sel ? pass_fail_wire : trigged_flag ;

wire [63:0] freq_data;
wire       freq_done;
wire [7:0] max_value,min_value;

wire [3:0] arm_trig_bias;
//wire [31:0] low_freq_data;


dsp_cmd_rd ins_dsp_cmd_rd (
 
    .clk                           (dclk), 
    .dclk                          (dclk), 
    .dsp_iord_en                   (gpmc_nre             ), 
    .adsp_addr                     (am_gpmc_a[9:0]       ), 
    .dsp_rd_sel                    (dsp_rd_sel[15:0]     ), 
    .adsp_databus_rd               (adsp_databus_rd[15:0]), 
    .dsp_rd_fifo_en                (dsp_rd_fifo_en[3:0]), 
    .dma_fifo_rd_en                (dma_fifo_rd_en), 
 
    .dsp_rd_pic_pulse              (dsp_rd_pic_pulse), 
    
    
    .cmd_h300                      (test_reg[15:0]       ),//80
    .cmd_h302                      (pll_clk_error[1:0]   ),//
    .cmd_h304                      (wave_data[15:0]      ),
    .cmd_h306                      (fifo_full            ),//fifo满标志位
    
    .cmd_h310                      (           ), //触发状�?�寄存器trig_state
   
    
    .cmd_h324                      (max_value),
	.cmd_h326                      (min_value),
    
    .cmd_h328                       ({12'd0,arm_trig_bias}),
    
    //*****************************************************************Ƶ������
    .cmd_h320                      (freq_data[15:0]     ), 
    .cmd_h322                      (freq_data[31:16]     ),//fs_cnt
    .cmd_h32A                       (freq_data[47:32]),
    .cmd_h32C                       (freq_data[63:48]),//fx_cnt
    .cmd_h33E                       ({15'd0,freq_done}),
    
    //************************************************************************
    
    .cmd_h3FE                      (16'H1114             )	
        
);

//端口读写测试
//reg arm_rd_done_r;

//always@(posedge dclk)
//begin
//if(trig_en == 1)
//    arm_rd_done_r<=0;
//else
//    arm_rd_done_r<=1;
//end

//assign arm_rd_done = arm_rd_done_r;

reg gpmc_nre_r1 ,gpmc_nre_r2 ;
reg [9:0] am_gpmc_a_r1 ;
reg [15:0] adsp_databus_rd_r1 ;

always @ (posedge dclk)
begin
gpmc_nre_r1  <= gpmc_nre ;
gpmc_nre_r2  <= gpmc_nre_r1 ;
am_gpmc_a_r1 <= am_gpmc_a ;
adsp_databus_rd_r1 <= adsp_databus_rd ;
end



  
assign fpga_int = 1 ;
wire [11:0] pre_trig_len;
assign pre_trig_len='d1024;

 
adc_data_stream ins_stream_adc1 (
//iiiii
    .clk                           (dclk), 
    .pll_locked                    (pll_locked), 
    .adc_dclk                      (adc2_dclk), 
    .bw_100m                       (bw_100m ), 
    .adc_data_adjust               (0), 
    .dqd_p                         (adc2_dqd_p[7:0]), 
    .dqd_n                         (adc2_dqd_n[7:0]), 
    .dq_p                          (adc2_dq_p[7:0]), 
    .dq_n                          (adc2_dq_n[7:0]), 
    .did_p                         (adc2_did_p[7:0]), 
    .did_n                         (adc2_did_n[7:0]), 
    .di_p                          (adc2_di_p[7:0]), 
    .di_n                          (adc2_di_n[7:0]), 
    
    .adc_fifo_rst                  (adc_dclk_rst[2]), 
    .pll_clk_rst                   (pll_clk_rst), 
    .rd_en                         (dsp_rd_fifo_en[2]), 
    
   
    .channel_mode                  (channel_mode),  
    
   .adc_fifo_cmd                   (adc_fifo_cmd),
   
    .trig_mode                       (trig_mode     ),     
    .trig_edge_sel                 (trig_edge_sel),
	.trig_data                     (trig_data      ),
	.arm_rd_done                   (arm_rd_done    ),
	.x_sel                         (x_sel          ),
                             
	//.trig_state                    (trig_state     ),
	.freq_done                      (freq_done),
    .freq_data                     (freq_data       ),
   
    .max_value                     (max_value       ),
    .min_value                     (min_value       ),
   
   
   
   .pre_trig_len                  (pre_trig_len),
//ooooo 
    .pll_clk_error                 (pll_clk_error[0]),   
    .wave_data                     (wave_data[15:0]),
    .fifo_full                     (fifo_full),
	
	//.low_freq_data                 (low_freq_data),
	
	.arm_trig_bias                      (arm_trig_bias)
    );


peripheral_ctrl ins_peripheral_ctrl (
    .clk                            (clk_100mhz),
    .rst_n                          (pll_locked),
    .dac_send_en                    (dac_send_en),
    .dac_send_sel                   (dac_send_sel[4:0]),
    .dac_send_data                  (dac_send_data[23:0]),
    .adc_send_en                    (adc_send_en),
    .adc_send_sel                   (adc_send_sel[1:0]),
    .adc_send_data                  (adc_send_data[31:0]),
    .dvga_send_en                   (dvga_send_en),
    .dvga_send_sel                  (dvga_send_sel[3:0]),
    .dvga_send_data                 (dvga_send_data[23:0]),
    .pll_fpga_muxout                (pll_muxout),
    .dac_clk                        (dac_clk),
    .dac_din                        (dac_din),
    .dac_cs                         ({pll_fpga_le, dac3_cs,dac2_cs,dac1_cs}),
    .dvga_sclk                      (ch_dvga_sclk),
    .dvga_data                      (ch_dvga_data),
    .dvga_cs                        ({ch4_dvga_cs , ch3_dvga_cs , ch2_dvga_cs ,ch1_dvga_cs}),
    .adc0_sclk                      (adc1_sclk),
    .adc0_cs                        (adc1_cs),
    .adc0_sdata                     (adc1_sdata),
    .adc1_sclk                      (adc2_sclk),
    .adc1_cs                        (adc2_cs),
    .adc1_sdata                     (adc2_sdata),
    .pll_init_done                  (pll_init_done)
    );  

 

  
endmodule
