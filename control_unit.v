module control_unit (
    input clk,
    input [5:0] opcode,
    output reg RegDst,
    output reg RegWrite,
    output reg ALUSrc,
    output reg [3:0] ALUcontrol,
    output reg MemWrite,
    output reg MemRead,
    output reg MemToReg
);

  reg [1:0] ALUOp;

  always @(*) begin

    case (opcode)
      6'b000001: begin  // add
        RegDst = 1'b1;
        RegWrite = 1'b1;
        ALUSrc = 1'b0;
        ALUOp = 2'b10;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemToReg = 1'b0;
      end

      6'b000010: begin  // sw
        RegDst = 1'bx;  // store word in ram => don't care where it store in rf
        RegWrite = 1'b0;
        ALUSrc = 1'b1;
        ALUOp = 2'b00;
        MemWrite = 1'b1;
        MemRead = 1'b0;
        MemToReg = 1'bx;
      end
      6'b000100: begin  // lw
        RegDst = 1'b0;
        RegWrite = 1'b1;
        ALUSrc = 1'b1;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        MemRead = 1'b1;
        MemToReg = 1'b1;
      end
      default: begin
        RegDst = 1'b0;
        RegWrite = 1'b0;
        ALUSrc = 1'b0;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemToReg = 1'b0;
      end
    endcase

  end


  always @(*) begin
    case (ALUOp)
      2'b00, 2'b10: ALUcontrol = 4'b0101;
      default: ALUcontrol = 4'b0000;
    endcase
  end

endmodule
