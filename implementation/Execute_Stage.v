module Execute_Stage(
    input IRegWrite,
    input IALUSrc,
    input [2:0] IALUOp,
    input IMemWrite,
    input IMemRead,
    input IRegStore,
    input [15:0] IOPCP2,
    input [15:0] I1stArg,
    input [15:0] I2ndArg,
    input [15:0] I3rdArg,
    input [15:0] Imm,
    input [15:0] IRs1,
    input [15:0] IRs2,
    input [15:0] IRd,
    input [15:0] ALUResultMEM,
    input [15:0] loadDataWB,
    input [1:0] mux1select,
    input [1:0] mux2select,
    input reset,
    input clk,
    output ORegWrite,
    output ORegStore,
    output OMemWrite,
    output OMemRead,
    output [15:0] OPCP2,
    output [15:0] OALUResult,
    output [15:0] O3rdArg,
    output [15:0] ORs1,
    output [15:0] ORs2,
    output [15:0] ORd,
);

wire ALUSrcCon;
wire [2:0] ALUOpCon;
wire [15:0] arg1;
wire [15:0] arg2;
wire [15:0] immCon;

ID_EX IDEXRB (
    .IRegWrite(IRegWrite),
    .IALUSrc(IALUSrc),
    .IALUOP(IALUOP),
    .IMemWrite(IMemWrite),
    .IMemRead(IMemRead),
    .IRegStore(IRegStore),
    .IPCP2(IPCP2),
    .I1stArg(I1stArg),
    .I2ndArg(I2ndArg),
    .I3rdArg(I3rdArg),
    .IImm(IImm),
    .IRs1(IRs1),
    .IRs2(IRs2),
    .IRd(IRd),
    .CLK(clk),
    .Reset(reset),
    .RegWrite(RegWrite),
    .ORegWrite(ORegWrite),
    .OALUSrc(ALUOpCon),
    .OALUOP(ALUOpCon),
    .OMemWrite(OMemWrite),
    .OMemRead(OMemRead),
    .ORegStore(ORegStore),
    .OPCP2(OPCP2),
    .O1stArg(arg1),
    .O2ndArg(arg2),
    .O3rdArg(O3rdArg),
    .OImm(immCon),
    .ORs1(ORs1),
    .ORs2(ORs2),
    .ORd(ORd)
);

wire [15:0] arg1MuxCon;
wire [15:0] arg2MuxCon;

mux16b4 arg1mux(
    .a(ALUResultMEM),
    .b(loadDataWB),
    .c(arg1),
    .d(0),
    .s(mux1select),
    .r(arg1MuxCon)
);

mux16b4 arg2mux(
    .a(ALUResultMEM),
    .b(loadDataWB),
    .c(arg2),
    .d(0),
    .s(mux2select),
    .r(arg2MuxCon)
);

wire [15:0] ALUIn2;

mux16b2 ALUIn2Mux(
    .a(immCon),
    .b(arg2MuxCon),
    .s(ALUSrcCon),
    .r(ALUIn2)
);

ALU exALU(
    .FirstInput(arg1MuxCon),
    .SecondInput(ALUIn2),
    .ALUOp(ALUOpCon),
    .OutputData(OALUResult)
);

endmodule