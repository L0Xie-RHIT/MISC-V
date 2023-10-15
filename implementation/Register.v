module Register(
    input [15:0] reg_input,
    input reset[0:0],
    input CLK [0:0],
    output reg [15:0] reg_output
)

always @ (posedge(CLK))
begin
    if(reset != 1) begin
        reg_output = reg_input;
    end
        reg_output = reg_input;
end

endmodule