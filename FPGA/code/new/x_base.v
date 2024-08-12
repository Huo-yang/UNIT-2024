`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:18:48
// Design Name: 
// Module Name: x_base
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


module x_base(
    input clk,
    input [7:0] x_sel,
    output x_wr_en
    );
	
	parameter t_200ns = 8'd0;
    parameter t_500ns=8'd1;
    parameter t_1us=8'd2;
    parameter t_2us=8'd3;
    parameter t_5us=8'd4;
    parameter t_10us=8'd5;
    parameter t_20us=8'd6;
    parameter t_50us=8'd7;
    parameter t_100us=8'd8;
    parameter t_200us=8'd9;
    parameter t_500us=8'd10;
    parameter t_1ms=8'd11;
    parameter t_2ms=8'd12;
    parameter t_5ms=8'd13;
    parameter t_10ms=8'd14;
    parameter t_20ms=8'd15;
    parameter t_50ms=8'd16;
    
   reg [19:0] cnt ;
   reg [19:0] flag ;
   reg wr_en_r ;
    
    assign x_wr_en=wr_en_r;
    
    always@(posedge clk )//fifo ±÷”
    begin
		if(flag==2) 
		begin
			if(cnt==4)
			   cnt<='d0;
			else
			   cnt<=cnt+1;
				if(cnt==0||cnt==2)
					wr_en_r<=1'b1;
				else
					wr_en_r<=1'b0;
		end
		else if(flag == 1)
			wr_en_r <= 1'b1;
		else if(cnt==flag-1) 
		begin
			cnt<='d0;
			wr_en_r<=1'b1;
		end
		else 
		begin
			cnt<=cnt+1;
			wr_en_r<=1'b0;
		end
    end
    
    
    
   /* always@(posedge clk)
        case(flag)
            
            'd1:    wr_en_r <= 1'b1;
            
            'd2:    cnt_en1<=1'b1;*/
            
            
    
    
    
    
    
    
    
    
    
    always@(*)
        case(x_sel)
			
			t_200ns:	flag='d1;
            
            t_500ns:    flag='d2;////////////////////////5≥È2
            
            t_1us:      flag='d5;
            
            t_2us:      flag='d10;
            
            t_5us:      flag='d25;
     
            t_10us:     flag='d50;
     
            t_20us:     flag='d100;
     
            t_50us:     flag='d250;
     
            t_100us:    flag='d500;
     
            t_200us:    flag='d1000;
     
            t_500us:    flag='d2500;
    
            t_1ms:      flag='d5000;
     
            t_2ms:      flag='d10000;
     
            t_5ms:      flag='d25000;
     
            t_10ms:     flag='d50000;
     
            t_20ms:     flag='d100000;
     
            t_50ms:     flag='d250000;
    
            default:    flag=1;
        endcase 
endmodule
