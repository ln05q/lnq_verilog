module tb_ram;

  // Inputs

  reg clk;
  reg [9:0] Address;
  reg [7:0] WriteData;
  reg WriteEn;
  reg ReadEn;

  // Outputs

  wire [7:0] ReadData;

  // Instantiation
  ram my_ram (
      .clk(clk),
      .Address(Address),
      .WriteData(WriteData),
      .WriteEn(WriteEn),
      .ReadEn(ReadEn),
      .ReadData(ReadData)
  );

  // Create CLOCK sygnal

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    Address = 10'd0;
    WriteData = 8'd0;
    WriteEn = 0;
    ReadEn = 1;

    //    $monitor("TIME: %d | Address: %d | WriteDataData: %d | ReadData = %d", $time, Address,
    //         WriteData, ReadData);

    #2 WriteEn = 1;
    ReadEn = 0;
    Address = 10'd131;
    WriteData = 8'd39;

    #13 $display("Testcase 1:");
    $display("TIME: %d | Address: %d | WriteDataData: %d | ReadData = %d", $time, Address,
             WriteData, ReadData);
    WriteEn = 0;
    ReadEn  = 1;

    #7 WriteEn = 1;
    ReadEn = 0;
    Address = 10'd21;
    WriteData = 8'd84;

    #13 $display("Testcase 2:");
    $display("TIME: %d | Address: %d | WriteDataData: %d | ReadData = %d", $time, Address,
             WriteData, ReadData);
    WriteEn = 0;
    ReadEn  = 1;

    #7 WriteEn = 1;
    ReadEn = 0;
    Address = 10'd10;
    WriteData = 8'd95;

    #13 $display("Testcase 3:");
    $display("TIME: %d | Address: %d | WriteDataData: %d | ReadData = %d", $time, Address,
             WriteData, ReadData);
    WriteEn = 0;
    ReadEn  = 1;

    #10 $finish;
  end

endmodule

