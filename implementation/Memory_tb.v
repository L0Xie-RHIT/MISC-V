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
        w = 1;
		addr = 'h0000;
		data = 'h1111;
		
		#(3*PERIOD);
		addr = 'h0001;
		data = 'h2222;
		
		#(2*PERIOD);
		we = 0;
		addr = 'h0000;
		data = 'h2222;
end
	  
	  
endmodule