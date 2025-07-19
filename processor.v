module processor (
    input clk,
    input [31:0] instruction,
    output [31:0] RD1,
    output [31:0] RD2,
    output [31:0] RD,
    output [31:0] ALU_RESULT

);

  wire RegDst;
  wire RegWrite;
  wire ALUSrc;
  wire [3:0] ALUcontrol;
  wire MemWrite;
  wire MemRead;
  wire MemToReg;

  control_unit cu (
      .clk(clk),
      .opcode(instruction[31:26]),
      .RegDst(RegDst),
      .RegWrite(RegWrite),
      .ALUSrc(ALUSrc),
      .ALUcontrol(ALUcontrol),
      .MemWrite(MemWrite),
      .MemRead(MemRead),
      .MemToReg(MemToReg)
  );

  datapath dp (
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

endmodule
