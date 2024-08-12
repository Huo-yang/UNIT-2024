`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:30 06/12/2015 
// Design Name: 
// Module Name:    dsp_cmd_rd 
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
module dsp_cmd_rd
#(
    parameter           BIT_NUM = 16
)
(
input           clk,
input           dclk,
input           debug_in,
input [15:0]    dsp_rd_sel,
input           dsp_iord_en,
input [11:0]    adsp_addr,
input [15:0]    pic_data,
// input [2:0]     dpx_status,
output   [BIT_NUM - 1:0]        adsp_databus_rd,
input    [BIT_NUM - 1:0]        dso_fifo_data0,
input    [BIT_NUM - 1:0]        dso_fifo_data1,
input    [BIT_NUM - 1:0]        dso_fifo_data2,
input    [BIT_NUM - 1:0]        dso_fifo_data3,

input    [BIT_NUM - 1:0]        dma_fifo_data,




output reg [3:0]                dsp_rd_fifo_en,
output                          dma_fifo_rd_en,
output reg                      dsp_rd_sram,
output reg                      dsp_rd_pic_pulse,
input [BIT_NUM - 1:0]  cmd_h300 ,
input [BIT_NUM - 1:0]  cmd_h302 ,
input [BIT_NUM - 1:0]  cmd_h304 ,
input [BIT_NUM - 1:0]  cmd_h306 ,
input [BIT_NUM - 1:0]  cmd_h308 ,
input [BIT_NUM - 1:0]  cmd_h30A ,
input [BIT_NUM - 1:0]  cmd_h30C ,
input [BIT_NUM - 1:0]  cmd_h30E ,
input [BIT_NUM - 1:0]  cmd_h310 ,
input [BIT_NUM - 1:0]  cmd_h312 ,
input [BIT_NUM - 1:0]  cmd_h314 ,
input [BIT_NUM - 1:0]  cmd_h316 ,
input [BIT_NUM - 1:0]  cmd_h318 ,
input [BIT_NUM - 1:0]  cmd_h31A ,
input [BIT_NUM - 1:0]  cmd_h31C ,
input [BIT_NUM - 1:0]  cmd_h31E ,
input [BIT_NUM - 1:0]  cmd_h320 ,
input [BIT_NUM - 1:0]  cmd_h322 ,
input [BIT_NUM - 1:0]  cmd_h324 ,
input [BIT_NUM - 1:0]  cmd_h326 ,
input [BIT_NUM - 1:0]  cmd_h328 ,
input [BIT_NUM - 1:0]  cmd_h32A ,
input [BIT_NUM - 1:0]  cmd_h32C ,
input [BIT_NUM - 1:0]  cmd_h32E ,
input [BIT_NUM - 1:0]  cmd_h330 ,
input [BIT_NUM - 1:0]  cmd_h332 ,
input [BIT_NUM - 1:0]  cmd_h334 ,
input [BIT_NUM - 1:0]  cmd_h336 ,
input [BIT_NUM - 1:0]  cmd_h338 ,
input [BIT_NUM - 1:0]  cmd_h33A ,
input [BIT_NUM - 1:0]  cmd_h33C ,
input [BIT_NUM - 1:0]  cmd_h33E ,
input [BIT_NUM - 1:0]  cmd_h340 ,
input [BIT_NUM - 1:0]  cmd_h342 ,
input [BIT_NUM - 1:0]  cmd_h344 ,
input [BIT_NUM - 1:0]  cmd_h346 ,
input [BIT_NUM - 1:0]  cmd_h348 ,
input [BIT_NUM - 1:0]  cmd_h34A ,
input [BIT_NUM - 1:0]  cmd_h34C ,
input [BIT_NUM - 1:0]  cmd_h34E ,
input [BIT_NUM - 1:0]  cmd_h350 ,
input [BIT_NUM - 1:0]  cmd_h352 ,
input [BIT_NUM - 1:0]  cmd_h354 ,
input [BIT_NUM - 1:0]  cmd_h356 ,
input [BIT_NUM - 1:0]  cmd_h358 ,
input [BIT_NUM - 1:0]  cmd_h35A ,
input [BIT_NUM - 1:0]  cmd_h35C ,
input [BIT_NUM - 1:0]  cmd_h35E ,
input [BIT_NUM - 1:0]  cmd_h360 ,
input [BIT_NUM - 1:0]  cmd_h362 ,
input [BIT_NUM - 1:0]  cmd_h364 ,
input [BIT_NUM - 1:0]  cmd_h366 ,
input [BIT_NUM - 1:0]  cmd_h368 ,
input [BIT_NUM - 1:0]  cmd_h36A ,
input [BIT_NUM - 1:0]  cmd_h36C ,
input [BIT_NUM - 1:0]  cmd_h36E ,
input [BIT_NUM - 1:0]  cmd_h370 ,
input [BIT_NUM - 1:0]  cmd_h372 ,
input [BIT_NUM - 1:0]  cmd_h374 ,
input [BIT_NUM - 1:0]  cmd_h376 ,  
input [BIT_NUM - 1:0]  cmd_h378 ,  
input [BIT_NUM - 1:0]  cmd_h37A ,  
input [BIT_NUM - 1:0]  cmd_h37C ,  
input [BIT_NUM - 1:0]  cmd_h37E ,  
input [BIT_NUM - 1:0]  cmd_h380 ,  
input [BIT_NUM - 1:0]  cmd_h382 ,  
input [BIT_NUM - 1:0]  cmd_h384 ,  
input [BIT_NUM - 1:0]  cmd_h386 ,  
input [BIT_NUM - 1:0]  cmd_h388 ,  
input [BIT_NUM - 1:0]  cmd_h38A ,  
input [BIT_NUM - 1:0]  cmd_h38C ,  
input [BIT_NUM - 1:0]  cmd_h38E ,  
input [BIT_NUM - 1:0]  cmd_h390 ,  
input [BIT_NUM - 1:0]  cmd_h392 ,  
input [BIT_NUM - 1:0]  cmd_h394 ,  
input [BIT_NUM - 1:0]  cmd_h396 ,  
input [BIT_NUM - 1:0]  cmd_h398 ,  
input [BIT_NUM - 1:0]  cmd_h39A ,  
input [BIT_NUM - 1:0]  cmd_h39C ,  
input [BIT_NUM - 1:0]  cmd_h39E ,  
input [BIT_NUM - 1:0]  cmd_h3A0 ,  
input [BIT_NUM - 1:0]  cmd_h3A2 ,  
input [BIT_NUM - 1:0]  cmd_h3A4 ,  
input [BIT_NUM - 1:0]  cmd_h3A6 ,  
input [BIT_NUM - 1:0]  cmd_h3A8 ,  
input [BIT_NUM - 1:0]  cmd_h3AA ,  
input [BIT_NUM - 1:0]  cmd_h3AC ,  
input [BIT_NUM - 1:0]  cmd_h3AE ,  
input [BIT_NUM - 1:0]  cmd_h3B0 ,  
input [BIT_NUM - 1:0]  cmd_h3B2 ,  
input [BIT_NUM - 1:0]  cmd_h3B4 ,  
input [BIT_NUM - 1:0]  cmd_h3B6 ,  
input [BIT_NUM - 1:0]  cmd_h3B8 ,  
input [BIT_NUM - 1:0]  cmd_h3BA ,  
input [BIT_NUM - 1:0]  cmd_h3BC ,  
input [BIT_NUM - 1:0]  cmd_h3BE ,  
input [BIT_NUM - 1:0]  cmd_h3C0 ,  
input [BIT_NUM - 1:0]  cmd_h3C2 ,  
input [BIT_NUM - 1:0]  cmd_h3C4 ,  
input [BIT_NUM - 1:0]  cmd_h3C6 ,  
input [BIT_NUM - 1:0]  cmd_h3C8 ,  
input [BIT_NUM - 1:0]  cmd_h3CA ,  
input [BIT_NUM - 1:0]  cmd_h3CC ,  
input [BIT_NUM - 1:0]  cmd_h3CE ,  
input [BIT_NUM - 1:0]  cmd_h3D0 ,  
input [BIT_NUM - 1:0]  cmd_h3D2 ,  
input [BIT_NUM - 1:0]  cmd_h3D4 ,  
input [BIT_NUM - 1:0]  cmd_h3D6 ,  
input [BIT_NUM - 1:0]  cmd_h3D8 ,  
input [BIT_NUM - 1:0]  cmd_h3DA ,  
input [BIT_NUM - 1:0]  cmd_h3DC ,  
input [BIT_NUM - 1:0]  cmd_h3DE ,  
input [BIT_NUM - 1:0]  cmd_h3E0 ,  
input [BIT_NUM - 1:0]  cmd_h3E2 ,  
input [BIT_NUM - 1:0]  cmd_h3E4 ,  
input [BIT_NUM - 1:0]  cmd_h3E6 ,  
input [BIT_NUM - 1:0]  cmd_h3E8 ,  
input [BIT_NUM - 1:0]  cmd_h3EA ,  
input [BIT_NUM - 1:0]  cmd_h3EC ,  
input [BIT_NUM - 1:0]  cmd_h3EE ,  
input [BIT_NUM - 1:0]  cmd_h3F0 ,  
input [BIT_NUM - 1:0]  cmd_h3F2 ,  
input [BIT_NUM - 1:0]  cmd_h3F4 ,  
input [BIT_NUM - 1:0]  cmd_h3F6 ,  
input [BIT_NUM - 1:0]  cmd_h3F8 ,  
input [BIT_NUM - 1:0]  cmd_h3FA ,  
input [BIT_NUM - 1:0]  cmd_h3FC ,  
input [BIT_NUM - 1:0]  cmd_h3FE  
    );

reg [31:0 ] data_to_dma_r1 ;
reg [31:0 ] data_to_dma_r2 ;
reg new_acq_data_flag_r ;
reg dsp_rd_sram_en_sync ;
reg dsp_rd_sram_en_sync1 ;
reg [17:0] sram_addr_r1 ;


reg  [BIT_NUM - 1:0]      cmd_h300_r ; 
reg  [BIT_NUM - 1:0]      cmd_h302_r ; 
reg  [BIT_NUM - 1:0]      cmd_h304_r ; 
reg  [BIT_NUM - 1:0]      cmd_h306_r ; 
reg  [BIT_NUM - 1:0]      cmd_h308_r ; 
reg  [BIT_NUM - 1:0]      cmd_h30A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h30C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h30E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h310_r ; 
reg  [BIT_NUM - 1:0]      cmd_h312_r ; 
reg  [BIT_NUM - 1:0]      cmd_h314_r ; 
reg  [BIT_NUM - 1:0]      cmd_h316_r ; 
reg  [BIT_NUM - 1:0]      cmd_h318_r ; 
reg  [BIT_NUM - 1:0]      cmd_h31A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h31C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h31E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h320_r ; 
reg  [BIT_NUM - 1:0]      cmd_h322_r ; 
reg  [BIT_NUM - 1:0]      cmd_h324_r ; 
reg  [BIT_NUM - 1:0]      cmd_h326_r ; 
reg  [BIT_NUM - 1:0]      cmd_h328_r ; 
reg  [BIT_NUM - 1:0]      cmd_h32A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h32C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h32E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h330_r ; 
reg  [BIT_NUM - 1:0]      cmd_h332_r ; 
reg  [BIT_NUM - 1:0]      cmd_h334_r ; 
reg  [BIT_NUM - 1:0]      cmd_h336_r ; 
reg  [BIT_NUM - 1:0]      cmd_h338_r ; 
reg  [BIT_NUM - 1:0]      cmd_h33A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h33C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h33E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h340_r ; 
reg  [BIT_NUM - 1:0]      cmd_h342_r ; 
reg  [BIT_NUM - 1:0]      cmd_h344_r ; 
reg  [BIT_NUM - 1:0]      cmd_h346_r ; 
reg  [BIT_NUM - 1:0]      cmd_h348_r ; 
reg  [BIT_NUM - 1:0]      cmd_h34A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h34C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h34E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h350_r ; 
reg  [BIT_NUM - 1:0]      cmd_h352_r ; 
reg  [BIT_NUM - 1:0]      cmd_h354_r ; 
reg  [BIT_NUM - 1:0]      cmd_h356_r ; 
reg  [BIT_NUM - 1:0]      cmd_h358_r ; 
reg  [BIT_NUM - 1:0]      cmd_h35A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h35C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h35E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h360_r ; 
reg  [BIT_NUM - 1:0]      cmd_h362_r ; 
reg  [BIT_NUM - 1:0]      cmd_h364_r ; 
reg  [BIT_NUM - 1:0]      cmd_h366_r ; 
reg  [BIT_NUM - 1:0]      cmd_h368_r ; 
reg  [BIT_NUM - 1:0]      cmd_h36A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h36C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h36E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h370_r ; 
reg  [BIT_NUM - 1:0]      cmd_h372_r ; 
reg  [BIT_NUM - 1:0]      cmd_h374_r ; 
reg  [BIT_NUM - 1:0]      cmd_h376_r ; 
reg  [BIT_NUM - 1:0]      cmd_h378_r ; 
reg  [BIT_NUM - 1:0]      cmd_h37A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h37C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h37E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h380_r ; 
reg  [BIT_NUM - 1:0]      cmd_h382_r ; 
reg  [BIT_NUM - 1:0]      cmd_h384_r ; 
reg  [BIT_NUM - 1:0]      cmd_h386_r ; 
reg  [BIT_NUM - 1:0]      cmd_h388_r ; 
reg  [BIT_NUM - 1:0]      cmd_h38A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h38C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h38E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h390_r ; 
reg  [BIT_NUM - 1:0]      cmd_h392_r ; 
reg  [BIT_NUM - 1:0]      cmd_h394_r ; 
reg  [BIT_NUM - 1:0]      cmd_h396_r ; 
reg  [BIT_NUM - 1:0]      cmd_h398_r ; 
reg  [BIT_NUM - 1:0]      cmd_h39A_r ; 
reg  [BIT_NUM - 1:0]      cmd_h39C_r ; 
reg  [BIT_NUM - 1:0]      cmd_h39E_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3A0_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3A2_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3A4_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3A6_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3A8_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3AA_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3AC_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3AE_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3B0_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3B2_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3B4_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3B6_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3B8_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3BA_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3BC_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3BE_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3C0_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3C2_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3C4_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3C6_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3C8_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3CA_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3CC_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3CE_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3D0_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3D2_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3D4_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3D6_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3D8_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3DA_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3DC_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3DE_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3E0_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3E2_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3E4_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3E6_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3E8_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3EA_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3EC_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3EE_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3F0_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3F2_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3F4_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3F6_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3F8_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3FA_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3FC_r ; 
reg  [BIT_NUM - 1:0]      cmd_h3FE_r ;

reg  [BIT_NUM - 1:0]      cmd_h3B0_r1 ;
reg  [BIT_NUM - 1:0]      cmd_h3B2_r1 ;
reg  [BIT_NUM - 1:0]      cmd_h3B4_r1 ;
reg  [BIT_NUM - 1:0]      cmd_h3B6_r1 ;
reg  [BIT_NUM - 1:0]      cmd_h3B8_r1 ;
reg  [BIT_NUM - 1:0]      cmd_h3BA_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3BC_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3BE_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3C0_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3C2_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3C4_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3C6_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3C8_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3CA_r1 ; 
reg  [BIT_NUM - 1:0]      cmd_h3CC_r1 ; 

//`include "File1.txt"

