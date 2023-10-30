module Execute_Stage(
    input reset,
    input clk,
    output RegWrite,
    output ALUSrc,
    output [2:0] ALUOp,
    output [0:0] MemWrite,
    output [0:0] MemRead,
    output [0:0] RegStore,
    output [15:0] 1stArg,
    output [15:0] 2ndArg,
    output [15:0] 3rdArg,
    output [15:0] Imm,
    output [15:0] Rs1,
    output [15:0] Rs2,
    output [15:0] Rd,
    output [15:0] new_pc,
    output [0:0] jump
);



endmodule