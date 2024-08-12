`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:21:45
// Design Name: 
// Module Name: trig
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


module trig(
    input           clk,
    input [31:0]    adc_data_ch1,
    //input           pll_locked,
    //input [10:0]    wr_data_count,
    
    //input           trig_en,
    input           trig_edge_sel,
	input  [7:0]    trig_data,
	//input           rst_max_min_val,
	
	input           max_min_en,
	
	
	//output          trig_state,
	output          trig_pulse0,
	output          trig_pulse1,
	output          trig_pulse2,
	output          trig_pulse3,
	
	//output          trig_fifo_rst,  
	//output          trig_fifo_wr_en,
	
	output  reg [7:0]   max_value,
    output  reg [7:0]   min_value,
	output  reg    square_wave1
	
    );
    
   reg square_wave;
   
    parameter VBAIS0=8'd3;
    parameter VBAIS1=8'd5;
    
    reg [31:0] cnt_05s=32'd0;
    reg rst_max_min_val=0;
    
    
    
    reg [7:0] max_val = 0;
    reg [7:0] min_val = 8'hff;
    reg [7:0] max_1 = 8'h00;
    reg [7:0] min_1 = 8'hff;
    
    reg [7:0] max_2 = 8'h00;
    reg [7:0] min_2 = 8'hff;

   reg [7:0] curr_max=0; 
   reg [7:0] curr_min=8'hff;
  reg [15:0]middle_val=16'd0;
  reg [7:0] in0,in1,in2,in3;
//    assign in0 = adc_data_ch1[31:24];
//    assign in1 = adc_data_ch1[23:16];
//    assign in2 = adc_data_ch1[15:8];
//    assign in3 = adc_data_ch1[7:0];
    
    
    
    
    always@(posedge clk)begin
        in0 <= adc_data_ch1[31:24];
        in1 <= adc_data_ch1[23:16];
        in2 <= adc_data_ch1[15:8];
        in3 <= adc_data_ch1[7:0];
    end
    
    always @(posedge clk ) 
        if(cnt_05s=='d125_000_000) begin
            cnt_05s<=0;
            rst_max_min_val<=1;
        end
        else begin
            cnt_05s<=cnt_05s+1;
            rst_max_min_val<=0;
        end
    
    
    
    
    always@(posedge clk)begin
        if(in0>in1)begin
            max_1 <= in0;
            min_1 <= in1;
        end
        else begin
            max_1<= in1;
            min_1<= in0;
        end
    end
    
    always@(posedge clk)begin
        if(in2>in3)begin
            max_2 <= in2;
            min_2 <= in3;
        end
        else begin
            max_2<= in3;
            min_2<= in2;
        end
    end
    
    // 二级流水
    
    always@(posedge clk)begin
        if(max_1 > max_2)
            curr_max <= max_1;
        else 
            curr_max <= max_2;
    end
    
    always@(posedge clk)begin
        if(min_1 < min_2)
            curr_min <= min_1;
        else 
            curr_min <= min_2;
    end
    
    // 更新历史最大值和最小值
    always @(posedge clk) 
    begin
        if(rst_max_min_val==1)
        begin
            max_val <= 0;
            min_val <= 8'hff;
        end
        else 
        begin
            if (curr_max > max_val)
                max_val <= curr_max;
            else
                max_val <= max_val ;
                
            if (curr_min < min_val)
                min_val <= curr_min;
            else
                min_val <= min_val ;
        end
    end
    
    
    

    always @(posedge clk)
        if(cnt_05s==120_000_000 ) begin
            max_value <= max_val;
            min_value <= min_val;
        end
        else begin
            max_value <= max_value;
            min_value <= min_value;
        end

 
 
 
    always @(posedge clk)
        middle_val<= (max_value + min_value)>>1;
    
//  上升下降沿触发选择
    reg trig_an0;//波形转为方波信号
    reg trig_an1;
    reg trig_an2;
    reg trig_an3;

    
    wire [7:0] VH;
    wire [7:0] VL;
    
    wire [15:0] SQUARE_WAVE_VH;
    wire [15:0] SQUARE_WAVE_VL;
    
    assign VH=(trig_data>=8'b1111_1010)?trig_data:trig_data+VBAIS0;//限值，以免加爆了
    assign VL=(trig_data<=8'b0000_0101)?trig_data:trig_data-VBAIS0;
    
    assign SQUARE_WAVE_VH=(middle_val>=16'b0000_0000_1111_0000)?middle_val:middle_val+VBAIS1;//限值，以免加爆了
    assign SQUARE_WAVE_VL=(middle_val<=16'b0000_0000_0000_1111)?middle_val:middle_val-VBAIS1;
    
    //***************
    always@(posedge clk)//对比ADC采样输出的数据转化成方波
        if(in0>=VH)
            trig_an0<=1'b1;
        else if(in0<=VL)
            trig_an0<=1'b0;
        else
            trig_an0<=trig_an0;
    
    
    
    always@(posedge clk)//对比ADC采样输出的数据转化成方波
        if({8'd0,in0}>=SQUARE_WAVE_VH)
            square_wave<=1'b1;
        else if({8'd0,in0}<=SQUARE_WAVE_VL)
            square_wave<=1'b0;
        else
            square_wave<=square_wave;
    //***************************
    reg [31:0] cnt;
    
    always@(posedge clk)
        if(square_wave)
            cnt<=cnt+1;
        else
            cnt<=0;
    
    always@(posedge clk)
        if(cnt<=1)
            square_wave1<=0;
        else
            square_wave1<=1;
             
            
    
    
    
    //**********************************************
    always@(posedge clk)//对比ADC采样输出的数据转化成方波
    if(in1>=VH)
        trig_an1<=1'b1;
    else if(in1<=VL)
        trig_an1<=1'b0;
    else
        trig_an1<=trig_an1;
    
    
    always@(posedge clk)//对比ADC采样输出的数据转化成方波
    if(in2>=VH)
        trig_an2<=1'b1;
    else if(in2<=VL)
        trig_an2<=1'b0;
    else
        trig_an2<=trig_an2;
        
        
        
    always@(posedge clk)//对比ADC采样输出的数据转化成方波
    if(in3>=VH)
        trig_an3<=1'b1;
    else if(in3<=VL)
        trig_an3<=1'b0;
    else
        trig_an3<=trig_an3;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    (*MAX_FANOUT=10*) reg falling_edge0;
    (*MAX_FANOUT=10*) reg rising_edge0;
    
    
    (*MAX_FANOUT=10*) reg falling_edge1,rising_edge1;
   
    
    (*MAX_FANOUT=10*)reg falling_edge2,rising_edge2;

    
    (*MAX_FANOUT=10*)reg falling_edge3,rising_edge3;
 
    
    
    
    
    
    
    
    //根据trig_edge_sel选择上升沿还是下降沿作为状态转换条件
    
    // 用于存储上一个时钟周期的trig_an值
    reg prev_trig_an0;
    
    always@(posedge clk)
    begin
        prev_trig_an0 <= trig_an0; // 存储当前值，用于下一个时钟周期的边沿检测
        
        // 检测上升沿
        if (trig_an0 && !prev_trig_an0) begin
            rising_edge0 <= 1'b1;
        end else begin
            rising_edge0 <= 1'b0;
        end
        
        // 检测下降沿
        if (!trig_an0 && prev_trig_an0) begin
            falling_edge0 <= 1'b1;
        end else begin
            falling_edge0 <= 1'b0;
        end
    end
    
    assign trig_pulse0 = trig_edge_sel ? falling_edge0 : rising_edge0;
    
    
    
    reg prev_trig_an1;
    
    always@(posedge clk)
    begin
        prev_trig_an1 <= trig_an1; // 存储当前值，用于下一个时钟周期的边沿检测
        
        // 检测上升沿
        if (trig_an1 && !prev_trig_an1) begin
            rising_edge1 <= 1'b1;
        end else begin
            rising_edge1 <= 1'b0;
        end
        
        // 检测下降沿
        if (!trig_an1 && prev_trig_an1) begin
            falling_edge1 <= 1'b1;
        end else begin
            falling_edge1 <= 1'b0;
        end
    end
    
    assign trig_pulse1 = trig_edge_sel ? falling_edge1 : rising_edge1;
    
    
    reg prev_trig_an2;
    
    always@(posedge clk)
    begin
        prev_trig_an2 <= trig_an2; // 存储当前值，用于下一个时钟周期的边沿检测
        
        // 检测上升沿
        if (trig_an2 && !prev_trig_an2) begin
            rising_edge2 <= 1'b1;
        end else begin
            rising_edge2 <= 1'b0;
        end
        
        // 检测下降沿
        if (!trig_an2 && prev_trig_an2) begin
            falling_edge2 <= 1'b1;
        end else begin
            falling_edge2 <= 1'b0;
        end
    end
    
    assign trig_pulse2 = trig_edge_sel ? falling_edge2 : rising_edge2;
    
    
    
    reg prev_trig_an3;
    
    always@(posedge clk)
    begin
        prev_trig_an3 <= trig_an3; // 存储当前值，用于下一个时钟周期的边沿检测
        
        // 检测上升沿
        if (trig_an3 && !prev_trig_an3) begin
            rising_edge3 <= 1'b1;
        end else begin
            rising_edge3 <= 1'b0;
        end
        
        // 检测下降沿
        if (!trig_an3 && prev_trig_an3) begin
            falling_edge3 <= 1'b1;
        end else begin
            falling_edge3 <= 1'b0;
        end
    end
    
    assign trig_pulse3 = trig_edge_sel ? falling_edge3 : rising_edge3;
    

    
endmodule
