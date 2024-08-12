`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:01 04/24/2013 
// Design Name: 
// Module Name:    adc_ctrl 
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
//////////////////////////////////////////////////////////////////////////////////
module parrel_to_serial 
#(
						parameter			BIT_NUM = 16
)

(			
						input					clk,
						input					ref_freq,			//the benchmark of da_clk
										//rst,				//reset sigal
						input					da_start,			//dsp control staring to transfer the data 
						input	 [BIT_NUM -1 : 0]	da_data,			//parallel data input
										//output
						output				da_cs,
						output				da_din,				//serial data to DA
						output				da_clk	
				);	
	
reg ref_freq_1q ,ref_freq_2q ,ref_freq_3q ;
wire ref_freq_falling ;
wire ref_freq_rising ;

reg [5 :0] cnt ;
reg [BIT_NUM -1 : 0] parrel_data ;
reg [BIT_NUM -1 : 0] da_data_sync1 ;
reg [BIT_NUM -1 : 0] da_data_sync ;
reg cs_sig ;
reg da_start_sync ;
reg da_start_sync1 ;

always @ (posedge clk)
begin 
da_start_sync <= da_start ;
da_start_sync1 <= da_start_sync ;
da_data_sync1  <= da_data ;
da_data_sync   <= da_data_sync1 ;
end


always @ (posedge clk)
begin 
ref_freq_1q  <= ref_freq ;
ref_freq_2q  <= ref_freq_1q ;
ref_freq_3q  <= ref_freq_2q ;
end

assign ref_freq_falling  = ~ref_freq_1q & ref_freq_2q ;
assign ref_freq_rising   =  ref_freq_1q & ~ref_freq_2q ;


assign da_start_rising   =  da_start_sync & ~da_start_sync1 ;

reg da_start_en ;


always @ (posedge clk)
begin 
if (da_start_rising)
   da_start_en <= 1'b0 ;
else if (cnt == 6'd63)   
   da_start_en <= 1'b1 ;
end

always @ (posedge clk)
begin 
if (da_start_rising && da_start_en)				    cnt <= 6'd0 ;
else if (ref_freq_falling)	
		begin 
		if (cnt == 6'd63)						    cnt <= 6'd63 ;
		else 										cnt <= cnt + 1'b1 ;
		end
end		

always @ (posedge clk)
begin 
if (da_start_rising && da_start_en)				    cs_sig <= 1'b1 ;
else if (ref_freq_falling)
			begin
			if(cnt == 6'd5)							cs_sig <= 1'b0 ;
			else if (cnt == 6'd5 + BIT_NUM)		    cs_sig <= 1'b1 ;
			end
end			


always @ (posedge clk)
begin 
if (da_start_rising && da_start_en)					 parrel_data <= da_data_sync ;
else if (ref_freq_falling)
		begin
		if (!cs_sig)							     parrel_data[BIT_NUM - 1 : 1] <= parrel_data[BIT_NUM - 2 : 0] ;
		end
end
////da_start    : _______________|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
////
////ref_freq    : __|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|
////
////              _______________________________________________________________________________________________________
////cnt         : ________0________|__1__|__2__|__3__|__4__|__5__|__6__|.....|_26__|_27__|_28__|_29__|_30__|_31__|_32__|
//
//cs_sig        :~~~~~~~~~~~~~~~~~~~~~~~~|_____________________________________________________________________________|~~~~~~~~~~~~~~~~~
//
//da_clk        :~~~~~~~~~~~~~~~~~~~~~~~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__
//

wire [3:0] 	A ;
wire 			cs_sig_delay ;
reg 			cs_sig1 ;

//assign A = 4'D4 ;
//
//   SRL16E #(
//      .INIT(16'h0000) // Initial Value of Shift Register
//   ) SRL16E_inst (
//      .Q(cs_sig_delay),       // SRL data output
//      .A0(A[0]),     // Select[0] input
//      .A1(A[1]),     // Select[1] input
//      .A2(A[2]),     // Select[2] input
//      .A3(A[3]),     // Select[3] input
//      .CE(1'b1),     // Clock enable input
//      .CLK(clk),   	// Clock input
//      .D(cs_sig)     // SRL data input
//   );

reg da_clk_sig , da_din_sig ,da_cs_sig ;

always @ (posedge clk)
begin
 da_clk_sig <= cs_sig | ref_freq_3q ;
 da_din_sig <= parrel_data[BIT_NUM - 1];
 cs_sig1    <= cs_sig; 		
 da_cs_sig  <= cs_sig1; 		
end

assign da_clk = da_clk_sig ;
assign da_din = da_din_sig ;
assign da_cs  = da_cs_sig ;


endmodule

	
