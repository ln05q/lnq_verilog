module tb_sign_extended;

  // Inputs
  reg  [ 5:0] in;
  // Outputs
  wire [15:0] out;

  // Instantiation
  sign_extended se(
      .in(in), .out(out)
  );

  initial begin
    in = 6'd13;
    #10 $display("Input is: %b", in);
    $display("Ouput is: %b", out);
    #5 $finish;
  end
endmodule


