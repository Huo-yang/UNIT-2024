`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 10:37:31
// Design Name: 
// Module Name: fifo_control
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


module fifo_control(
    input   clk,
    input   rst_n,
    input [15:0]  trig_mode,
    
    input   trig_pulse0,
    input   trig_pulse1,
    input   trig_pulse2,
    input   trig_pulse3,
    
    input [10:0]  fifo_wave_wr_data_count,
    input   arm_rd_done,
    input [11:0]  pre_trig_len,//总共8k个点，8K减去预触发长度等于后触发长度
    input [11:0] fifo_trig_wr_data_count,
    
    input     x_wr_en,
    
    output  fifo_wave_rst,
    output  fifo_trig_rst,
    output  fifo_wave_wr_en,
    output  fifo_trig_wr_en,
    output  fifo_trig_rd_en,
    
    output  [3:0] arm_trig_bias,
    
    output  no_trig_sign
    );
    
    parameter       CNT_05S=32'd125_000_000;
    //*********************************
    parameter       IDLE=8'd0;
    parameter       RST_DELAY=8'd1;
    parameter       PRE_TRIG=8'd2;//
    parameter       WAIT_TRIG=8'd3;
    
    parameter       NO_TRIG=8'd4;
    parameter       RST_FIFO_WAVE=8'd5;
    parameter       RST_FIFO_WAVE_DELAY=8'd6;
    //parameter       FIFO_WAVE_RST=8'd4;
    //parameter       WAIT_FIFO_WAVE_RST=8'd5;
   
    parameter       POST_TRIG=8'd7;
    parameter       WR_DATA_TO_FIFO_WAVE=8'd8;
    parameter       WAIT_RD_DONE=8'd9;
    
    
    //***************************************
    wire [15:0] trig_mode_debug;
    reg [7:0]   trig_state=0;
    (*FORCE_MAX_FANOUT=10*)reg fifo_wave_rst_r;
    reg fifo_trig_rst_r;
    reg fifo_wave_wr_en_r;
    reg fifo_trig_wr_en_r;
    reg fifo_trig_rd_en_r;
    //(*Mark_debug = "TRUE"*)reg [11:0] trig_cnt_r;
    //(*Mark_debug = "TRUE"*)reg cnt_en;
    //(*Mark_debug = "TRUE"*)reg [11:0] cnt;
    //(*Mark_debug = "TRUE"*)reg cnt_rst;
    reg [31:0] wait_cnt;
    reg wait_cnt_en;
    reg [2:0]   trig_bias;
    reg no_trig_sign_r;
    
    //reg max_min_en_r;
    assign trig_state_out=trig_state;
    
    assign  trig_mode_debug=trig_mode;
    
    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            trig_state<=IDLE;
        else    case(trig_state)
        
            IDLE:       begin
                        //trig_cnt_r<='d0;
                        trig_bias<='d0;
                        if(trig_mode_debug!='d0)
                            trig_state<=RST_DELAY;
                        else    
                            trig_state<=IDLE;
                        end
                        
                        
            RST_DELAY:  if(wait_cnt==8'd10)
                             trig_state<=PRE_TRIG;
                         else
                             trig_state<=trig_state;
            
                      
            PRE_TRIG:   if(fifo_trig_wr_data_count==12'd1024)
                                trig_state<=WAIT_TRIG;
                        else
                            trig_state<=trig_state;
            
            WAIT_TRIG:  case(trig_mode_debug)
            
                            'd0:    trig_state<=IDLE;
            
                            'd1:    if(wait_cnt==CNT_05S)//等待超过0.5秒认为没有触发脉冲，所有只能测2hz以上的信号
                                        trig_state<= NO_TRIG;
                                    else if(trig_pulse0) begin
                                        trig_state<=POST_TRIG;
                                        trig_bias<={trig_pulse1,trig_pulse2,trig_pulse3};
                                    end
                                    else begin
                                    trig_state<=trig_state;
                                    trig_bias<=trig_bias;
                                    end
            
                            'd2:    if(trig_pulse0) begin
                                        trig_state<=POST_TRIG;
                                        trig_bias<={trig_pulse1,trig_pulse2,trig_pulse3};
                                    end
                                    else begin
                                    trig_state<=trig_state;
                                    trig_bias<=trig_bias;
                                    end
                                   
                            default:    trig_state<=trig_state;
                            
                         endcase
                            
                        
                        
           //***************************************************************************************************
            NO_TRIG: if(trig_pulse0) 
                            trig_state<=RST_FIFO_WAVE;
                        else 
                            trig_state<=trig_state;

            RST_FIFO_WAVE:    trig_state<=RST_FIFO_WAVE_DELAY;
            
            RST_FIFO_WAVE_DELAY:    if(wait_cnt=='d20) 
                            trig_state<=POST_TRIG;
                        else 
                            trig_state<=trig_state;
                            
                            
            //****************************************************************************************   
                        
            POST_TRIG:  if(fifo_trig_wr_data_count==12'd2048)
                                trig_state<=WR_DATA_TO_FIFO_WAVE;
                            else
                                trig_state<=trig_state;
            
            
            
            
            
            
                            /*if(fifo_wave_full)
                                trig_state<=WAIT_RD_DONE;
                            else
                                trig_state<=trig_state;*/
                                
                                
                                
            /*WR_SCREEN1_DATA_TO_FIFO_WAVE: if(fifo_wave_wr_data_count==11'b1111_1111_111) begin
                                            if(split_srceen_mode)
                                                trig_state
                                            trig_state<=WAIT_RD_DONE;
                                         else
                                            trig_state<=trig_state;   */         
                                
                                
           WR_DATA_TO_FIFO_WAVE: if(fifo_wave_wr_data_count==11'b1111_1111_111)
                                            trig_state<=WAIT_RD_DONE;
                                         else
                                            trig_state<=trig_state;       
                                
          // FIFO_SCREEN2_WR_DATA:  if()                     
                                
                                

    
            WAIT_RD_DONE: if(trig_mode_debug=='d0)
                            trig_state<=IDLE;
                          else if(arm_rd_done)
                            trig_state<=IDLE;
                          else
                            trig_state<=trig_state;
    
            default:    trig_state<=IDLE;
        endcase
        
       
       
        
        assign  fifo_wave_rst=fifo_wave_rst_r;
        assign  fifo_trig_rst=fifo_trig_rst_r;
        
              
        assign  fifo_trig_wr_en=fifo_trig_wr_en_r&&x_wr_en;//wr_en_r <= 1'b1;
               
        assign  fifo_wave_wr_en=fifo_wave_wr_en_r;//&&x_wr_en
        assign  fifo_trig_rd_en=(trig_state==WR_DATA_TO_FIFO_WAVE)?fifo_trig_rd_en_r : fifo_trig_rd_en_r&&x_wr_en;
        
        
        assign  no_trig_sign=no_trig_sign_r;
        
        
        
         always@(posedge clk)
            case(trig_state)
                IDLE:       begin
                            fifo_wave_rst_r<=1'b1;
                            fifo_trig_rst_r<=1'b1;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b0;
                            fifo_trig_rd_en_r<=1'b0;
                            wait_cnt_en<=1'b0;
                            no_trig_sign_r<=1'b0;
                            //max_min_en_r<=1'b0;
                            //cnt_en<=1'b0;
                            //cnt_rst<=1'b1;
                            //trig_cnt_r<='d0;
                            end
                            
               RST_DELAY:   begin
                            fifo_wave_rst_r<=1'b0;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b0;
                            fifo_trig_rd_en_r<=1'b0;
                            wait_cnt_en<=1'b1;
                            //max_min_en_r<=1'b0;
                            end          
                            
                            
                            
                PRE_TRIG:   begin
                            fifo_wave_rst_r<=1'b0;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b1;
                            fifo_trig_rd_en_r<=1'b0;
                            wait_cnt_en<=1'b0;
                            //max_min_en_r<=1'b1;
                            //cnt_en<=1'b0;
                            //cnt_rst<=1'b0;
                            end 
                            
                            
                WAIT_TRIG:  begin//2
                            fifo_wave_rst_r<=1'b0;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b1;
                            fifo_trig_rd_en_r<=1'b1;
                            wait_cnt_en<=1'b1;
                            //max_min_en_r<=1'b1;
                            //cnt_en <= 1'b1;
                            end
                 //**********************************************************************************************        
                NO_TRIG: begin//2
                            fifo_wave_rst_r<=1'b0;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b1;
                            fifo_trig_rd_en_r<=1'b1;
                            wait_cnt_en<=1'b0;
                            no_trig_sign_r<=1'b1;
                            //max_min_en_r<=1'b1;
                            //cnt_en <= 1'b1;
                            end
               
                RST_FIFO_WAVE:  begin//2
                            fifo_wave_rst_r<=1'b1;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b1;
                            fifo_trig_rd_en_r<=1'b0;
                            wait_cnt_en<=1'b0;
                            no_trig_sign_r<=1'b0;
                            //max_min_en_r<=1'b1;
                            //cnt_en <= 1'b1;
                            end
            
                RST_FIFO_WAVE_DELAY: begin//2
                            fifo_wave_rst_r<=1'b0;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b1;
                            fifo_trig_rd_en_r<=1'b0;
                            wait_cnt_en<=1'b1;
                            //max_min_en_r<=1'b1;
                            //cnt_en <= 1'b1;
                            end        
                 //*************************************************************************************************************         
                
                            
                POST_TRIG:  begin//2
                            fifo_wave_rst_r<=1'b0;
                            fifo_trig_rst_r<=1'b0;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b1;
                            fifo_trig_rd_en_r<=1'b0;
                            wait_cnt_en<=1'b0;
                            //max_min_en_r<=1'b1;
                            //trig_cnt_r<=fifo_trig_wr_data_count+cnt;
                            //cnt_en<=1'b0;
                            end
                
                WR_DATA_TO_FIFO_WAVE:begin
                                fifo_wave_rst_r<=1'b0;
                                fifo_trig_rst_r<=1'b0;
                                fifo_wave_wr_en_r<=1'b1;
                                fifo_trig_wr_en_r<=1'b0;
                                fifo_trig_rd_en_r<=1'b1;
                                //max_min_en_r<=1'b1;
                                end
                
                
                
                
                WAIT_RD_DONE:   begin
                                fifo_wave_rst_r<=1'b0;
                                fifo_trig_rst_r<=1'b0;
                                fifo_wave_wr_en_r<=1'b0;
                                fifo_trig_wr_en_r<=1'b0;
                                fifo_trig_rd_en_r<=1'b0;
                                //max_min_en_r<=1'b0;
                                end
                default:    begin
                            fifo_wave_rst_r<=1'b1;
                            fifo_trig_rst_r<=1'b1;
                            fifo_wave_wr_en_r<=1'b0;
                            fifo_trig_wr_en_r<=1'b0;
                            fifo_trig_rd_en_r<=1'b0;
                            //max_min_en_r<=1'b0;
                            //cnt_en<=1'b0;
                            end        
        
        endcase
    
    always@(posedge clk)
        if(!wait_cnt_en)
            wait_cnt<='d0;
        else
            wait_cnt<=wait_cnt+1;
            
            
    //**********************************************
    reg [3:0] arm_trig_bias_r;
    assign arm_trig_bias=arm_trig_bias_r;
    always@(posedge clk)
        case(trig_bias)
            3'b111:     arm_trig_bias_r<=4'd3;
            
            3'b110:     arm_trig_bias_r<=4'd2;
            
            3'b100:     arm_trig_bias_r<=4'd1;
     
            default:    arm_trig_bias_r<=4'd0;
         endcase
         
         
         
endmodule
