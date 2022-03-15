/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module alu_9 (
    input clk,
    input [15:0] a,
    input [15:0] b,
    input [5:0] alufn,
    input lsb,
    output reg [15:0] out,
    output reg z,
    output reg v,
    output reg n
  );
  
  
  
  wire [16-1:0] M_shiftmod_out;
  reg [16-1:0] M_shiftmod_a;
  reg [4-1:0] M_shiftmod_b;
  reg [6-1:0] M_shiftmod_alufn;
  shifter_19 shiftmod (
    .a(M_shiftmod_a),
    .b(M_shiftmod_b),
    .alufn(M_shiftmod_alufn),
    .out(M_shiftmod_out)
  );
  
  wire [16-1:0] M_addermod_out;
  wire [1-1:0] M_addermod_z;
  wire [1-1:0] M_addermod_v;
  wire [1-1:0] M_addermod_n;
  reg [16-1:0] M_addermod_a;
  reg [16-1:0] M_addermod_b;
  reg [1-1:0] M_addermod_alufn;
  adder_20 addermod (
    .a(M_addermod_a),
    .b(M_addermod_b),
    .alufn(M_addermod_alufn),
    .out(M_addermod_out),
    .z(M_addermod_z),
    .v(M_addermod_v),
    .n(M_addermod_n)
  );
  
  wire [16-1:0] M_booleanmod_out;
  reg [16-1:0] M_booleanmod_a;
  reg [16-1:0] M_booleanmod_b;
  reg [6-1:0] M_booleanmod_alufn;
  boolean_21 booleanmod (
    .a(M_booleanmod_a),
    .b(M_booleanmod_b),
    .alufn(M_booleanmod_alufn),
    .out(M_booleanmod_out)
  );
  
  wire [16-1:0] M_comparemod_out;
  reg [1-1:0] M_comparemod_z;
  reg [1-1:0] M_comparemod_v;
  reg [1-1:0] M_comparemod_n;
  reg [6-1:0] M_comparemod_alufn;
  compare_22 comparemod (
    .z(M_comparemod_z),
    .v(M_comparemod_v),
    .n(M_comparemod_n),
    .alufn(M_comparemod_alufn),
    .out(M_comparemod_out)
  );
  
  wire [16-1:0] M_multipliermod_out;
  reg [16-1:0] M_multipliermod_a;
  reg [16-1:0] M_multipliermod_b;
  multiplier_23 multipliermod (
    .a(M_multipliermod_a),
    .b(M_multipliermod_b),
    .out(M_multipliermod_out)
  );
  
  wire [16-1:0] M_modulomod_out;
  reg [16-1:0] M_modulomod_a;
  reg [16-1:0] M_modulomod_b;
  modulo_24 modulomod (
    .a(M_modulomod_a),
    .b(M_modulomod_b),
    .out(M_modulomod_out)
  );
  
  reg z1;
  reg v1;
  reg n1;
  reg [15:0] k;
  reg [15:0] r;
  reg [15:0] l;
  
  always @* begin
    M_addermod_a = a;
    M_addermod_b = b;
    M_addermod_alufn = alufn[0+0-:1];
    z1 = M_addermod_z;
    v1 = M_addermod_v;
    n1 = M_addermod_n;
    z = z1;
    v = v1;
    n = n1;
    M_comparemod_alufn = alufn;
    M_comparemod_z = z1;
    M_comparemod_v = v1;
    M_comparemod_n = n1;
    M_booleanmod_alufn = alufn;
    M_booleanmod_a = a;
    M_booleanmod_b = b;
    M_shiftmod_a = a;
    M_shiftmod_b = b[0+3-:4];
    M_shiftmod_alufn = alufn;
    M_multipliermod_a = a;
    M_multipliermod_b = b;
    M_modulomod_a = a;
    M_modulomod_b = b;
    r = 16'h0000;
    
    case (alufn[1+1-:2])
      default: begin
        k = 16'h0000;
      end
      2'h0: begin
        k = M_addermod_out;
      end
      2'h1: begin
        k = M_multipliermod_out;
      end
      2'h2: begin
        k = M_modulomod_out;
      end
      2'h3: begin
        k = r;
      end
    endcase
    
    case (alufn[4+1-:2])
      default: begin
        l = 16'h0000;
      end
      2'h0: begin
        l = k;
      end
      2'h1: begin
        l = M_booleanmod_out;
      end
      2'h2: begin
        l = M_shiftmod_out;
      end
      2'h3: begin
        l = M_comparemod_out;
      end
    endcase
    if (lsb == 1'h1) begin
      l[0+0-:1] = ~l[0+0-:1];
    end
    out = l;
  end
endmodule
