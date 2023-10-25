// Wrapper module for raw memory
module Memory
(
	input [15:0] data,
	input [15:0] addr,
	input we, clk,
	output [15:0] q
);

	raw_memory mem(
		.data(data),
		.addr(addr[10:1]),
		.we(we),
		.clk(clk),
		.q(q)
	);

endmodule