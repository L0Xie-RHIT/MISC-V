`timescale 1 ns / 1 ps 

module Memory_tb();

reg [15:0] data;
reg [15:0] addr;
reg w;
reg r;
reg [0:0] clk;

wire[15:0] q;

Memory uut(
	.data(data),
	.addr(addr),
	.w(w),
    .r(r),
	.clk(clk),
	.q(q)
);

parameter PERIOD = 50;

initial begin 
	  clk = 0;
	  repeat (50) begin
			#PERIOD;
			clk = ~clk;
	  end
 end
 
 initial begin
	clk = 0;
	w = 1;
	r = 1;
	addr = 'h0000;
	data = 'h1111;
	
	#(2*PERIOD);

	if (q != data) begin
		$display("Test 1 failed - No Data Write when bit 1")
	end

	w = 0;
	addr = 'h0001;
	data = 'h2222;

	#(2*PERIOD);
	if (q == data) begin
		$display("Test 2 failed - Data Write even when bit 0")
	end

	w = 1;
	r=0;
	addr = 'h0000;
	data = 'h3333;
	#(2*PERIOD);

	if (q == data) begin
		$display("Test 3 failed - Data Read even when bit 0")
	end

end
	  
	  
endmodule