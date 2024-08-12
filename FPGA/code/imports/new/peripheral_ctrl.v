module peripheral_ctrl
  #(parameter SHIFT_WIDTH = 40,
    parameter DAC_WIDTH   = 24,
    parameter ADC_WIDTH   = 32,
    parameter DVGA_WIDTH  = 24)
  (
    input                       clk,
    input                       rst_n,
    // local bus
    input                       cd4094_send_en,
    input     [SHIFT_WIDTH-1:0] cd4094_send_data,
    input                       dac_send_en,
    input     [4:0]             dac_send_sel,
    input     [DAC_WIDTH-1:0]   dac_send_data,
    input                       adc_send_en,
    input     [1:0]             adc_send_sel,
    input     [ADC_WIDTH-1:0]   adc_send_data,
    input                       dvga_send_en,
    input     [3:0]             dvga_send_sel,
    input     [DVGA_WIDTH-1:0]  dvga_send_data,
    // ADF4360
    input                       pll_fpga_muxout,
    // CD4094
    output                      cd4094_clk,
    output                      cd4094_data,
    output                      cd4094_cs,
    // DAC
    output                      dac_clk,
    output                      dac_din,
    output     [3:0]            dac_cs,
    // DVGA
    output                      dvga_sclk,
    output                      dvga_data,
    output     [3:0]            dvga_cs,
    //
    output                      adc0_sclk,
    output                      adc0_cs,
    output                      adc0_sdata,
    output                      adc1_sclk,
    output                      adc1_cs,
    output                      adc1_sdata,
    //
    output reg                  pll_init_done
  );

wire                   cd4094_tx_en;
wire [SHIFT_WIDTH-1:0] cd4094_tx_data;

wire                   dac_tx_en;
wire [4:0]             dac_ch_sel;
wire [DAC_WIDTH-1:0]   dac_tx_data;

wire                   dvga_tx_en;
wire [3:0]             dvga_ch_sel;
wire [DVGA_WIDTH-1:0]  dvga_tx_data;
wire                   adc_tx_en;
wire [1:0]             adc_ch_sel;
wire [ADC_WIDTH-1:0]   adc_tx_data;

wire                   dac_clk_tmp;
wire                   pll_clk_tmp;
wire                   dac_din_tmp;
wire                   pll_din_tmp;
wire                   dac_cs_tmp;
wire                   pll_cs_tmp;
wire                   dvga_cs_tmp;

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      pll_init_done <= 1'b0;
   else
      pll_init_done <= pll_fpga_muxout;
end

main_ctrl #(.DAC_WIDTH   (DAC_WIDTH),
            .DVGA_WIDTH  (DVGA_WIDTH),
            .SHIFT_WIDTH (SHIFT_WIDTH))
  main_ctrl
  (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .cd4094_send_en          (cd4094_send_en),
    .cd4094_send_data        (cd4094_send_data),
    .dac_send_en             (dac_send_en),
    .dac_send_sel            (dac_send_sel),
    .dac_send_data           (dac_send_data),
    .adc_send_en             (adc_send_en),
    .adc_send_sel            (adc_send_sel),
    .adc_send_data           (adc_send_data),
    .dvga_send_en            (dvga_send_en),
    .dvga_send_sel           (dvga_send_sel),
    .dvga_send_data          (dvga_send_data),
    .cd4094_tx_en            (cd4094_tx_en),
    .cd4094_tx_data          (cd4094_tx_data),
    .dac_tx_en               (dac_tx_en),
    .dac_ch_sel              (dac_ch_sel),
    .dac_tx_data             (dac_tx_data),
    .adc_tx_en               (adc_tx_en),
    .adc_ch_sel              (adc_ch_sel),
    .adc_tx_data             (adc_tx_data),
    .dvga_tx_en              (dvga_tx_en),
    .dvga_ch_sel             (dvga_ch_sel),
    .dvga_tx_data            (dvga_tx_data)
  );

spi_base_low #(.TX_WIDTH (40),
               .DIV_PAR  (100), //clk 的分频时钟倍数作为发送时钟
               .CAP_EDGE ("RISE"),
               .TX_MODE  ("MSB"))
  spi_cd4094
  (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .spi_tx_en               (cd4094_tx_en),
    .spi_tx_data             (cd4094_tx_data),
    .spi_sclk_pose           (cd4094_clk),
    .spi_sclk_nege           (),
    .spi_csn                 (cd4094_cs),
    .spi_sdata               (cd4094_data),
    .spi_strobe              ()
  );

spi_base_low #(.TX_WIDTH (16),
               .DIV_PAR  (25),//clk 的分频时钟倍数作为发送时钟
               .CAP_EDGE ("FALL"),
               .TX_MODE  ("MSB"))
  spi_dac_16b
  (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .spi_tx_en               (dac_tx_en),
    .spi_tx_data             (dac_tx_data[15:0]),
    .spi_sclk_pose           (),
    .spi_sclk_nege           (dac_clk_tmp_16b),
    .spi_csn                 (dac_cs_tmp_16b),
    .spi_sdata               (dac_din_tmp_16b),
    .spi_strobe              ()
  );

