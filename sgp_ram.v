module sgp_ram (
    input clk,
    input cs,
    input wr_e,
    input oe,
    input [6:0] addr,
    inout [7:0] data
);

  reg [7:0] register[127:0];

  reg data_out;

  assign data = (oe && !wr_e) ? data_out : 8'bzzzzzzzz;

  always @(posedge clk) begin

    if (cs) begin
      if (wr_e) register[addr] <= data;
      else if (!wr_e) data_out <= register[addr];
    end

  end
endmodule
