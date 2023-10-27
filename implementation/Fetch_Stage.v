module Fetch_Stage(
    input [15:0] pc,
    input reset,
    input clk,
    output reg[15:0] new_pc,
    output reg[15:0] old_pc,
    output reg[15:0] ir
);

Memory_Text instruction_memory(
    .data('h0000),
    .addr(pc),
    .we(0),
    .clk(clk),
    .q(ir)
) ;

assign new_pc = pc + 2;
assign old_pc = pc;

assign

endmodule