reg dsp_iord_en_1q , dsp_iord_en_2q ;
reg dsp_iord_en_3q , dsp_iord_en_4q ;

reg dsp_iord_en_rising_r1 ;
reg dsp_iord_en_rising_r2 ;
reg dsp_iord_en_rising_r3 ;
wire dsp_iord_en_falling ;



(* KEEP = "TRUE" *)reg [BIT_NUM - 1:0]          pic_data_d1 ;
(* KEEP = "TRUE" *)reg [BIT_NUM - 1:0]          pic_data_d2 ;
reg [BIT_NUM - 1:0]             dsp_databus_rd ;
reg [BIT_NUM - 1:0]             dsp_databus_rd_r1 ;
reg [7:0]             dsp_rd_sel_d1 ;


always @ (posedge clk)
begin
pic_data_d1    <= pic_data ;
dsp_rd_sel_d1  <= dsp_rd_sel[15:8] ;
dsp_databus_rd_r1  <= dsp_databus_rd[BIT_NUM - 1:0] ;
// dsp_rd_sel_d1  <= dsp_rd_sel[7:0] ;
end 

wire [9:0] o_pic_data ;

//*******************************

// reg debug_flag ;

// always @ (posedge clk)
// begin
// debug_flag <= (dsp_rd_sel_d1 == 0 && {1'b0,adsp_addr[10:1],1'b0} == 12'H32C) ;
// end
  


