`timescale 1ns / 1ns
module tb_datapath;

  // Inputs

  reg clk;
  reg [31:0] instruction;
  reg RegDst;
  reg RegWrite;
  reg ALUSrc;
  reg [3:0] ALUcontrol;
  reg MemWrite;
  reg MemRead;
  reg MemToReg;

  // Outputs
  wire [31:0] RD1;
  wire [31:0] RD2;
  wire [31:0] RD;
  wire [31:0] ALU_RESULT;

  // Instantiation
  datapath my_datapath (
      .clk(clk),
      .instruction(instruction),
      .RegDst(RegDst),
      .RegWrite(RegWrite),
      .ALUSrc(ALUSrc),
      .ALUcontrol(ALUcontrol),
      .MemWrite(MemWrite),
      .MemRead(MemRead),
      .MemToReg(MemToReg),
      .RD1(RD1),
      .RD2(RD2),
      .RD(RD),
      .ALU_RESULT(ALU_RESULT)
  );

  // Create CLOCK signal
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    instruction = 32'd0;
    RegDst = 0;
    RegWrite = 0;
    ALUSrc = 0;
    ALUcontrol = 0;
    MemWrite = 0;
    MemRead = 0;
    MemToReg = 0;

    // add
    #3 instruction = 32'b00000000010000110000100000000000;
    RegDst = 1'b1;
    RegWrite = 1'b1;
    ALUSrc = 1'b0;
    ALUcontrol = 4'b0101;
    MemWrite = 1'b0;
    MemRead = 1'b0;
    MemToReg = 1'b0;

    #4
    $display(
        "add $1, $2, $3 | TIME: %d | RD1 = %d | RD2 = %d | ALU_RESULT = %d | READ_DATA = %d",
        $time,
        RD1,
        RD2,
        ALU_RESULT,
        RD
    );

    // lw

    #3 instruction = 32'b00000000010001000000000000000000;
//    #5 instruction = 32'b00000000010001000000000000000000;
    RegDst = 1'b0;
    RegWrite = 1'b1;
    ALUSrc = 1'b1;
    ALUcontrol = 4'b0101;
    MemWrite = 1'b0;
    MemRead = 1'b1;
    MemToReg = 1'b1;

    #6
   // #5
    $display(
        "lw $4,0($2) | TIME: %d | RD1 = %d | RD2 = %d | ALU_RESULT = %d | READ_DATA = %d",
        $time,
        RD1,
        RD2,
        ALU_RESULT,
        RD
    );

    // sw
    #4 instruction = 32'b00000000010000010000000000000000;
    //#5 instruction = 32'b00000000010000010000000000000000;
    RegDst = 1'bx;  // store word in ram => don't care where it store in rf
    RegWrite = 1'b0;
    ALUSrc = 1'b1;
    ALUcontrol = 4'b0101;
    MemWrite = 1'b1;
    MemRead = 1'b0;
    MemToReg = 1'bx;

    #6
    //#5
    $display(
        "sw $1,0($2) | TIME: %d | RD1 = %d | RD2 = %d | ALU_RESULT = %d | READ_DATA = %d",
        $time,
        RD1,
        RD2,
        ALU_RESULT,
        RD
    );
    #10 $finish;
  end
endmodule
