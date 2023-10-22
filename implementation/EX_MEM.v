module EX_MEM(
    input [0:0] IRegWrite,
    input [0:0] IALUSrc,
    input [2:0] IALUOP,
    input [0:0] IMemWrite,
    input [0:0] IMemRead,
    input [0:0] IRegStore,
    input [15:0] IALUResult,
    input [15:0] I3rdArg,
    input [15:0] IRd,
    input CLK,
    input Reset,
    input RegWrite,
    output [0:0] ORegWrite,
    output [0:0] OALUSrc,
    output [2:0] OALUOP,
    output [0:0] OMemWrite,
    output [0:0] OMemRead,
    output [0:0] ORegStore,
    output [15:0] OALUResult,
    output [15:0] O3rdArg,
    output [15:0] ORd,
);

always @ (posedge(CLK))
begin
    if (reset != 1) begin
        if(RegWrite == 1) begin
            ORegWrite = IRegWrite,
            OALUSrc = IALUSrc,
            OALUOP = IALUOP,
            OMemWrite = IMemWrite,
            OMemRead = IMemRead,
            ORegStore = IRegStore,
            OALUResult = IALUResult,
            O3rdArg = I3rdArg,
            ORd = IRd,
        end
    end else begin 
        reg_output = 16'b0000000000000000;
    end
end

endmodule