// ila_0 ins_ila_00 (
    // .clk(clk), // input wire clk

    // .probe0({    
            // debug_flag,
            // dsp_iord_en,
            // dpx_status[2:0],
            // cmd_h32C_r[BIT_NUM - 1:0]
            // })
            // );  


//********************************

// ila_0 my_ila_0 (
    // .clk(clk), // input wire clk


    // .probe0({
             // dsp_rd_sel_d1[7:0],
             // adsp_addr[9:0],
             // cmd_h30A_r[15:0],
             // cmd_h30C_r[15:0],
             // dsp_databus_rd_r1[15:0],
             // dsp_iord_en_1q
            // }) // input wire [99:0] probe0
// );  
    


always @ (posedge clk)
begin
if(dsp_rd_sel_d1 == 0 )
        begin
            begin
            case    ({1'b0,adsp_addr[10:1],1'b0})

            12'H300:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h300_r[BIT_NUM - 1:0]  ; 
            12'H302:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h302_r[BIT_NUM - 1:0]  ; 
            12'H304:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h304_r[BIT_NUM - 1:0]  ; 
            12'H306:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h306_r[BIT_NUM - 1:0]  ; 
            12'H308:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h308_r[BIT_NUM - 1:0]  ; 
            12'H30A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h30A_r[BIT_NUM - 1:0]  ; 
            12'H30C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h30C_r[BIT_NUM - 1:0]  ; 
            12'H30E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h30E_r[BIT_NUM - 1:0]  ; 
            12'H310:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h310_r[BIT_NUM - 1:0]  ; 
            12'H312:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h312_r[BIT_NUM - 1:0]  ; 
            12'H314:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h314_r[BIT_NUM - 1:0]  ; 
            12'H316:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h316_r[BIT_NUM - 1:0]  ; 
            12'H318:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h318_r[BIT_NUM - 1:0]  ; 
            12'H31A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h31A_r[BIT_NUM - 1:0]  ; 
            12'H31C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h31C_r[BIT_NUM - 1:0]  ; 
            12'H31E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h31E_r[BIT_NUM - 1:0]  ; 
            12'H320:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h320_r[BIT_NUM - 1:0]  ; 
            12'H322:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h322_r[BIT_NUM - 1:0]  ; 
            12'H324:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h324_r[BIT_NUM - 1:0]  ; 
            12'H326:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h326_r[BIT_NUM - 1:0]  ; 
            12'H328:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h328_r[BIT_NUM - 1:0]  ; 
            12'H32A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h32A_r[BIT_NUM - 1:0]  ; 
            12'H32C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h32C_r[BIT_NUM - 1:0]  ; 
            12'H32E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h32E_r[BIT_NUM - 1:0]  ; 
            12'H330:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h330_r[BIT_NUM - 1:0]  ; 
            12'H332:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h332_r[BIT_NUM - 1:0]  ; 
            12'H334:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h334_r[BIT_NUM - 1:0]  ; 
            12'H336:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h336_r[BIT_NUM - 1:0]  ; 
            12'H338:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h338_r[BIT_NUM - 1:0]  ; 
            12'H33A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h33A_r[BIT_NUM - 1:0]  ; 
            12'H33C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h33C_r[BIT_NUM - 1:0]  ; 
            12'H33E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h33E_r[BIT_NUM - 1:0]  ; 
            12'H340:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h340_r[BIT_NUM - 1:0]  ; 
            12'H342:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h342_r[BIT_NUM - 1:0]  ; 
            12'H344:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h344_r[BIT_NUM - 1:0]  ; 
            12'H346:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h346_r[BIT_NUM - 1:0]  ; 
            12'H348:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h348_r[BIT_NUM - 1:0]  ; 
            12'H34A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h34A_r[BIT_NUM - 1:0]  ; 
            12'H34C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h34C_r[BIT_NUM - 1:0]  ; 
            12'H34E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h34E_r[BIT_NUM - 1:0]  ; 
            12'H350:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h350_r[BIT_NUM - 1:0]  ; 
            12'H352:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h352_r[BIT_NUM - 1:0]  ; 
            12'H354:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h354_r[BIT_NUM - 1:0]  ; 
            12'H356:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h356_r[BIT_NUM - 1:0]  ; 
            12'H358:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h358_r[BIT_NUM - 1:0]  ; 
            12'H35A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h35A_r[BIT_NUM - 1:0]  ; 
            12'H35C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h35C_r[BIT_NUM - 1:0]  ; 
            12'H35E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h35E_r[BIT_NUM - 1:0]  ; 
            12'H360:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h360_r[BIT_NUM - 1:0]  ; 
            12'H362:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h362_r[BIT_NUM - 1:0]  ; 
            12'H364:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h364_r[BIT_NUM - 1:0]  ; 
            12'H366:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h366_r[BIT_NUM - 1:0]  ; 
            12'H368:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h368_r[BIT_NUM - 1:0]  ; 
            12'H36A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h36A_r[BIT_NUM - 1:0]  ; 
            12'H36C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h36C_r[BIT_NUM - 1:0]  ; 
            12'H36E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h36E_r[BIT_NUM - 1:0]  ; 
            12'H370:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h370_r[BIT_NUM - 1:0]  ; 
            12'H372:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h372_r[BIT_NUM - 1:0]  ; 
            12'H374:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h374_r[BIT_NUM - 1:0]  ; 
            12'H376:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h376_r[BIT_NUM - 1:0]  ; 
            12'H378:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h378_r[BIT_NUM - 1:0]  ; 
            12'H37A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h37A_r[BIT_NUM - 1:0]  ; 
            12'H37C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h37C_r[BIT_NUM - 1:0]  ; 
            12'H37E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h37E_r[BIT_NUM - 1:0]  ; 
            12'H380:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h380_r[BIT_NUM - 1:0]  ; 
            12'H382:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h382_r[BIT_NUM - 1:0]  ; 
            12'H384:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h384_r[BIT_NUM - 1:0]  ; 
            12'H386:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h386_r[BIT_NUM - 1:0]  ; 
            12'H388:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h388_r[BIT_NUM - 1:0]  ; 
            12'H38A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h38A_r[BIT_NUM - 1:0]  ; 
            12'H38C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h38C_r[BIT_NUM - 1:0]  ; 
            12'H38E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h38E_r[BIT_NUM - 1:0]  ; 
            12'H390:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h390_r[BIT_NUM - 1:0]  ; 
            12'H392:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h392_r[BIT_NUM - 1:0]  ; 
            12'H394:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h394_r[BIT_NUM - 1:0]  ; 
            12'H396:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h396_r[BIT_NUM - 1:0]  ; 
            12'H398:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h398_r[BIT_NUM - 1:0]  ; 
            12'H39A:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h39A_r[BIT_NUM - 1:0]  ; 
            12'H39C:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h39C_r[BIT_NUM - 1:0]  ; 
            12'H39E:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h39E_r[BIT_NUM - 1:0]  ; 
            12'H3A0:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3A0_r[BIT_NUM - 1:0]  ; 
            12'H3A2:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3A2_r[BIT_NUM - 1:0]  ; 
            12'H3A4:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3A4_r[BIT_NUM - 1:0]  ; 
            12'H3A6:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3A6_r[BIT_NUM - 1:0]  ; 
            12'H3A8:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3A8_r[BIT_NUM - 1:0]  ; 
            12'H3AA:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3AA_r[BIT_NUM - 1:0]  ; 
            12'H3AC:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3AC_r[BIT_NUM - 1:0]  ; 
            12'H3AE:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3AE_r[BIT_NUM - 1:0]  ; 
            12'H3B0:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3B0_r[BIT_NUM - 1:0]  ; 
            12'H3B2:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3B2_r[BIT_NUM - 1:0]  ; 
            12'H3B4:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3B4_r[BIT_NUM - 1:0]  ; 
            12'H3B6:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3B6_r[BIT_NUM - 1:0]  ; 
            12'H3B8:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3B8_r[BIT_NUM - 1:0]  ; 
            12'H3BA:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3BA_r[BIT_NUM - 1:0]  ; 
            12'H3BC:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3BC_r[BIT_NUM - 1:0]  ; 
            12'H3BE:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3BE_r[BIT_NUM - 1:0]  ; 
            12'H3C0:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3C0_r[BIT_NUM - 1:0]  ; 
            12'H3C2:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3C2_r[BIT_NUM - 1:0]  ; 
            12'H3C4:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3C4_r[BIT_NUM - 1:0]  ; 
            12'H3C6:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3C6_r[BIT_NUM - 1:0]  ; 
            12'H3C8:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3C8_r[BIT_NUM - 1:0]  ; 
            12'H3CA:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3CA_r[BIT_NUM - 1:0]  ; 
            12'H3CC:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3CC_r[BIT_NUM - 1:0]  ; 
            12'H3CE:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3CE_r[BIT_NUM - 1:0]  ; 
            12'H3D0:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3D0_r[BIT_NUM - 1:0]  ; 
            12'H3D2:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3D2_r[BIT_NUM - 1:0]  ; 
            12'H3D4:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3D4_r[BIT_NUM - 1:0]  ; 
            12'H3D6:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3D6_r[BIT_NUM - 1:0]  ; 
            12'H3D8:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3D8_r[BIT_NUM - 1:0]  ; 
            12'H3DA:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3DA_r[BIT_NUM - 1:0]  ; 
            12'H3DC:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3DC_r[BIT_NUM - 1:0]  ; 
            12'H3DE:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3DE_r[BIT_NUM - 1:0]  ; 
            12'H3E0:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3E0_r[BIT_NUM - 1:0]  ; 
            12'H3E2:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3E2_r[BIT_NUM - 1:0]  ; 
            12'H3E4:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3E4_r[BIT_NUM - 1:0]  ; 
            12'H3E6:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3E6_r[BIT_NUM - 1:0]  ; 
            12'H3E8:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3E8_r[BIT_NUM - 1:0]  ; 
            12'H3EA:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3EA_r[BIT_NUM - 1:0]  ; 
            12'H3EC:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3EC_r[BIT_NUM - 1:0]  ; 
            12'H3EE:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3EE_r[BIT_NUM - 1:0]  ; 
            12'H3F0:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3F0_r[BIT_NUM - 1:0]  ; 
            12'H3F2:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3F2_r[BIT_NUM - 1:0]  ; 
            12'H3F4:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3F4_r[BIT_NUM - 1:0]  ; 
            12'H3F6:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3F6_r[BIT_NUM - 1:0]  ; 
            12'H3F8:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3F8_r[BIT_NUM - 1:0]  ; 
            12'H3FA:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3FA_r[BIT_NUM - 1:0]  ; 
            12'H3FC:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3FC_r[BIT_NUM - 1:0]  ; 
            12'H3FE:    dsp_databus_rd [BIT_NUM - 1:0]  <= cmd_h3FE_r[BIT_NUM - 1:0]  ; 
            default:    dsp_databus_rd [BIT_NUM - 1:0]  <= dsp_databus_rd[BIT_NUM - 1:0];                                   
            endcase 
            end
        end 
