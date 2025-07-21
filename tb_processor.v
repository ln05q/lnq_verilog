`timescale 1ns / 1ns
module tb_processor;
  // Inputs
  reg clk;
  reg [31:0] instruction;

  // Outputs
  wire [31:0] RD1;
  wire [31:0] RD2;
  wire [31:0] RD;
  wire [31:0] ALU_RESULT;

  // Instantiation
  processor pr (
      .clk(clk),
      .instruction(instruction),
      .RD1(RD1),
      .RD2(RD2),
      .RD(RD),
      .ALU_RESULT(ALU_RESULT)
  );

  // Create CLOCK signal
  always #5 clk = ~clk;

  initial begin
    
    $dumpfile("tb_processor.vcd"); // waveform file
    $dumpvars(0, tb_processor);


    clk = 0;
    instruction = 32'b00000000000000000000000000000000;

    // add 
    #3 instruction = 32'b00000100010000110000100000000000;

    #4
    $display(
        "add $1, $2, $3 | TIME: %d | RD1 = %d | RD2 = %d | ALU_RESULT = %d | READ_DATA = %d",
        $time,
        RD1,
        RD2,
        ALU_RESULT,
        RD
    );

    // sw
    #5 instruction = 32'b00001000010000010000000000000000;

    #5
    $display(
        "sw $1,0($2) | TIME: %d | RD1 = %d | RD2 = %d | ALU_RESULT = %d | READ_DATA = %d",
        $time,
        RD1,
        RD2,
        ALU_RESULT,
        RD
    );
    // lw
    #5 instruction = 32'b00010000010001000000000000000000;

    #5
    $display(
        "lw $4,0($2) | TIME: %d | RD1 = %d | RD2 = %d | ALU_RESULT = %d | READ_DATA = %d",
        $time,
        RD1,
        RD2,
        ALU_RESULT,
        RD
    );

    #10 $finish;
  end
endmodule

