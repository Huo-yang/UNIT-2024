`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:24:19 08/29/2016 
// Design Name: 
// Module Name:    cpu_databus_mg 
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
module cpu_databus_mg
#(
	parameter			BIT_W = 16
)
(
    input dsp_iord_en,
    input dsp_iowr_en,		 
    input   [BIT_W - 1 : 0] adsp_databus_rd,
	 
    inout   [BIT_W - 1 : 0] adsp_d,
	 
    output  [BIT_W - 1 : 0] adsp_databus_wr
    );

wire [15:0] adsp_d_wire ;
reg  [15:0] adsp_databus_wr_sig ;
reg  [15:0] adsp_databus_wr_sig1 ;

assign adsp_databus_wr = adsp_d_wire ;

genvar i;
generate
for (i = 0; i <= BIT_W - 1 ; i = i + 1)
begin: loop1

   IOBUF #(
      .DRIVE(12), // Specify the output drive strength
      .IBUF_LOW_PWR("TRUE"),  // Low Power - "TRUE", High Performance = "FALSE" 
      .IOSTANDARD("DEFAULT"), // Specify the I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) IOBUF_inst (
      .O (adsp_d_wire[i]),     // Buffer output
      .IO(adsp_d[i]),   // Buffer inout port (connect directly to top-level port)
      .I (adsp_databus_rd[i]),     // Buffer input
      .T (dsp_iord_en)      // 3-state enable input, high=input, low=output
   );
	
// IBUF  IBUF_DSP_DB  ( 
		  // .I(adsp_d[i]),			//dsp data bus
		  // .O(adsp_d_wire[i])		//data from dsp databus write to reg  adsp_databus_wr
		  // );

		
// OBUFT  OBUF_DSP_DB (
		  // .I(adsp_databus_rd[i]),	// dsp databus read data from reg
		  // .T((dsp_iord_en)),
		  // .O(adsp_d[i])
		 // );
		 
end
endgenerate

endmodule
