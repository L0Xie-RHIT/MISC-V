module MEM_WB(
    input [0:0] IRegWrite,
    input [0:0] IRegStore,
    input [15:0] IALUResult,
    input [15:0] IStoreMem,
    input [15:0] IRd,
    input CLK,
    input Reset,
    input RegWrite,
    output [0:0] ORegWrite,
    output [0:0] ORegStore,
    output [15:0] OALUResult,
    output [15:0] OStoreMem,
    output [15:0] ORd,
);

always @ (posedge(CLK))
begin
    if (reset != 1) begin
        if(RegWrite == 1) begin
            ORegWrite = IRegWrite,
            ORegStore = IRegStore,
            OALUResult = IALUResult,
            OStoreMem = IStoreMem,
            ORd = IRd,
        end
    end else begin 
        reg_output = 16'b0000000000000000;
    end
end

endmodule
