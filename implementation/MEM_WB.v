module MEM_WB(
    input [0:0] IRegWrite,
    input [0:0] IRegStore,
    input [15:0] IALUResult,
    input [15:0] IStoreMem,
    input [2:0] IRd,
    input CLK,
    input Reset,
    input RegWrite,
    output reg[0:0] ORegWrite,
    output reg[0:0] ORegStore,
    output reg[15:0] OALUResult,
    output reg[15:0] OStoreMem,
    output reg[2:0] ORd
);

always @ (posedge(CLK))
begin
    if (Reset != 1) begin
        if(RegWrite == 1) begin
            ORegWrite = IRegWrite;
            ORegStore = IRegStore;
            OALUResult = IALUResult;
            OStoreMem = IStoreMem;
            ORd = IRd;
        end
    end else begin 
            ORegWrite = 0;
            ORegStore = 0;
            OALUResult = 0;
            OStoreMem = 0;
            ORd = 0;
    end
end

endmodule
