/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module initialise_2 (
    input clk,
    input rst,
    output reg [7:0] led,
    input usb_rx,
    output reg usb_tx,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  wire [(3'h5+0)-1:0] M_buttoncond_out;
  reg [(3'h5+0)-1:0] M_buttoncond_in;
  
  genvar GEN_buttoncond0;
  generate
  for (GEN_buttoncond0=0;GEN_buttoncond0<3'h5;GEN_buttoncond0=GEN_buttoncond0+1) begin: buttoncond_gen_0
    button_conditioner_3 buttoncond (
      .clk(clk),
      .in(M_buttoncond_in[GEN_buttoncond0*(1)+(1)-1-:(1)]),
      .out(M_buttoncond_out[GEN_buttoncond0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  wire [(3'h5+0)-1:0] M_buttondetector_out;
  reg [(3'h5+0)-1:0] M_buttondetector_in;
  
  genvar GEN_buttondetector0;
  generate
  for (GEN_buttondetector0=0;GEN_buttondetector0<3'h5;GEN_buttondetector0=GEN_buttondetector0+1) begin: buttondetector_gen_0
    edge_detector_4 buttondetector (
      .clk(clk),
      .in(M_buttondetector_in[GEN_buttondetector0*(1)+(1)-1-:(1)]),
      .out(M_buttondetector_out[GEN_buttondetector0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  wire [16-1:0] M_aluunitM_out;
  wire [8-1:0] M_aluunitM_outDisplay;
  wire [1-1:0] M_aluunitM_z;
  wire [1-1:0] M_aluunitM_v;
  wire [1-1:0] M_aluunitM_n;
  reg [2-1:0] M_aluunitM_button;
  reg [6-1:0] M_aluunitM_alufn;
  reg [16-1:0] M_aluunitM_in;
  reg [1-1:0] M_aluunitM_lsb;
  alu_manual_5 aluunitM (
    .clk(clk),
    .rst(rst),
    .button(M_aluunitM_button),
    .alufn(M_aluunitM_alufn),
    .in(M_aluunitM_in),
    .lsb(M_aluunitM_lsb),
    .out(M_aluunitM_out),
    .outDisplay(M_aluunitM_outDisplay),
    .z(M_aluunitM_z),
    .v(M_aluunitM_v),
    .n(M_aluunitM_n)
  );
  wire [3-1:0] M_autoTest_test_state;
  wire [2-1:0] M_autoTest_current_state;
  reg [3-1:0] M_autoTest_button;
  reg [1-1:0] M_autoTest_lsb;
  tester_6 autoTest (
    .clk(clk),
    .rst(rst),
    .button(M_autoTest_button),
    .lsb(M_autoTest_lsb),
    .test_state(M_autoTest_test_state),
    .current_state(M_autoTest_current_state)
  );
  wire [7-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [16-1:0] M_seg_values;
  multi_seven_seg_7 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  localparam MANUAL_modeSelector = 1'd0;
  localparam AUTO_modeSelector = 1'd1;
  
  reg M_modeSelector_d, M_modeSelector_q = MANUAL_modeSelector;
  
  always @* begin
    M_modeSelector_d = M_modeSelector_q;
    
    led = 8'h00;
    usb_tx = usb_rx;
    io_led = 24'h000000;
    io_seg = 8'hff;
    io_sel = 4'hf;
    M_buttoncond_in = io_button;
    M_buttondetector_in = M_buttoncond_out;
    M_seg_values = 16'hffff;
    M_aluunitM_button = M_buttondetector_out[1+1-:2];
    M_aluunitM_alufn = io_dip[16+0+5-:6];
    M_aluunitM_in[8+7-:8] = io_dip[8+7-:8];
    M_aluunitM_in[0+7-:8] = io_dip[0+7-:8];
    M_aluunitM_lsb = io_dip[16+6+0-:1];
    M_autoTest_button[0+1-:2] = M_buttondetector_out[3+1-:2];
    M_autoTest_button[2+0-:1] = M_buttondetector_out[1+0-:1];
    M_autoTest_lsb = io_dip[16+6+0-:1];
    
    case (M_modeSelector_q)
      MANUAL_modeSelector: begin
        io_led[0+7-:8] = M_aluunitM_out[0+7-:8];
        io_led[8+7-:8] = M_aluunitM_out[8+7-:8];
        io_led[16+0+0-:1] = M_aluunitM_z;
        io_led[16+1+0-:1] = M_aluunitM_v;
        io_led[16+2+0-:1] = M_aluunitM_n;
        io_seg = M_aluunitM_outDisplay;
        io_sel = 4'he;
        if (M_buttondetector_out[0+0-:1]) begin
          M_modeSelector_d = AUTO_modeSelector;
        end
      end
      AUTO_modeSelector: begin
        
        case (M_autoTest_test_state)
          1'h0: begin
            M_seg_values[4+11-:12] = 12'h000;
          end
          1'h1: begin
            M_seg_values[4+11-:12] = 12'h001;
          end
          2'h2: begin
            M_seg_values[4+11-:12] = 12'h002;
          end
          2'h3: begin
            M_seg_values[4+11-:12] = 12'h003;
          end
          3'h4: begin
            M_seg_values[4+11-:12] = 12'h004;
          end
          3'h5: begin
            M_seg_values[4+11-:12] = 12'h005;
          end
          3'h6: begin
            M_seg_values[4+11-:12] = 12'h006;
          end
        endcase
        
        case (M_autoTest_current_state)
          2'h0: begin
            M_seg_values[0+3-:4] = 4'h0;
          end
          2'h1: begin
            M_seg_values[0+3-:4] = 4'h8;
          end
          2'h2: begin
            M_seg_values[0+3-:4] = 4'h7;
          end
          2'h3: begin
            M_seg_values[0+3-:4] = 4'h3;
          end
          default: begin
            M_seg_values[0+3-:4] = 4'h1;
          end
        endcase
        io_seg = ~M_seg_seg;
        io_sel = ~M_seg_sel;
        if (M_buttondetector_out[0+0-:1]) begin
          M_modeSelector_d = MANUAL_modeSelector;
        end
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_modeSelector_q <= 1'h0;
    end else begin
      M_modeSelector_q <= M_modeSelector_d;
    end
  end
  
endmodule
