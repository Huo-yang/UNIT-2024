`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/01 13:55:38
// Design Name: 
// Module Name: probe_sig
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
module probe_sig(
    input clk,
    input passfail_spk_sel,
    input [1:0] probe_select,    
     
    output probe_out,
    output passfail_spk
    );


reg [15:0] cnt0  ;
reg [19:0] cnt1  ;
reg [15:0] cnt2  ;
reg [15:0] cnt3  ;
reg [15:0] cnt4  ;
reg [1:0]  probe_select_r  ;

reg clk_1mhz ;
reg passfail_spk_sig = 0 ;
reg probe_out_sig ;

//always @ (posedge clk)
//begin
//if (cnt0 == 16'd4)
//  begin
//  clk_1mhz <= ~clk_1mhz ;
//  cnt0     <= 16'd0
//  end
//else
//  cnt0     <= cnt0 + 1'b1 ;
//end   

reg probe_10hz ;
reg probe_100hz ;
reg probe_1khz ;
reg probe_10khz ;

always @ (posedge clk)
begin
probe_select_r <= probe_select ;
end

always @ (posedge clk)
begin
if (cnt1 == 20'd499999)
    begin
    probe_10hz <= ~probe_10hz ;
    cnt1          <=    0 ;
   end
else    
    cnt1          <=    cnt1 + 1'b1 ;
end 

always @ (posedge clk)
begin
if (cnt2 == 16'd49999)
    begin
    probe_100hz <= ~probe_100hz ;
    cnt2          <=    0 ;
   end
else    
    cnt2          <=    cnt2 + 1'b1 ;
end 


always @ (posedge clk)
begin
if (cnt3 == 16'd4999)
    begin
    probe_1khz <= ~probe_1khz ;
    cnt3          <=    0 ;
   end
else    
    cnt3          <=    cnt3 + 1'b1 ;
end 


always @ (posedge clk)
begin
if (cnt4 == 16'd499)
    begin
    probe_10khz <= ~probe_10khz ;
    cnt4          <=    0 ;
   end
else    
    cnt4          <=    cnt4 + 1'b1 ;
end


always @(posedge clk )
begin
    begin
        case(probe_select_r[1:0])
            2'b00: probe_out_sig <= probe_10hz;                           
            2'b01: probe_out_sig <= probe_100hz;
            2'b10: probe_out_sig <= probe_1khz;
            2'b11: probe_out_sig <= probe_10khz;
        endcase
    end
end

assign probe_out = probe_out_sig ;

reg passfail_spk_sel_temp = 0 ;


always @(posedge clk )
begin
passfail_spk_sel_temp <= passfail_spk_sel ;
end

always @(posedge clk )
begin
if (passfail_spk_sel_temp)      passfail_spk_sig <=     probe_1khz ;
else                            passfail_spk_sig <=     1'b0 ;
end

assign passfail_spk = passfail_spk_sig ;

endmodule
