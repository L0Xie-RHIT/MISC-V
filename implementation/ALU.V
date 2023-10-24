module ALU(
	input [15:0] 1stInput,
	input [15:0] 2ndInput,
	input [2:0] ALUOp,
	input [0:0] CLK,
    output [15:0]OutputData,
    output [0:0]Zero
);

always @ (posedge(CLK))
begin
	if (ALUOp == 0) begin 
		OutputData = 2ndInput + 1stInput;
	end else if (ALUOp == 1) begin 
        OutputData = 1stInput - 2ndInput;
	end else if (ALUOp == 2) begin 
        OutputData = 1stInput || 2ndInput;
	end else if (ALUOp == 3) begin 
        OutputData = 1stInput && 2ndInput;
	end else if (ALUOp == 4) begin 
        OutputData = 1stInput * (2 ** 2ndInput);
	end else if (ALUOp == 5) begin 
        OutputData = 1stInput / (2 ** 2ndInput);
	end else if (ALUOp == 6) begin 
        OutputData = (1stInput || 2ndInput) && !(1stInput && 2ndInput);
	end else if (ALUOp == 7) begin 
        OutputData = 0;
	end 

    if (1stInput - 2ndInput = 0) begin 
        Zero = 1;
    end else begin
        Zero = 0;
    end
end

endmodule