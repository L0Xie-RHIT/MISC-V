module Memory_Stage(
    input reset,
    input clk,
    input IRegWrite,
    input IRegStore,
    input MemWrite,
    input MemRead,
    input [15:0] IALUResult,
    input [15:0] thirdArg,
    input [2:0] rdMem,
    output ORegWrite,
    output ORegStore,
    output [15:0] OALUResult,
    output [15:0] StoreMem,
    output [2:0] rdWB
);

wire [0:0] MemWriteCon;
wire [0:0] MemReadCon;
wire [15:0] thirdArgCon;
wire [15:0] ALUResultCon;

EX_MEM EXMEMRB(
    .IRegWrite(IRegWrite),
    .IMemWrite(MemWrite),
    .IMemRead(MemRead),
    .IRegStore(IRegStore),
    .IALUResult(IALUResult),
    .I3rdArg(thirdArg),
    .IRd(rdMem),
    .CLK(clk),
    .Reset(reset),
    .RegWrite(1'b1),
    .ORegWrite(ORegWrite),
    .OMemWrite(MemWriteCon),
    .OMemRead(MemReadCon),
    .ORegStore(ORegStore),
    .OALUResult(ALUResultCon),
    .O3rdArg(thirdArgCon),
    .ORd(rdWB)
);

assign OALUResult = ALUResultCon;

wire [15:0] StoreMemCon;

Memory_Data mem (
	.data(thirdArgCon),
	.addr(ALUResultCon),
	.we(MemWriteCon),
	.clk(clk),
	.q(StoreMemCon)
);

assign StoreMem = StoreMemCon;

endmodule