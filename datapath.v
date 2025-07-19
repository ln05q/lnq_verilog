module datapath (
    input clk,
    input [31:0] instruction,
    input RegDst,
    input RegWrite,
    input ALUSrc,
    input [3:0] ALUcontrol,
    input MemWrite,
    input MemRead,
    input MemToReg,
    output [31:0] RD1,
    output [31:0] RD2,
    output [31:0] RD,
    output [31:0] ALU_RESULT

);

  wire [ 4:0] res_RegDst;
  wire [31:0] res_MemToReg;
  wire [31:0] res_Sign_Extend;
  wire [31:0] res_ALUSrc;
  wire [31:0] res_ALU;

  wire [31:0] temp_RD1;
  wire [31:0] temp_RD2;
  wire [31:0] temp_RD;

  // mux RegDst
  assign res_RegDst   = (RegDst ? instruction[15:11] : instruction[20:16]);

  // mux ALUSrc
  assign res_ALUSrc   = (ALUSrc ? res_Sign_Extend : temp_RD2);

  // mux MemToReg
  assign res_MemToReg = (MemToReg ? temp_RD : res_ALU);


  sign_extended my_se (
      .in (instruction[15:0]),
      .out(res_Sign_Extend)
  );

  register_file my_rf (
      .clk(clk),
      .ReadAddress1(instruction[25:21]),
      .ReadAddress2(instruction[20:16]),
      .WriteAddress(res_RegDst),
      .WriteData(res_MemToReg),
      .ReadWriteEn(RegWrite),
      .ReadData1(temp_RD1),
      .ReadData2(temp_RD2)
  );

  alu my_alu (
      .ALU_control(ALUcontrol),
      .in_A(temp_RD1),
      .in_B(res_ALUSrc),
      .out(res_ALU)
  );

  ram my_ram (
      .clk(clk),
      .Address(res_ALU[9:0]),
      .WriteData(RD2),
      .WriteEn(MemWrite),
      .ReadEn(MemRead),
      .ReadData(temp_RD)
  );

  assign RD1 = temp_RD1;
  assign RD2 = temp_RD2;
  assign RD = temp_RD;
  assign ALU_RESULT = res_ALU;
endmodule
