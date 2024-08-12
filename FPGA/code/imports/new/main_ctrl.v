module main_ctrl
  #(parameter DAC_WIDTH   = 24,
    parameter DVGA_WIDTH  = 24,
    parameter SHIFT_WIDTH = 40,
    parameter ADC_WIDTH   = 32)
  (
    input                        clk,
    input                        rst_n,
    // local bus
    input                        cd4094_send_en,
    input      [SHIFT_WIDTH-1:0] cd4094_send_data,
    input                        dac_send_en,
    input      [4:0]             dac_send_sel,
    input      [DAC_WIDTH-1:0]   dac_send_data,
    input                        adc_send_en,
    input      [1:0]             adc_send_sel,
    input      [ADC_WIDTH-1:0]   adc_send_data,
    input                        dvga_send_en,
    input      [3:0]             dvga_send_sel,
    input      [DVGA_WIDTH-1:0]  dvga_send_data,
    // 
    output reg                   cd4094_tx_en,
    output reg [SHIFT_WIDTH-1:0] cd4094_tx_data,
    output reg [4:0]             dac_ch_sel,
    output reg                   dac_tx_en,
    output reg [DAC_WIDTH-1:0]   dac_tx_data,
    output reg [1:0]             adc_ch_sel,
    output reg                   adc_tx_en,
    output reg [ADC_WIDTH-1:0]   adc_tx_data,
    output reg [3:0]             dvga_ch_sel,
    output reg                   dvga_tx_en,
    output reg [DVGA_WIDTH-1:0]  dvga_tx_data
  );

always @(posedge clk or negedge rst_n) begin
   if (!rst_n) begin
      cd4094_tx_en    <= 1'b0;
      cd4094_tx_data  <= {SHIFT_WIDTH{1'b0}};
      dac_ch_sel      <= 5'h00;
      dac_tx_en       <= 1'b0;
      dac_tx_data     <= {DAC_WIDTH{1'b0}};
      adc_tx_en       <= 1'b0;
      adc_ch_sel      <= 2'b00;
      adc_tx_data     <= {ADC_WIDTH{1'b0}};
      dvga_ch_sel     <= 4'h0;
      dvga_tx_en      <= 1'b0;
      dvga_tx_data    <= {DVGA_WIDTH{1'b0}};
   end
   else begin
      cd4094_tx_en    <= cd4094_send_en;
      cd4094_tx_data  <= cd4094_send_data;
      dac_tx_en       <= dac_send_en;
      dac_ch_sel      <= dac_send_sel;
      dac_tx_data     <= dac_send_data;
      adc_tx_en       <= adc_send_en;
      adc_ch_sel      <= adc_send_sel;
      adc_tx_data     <= adc_send_data;
      dvga_tx_en      <= dvga_send_en;
      dvga_ch_sel     <= dvga_send_sel;
      dvga_tx_data    <= dvga_send_data;
   end
end

endmodule
