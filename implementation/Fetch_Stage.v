module Fetch_Stage(
    input [15:0] pc_in,
    input reset,
    input clk,
    output [15:0] new_pc,
    output [15:0] old_pc,
    output [15:0] ir
);

wire [15:0] pc_out;

Register pc (
    .reg_input(pc_in),
    .reg_write(1'b1),
    .reset(reset),
    .CLK(~clk),
    .reg_output(pc_out)
);

Memory_Text instruction_memory(
    .data(16'h0000),
    .addr(pc_out),
    .we(1'b0),
    .clk(clk),
    .q(ir)
);


assign new_pc = pc_out + 2;
assign old_pc = pc_out;

endmodule