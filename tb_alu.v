`timescale 1ns / 1ps
module tb_alu;

  // Inputs

  reg  [ 3:0] ALU_control;
  reg  [31:0] in_A;
  reg  [31:0] in_B;

  // Outputs
  wire [31:0] out;

  // Instantiation

  alu my_alu (
      .ALU_control(ALU_control),
      .in_A(in_A),
      .in_B(in_B),
      .out(out)
  );

  // No clock

  //Testbench

  initial begin
    ALU_control = 0;
    in_A = 32'd0;
    in_B = 32'd0;

    $monitor("TIME: %d | ALU_control = %d | in_A = %d | in_B = %d | out = %d ", $time, ALU_control,
             in_A, in_B, out);

    #10 ALU_control = 4'd0;
    in_A = 32'd254;
    in_B = 32'd129;
    #10 ALU_control = 4'd1;
    #10 ALU_control = 4'd2;
    #10 ALU_control = 4'd3;
    #10 ALU_control = 4'd4;
    #10 ALU_control = 4'd5;
    #10 ALU_control = 4'd6;
    #10 ALU_control = 4'd7;
    #10 $finish;
  end
endmodule
