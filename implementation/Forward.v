module Forward(
	input [2:0] rs1,
	input [2:0] rs2,
	input [2:0] rd,
	input [2:0] rdMEM,
	input [2:0] rdWB,
	input clk,
	output reg [1:0] fwd1,
	output reg [1:0] fwd2,
	output reg [0:0] fwd3
);

	always @(*) begin
		//Default Values
		fwd1 = 2;
		fwd2 = 2;
		fwd3 = 1;
		
		if (rs1 == rdMEM) begin
			fwd1 = 0;
		end
		if (rs2 == rdMEM) begin
			fwd2 = 0;
		end
		if (rdMEM == rdWB) begin
			fwd3 = 0;
		end
		else fwd3 = 1;
		if (rs1 == rdWB && rs1 != rdMEM) begin
			fwd1 = 1;
		end
		if (rs2 == rdWB && rs2 != rdMEM) begin
			fwd2 = 1;
		end
		if (rs1 != rdWB && rs1 != rdMEM) begin
			fwd1 = 2;
		end
		if (rs2 != rdWB && rs2 != rdMEM) begin
			fwd2 = 2;
		end
		
		
	end
endmodule