//***************************************************  
spi_base_low #(.TX_WIDTH (24),
               .DIV_PAR  (25),//clk 的分频时钟倍数作为发送时钟
               .CAP_EDGE ("FALL"),
               .TX_MODE  ("MSB"))
  spi_dac_24b
  (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .spi_tx_en               (dac_tx_en),
    .spi_tx_data             (dac_tx_data[23:0]),
    .spi_sclk_pose           (dac_clk_tmp_24b),
    .spi_sclk_nege           (),
    .spi_csn                 (dac_cs_tmp_24b),
    .spi_sdata               (dac_din_tmp_24b),
    .spi_strobe              ()
  );  
  
//****************************************************
  
// spi_base_low #(.TX_WIDTH (24),
               // .DIV_PAR  (100),
               // .CAP_EDGE ("RISE"),
               // .TX_MODE  ("MSB"))
  // spi_pll
  // (
    // .clk                     (clk),
    // .rst_n                   (rst_n),
    // .spi_tx_en               (dac_tx_en),
    // .spi_tx_data             (dac_tx_data[23:0]),
    // .spi_sclk_pose           (pll_clk_tmp),
    // .spi_sclk_nege           (),
    // .spi_csn                 (pll_cs_tmp),
    // .spi_sdata               (pll_din_tmp),
    // .spi_strobe              ()
  // );

spi_base_low #(.TX_WIDTH (24),
               .DIV_PAR  (100),
               .CAP_EDGE ("RISE"),
               .TX_MODE  ("MSB"))
  spi_ch_dvga
  (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .spi_tx_en               (dvga_tx_en),
    .spi_tx_data             (dvga_tx_data),
    .spi_sclk_pose           (dvga_sclk),
    .spi_sclk_nege           (),
    .spi_csn                 (dvga_cs_tmp),
    .spi_sdata               (dvga_data),
    .spi_strobe              (),
    .spi_busy                ()
  );

spi_base_low #(.TX_WIDTH(32),
               .DIV_PAR(25),
               .TX_MODE("MSB"))
  adc_ctrl_send
  (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .spi_tx_en               (adc_tx_en),
    .spi_tx_data             (adc_tx_data),
    .spi_csn                 (adc_cs),
    .spi_sdata               (adc_sdata),
    .spi_sclk_pose           (adc_sclk),
    .spi_sclk_nege           (),
    .spi_strobe              (),
    .spi_busy                ()
  );



clk_div #( .CLK_DIV(100))    clk_ref_freq0    (.clk_in(clk),  .clk_out(ref_freq0) );


parrel_to_serial #(          
                    .BIT_NUM                   (24)
                        )
ins_spi_24b     (
                   //input                 
                    .clk                       (clk), 
                    .ref_freq                  (ref_freq0), 
                    .da_start                  (dac_tx_en), 
                    .da_data                   (dac_tx_data[23:0]),
                    
                   //output                                                                     
                    .da_cs                     (pll_cs_tmp), 
                    .da_din                    (pll_din_tmp), 
                    .da_clk                    (pll_clk_tmp)
                    );

// ch mux sel


assign dac_clk     = dac_ch_sel[3] ? pll_clk_tmp :  (dac_ch_sel[4] ? dac_clk_tmp_24b : dac_clk_tmp_16b )  ;
assign dac_din     = dac_ch_sel[3] ? pll_din_tmp :  (dac_ch_sel[4] ? dac_din_tmp_24b : dac_din_tmp_16b )  ;
                                                    
assign dac_cs[0]   = dac_ch_sel[0] ? (dac_ch_sel[4] ? dac_cs_tmp_24b : dac_cs_tmp_16b) : 1'b1;
assign dac_cs[1]   = dac_ch_sel[1] ? (dac_ch_sel[4] ? dac_cs_tmp_24b : dac_cs_tmp_16b) : 1'b1;
assign dac_cs[2]   = dac_ch_sel[2] ? (dac_ch_sel[4] ? dac_cs_tmp_24b : dac_cs_tmp_16b) : 1'b1;



assign dac_cs[3]   = dac_ch_sel[3] ? pll_cs_tmp     : 1'b1;

assign dvga_cs[0] = dvga_ch_sel[0] ? dvga_cs_tmp : 1'b1;
assign dvga_cs[1] = dvga_ch_sel[1] ? dvga_cs_tmp : 1'b1;
assign dvga_cs[2] = dvga_ch_sel[2] ? dvga_cs_tmp : 1'b1;
assign dvga_cs[3] = dvga_ch_sel[3] ? dvga_cs_tmp : 1'b1;

assign adc0_cs    = adc_ch_sel[0] ? adc_cs : 1'b1;
assign adc1_cs    = adc_ch_sel[1] ? adc_cs : 1'b1;

assign adc0_sclk  = adc_ch_sel[0] ? adc_sclk : 1'b0;
assign adc1_sclk  = adc_ch_sel[1] ? adc_sclk : 1'b0;

assign adc0_sdata = adc_ch_sel[0] ? adc_sdata : 1'b0;
assign adc1_sdata = adc_ch_sel[1] ? adc_sdata : 1'b0;

endmodule

