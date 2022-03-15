/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module adderTester_13 (
    input clk,
    input rst,
    input start,
    input lsb,
    output reg [1:0] status
  );
  
  
  
  wire [1-1:0] M_slowclock_value;
  counter_25 slowclock (
    .clk(clk),
    .rst(rst),
    .value(M_slowclock_value)
  );
  
  reg [3:0] M_register_d, M_register_q = 1'h0;
  
  
  localparam IDLE_state = 2'd0;
  localparam TESTING_state = 2'd1;
  localparam PASS_state = 2'd2;
  localparam FAIL_state = 2'd3;
  
  reg [1:0] M_state_d, M_state_q = IDLE_state;
  
  wire [16-1:0] M_alu_out;
  wire [1-1:0] M_alu_z;
  wire [1-1:0] M_alu_v;
  wire [1-1:0] M_alu_n;
  reg [16-1:0] M_alu_a;
  reg [16-1:0] M_alu_b;
  reg [6-1:0] M_alu_alufn;
  reg [1-1:0] M_alu_lsb;
  alu_9 alu (
    .clk(M_slowclock_value),
    .a(M_alu_a),
    .b(M_alu_b),
    .alufn(M_alu_alufn),
    .lsb(M_alu_lsb),
    .out(M_alu_out),
    .z(M_alu_z),
    .v(M_alu_v),
    .n(M_alu_n)
  );
  
  always @* begin
    M_state_d = M_state_q;
    M_register_d = M_register_q;
    
    status = 1'h0;
    M_alu_lsb = lsb;
    M_alu_a = 1'h0;
    M_alu_b = 1'h0;
    M_alu_alufn = 6'h00;
    if (start == 1'h0) begin
      M_state_d = IDLE_state;
    end
    
    case (M_state_q)
      IDLE_state: begin
        status = 1'h0;
        if (start == 1'h1) begin
          M_state_d = TESTING_state;
        end
      end
      TESTING_state: begin
        
        case (M_register_q)
          4'h0: begin
            M_alu_a = 16'h0000;
            M_alu_b = 16'h0000;
            M_alu_alufn = 6'h00;
            if (M_alu_out != 16'h0000 | M_alu_z != 1'h1 | M_alu_v != 1'h0 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h1: begin
            M_alu_a = 16'h000a;
            M_alu_b = 16'h000a;
            M_alu_alufn = 6'h00;
            if (M_alu_out != 16'h0014 | M_alu_z != 1'h0 | M_alu_v != 1'h0 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h2: begin
            M_alu_a = 16'h000a;
            M_alu_b = 16'hfff6;
            M_alu_alufn = 6'h00;
            if (M_alu_out != 16'h0000 | M_alu_z != 1'h1 | M_alu_v != 1'h0 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h3: begin
            M_alu_a = 16'hfff6;
            M_alu_b = 16'hfff4;
            M_alu_alufn = 6'h00;
            if (M_alu_out != 16'hffea | M_alu_z != 1'h0 | M_alu_v != 1'h0 | M_alu_n != 1'h1) begin
              M_state_d = FAIL_state;
            end
          end
          4'h4: begin
            M_alu_a = 16'h8001;
            M_alu_b = 16'h8001;
            M_alu_alufn = 6'h00;
            if (M_alu_out != 16'h0002 | M_alu_z != 1'h0 | M_alu_v != 1'h1 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h5: begin
            M_alu_a = 16'h7fff;
            M_alu_b = 16'h7fff;
            M_alu_alufn = 6'h00;
            if (M_alu_out != 16'hfffe | M_alu_z != 1'h0 | M_alu_v != 1'h1 | M_alu_n != 1'h1) begin
              M_state_d = FAIL_state;
            end
          end
          4'h5: begin
            M_alu_a = 16'h0000;
            M_alu_b = 16'h0000;
            M_alu_alufn = 6'h01;
            if (M_alu_out != 16'h0000 | M_alu_z != 1'h1 | M_alu_v != 1'h0 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h6: begin
            M_alu_a = 16'h000a;
            M_alu_b = 16'hfff6;
            M_alu_alufn = 6'h01;
            if (M_alu_out != 16'h0014 | M_alu_z != 1'h0 | M_alu_v != 1'h0 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h7: begin
            M_alu_a = 16'h000a;
            M_alu_b = 16'h000a;
            M_alu_alufn = 6'h01;
            if (M_alu_out != 16'h0000 | M_alu_z != 1'h1 | M_alu_v != 1'h0 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'h8: begin
            M_alu_a = 16'hfff6;
            M_alu_b = 16'h000c;
            M_alu_alufn = 6'h01;
            if (M_alu_out != 16'hffea | M_alu_z != 1'h0 | M_alu_v != 1'h0 | M_alu_n != 1'h1) begin
              M_state_d = FAIL_state;
            end
          end
          4'h9: begin
            M_alu_a = 16'h8001;
            M_alu_b = 16'h7fff;
            M_alu_alufn = 6'h01;
            if (M_alu_out != 16'h0002 | M_alu_z != 1'h0 | M_alu_v != 1'h1 | M_alu_n != 1'h0) begin
              M_state_d = FAIL_state;
            end
          end
          4'ha: begin
            M_alu_a = 16'h7fff;
            M_alu_b = 16'h8001;
            M_alu_alufn = 6'h01;
            if (M_alu_out != 16'hfffe | M_alu_z != 1'h0 | M_alu_v != 1'h1 | M_alu_n != 1'h1) begin
              M_state_d = FAIL_state;
            end
          end
          4'hb: begin
            M_state_d = PASS_state;
          end
        endcase
      end
      PASS_state: begin
        status = 1'h1;
      end
      FAIL_state: begin
        status = 2'h2;
      end
    endcase
    M_register_d = M_register_q + 1'h1;
  end
  
  always @(posedge M_slowclock_value) begin
    if (rst == 1'b1) begin
      M_register_q <= 1'h0;
    end else begin
      M_register_q <= M_register_d;
    end
  end
  
  
  always @(posedge M_slowclock_value) begin
    if (rst == 1'b1) begin
      M_state_q <= 1'h0;
    end else begin
      M_state_q <= M_state_d;
    end
  end
  
endmodule
