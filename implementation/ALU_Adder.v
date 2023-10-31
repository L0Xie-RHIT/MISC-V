module ALU_Adder(
	input [15:0] FirstInput,
	input [15:0] SecondInput,
        input [0:0] CLK,
        output reg [15:0]OutputData
);

always @ (posedge(CLK))
begin
	OutputData = FirstInput + SecondInput;
end

endmodule