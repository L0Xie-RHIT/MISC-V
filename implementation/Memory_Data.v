// Wrapper module for raw memory
// This Memory represents the data memory.
// Only bits 0-10 can be used.
module Memory_Data
(
	input [15:0] data,
	input [15:0] addr,
	input we, clk,
	output [15:0] q
);

wire[9:0] modified_addr;
assign modified_addr = {1'b1, addr[8:1]};

	raw_memory mem(
		.data(data),
		.addr(modified_addr),
		.we(we),
		.clk(clk),
		.q(q)
	);

endmodule