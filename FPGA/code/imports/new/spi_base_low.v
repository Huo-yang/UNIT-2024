module spi_base_low
  #(parameter TX_WIDTH  = 32,       // data width
    parameter DIV_PAR   = 100,      // spi clk divide param
    parameter CAP_EDGE  = "RISE",   // "RISE" "FALL" 
    parameter TX_MODE   = "MSB")    // "MSB" "LSB"
  (
    // clk and reset 1 fast 2 low
    input                      clk,
    input                      rst_n,
    // Local
    input                      spi_tx_en,
    input       [TX_WIDTH-1:0] spi_tx_data,
    // SPI
    output reg                 spi_sclk_pose,
    output reg                 spi_sclk_nege,
    output reg                 spi_csn,
    output reg                 spi_sdata,
    output reg                 spi_strobe,
    output                     spi_busy
  );

parameter IDLE      = 3'b001,
          TX_ING    = 3'b010,
          TX_STROBE = 3'b100;

reg  [2:0]          c_state;
reg  [2:0]          n_state;

reg                 spi_tx_en_dly;
wire                spi_tx_en_pose;
reg  [TX_WIDTH-1:0] spi_frame_data;
reg  [7:0]          tx_bit_cnt;
reg  [15:0]         shift_cnt;
wire                shift_plus;

wire                tx_out_en;

reg  [7:0]          strobe_bit_cnt;

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      spi_tx_en_dly <= 1'b0;
   else
      spi_tx_en_dly <= spi_tx_en;
end

assign spi_tx_en_pose = !spi_tx_en_dly & spi_tx_en;

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      spi_frame_data <= {TX_WIDTH{1'b0}};
   else if (c_state == IDLE && spi_tx_en_pose)
      spi_frame_data <= spi_tx_data;
   else if (c_state == TX_STROBE)
      spi_frame_data <= {TX_WIDTH{1'b0}};
   else
      spi_frame_data <= spi_frame_data;
end

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      c_state <= IDLE;
   else
      c_state <= n_state;
end

always @( * ) begin
   case (c_state)
      IDLE      : if (spi_tx_en_pose)
                     n_state = TX_ING;
                  else
                     n_state = IDLE;

      TX_ING    : if (shift_plus && (tx_bit_cnt == ((TX_MODE == "MSB") ? 0 : TX_WIDTH+1)))
                     n_state = TX_STROBE;
                  else
                     n_state = TX_ING;

      TX_STROBE : if (strobe_bit_cnt == 8'd3)
                     n_state = IDLE;
                  else
                     n_state = TX_STROBE;

     default    : n_state = IDLE;

   endcase
end

assign spi_busy = (c_state == IDLE) ? 1'b0 : 1'b1;

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      shift_cnt <= 16'h0;
   else if ((c_state == TX_ING) || (c_state == TX_STROBE)) begin
      if (shift_cnt == (DIV_PAR-1'b1))
         shift_cnt <= 16'h0;
      else
         shift_cnt <= shift_cnt + 1'b1;
   end
   else
      shift_cnt <= 16'h0;
end

assign shift_plus = (shift_cnt == (DIV_PAR-1'b1)) ? 1'b1 : 1'b0;

// tx data p-2-s
generate
   if (TX_MODE == "MSB") begin

      always @(posedge clk or negedge rst_n) begin
         if (!rst_n)
            tx_bit_cnt <= 8'h0;
         else if (c_state == IDLE && spi_tx_en_pose)
            tx_bit_cnt <= TX_WIDTH+1'b1;
         else if (c_state == TX_ING) begin
            if (shift_plus)
               tx_bit_cnt <= tx_bit_cnt - 1'b1;
            else
               tx_bit_cnt <= tx_bit_cnt;
         end
         else
            tx_bit_cnt <= 8'h0;
      end

   end

   else begin

      always @(posedge clk or negedge rst_n) begin
         if (!rst_n)
            tx_bit_cnt <= 8'h0;
         else if (c_state == IDLE && spi_tx_en_pose)
            tx_bit_cnt <= 8'h0;
         else if (c_state == TX_ING) begin
            if (shift_plus)
               tx_bit_cnt <= tx_bit_cnt + 1'b1;
            else
               tx_bit_cnt <= tx_bit_cnt;
         end
         else
            tx_bit_cnt <= 8'h0;
      end

   end
endgenerate

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      strobe_bit_cnt <= 8'h0;
   else if (c_state == TX_STROBE) begin
      if (shift_plus)
          strobe_bit_cnt <= strobe_bit_cnt + 1'b1;
      else
          strobe_bit_cnt <= strobe_bit_cnt;
   end
   else
      strobe_bit_cnt <= 8'h0;
end

assign tx_out_en  = (tx_bit_cnt > 8'h0) && ((tx_bit_cnt < TX_WIDTH+1)) ? 1'b1 : 1'b0;

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      spi_csn <= 1'b1;
   else if (c_state == TX_ING)
      spi_csn <= 1'b0;
   else
      spi_csn <= 1'b1;
end

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      spi_strobe <= 1'b0;
   else if (c_state == TX_STROBE)
      spi_strobe <= 1'b1;
   else
      spi_strobe <= 1'b0;
end

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      spi_sdata <= 1'b0;
   else if (tx_out_en)
      spi_sdata <= spi_frame_data[tx_bit_cnt-1'b1];
   else
      spi_sdata <= 1'b0;
end

always @(posedge clk or negedge rst_n) begin
   if (!rst_n) begin
      spi_sclk_pose <= 1'b0;
      spi_sclk_nege <= 1'b0;
   end
   else if (tx_out_en) begin
      spi_sclk_pose <= (shift_cnt > ((DIV_PAR-1)/2));
      spi_sclk_nege <= (shift_cnt <= ((DIV_PAR-1)/2));
   end
   else begin
      spi_sclk_pose <= 1'b0;
      spi_sclk_nege <= 1'b0;
   end
end

endmodule
