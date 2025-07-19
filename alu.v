`define COMPLEMENT_A 3'd0

`define AND 3'd1

`define EX_OR 3'd2

`define OR 3'd3

`define DECRMENT_A 3'd4

`define ADD 3'd5

`define SUBTRACT 3'd6

`define INCREMENT_A 3'd7

module alu (
    input [3:0] ALU_control,
    input [31:0] in_A,
    input [31:0] in_B,
    output reg [31:0] out
);
  always @(*) begin

    case (ALU_control)
      `COMPLEMENT_A: out = ~in_A;
      `AND: out = in_A & in_B;
      `EX_OR: out = in_A ^ in_B;
      `OR: out = in_A | in_B;
      `DECRMENT_A: out = in_A - 32'd1;
      `ADD: out = in_A + in_B;
      `SUBTRACT: out = in_A - in_B;
      `INCREMENT_A: out = in_A + 32'd1;
      default: out = 32'b0;
    endcase
  end
endmodule

