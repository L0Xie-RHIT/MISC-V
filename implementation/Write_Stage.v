module Write_Stage(
    input reset,
    input clk,
    input RegWrite,
    input RegStore,
    input [15:0] ALUResult,
    input [15:0] StoreMem,
    input [2:0] rdWB,
    output [15:0] loadData,
    output [2:0] loadAddr,
    output [0:0] regWriteOut
);

wire [15:0] StoreMemCon;
wire [15:0] ALUResultCon;
wire [0:0] RegStoreCon;


MEM_WB MEMWBRB(
    .IRegWrite(RegWrite),
    .IRegStore(RegStore),
    .IALUResult(ALUResult),
    .IStoreMem(StoreMem),
    .IRd(rdWB),
    .CLK(clk),
    .Reset(reset),
    .RegWrite(1'b1),
    .ORegWrite(regWriteOut),
    .ORegStore(RegStoreCon),
    .OALUResult(ALUResultCon),
    .OStoreMem(StoreMemCon),
    .ORd(loadAddr)
);

mux16b2 RegStoreMux(
    .a(StoreMemCon),
    .b(ALUResultCon),
    .s(RegStoreCon),
    .r(loadData)
);

endmodule