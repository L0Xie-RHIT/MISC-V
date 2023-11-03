module Decode_Stage(
    input [15:0] IPCP2,
    input [15:0] pc_in,
    input [15:0] ir_in,
    input [3:0] loadAddr,
    input [15:0] loadData,
    input rf_write,
    input reset,
    input clk,
    output RegWrite,
    output ALUSrc,
    output [2:0] ALUOp,
    output [0:0] MemWrite,
    output [0:0] MemRead,
    output [0:0] RegStore,
    output [15:0] OPCP2,
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

wire [15:0] pc,
wire [15:0] ir,

IF_ID IFIDRB(
    .IPCP2(IPCP2),
    .IPC(pc_in),
    .IIR(ir_in),
    .CLK(clk),
    .Reset(reset),
    .RegWrite(1'b1),
    .OPCP2(OPCP2),
    .OPC(pc),
    .OIR(ir)
);

assign Rs1 = ir[8:6];
assign Rs2 = ir[11:9];
assign Rd = ir[5:3];

wire BranchCon;
wire JumpCon;

Control CUnit(
    .opcode(ir[2:0]),
    .func(ir[15:12]),
    .reset(reset),
    .CLK(clk),
    .RegWrite(rf_write),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .RegStore(RegStore),
    .Branch(BranchCon),
    .JumpOut(JumpCon)
);

wire [15:0] arg1;
wire [15:0] arg2;
wire [15:0] arg3;

Register_File Regs(
    .Reg_address1(ir[8:6]),
    .Reg_address2(ir[11:9]),
    .Reg_address3(ir[5:3]),
    .Reg_input_address(loadAddr),
    .Reg_input_data(loadData),
    .CLK(clk),
    .Reset(reset),
    .Reg_Write(RegWrite),
    .Reg_output1(arg1),
    .Reg_output2(arg2),
    .Reg_output3(arg3)
);

wire [15:0] immCon;

Imm_Gen genie(
    .instruction(ir),
    .immediate(immCon)
);

assign Imm = immCon;

wire [15:0] pc_added;
wire branchCompCon;

Comparator comp(
    .FirstInput(arg1),
    .SecondInput(arg2),
    .CLK(clk),
    .OPCode(ir[2:0]),
    .BranchComparison(branchCompCon)
);

always @ * begin
    pc_added <= pc + immCon;
    jump <= BranchCon && branchCompCon;
end

mux16b2 jumpMux(
    .a(pc_added),
    .b(arg3),
    .s(JumpCon),
    .r(new_pc)
);


endmodule