else if (dsp_rd_sel_d1 == 8'h01)    
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dso_fifo_data0[BIT_NUM - 1:0];  
else if (dsp_rd_sel_d1 == 8'h02)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dso_fifo_data1[BIT_NUM - 1:0];  
else if (dsp_rd_sel_d1 == 8'h03)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dso_fifo_data2[BIT_NUM - 1:0];  
else if (dsp_rd_sel_d1 == 8'h04)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dso_fifo_data3[BIT_NUM - 1:0];
			 
else if (dsp_rd_sel_d1 == 8'h05)    
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0];  
else if (dsp_rd_sel_d1 == 8'h06)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0];  
else if (dsp_rd_sel_d1 == 8'h07)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0];  
else if (dsp_rd_sel_d1 == 8'h08)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0]; 
			 
else if (dsp_rd_sel_d1 == 8'h09)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0]; //LA_L
else if (dsp_rd_sel_d1 == 8'h0A)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0]; //LA_H
else if (dsp_rd_sel_d1 == 8'h0B)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0]; //LA_ACH	
else if (dsp_rd_sel_d1 == 8'h0C)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  dma_fifo_data[BIT_NUM - 1:0]; //decode
			 
else if (dsp_rd_sel_d1 == 8'h10)
             dsp_databus_rd[BIT_NUM - 1:0]              <=  pic_data_d1[BIT_NUM - 1:0];  
             // dsp_databus_rd[BIT_NUM - 1:0]              <=  o_pic_data[9:0];  
			 
end 

//*****************************************

reg  [9:0]  h_cnt ;
reg  [7:0]  v_cnt ;

reg [7:0] h_cnt_int = 0 ;

reg dsp_rd_sram_d1 ;
reg dsp_rd_sram_d2 ;

always @ (posedge clk)
begin
begin
if (dsp_rd_sel_d1 == 8'h10) 
   dsp_rd_sram <= 1'b1 ;
else
   dsp_rd_sram <= 1'b0 ;
end   
   
dsp_rd_sram_d1 <= dsp_rd_sram ;
dsp_rd_sram_d2 <= dsp_rd_sram_d1 ;
end

always @ (posedge clk)
begin
if (dsp_rd_sram_d1 & ~dsp_rd_sram_d2)
   begin
   // if (h_cnt_int == 10'd699)
      // h_cnt_int <= 0 ;
   // else
      h_cnt_int <= h_cnt_int + 10 ;
   end	  
end



always @ (posedge clk)
begin
if (!dsp_rd_sram)   
   begin
   h_cnt        <= 10'd0 ;
   v_cnt        <= 8'd28 ;//只读取中�?200�?
   end
else if(dsp_iord_en_falling)
   begin 
   if(h_cnt == 10'd699)
      begin
	  begin
	  if (v_cnt == 255)
	     v_cnt     <= v_cnt ; 
	  else 	 
         v_cnt     <= v_cnt + 1'b1 ;
	  end
      h_cnt     <= 10'd0 ;
      end
   else    
      begin
      h_cnt     <= h_cnt + 1'b1 ;
      end
   end
end

reg [7:0] data_t_d1 ;

always @ (posedge clk)
begin
data_t_d1 <= h_cnt[7:0] + h_cnt_int;
end  

assign o_pic_data[9:0] = {2'b00,data_t_d1[7:0]};
















assign adsp_databus_rd = dsp_databus_rd ;

//*******************************************************************




reg rd_p_valid ;
// reg dsp_rd_sram_en_sync1 ;
// reg dsp_rd_sram_en_sync ;

always @ (posedge clk)
begin
dsp_rd_sram_en_sync1 <= dsp_rd_sram ;
dsp_rd_sram_en_sync  <= dsp_rd_sram_en_sync1 ;
end 


// always @ (posedge clk)
always @ (*)
begin
            cmd_h300_r[BIT_NUM - 1:0] <=  cmd_h300[BIT_NUM - 1:0] ; 
            cmd_h302_r[BIT_NUM - 1:0] <=  cmd_h302[BIT_NUM - 1:0] ; 
            cmd_h304_r[BIT_NUM - 1:0] <=  cmd_h304[BIT_NUM - 1:0] ; 
            cmd_h306_r[BIT_NUM - 1:0] <=  cmd_h306[BIT_NUM - 1:0] ; 
            cmd_h308_r[BIT_NUM - 1:0] <=  cmd_h308[BIT_NUM - 1:0] ; 
            cmd_h30A_r[BIT_NUM - 1:0] <=  cmd_h30A[BIT_NUM - 1:0] ; 
            cmd_h30C_r[BIT_NUM - 1:0] <=  cmd_h30C[BIT_NUM - 1:0] ; 
            cmd_h30E_r[BIT_NUM - 1:0] <=  cmd_h30E[BIT_NUM - 1:0] ; 
            cmd_h310_r[BIT_NUM - 1:0] <=  cmd_h310[BIT_NUM - 1:0] ; 
            cmd_h312_r[BIT_NUM - 1:0] <=  cmd_h312[BIT_NUM - 1:0] ; 
            cmd_h314_r[BIT_NUM - 1:0] <=  cmd_h314[BIT_NUM - 1:0] ; 
            cmd_h316_r[BIT_NUM - 1:0] <=  cmd_h316[BIT_NUM - 1:0] ; 
            cmd_h318_r[BIT_NUM - 1:0] <=  cmd_h318[BIT_NUM - 1:0] ; 
            cmd_h31A_r[BIT_NUM - 1:0] <=  cmd_h31A[BIT_NUM - 1:0] ; 
            cmd_h31C_r[BIT_NUM - 1:0] <=  cmd_h31C[BIT_NUM - 1:0] ; 
            cmd_h31E_r[BIT_NUM - 1:0] <=  cmd_h31E[BIT_NUM - 1:0] ; 
            cmd_h320_r[BIT_NUM - 1:0] <=  cmd_h320[BIT_NUM - 1:0] ; 
            cmd_h322_r[BIT_NUM - 1:0] <=  cmd_h322[BIT_NUM - 1:0] ; 
            cmd_h324_r[BIT_NUM - 1:0] <=  cmd_h324[BIT_NUM - 1:0] ; 
            cmd_h326_r[BIT_NUM - 1:0] <=  cmd_h326[BIT_NUM - 1:0] ; 
            cmd_h328_r[BIT_NUM - 1:0] <=  cmd_h328[BIT_NUM - 1:0] ; 
            cmd_h32A_r[BIT_NUM - 1:0] <=  cmd_h32A[BIT_NUM - 1:0] ; 
            cmd_h32C_r[BIT_NUM - 1:0] <=  cmd_h32C[BIT_NUM - 1:0] ; 
            cmd_h32E_r[BIT_NUM - 1:0] <=  cmd_h32E[BIT_NUM - 1:0] ; 
            cmd_h330_r[BIT_NUM - 1:0] <=  cmd_h330[BIT_NUM - 1:0] ; 
            cmd_h332_r[BIT_NUM - 1:0] <=  cmd_h332[BIT_NUM - 1:0] ; 
            cmd_h334_r[BIT_NUM - 1:0] <=  cmd_h334[BIT_NUM - 1:0] ; 
            cmd_h336_r[BIT_NUM - 1:0] <=  cmd_h336[BIT_NUM - 1:0] ; 
            cmd_h338_r[BIT_NUM - 1:0] <=  cmd_h338[BIT_NUM - 1:0] ; 
            cmd_h33A_r[BIT_NUM - 1:0] <=  cmd_h33A[BIT_NUM - 1:0] ; 
            cmd_h33C_r[BIT_NUM - 1:0] <=  cmd_h33C[BIT_NUM - 1:0] ; 
            cmd_h33E_r[BIT_NUM - 1:0] <=  cmd_h33E[BIT_NUM - 1:0] ; 
            cmd_h340_r[BIT_NUM - 1:0] <=  cmd_h340[BIT_NUM - 1:0] ; 
            cmd_h342_r[BIT_NUM - 1:0] <=  cmd_h342[BIT_NUM - 1:0] ; 
            cmd_h344_r[BIT_NUM - 1:0] <=  cmd_h344[BIT_NUM - 1:0] ; 
            cmd_h346_r[BIT_NUM - 1:0] <=  cmd_h346[BIT_NUM - 1:0] ; 
            cmd_h348_r[BIT_NUM - 1:0] <=  cmd_h348[BIT_NUM - 1:0] ; 
            cmd_h34A_r[BIT_NUM - 1:0] <=  cmd_h34A[BIT_NUM - 1:0] ; 
            cmd_h34C_r[BIT_NUM - 1:0] <=  cmd_h34C[BIT_NUM - 1:0] ; 
            cmd_h34E_r[BIT_NUM - 1:0] <=  cmd_h34E[BIT_NUM - 1:0] ; 
            cmd_h350_r[BIT_NUM - 1:0] <=  cmd_h350[BIT_NUM - 1:0] ; 
            cmd_h352_r[BIT_NUM - 1:0] <=  cmd_h352[BIT_NUM - 1:0] ; 
            cmd_h354_r[BIT_NUM - 1:0] <=  cmd_h354[BIT_NUM - 1:0] ; 
            cmd_h356_r[BIT_NUM - 1:0] <=  cmd_h356[BIT_NUM - 1:0] ; 
            cmd_h358_r[BIT_NUM - 1:0] <=  cmd_h358[BIT_NUM - 1:0] ; 
            cmd_h35A_r[BIT_NUM - 1:0] <=  cmd_h35A[BIT_NUM - 1:0] ; 
            cmd_h35C_r[BIT_NUM - 1:0] <=  cmd_h35C[BIT_NUM - 1:0] ; 
            cmd_h35E_r[BIT_NUM - 1:0] <=  cmd_h35E[BIT_NUM - 1:0] ; 
            cmd_h360_r[BIT_NUM - 1:0] <=  cmd_h360[BIT_NUM - 1:0] ; 
            cmd_h362_r[BIT_NUM - 1:0] <=  cmd_h362[BIT_NUM - 1:0] ; 
            cmd_h364_r[BIT_NUM - 1:0] <=  cmd_h364[BIT_NUM - 1:0] ; 
            cmd_h366_r[BIT_NUM - 1:0] <=  cmd_h366[BIT_NUM - 1:0] ; 
            cmd_h368_r[BIT_NUM - 1:0] <=  cmd_h368[BIT_NUM - 1:0] ; 
            cmd_h36A_r[BIT_NUM - 1:0] <=  cmd_h36A[BIT_NUM - 1:0] ; 
            cmd_h36C_r[BIT_NUM - 1:0] <=  cmd_h36C[BIT_NUM - 1:0] ; 
            cmd_h36E_r[BIT_NUM - 1:0] <=  cmd_h36E[BIT_NUM - 1:0] ; 
            cmd_h370_r[BIT_NUM - 1:0] <=  cmd_h370[BIT_NUM - 1:0] ; 
            cmd_h372_r[BIT_NUM - 1:0] <=  cmd_h372[BIT_NUM - 1:0] ; 
            cmd_h374_r[BIT_NUM - 1:0] <=  cmd_h374[BIT_NUM - 1:0] ; 
            cmd_h376_r[BIT_NUM - 1:0] <=  cmd_h376[BIT_NUM - 1:0] ; 
            cmd_h378_r[BIT_NUM - 1:0] <=  cmd_h378[BIT_NUM - 1:0] ; 
            cmd_h37A_r[BIT_NUM - 1:0] <=  cmd_h37A[BIT_NUM - 1:0] ; 
            cmd_h37C_r[BIT_NUM - 1:0] <=  cmd_h37C[BIT_NUM - 1:0] ; 
            cmd_h37E_r[BIT_NUM - 1:0] <=  cmd_h37E[BIT_NUM - 1:0] ; 
            cmd_h380_r[BIT_NUM - 1:0] <=  cmd_h380[BIT_NUM - 1:0] ; 
            cmd_h382_r[BIT_NUM - 1:0] <=  cmd_h382[BIT_NUM - 1:0] ; 
            cmd_h384_r[BIT_NUM - 1:0] <=  cmd_h384[BIT_NUM - 1:0] ; 
            cmd_h386_r[BIT_NUM - 1:0] <=  cmd_h386[BIT_NUM - 1:0] ; 
            cmd_h388_r[BIT_NUM - 1:0] <=  cmd_h388[BIT_NUM - 1:0] ; 
            cmd_h38A_r[BIT_NUM - 1:0] <=  cmd_h38A[BIT_NUM - 1:0] ; 
            cmd_h38C_r[BIT_NUM - 1:0] <=  cmd_h38C[BIT_NUM - 1:0] ; 
            cmd_h38E_r[BIT_NUM - 1:0] <=  cmd_h38E[BIT_NUM - 1:0] ; 
            cmd_h390_r[BIT_NUM - 1:0] <=  cmd_h390[BIT_NUM - 1:0] ; 
            cmd_h392_r[BIT_NUM - 1:0] <=  cmd_h392[BIT_NUM - 1:0] ; 
            cmd_h394_r[BIT_NUM - 1:0] <=  cmd_h394[BIT_NUM - 1:0] ; 
            cmd_h396_r[BIT_NUM - 1:0] <=  cmd_h396[BIT_NUM - 1:0] ; 
            cmd_h398_r[BIT_NUM - 1:0] <=  cmd_h398[BIT_NUM - 1:0] ; 
            cmd_h39A_r[BIT_NUM - 1:0] <=  cmd_h39A[BIT_NUM - 1:0] ; 
            cmd_h39C_r[BIT_NUM - 1:0] <=  cmd_h39C[BIT_NUM - 1:0] ; 
            cmd_h39E_r[BIT_NUM - 1:0] <=  cmd_h39E[BIT_NUM - 1:0] ; 
            cmd_h3A0_r[BIT_NUM - 1:0] <=  cmd_h3A0[BIT_NUM - 1:0] ; 
            cmd_h3A2_r[BIT_NUM - 1:0] <=  cmd_h3A2[BIT_NUM - 1:0] ; 
            cmd_h3A4_r[BIT_NUM - 1:0] <=  cmd_h3A4[BIT_NUM - 1:0] ; 
            cmd_h3A6_r[BIT_NUM - 1:0] <=  cmd_h3A6[BIT_NUM - 1:0] ; 
            cmd_h3A8_r[BIT_NUM - 1:0] <=  cmd_h3A8[BIT_NUM - 1:0] ; 
            cmd_h3AA_r[BIT_NUM - 1:0] <=  cmd_h3AA[BIT_NUM - 1:0] ; 
            cmd_h3AC_r[BIT_NUM - 1:0] <=  cmd_h3AC[BIT_NUM - 1:0] ; 
            cmd_h3AE_r[BIT_NUM - 1:0] <=  cmd_h3AE[BIT_NUM - 1:0] ; 
            cmd_h3B0_r[BIT_NUM - 1:0] <=  cmd_h3B0[BIT_NUM - 1:0] ; 
            cmd_h3B2_r[BIT_NUM - 1:0] <=  cmd_h3B2[BIT_NUM - 1:0] ; 
            cmd_h3B4_r[BIT_NUM - 1:0] <=  cmd_h3B4[BIT_NUM - 1:0] ; 
            cmd_h3B6_r[BIT_NUM - 1:0] <=  cmd_h3B6[BIT_NUM - 1:0] ; 
            cmd_h3B8_r[BIT_NUM - 1:0] <=  cmd_h3B8[BIT_NUM - 1:0] ; 
            cmd_h3BA_r[BIT_NUM - 1:0] <=  cmd_h3BA[BIT_NUM - 1:0] ; 
            cmd_h3BC_r[BIT_NUM - 1:0] <=  cmd_h3BC[BIT_NUM - 1:0] ; 
            cmd_h3BE_r[BIT_NUM - 1:0] <=  cmd_h3BE[BIT_NUM - 1:0] ; 
            cmd_h3C0_r[BIT_NUM - 1:0] <=  cmd_h3C0[BIT_NUM - 1:0] ; 
            cmd_h3C2_r[BIT_NUM - 1:0] <=  cmd_h3C2[BIT_NUM - 1:0] ; 
            cmd_h3C4_r[BIT_NUM - 1:0] <=  cmd_h3C4[BIT_NUM - 1:0] ; 
            cmd_h3C6_r[BIT_NUM - 1:0] <=  cmd_h3C6[BIT_NUM - 1:0] ; 
            cmd_h3C8_r[BIT_NUM - 1:0] <=  cmd_h3C8[BIT_NUM - 1:0] ; 
            cmd_h3CA_r[BIT_NUM - 1:0] <=  cmd_h3CA[BIT_NUM - 1:0] ; 
            cmd_h3CC_r[BIT_NUM - 1:0] <=  cmd_h3CC[BIT_NUM - 1:0] ; 
            cmd_h3CE_r[BIT_NUM - 1:0] <=  cmd_h3CE[BIT_NUM - 1:0] ; 
            cmd_h3D0_r[BIT_NUM - 1:0] <=  cmd_h3D0[BIT_NUM - 1:0] ; 
            cmd_h3D2_r[BIT_NUM - 1:0] <=  cmd_h3D2[BIT_NUM - 1:0] ; 
            cmd_h3D4_r[BIT_NUM - 1:0] <=  cmd_h3D4[BIT_NUM - 1:0] ; 
            cmd_h3D6_r[BIT_NUM - 1:0] <=  cmd_h3D6[BIT_NUM - 1:0] ; 
            cmd_h3D8_r[BIT_NUM - 1:0] <=  cmd_h3D8[BIT_NUM - 1:0] ; 
            cmd_h3DA_r[BIT_NUM - 1:0] <=  cmd_h3DA[BIT_NUM - 1:0] ; 
            cmd_h3DC_r[BIT_NUM - 1:0] <=  cmd_h3DC[BIT_NUM - 1:0] ; 
            cmd_h3DE_r[BIT_NUM - 1:0] <=  cmd_h3DE[BIT_NUM - 1:0] ; 
            cmd_h3E0_r[BIT_NUM - 1:0] <=  cmd_h3E0[BIT_NUM - 1:0] ; 
            cmd_h3E2_r[BIT_NUM - 1:0] <=  cmd_h3E2[BIT_NUM - 1:0] ; 
            cmd_h3E4_r[BIT_NUM - 1:0] <=  cmd_h3E4[BIT_NUM - 1:0] ; 
            cmd_h3E6_r[BIT_NUM - 1:0] <=  cmd_h3E6[BIT_NUM - 1:0] ; 
            cmd_h3E8_r[BIT_NUM - 1:0] <=  cmd_h3E8[BIT_NUM - 1:0] ; 
            cmd_h3EA_r[BIT_NUM - 1:0] <=  cmd_h3EA[BIT_NUM - 1:0] ; 
            cmd_h3EC_r[BIT_NUM - 1:0] <=  cmd_h3EC[BIT_NUM - 1:0] ; 
            cmd_h3EE_r[BIT_NUM - 1:0] <=  cmd_h3EE[BIT_NUM - 1:0] ; 
            cmd_h3F0_r[BIT_NUM - 1:0] <=  cmd_h3F0[BIT_NUM - 1:0] ; 
            cmd_h3F2_r[BIT_NUM - 1:0] <=  cmd_h3F2[BIT_NUM - 1:0] ; 
            cmd_h3F4_r[BIT_NUM - 1:0] <=  cmd_h3F4[BIT_NUM - 1:0] ; 
            cmd_h3F6_r[BIT_NUM - 1:0] <=  cmd_h3F6[BIT_NUM - 1:0] ; 
            cmd_h3F8_r[BIT_NUM - 1:0] <=  cmd_h3F8[BIT_NUM - 1:0] ; 
            cmd_h3FA_r[BIT_NUM - 1:0] <=  cmd_h3FA[BIT_NUM - 1:0] ; 
            cmd_h3FC_r[BIT_NUM - 1:0] <=  cmd_h3FC[BIT_NUM - 1:0] ; 
            cmd_h3FE_r[BIT_NUM - 1:0] <=  cmd_h3FE[BIT_NUM - 1:0] ; 

end




reg [11:0]  dsp_addr ;
reg [7:0]   dma_fifo_rd_en_sig ;


always @ (posedge clk)
//always @ (*)
begin
//dsp_addr <= adsp_addr ;
dsp_addr <= {1'b0,adsp_addr[10:1],1'b0} ;
end

 //********************************************************************************************************************
 //********************************************************************************************************************
 //************************************************DCLK****************************************************************
 //********************************************************************************************************************
 //********************************************************************************************************************



always @ (posedge clk)
begin
dsp_iord_en_1q <= dsp_iord_en ;
dsp_iord_en_2q <= dsp_iord_en_1q ;
dsp_iord_en_3q <= dsp_iord_en_2q ;
dsp_iord_en_4q <= dsp_iord_en_3q ;
dsp_iord_en_rising_r1 <= dsp_iord_en_rising ;
dsp_iord_en_rising_r2 <= dsp_iord_en_rising_r1 ;
dsp_iord_en_rising_r3 <= dsp_iord_en_rising_r2 ;

end

assign dsp_iord_en_rising  =  dsp_iord_en_1q & ~dsp_iord_en_2q ;
assign dsp_iord_en_falling  = ~dsp_iord_en_1q & dsp_iord_en_2q ;

always @ (posedge clk)
begin
// dsp_rd_fifo_en[0]       <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h01) ;
// dsp_rd_fifo_en[1]       <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h02) ;
// dsp_rd_fifo_en[2]       <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h03) ;
// dsp_rd_fifo_en[3]       <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h04) ;

dma_fifo_rd_en_sig[0]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h05);
dma_fifo_rd_en_sig[1]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h06);
dma_fifo_rd_en_sig[2]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h07);
dma_fifo_rd_en_sig[3]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h08);

dma_fifo_rd_en_sig[4]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h09);
dma_fifo_rd_en_sig[5]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h0A);
dma_fifo_rd_en_sig[6]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h0B);
dma_fifo_rd_en_sig[7]   <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h0C);

dsp_rd_pic_pulse        <= dsp_iord_en_falling && (dsp_rd_sel_d1 == 8'h10) ;
end

assign dma_fifo_rd_en = |dma_fifo_rd_en_sig[7:0] ;


// always @ (posedge clk)
// begin
// if (dsp_addr[11:0] == 12'H300 ) dsp_rd_fifo_en[0]<= dsp_iord_en_falling & ~dsp_rd_sram;
// else                            dsp_rd_fifo_en[0]<= 1'b0 ;
// end                                           
// always @ (posedge clk)                        
// begin                                         
// if (dsp_addr[11:0] == 12'H302 ) dsp_rd_fifo_en[1]<= dsp_iord_en_falling & ~dsp_rd_sram ;
// else                            dsp_rd_fifo_en[1]<= 1'b0 ;
// end                                           
always @ (posedge clk)                        
begin                                        
if (dsp_addr[11:0] == 12'H304 ) dsp_rd_fifo_en[2]<= dsp_iord_en_falling  ;
else                            dsp_rd_fifo_en[2]<= 1'b0 ;
end                                           
// always @ (posedge clk)                        
// begin                                         
// if (dsp_addr[11:0] == 12'H306 ) dsp_rd_fifo_en[3]<= dsp_iord_en_falling & ~dsp_rd_sram ;
// else                            dsp_rd_fifo_en[3]<= 1'b0 ;
// end

//***********************************************************************************
// always @ (posedge clk)
// begin
// if (dsp_addr[11:0] == 12'H340 ) dma_fifo_rd_en[0] <= dsp_iord_en_rising & ~dsp_rd_sram;
// else                            dma_fifo_rd_en[0] <= 1'b0 ;
// end                                           
// always @ (posedge clk)                        
// begin                                         
// if (dsp_addr[11:0] == 12'H342 ) dma_fifo_rd_en[1] <= dsp_iord_en_rising & ~dsp_rd_sram ;
// else                            dma_fifo_rd_en[1] <= 1'b0 ;
// end                                           
// always @ (posedge clk)                        
// begin                                        
// if (dsp_addr[11:0] == 12'H344 ) dma_fifo_rd_en[2] <= dsp_iord_en_rising & ~dsp_rd_sram ;
// else                            dma_fifo_rd_en[2] <= 1'b0 ;
// end                                           
// always @ (posedge clk)                        
// begin                                         
// if (dsp_addr[11:0] == 12'H346 ) dma_fifo_rd_en[3] <= dsp_iord_en_rising & ~dsp_rd_sram ;
// else                            dma_fifo_rd_en[3] <= 1'b0 ;
// end



 
endmodule                
                        
                        