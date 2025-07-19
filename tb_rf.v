module tb_rf;

  // Inputs

  reg clk;
  reg [4:0] ReadAddress1;
  reg [4:0] ReadAddress2;
  reg [4:0] WriteAddress;
  reg [31:0] WriteData;
  reg ReadWriteEn;

  // Outputs

  wire [31:0] ReadData1;
  wire [31:0] ReadData2;

  // Instantiation

  register_file rf (
      .clk(clk),
      .ReadAddress1(ReadAddress1),
      .ReadAddress2(ReadAddress2),
      .WriteAddress(WriteAddress),
      .WriteData(WriteData),
      .ReadWriteEn(ReadWriteEn),
      .ReadData1(ReadData1),
      .ReadData2(ReadData2)
  );

  // Create CLOCK signal

  always #5 clk = ~clk;

  // Testbench

  initial begin
    clk = 0;
    ReadAddress1 = 5'd0;
    ReadAddress2 = 5'd0;
    WriteAddress = 5'd0;
    WriteData = 32'd0;
    ReadWriteEn = 1'b0;


    // Per clock cycle, can write to only 1 register 

    $monitor("TIME: %d | ReadAddress1 = %d | ReadAddress2 = %d | ReadData1 = %d | ReadData2 = %d",
             $time, ReadAddress1, ReadAddress2, ReadData1, ReadData2);

    #2 ReadWriteEn = 1;
    WriteAddress = 5'd8;
    WriteData = 32'd294;

    #10 ReadWriteEn = 1;
    WriteAddress = 5'd13;
    WriteData = 32'd194;

    #13 $display("Testcase 1:");
    ReadWriteEn  = 0;
    ReadAddress1 = 5'd8;
    ReadAddress2 = 5'd13;

    #7 ReadWriteEn = 1;
    WriteAddress = 5'd3;
    WriteData = 32'd48;

    #10 ReadWriteEn = 1;
    WriteAddress = 5'd10;
    WriteData = 32'd123;

    #13 $display("Testcase 1:");
    ReadWriteEn  = 0;
    ReadAddress1 = 5'd3;
    ReadAddress2 = 5'd10;

    #10 $finish;
  end


endmodule
