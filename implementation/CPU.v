module CPU(
    input [0:0] clk,
    input [0:0] reset
);

// if id components
wire [15:0] FnewPCCon;
wire [15:0] FPCCon;
wire [15:0] irCon;

// pc update components (id input components)
wire jumpCon;

wire [15:0] newPCInCon;

mux16b2 pcMux (
    .a(new_pcDE),
    .b(FnewPCCon),
    .s(jumpCon),
    .r(newPCInCon)
);


Fetch_Stage fetch (
    .pc_in(newPCInCon),
    .reset(reset),
    .clk(clk),
    .new_pc(FnewPCCon),
    .old_pc(FPCCon),
    .ir(irCon)
);


// id input components
wire [15:0] loadAddrWB;
wire [15:0] loadDataWB;
wire rfWriteWBCon;

// id ex components
wire RegWriteDE;
wire ALUSrcDE;
wire [2:0] ALUOpDE;
wire [0:0] MemWriteDE;
wire [0:0] MemReadDE;
wire [0:0] RegStoreDE;
wire [15:0] OPCP2DE;
wire [15:0] Arg1DE;
wire [15:0] Arg2DE;
wire [15:0] Arg3DE;
wire [15:0] ImmDE;
wire [15:0] Rs1DE;
wire [15:0] Rs2DE;
wire [15:0] RdDE;
wire [15:0] Rs2DE;
wire [15:0] RdDE;
wire [15:0] new_pcDE;
wire [0:0] jumpDE;

Decode_Stage DeStage (
    .IPC2(FnewPCCon),
    .pc_in(FPCCon),
    .ir_in(irCon),
    .loadAddr(loadAddr), //
    .loadData(loadData),  //
    .comparatorMux1Control(Bfwd1),
    .comparatorMux2Control(Bfwd2),
    .comparatorMuxForward(loadDataWB),
    .rf_write(RegWriteWB),
    .reset(reset),
    .clk(clk),
    .RegWrite(RegWriteDE),
    .ALUSrc(ALUSrcDE),
    .ALUOp(ALUOpDE),
    .MemWrite(MemWriteDE),
    .MemRead(MemReadDE),
    .RegStore(RegStoreDE),
    .OPCP2(OPCP2DE),
    .1stArg(Arg1DE),
    .2ndArg(Arg2DE),
    .3rdArg(Arg3DE),
    .Imm(ImmDE),
    .Rs1(Rs1DE),
    .Rs2(Rs2DE),
    .Rd(RdDE),
    .new_pc(new_pcDE),
    .jump(jumpCon)
);


wire ORegWriteEX;
wire ORegStoreEX;
wire OMemWriteEX;
wire OMemReadEX;
wire [15:0] OPCP2EX;
wire [15:0] OALUResultEX;
wire [15:0] O3rdArgEX;
wire [15:0] ORs1EX;
wire [15:0] ORs2EX;
wire [15:0] ORdEX;

Execute_Stage EXStage (
    .IRegWrite(RegWriteDE),
    .IALUSrc(ALUSrcDE),
    .IALUOp(ALUOpDE),
    .IMemWrite(MemWriteDE),
    .IMemRead(MemReadDE),
    .IRegStore(RegStoreDE),
    .IOPCP2(OPCP2DE),
    .I1stArg(Arg1DE),
    .I2ndArg(Arg2DE),
    .I3rdArg(Arg3DE),
    .Imm(ImmDE),
    .IRs1(Rs1DE),
    .IRs2(Rs2DE),
    .IRd(RdDE),
    .ALUResultMEM(OALUResultMEM),
    .loadDataWB(loadDataWB),
    .muxFwd1select(fwd1EX),
    .muxFwd2select(fwd2EX),
    .muxFwd3select(fwd3EX),
    .reset(reset),
    .clk(clk),
    .ORegWrite(ORegWriteEX),
    .ORegStore(ORegStoreEX),
    .OMemWrite(OMemWriteEX),
    .OMemRead(OMemReadEX),
    .OPCP2(OPCP2EX),
    .OALUResult(OALUResultEX),
    .O3rdArg(O3rdArgEX),
    .ORs1(ORs1EX),
    .ORs2(ORs2EX),
    .ORd(ORdEX)
);

wire ORegWriteMEM;
wire ORegStoreMEM;
wire [15:0] OPCP2MEM;
wire [15:0] OALUResultMEM;
wire [15:0] StoreMemMEM;
wire [2:0] rdMEM;

Memory_Stage MEMStage (
    .reset(reset),
    .clk(clk),
    .IRegWrite(ORegWriteEX),
    .IRegStore(ORegStoreEX),
    .MemWrite(OMemWriteEX),
    .MemRead(OMemReadEX),
    .IPCP2(OPCP2EX),
    .IALUResult(OALUResultEX),
    .thirdArg(O3rdArgEX),
    .rdMem(ORdEX),
    .loadData(loadDataWB),
    .DataInSelect(fwdMEM),
    .ORegWrite(ORegWriteMEM),
    .ORegStore(ORegStoreMEM),
    .OPCP2(OPCP2MEM),
    .OALUResult(OALUResultMEM),
    .StoreMem(StoreMemMEM),
    .rdWB(rdMEM)
);

wire RegWriteWB;
wire [15:0] loadDataWB;
wire [2:0] loadAddrWB;

Write_Stage WBStage (
    .reset(reset),
    .clk(clk),
    .RegWrite(ORegWriteMEM),
    .RegStore(ORegStoreMEM),
    .IPCP2(OPCP2MEM),
    .ALUResult(OALUResultMEM),
    .StoreMem(StoreMemMEM),
    .rdWB(rdMEM),
    .loadData(loadDataWB),
    .loadAddr(loadAddrWB),
    .regWriteOut(RegWriteWB)
);




wire [1:0] fwd1EX;
wire [1:0] fwd2EX;
wire [0:0] fwd3EX;
wire [0:0] Bfwd1;
wire [0:0] Bfwd2;
wire [0:0] fwdMEM; 

Forward Forward_Unit (
    .rs1EX(ORs1EX),
    .rs2EX(ORs2EX),
    .rdEX(ORdEX),
    .rdMEM(rdMEM),
    .rdWB(loadAddrWB),
    .rs1(Rs1DE),
    .rs2(Rs2DE),
    .fwd1EX(fwd1EX),
    .fwd2EX(fwd2EX),
    .fwd3EX(fwd3EX),
    .Bfwd1(Bfwd1),
    .Bfwd2(Bfwd2),
    .fwdMEM(fwdMEM)
);

endmodule