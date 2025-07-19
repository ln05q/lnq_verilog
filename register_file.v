module register_file (
    input clk,
    input [4:0] ReadAddress1,
    input [4:0] ReadAddress2,
    input [4:0] WriteAddress,
    input [31:0] WriteData,
    input ReadWriteEn,
    output reg [31:0] ReadData1,
    output reg [31:0] ReadData2
);

  reg [31:0] register[31:0];

  always @(posedge clk) begin
    if (ReadWriteEn) begin
      register[WriteAddress] <= WriteData;
    end
  end

  always @(*) begin
    ReadData1 = register[ReadAddress1];
    ReadData2 = register[ReadAddress2];
  end

  initial begin
    register[2] = 32'd13;
    register[3] = 32'd28;
  end
endmodule
