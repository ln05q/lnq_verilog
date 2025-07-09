module ram (
    input clk,
    input [9:0] Address,
    input [7:0] WriteData,
    input WriteEn,
    input ReadEn,
    output reg [7:0] ReadData
);

  reg [7:0] register[1023:0];

  always @(negedge clk) begin
    if (WriteEn) register[Address] <= ReadData;
  end

  always @(*) begin

    if (ReadEn) ReadData = register[Address];

  end
endmodule
