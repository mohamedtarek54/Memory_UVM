module memory_16x32 (
    input logic clk,
  	input logic re,
    input logic en,
    input logic rst,
    input logic [3:0] addr,
    input logic [31:0] data_in,
    output logic [31:0] data_out,
    output logic valid_out
);

// Declare a 2D array of 32-bit words with 16 rows
logic [31:0] mem [15:0];

// Write data to memory when enabled and address is valid
always @(posedge clk) begin
  if (!rst) begin
        mem <= '{default:'h0}; // Reset memory to zero
        data_out <= 'h0; // Reset output data to zero
        valid_out <= 'h0; // Reset output validity to zero
    end else if (en) begin // Check enable and address range
        mem[addr] <= data_in; // Assign memory location from input data 
    end else if (re) begin
      data_out <= mem[addr]; // Assign output data from memory location 
        valid_out <= 'h1; // Set output validity to one 
      end else begin 
        valid_out <= 'h0; // Clear output validity to zero otherwise 
    end 
end

endmodule
