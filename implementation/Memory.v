module Memory
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input w, r, clk,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	initial begin 
		$readmemh("memory.txt", ram);  // add abs path
		$display("Memory Loaded");
	end
	
	always @ (posedge clk)
	begin
		// Write
		if (w)
			ram[addr] <= data;

		addr_reg <= addr;
	end

    always @ (negedge clk)
    begin
        if (r)
            q <= ram[addr_reg];
    end

endmodule