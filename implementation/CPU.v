module CPU(
    input [0:0] clk,
    input [0:0] reset
);

// if id components
wire [15:0] FnewPCCon;
wire [15:0] FPCCon;
wire [15:0] irCon;

// pc update components (id input components)
wire [15:0] DnewPCCon;
wire jumpCon;

wire [15:0] newPCInCon;

mux16b2 pcMux (
    .a(DnewPCCon),
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
wire [15:0] loadAddrWBCon;
wire [15:0] loadDataWBCon;
wire rfWriteWBCon;

// id ex components
wire DeRegWriteCon;
wire DeALUSrcCon;
wire [2:0] DeALUOpCon;
wire [0:0] DeMemWriteCon;
wire [0:0] DeMemReadCon;
wire [0:0] DeRegStoreCon;
wire [15:0] DeOPCP2Con;
wire [15:0] De1stArgCon;
wire [15:0] De2ndArgCon;
wire [15:0] De3rdArgCon;
wire [15:0] DeImmCon;
wire [15:0] DeRs1Con;
wire [15:0] DeRs2Con;
wire [15:0] DeRdCon;


Decode_Stage uut (
    .IPCP2(FnewPCCon),
    .pc_in(FPCCon),
    .ir_in(irCon),
    .loadAddr(loadAddrWBCon),
    .loadData(loadDataWBCon),
    .rf_write(rfWriteWBCon),
    .reset(reset),
    .clk(clk),
    .RegWrite(DeRegWriteCon),
    .ALUSrc(DeALUSrcCon),
    .ALUOp(DeALUOpCon),
    .MemWrite(DeMemWriteCon),
    .MemRead(DeMemReadCon),
    .RegStore(DeRegStoreCon),
    .OPCP2(DeOPCP2Con),
    .1stArg(De1stArgCon),
    .2ndArg(De2ndArgCon),
    .3rdArg(De3rdArgCon),
    .Imm(DeImmCon),
    .Rs1(DeRs1Con),
    .Rs2(DeRs2Con),
    .Rd(DeRdCon),
    .new_pc(DnewPCCon),
    .jump(jumpCon)
);



endmodule