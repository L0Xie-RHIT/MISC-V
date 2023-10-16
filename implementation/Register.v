module Register(
    input [15:0] reg_input,
    input [0:0] reset,
    input [0:0] CLK,
    output reg [15:0] reg_output
);

always @ (posedge(CLK))
begin
    if (reset != 1) begin
        reg_output = reg_input;
    end else begin 
        reg_output = 16'b0000000000000000;
    end
end

endmodule