module Forward(
	input [2:0] rs1EX,
	input [2:0] rs2EX,
	input [2:0] rdEX,
	input [2:0] rdMEM,
	input [2:0] rdWB,
	input [2:0] rs1,
	input [2:0] rs2,
	output reg [1:0] fwd1EX,
	output reg [1:0] fwd2EX,
	output reg [0:0] fwd3EX,
	output reg [0:0] Bfwd1,
	output reg [0:0] Bfwd2,
	output reg [0:0] fwdMEM
);

	always @(*) begin
		//Default Values
		fwd1EX = 2;
		fwd2EX = 2;
		fwd3EX = 1;
		fwdMEM = 1;
		Bfwd1 = 1;
		Bfwd2 = 1;
		
		if (rs1EX == rdMEM) begin
			fwd1EX = 0;
		end
		if (rs2EX == rdMEM) begin
			fwd2EX = 0;
		end
		if (rdEX == rdWB) begin
			fwd3EX = 0;
		end
		if (rdMEM == rdWB) begin
			fwdMEM = 0;
		end
		if (rs1EX == rdWB && rs1EX != rdMEM) begin
			fwd1EX = 1;
		end
		if (rs2EX == rdWB && rs2EX != rdMEM) begin
			fwd2EX = 1;
		end
		if (rs1 == rdMEM) begin
			Bfwd1 = 0;
		end
		if (rs2 == rdMEM) begin
			Bfwd2 = 0;
		end
		
	end
endmodule
