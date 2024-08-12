`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 12:28:17
// Design Name: 
// Module Name: freq_counter2
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



//�Ⱦ��Ȳ�����(��Ƶ)
module freq_counter2 (   
        input                 clk_fs ,//��׼Ƶ��    
        input                 rst_n  ,            
        input                 clk_fx , //����Ƶ��
	
	    output    reg           freq_done,
        output    [63:0]   frequency_data      
);
 
 
 
 
 
parameter	CLK_FS    = 32'd250_000_000;           
//parameter   GATE_TIME = 16'd10;    		//�ſ�ʱ�䣬Խ�����ԽС��������ʱ��Ҳ��䳤    

//reg define
reg                	gate_fx		;   		//�ſ��źţ������ź�����         
reg                	gate_fs     ;           //ͬ������׼ʱ�ӵ��ſ��ź�	
reg                	gate_fs_r   ;          	//����ͬ��gate�źŵļĴ���
reg                	gate_fs_d0  ;           //���ڲɼ���׼ʱ����gate�½���
reg                	gate_fs_d1  ;           //���ڲɼ���׼ʱ����gate�½���
reg                	gate_fx_d0  ;          	//���ڲɼ�����ʱ����gate�½���
reg                	gate_fx_d1  ;           //���ڲɼ�����ʱ����gate�½���
reg    [31:0]   	gate_cnt    ;          	//�ſؼ���
reg    [31:0]   	fs_cnt      ;           //�ſ�ʱ���ڻ�׼ʱ�ӵļ���ֵ
reg    [31:0]   	fs_cnt_temp ;           //fs_cnt ��ʱֵ
//(*Mark_debug = "TRUE"*)reg    [31:0]   	fx_cnt      ;           //�ſ�ʱ���ڱ���ʱ�ӵļ���ֵ
//(*Mark_debug = "TRUE"*)reg    [31:0]   	fx_cnt_temp ;           //fx_cnt ��ʱֵ
 
//wire define
wire               neg_gate_fs;            	//��׼ʱ�����ſ��ź��½���=
wire               neg_gate_fx;            	//����ʱ�����ſ��ź��½���
 
 
 
 
reg     [63:0]      pre_freq_data;
reg     [7:0]       freq_state;
reg wait_cnt_en;
reg [7:0] wait_cnt;
parameter   PRE_FREQ=8'd0;
parameter   DELAY0=8'd1;
parameter   FREQ_JUDGE=8'd2;
parameter   RE_MEASURE_FREQ=8'd3;
parameter   DELAY1=8'd4;
parameter   FREQ_DONE=8'd5;
parameter   DELAY2=8'd6;



reg [31:0]limit_time_cnt;
reg overtime_flag;
reg [7:0] overtime_cnt;
reg fx_cnt_en;
(*MAX_FANOUT=10*)reg [31:0]fx_gate_time; 
reg [7:0] freq_flag;
reg [63:0] freq_data;

assign frequency_data = (overtime_cnt<=1) ? freq_data : 64'd1;


always@(posedge clk_fs or negedge rst_n)
        if(!rst_n) begin
            freq_state<=PRE_FREQ;
            freq_flag<='d0;
        end
        else    case(freq_state)


            PRE_FREQ:       if(neg_gate_fs)//pre_freq_done
                                freq_state<=DELAY0;
                            else
                                freq_state<=PRE_FREQ;
            
            DELAY0:if(wait_cnt==8'd100)
                             freq_state<=FREQ_JUDGE;
                         else
                             freq_state<=freq_state;            

            
            
            
            FREQ_JUDGE:
                            if(pre_freq_data<=300) begin
                                freq_state<=DELAY1;//Ƶ�ʽϵ;Ͳ���Ҫ���²⣬ֱ�����
                                freq_flag<='d0;
                            end
                            else begin
                                freq_state<=RE_MEASURE_FREQ;
                                if(pre_freq_data<=1024)                                
                                    freq_flag<='d1;                          
                                else if(pre_freq_data<=300_000)
                                    freq_flag<='d2;                       
                                else if(pre_freq_data<=600_000) 
                                    freq_flag<='d3;                      
                                else if(pre_freq_data<=1_000_000) 
                                    freq_flag<='d4;                 
                                else if(pre_freq_data<=10_000_000) 
                                    freq_flag<='d5;                     
                                else
                                    freq_flag<='d6;
                             end
                             
        
             
             
             RE_MEASURE_FREQ:if(overtime_flag) 
                                freq_state<=DELAY2;
                              else if(neg_gate_fs)
                                freq_state<=DELAY1;
                              else
                                freq_state<=freq_state;
             

          
            DELAY1:if(wait_cnt==8'd10)
                             freq_state<=FREQ_DONE;
                         else
                             freq_state<=freq_state;   
          
          

             FREQ_DONE:     freq_state<=DELAY2;
             
             
             DELAY2: if(wait_cnt==8'd100&&!gate_fs&&(gate_cnt==0))
                             freq_state<=PRE_FREQ;
                         else
                             freq_state<=freq_state;
            
            
            
            default:        freq_state<=PRE_FREQ;
         
         endcase
 
 always@(posedge clk_fs)
        if(!wait_cnt_en)
            wait_cnt<='d0;
        else
            wait_cnt<=wait_cnt+1;
 
 
 always@(posedge clk_fs or negedge rst_n)
    if(!rst_n) begin
        fx_cnt_en<=0;
        fx_gate_time<= 10;
        freq_data<=0;
        freq_done<=0;
        wait_cnt_en<=0;
    end
    else case(freq_state)
      
      
      
           PRE_FREQ:begin
                            wait_cnt_en<=0;
                            fx_cnt_en<=1;
                            fx_gate_time<= 5;
                            freq_done<=0;
                       end
            
            DELAY0:begin
                        wait_cnt_en<=1;
                        fx_cnt_en<=0;
                        end
            
            FREQ_JUDGE:begin
                            wait_cnt_en<=0;
                            fx_cnt_en<=0;
                            //fx_gate_time<= 10;
                            freq_done<=0;
                       end
             
             
             RE_MEASURE_FREQ:begin
                        wait_cnt_en<=0;
                        fx_cnt_en<=1;
                        freq_done<=0;
                        case(freq_flag)
                            0:fx_gate_time<='d5;
                            1:fx_gate_time<='d300;
                            2:fx_gate_time<='d1000;
                            3:fx_gate_time<='d300_000;
                            4:fx_gate_time<='d600_000;
                            5:fx_gate_time<='d1_000_000;
                            6:fx_gate_time<='d10_000_000;
                            default:fx_gate_time<='d10;
                        endcase    
                        end

            
              DELAY1:begin
                            fx_cnt_en<=0;
                            wait_cnt_en<=1;
                            freq_done<=0;
                         end
             
              FREQ_DONE:begin
                            fx_cnt_en<=0;
                            freq_data<={fx_gate_time,fs_cnt};
                            freq_done<=1;
                        end
 

 
              DELAY2:begin
                            fx_cnt_en<=0;
                            wait_cnt_en<=1;
                            freq_done<=0;
                            fx_gate_time<= 5;
                         end
 
             default:   begin
                        wait_cnt_en<=0;
                        fx_cnt_en<=0;
                        fx_gate_time<= 5;
                        freq_data<={fx_gate_time,fs_cnt};
                        freq_done<=0;
                     end       
         
         endcase
 
 

   
 
 
//��׽�ź��½���
assign neg_gate_fs = gate_fs_d1 & (~gate_fs_d0);
assign neg_gate_fx = gate_fx_d1 & (~gate_fx_d0);
 
//���gate_fx�½���
always @(posedge clk_fx  or negedge rst_n) begin
    if(!rst_n) begin
        gate_fx_d0 <= 1'b0;
        gate_fx_d1 <= 1'b0;
    end
    else begin
        gate_fx_d0 <= gate_fx;
        gate_fx_d1 <= gate_fx_d0;
    end
end
//���gate_fs�½���
always @(posedge clk_fs or negedge rst_n) begin
    if(!rst_n) begin
        gate_fs_d0 <= 1'b0;
        gate_fs_d1 <= 1'b0;
    end
    else begin
        gate_fs_d0 <= gate_fs;
        gate_fs_d1 <= gate_fs_d0;
    end
end


always @(posedge clk_fx or negedge rst_n) begin
    if(!rst_n)
        gate_cnt <= 'd0; 
    else if(fx_cnt_en)
            if(gate_cnt == fx_gate_time+3)
                gate_cnt <= 'd0;
            else 
                gate_cnt <= gate_cnt + 1'b1;
    else
        gate_cnt <= 'd0;
end




always @(posedge clk_fx or negedge rst_n ) begin
    if(!rst_n)
        gate_fx <= 1'b0;     
    else if(fx_cnt_en)
            if(gate_cnt == 3)
                gate_fx <= 1'b1;
            else if(gate_cnt == fx_gate_time+3)
                gate_fx <= 1'b0;
            else 
                gate_fx <= gate_fx;
    else
        gate_fx <= 1'b0;    
end


always @(posedge clk_fs or negedge rst_n ) 
    if(!rst_n) begin
        limit_time_cnt<=0;
        overtime_flag<=0;
    end
    else if(fx_cnt_en||freq_state==DELAY2)
        if(limit_time_cnt<='d270_000_000)begin
            limit_time_cnt<=limit_time_cnt+1;
            overtime_flag<=0;
         end
         else begin
            limit_time_cnt<=0;
            overtime_flag<=1;
         end
     else begin
            limit_time_cnt<=0;
            overtime_flag<=0;
     end



always @(posedge clk_fs or negedge rst_n ) 
    if(!rst_n)
        overtime_cnt<=0;
    else if(freq_done)
        overtime_cnt<=0;
    else if(overtime_flag&&!overtime_cnt[7])//����ӱ�
        overtime_cnt<=overtime_cnt+1;
    else
        overtime_cnt<=overtime_cnt;




//��բ�Ŵӱ���ʱ����ͬ������׼ʱ����
always @(posedge clk_fs or negedge rst_n) begin
    if(!rst_n) begin
        gate_fs_r <= 1'b0;
        gate_fs   <= 1'b0;
    end
    else begin
        gate_fs_r <= gate_fx;
        gate_fs   <= gate_fs_r;
    end
end

//�ڻ�׼ʱ����Ի�׼ʱ�Ӽ���
always @(posedge clk_fs or negedge rst_n) begin
    if(!rst_n) begin
        fs_cnt_temp <= 0;
        fs_cnt <= 0;
    end
    else if(gate_fs)//&&(fs_cnt_temp[32]==0)
            fs_cnt_temp <= fs_cnt_temp + 1'b1;
    else if(neg_gate_fs) begin
            fs_cnt_temp <= 0;
            fs_cnt <= fs_cnt_temp;
        end
end



//�ڻ�׼ʱ����������


always @(posedge clk_fs or negedge rst_n) begin
    if(!rst_n) begin
        pre_freq_data <= 0;
    end
    else if(gate_fs == 1'b0)
        pre_freq_data <= (CLK_FS * fx_gate_time) / fs_cnt;
end


endmodule 