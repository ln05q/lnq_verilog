module register_file (
    input clk,
    input [4:0]ReadAddress1,
    input [4:0]ReadAddress2,
    input [4:0]WriteAddress,
    input [31:0] WriteData,
    input ReadWriteEn,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

  reg [31:0] register[31];

  always @(posedge clk) begin
    if (ReadWriteEn) begin
      register[WriteAddress] <= WriteData;
    end
  end

endmodule
