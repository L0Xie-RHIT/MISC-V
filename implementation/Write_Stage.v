module Write_Stage(
    input reset,
    input clk,
    input RegWrite,
    input RegStore,
    input [15:0] ALUResult,
    input [15:0] StoreMem,
    input [2:0] rdWB,
    output reg [15:0] loadData,
    output reg [2:0] loadAddr,
    output reg regWriteOut
);

wire reg [15:0] StoreMemCon;
wire reg [15:0] ALUResultCon;
wire reg [0:0] RegStoreCon;

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