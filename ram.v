module ram (
    input clk,
    input [9:0] Address,
    input [31:0] WriteData,
    input WriteEn,
    input ReadEn,
    output reg [31:0] ReadData
);

  reg [31:0] register[1023:0];

  always @(posedge clk) begin
    if (WriteEn) register[Address] <= WriteData;
  end

  always @(*) begin

    if (ReadEn) ReadData = register[Address];

  end
endmodule
