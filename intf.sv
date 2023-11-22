interface intf;
  logic clk;
  logic en;
  logic re;
  logic rst;
  logic [3:0] addr;
  logic [31:0] data_in;
  logic [31:0] data_out;
  logic valid_out;

always begin
    #2 clk = ~clk;
end
endinterface