/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module alu_manual_5 (
    input clk,
    input rst,
    input [1:0] button,
    input [5:0] alufn,
    input [15:0] in,
    input lsb,
    output reg [15:0] out,
    output reg [7:0] outDisplay,
    output reg z,
    output reg v,
    output reg n
  );
  
  
  
  reg [15:0] M_regA_d, M_regA_q = 1'h0;
  reg [15:0] M_regB_d, M_regB_q = 1'h0;
  reg [15:0] M_result_d, M_result_q = 1'h0;
  reg [7:0] M_display_d, M_display_q = 1'h0;
  reg M_zout_d, M_zout_q = 1'h0;
  reg M_vout_d, M_vout_q = 1'h0;
  reg M_nout_d, M_nout_q = 1'h0;
  localparam A_inputSelector = 2'd0;
  localparam B_inputSelector = 2'd1;
  localparam ANS_inputSelector = 2'd2;
  
  reg [1:0] M_inputSelector_d, M_inputSelector_q = A_inputSelector;
  
  wire [16-1:0] M_aluunit_out;
  wire [1-1:0] M_aluunit_z;
  wire [1-1:0] M_aluunit_v;
  wire [1-1:0] M_aluunit_n;
  reg [16-1:0] M_aluunit_a;
  reg [16-1:0] M_aluunit_b;
  reg [6-1:0] M_aluunit_alufn;
  reg [1-1:0] M_aluunit_lsb;
  alu_9 aluunit (
    .clk(clk),
    .a(M_aluunit_a),
    .b(M_aluunit_b),
    .alufn(M_aluunit_alufn),
    .lsb(M_aluunit_lsb),
    .out(M_aluunit_out),
    .z(M_aluunit_z),
    .v(M_aluunit_v),
    .n(M_aluunit_n)
  );
  
  always @* begin
    M_inputSelector_d = M_inputSelector_q;
    M_result_d = M_result_q;
    M_nout_d = M_nout_q;
    M_display_d = M_display_q;
    M_regA_d = M_regA_q;
    M_regB_d = M_regB_q;
    M_zout_d = M_zout_q;
    M_vout_d = M_vout_q;
    
    M_aluunit_a = M_regA_q;
    M_aluunit_b = M_regB_q;
    M_aluunit_lsb = lsb;
    M_aluunit_alufn = alufn;
    
    case (M_inputSelector_q)
      A_inputSelector: begin
        M_display_d = 8'h88;
        if (button[1+0-:1]) begin
          M_regA_d = in;
          M_inputSelector_d = B_inputSelector;
        end else begin
          M_inputSelector_d = A_inputSelector;
        end
      end
      B_inputSelector: begin
        M_display_d = 8'h83;
        if (button[1+0-:1]) begin
          M_regB_d = in;
          M_inputSelector_d = ANS_inputSelector;
        end else begin
          M_inputSelector_d = B_inputSelector;
        end
      end
      ANS_inputSelector: begin
        M_display_d = 8'hc0;
        M_result_d = M_aluunit_out;
        M_zout_d = M_aluunit_z;
        M_vout_d = M_aluunit_v;
        M_nout_d = M_aluunit_n;
        if (button[1+0-:1]) begin
          M_regA_d = 1'h0;
          M_regB_d = 1'h0;
          M_result_d = 1'h0;
          M_zout_d = 1'h0;
          M_vout_d = 1'h0;
          M_nout_d = 1'h0;
          M_inputSelector_d = A_inputSelector;
        end else begin
          M_inputSelector_d = ANS_inputSelector;
        end
      end
    endcase
    if (button[0+0-:1]) begin
      M_regA_d = 1'h0;
      M_regB_d = 1'h0;
      M_result_d = 1'h0;
      M_inputSelector_d = A_inputSelector;
    end
    z = M_zout_q;
    v = M_vout_q;
    n = M_nout_q;
    out = M_result_q;
    outDisplay = M_display_q;
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_regA_q <= 1'h0;
      M_regB_q <= 1'h0;
      M_result_q <= 1'h0;
      M_display_q <= 1'h0;
      M_zout_q <= 1'h0;
      M_vout_q <= 1'h0;
      M_nout_q <= 1'h0;
      M_inputSelector_q <= 1'h0;
    end else begin
      M_regA_q <= M_regA_d;
      M_regB_q <= M_regB_d;
      M_result_q <= M_result_d;
      M_display_q <= M_display_d;
      M_zout_q <= M_zout_d;
      M_vout_q <= M_vout_d;
      M_nout_q <= M_nout_d;
      M_inputSelector_q <= M_inputSelector_d;
    end
  end
  
endmodule
