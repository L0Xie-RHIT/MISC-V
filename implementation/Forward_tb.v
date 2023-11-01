`timescale 1 ns / 1 ps

module Forward_tb();

//inputs
reg [2:0] rs1test;
reg [2:0] rs2test;
reg [2:0] rdtest;
reg [2:0] rdMEMtest;
reg [2:0] rdWBtest;
reg [0:0] clock;

//outputs
wire [1:0] fwd1test;
wire [1:0] fwd2test;
wire [0:0] fwd3test;

Forward Forward_uut(
	.rs1(rs1test),
	.rs2(rs2test),
	.rd(rdtest),
	.rdMEM(rdMEMtest),
	.rdWB(rdWBtest),
	.fwd1(fwd1test),
	.fwd2(fwd2test),
	.fwd3(fwd3test),
	.clk(clock)
);

//clockwork
parameter HALF_PERIOD = 50;

integer failures = 0;

initial begin
    clock = 0;
    forever begin
        #(HALF_PERIOD);
        clock = ~clock;
    end
end

initial begin

//Testing initilization
	$display("Testing inilitilization.");
	
	rs1test = 0;
	rs2test = 0;
	rdtest = 0;
	rdMEMtest = 0;
	rdWBtest = 0;
	
	#(2*HALF_PERIOD);
	
	repeat (8) begin
		repeat (8) begin
			repeat (8) begin
				repeat (8) begin
					repeat (8) begin
					#(2*HALF_PERIOD);
					if (rs1test == rdMEMtest) begin
						if (fwd1test != 0) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					
					if (rs1test == rdWBtest && rs1test != rdMEMtest) begin
						if (fwd1test != 1) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					
					if (rs1test != rdMEMtest && rs1test != rdWBtest) begin
						if (fwd1test != 2) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					
					if (rs2test == rdMEMtest) begin
						if (fwd2test != 0) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					
					if (rs2test == rdWBtest && rs2test != rdMEMtest) begin
						if (fwd2test != 1) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					
					if (rs2test != rdMEMtest && rs2test != rdWBtest) begin
						if (fwd2test != 2) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					if (rdMEMtest == rdWBtest) begin
						if (fwd3test != 0) begin
							failures = failures + 1;
							$display("Fail here: rs1: %d, rs2: %d, rd: %d, rdMEM: %d, rdWB: %d, fwd1: %d", rs1test, rs2test, rdtest, rdMEMtest, rdWBtest, fwd1test);
						end
					end
					
					rs1test = rs1test + 1;
					end
					
				rs2test = rs2test + 1;
				end
				
			rdtest = rdtest + 1;
			end
			
		rdMEMtest = rdMEMtest + 1;
		end
		
	rdWBtest = rdWBtest + 1;
	end
	
	$display("TESTS COMPLETE. \n Failures = %d", failures);
	$stop;
	end
endmodule
	
	
