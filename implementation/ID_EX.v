module ID_EX(
    input [0:0] IRegWrite,
    input [0:0] IALUSrc,
    input [2:0] IALUOP,
    input [0:0] IBranch,
    input [0:0] IMemWrite,
    input [0:0] IMemRead,
    input [0:0] IRegStore,
    input [15:0] I1stArg,
    input [15:0] I2ndArg,
    input [15:0] I3rdArg,
    input [15:0] IImm,
    input [15:0] IRs1,
    input [15:0] IRs2,
    input [15:0] IRd,
    input CLK,
    input Reset,
    input RegWrite,
    output [0:0] ORegWrite,
    output [0:0] OALUSrc,
    output [2:0] OALUOP,
    output [0:0] OBranch,
    output [0:0] OMemWrite,
    output [0:0] OMemRead,
    output [0:0] ORegStore,
    output [15:0] O1stArg,
    output [15:0] O2ndArg,
    output [15:0] O3rdArg,
    output [15:0] OImm,
    output [15:0] ORs1,
    output [15:0] ORs2,
    output [15:0] ORd,
);

always @ (posedge(CLK))
begin
    if (reset != 1) begin
        if(RegWrite == 1) begin
            ORegWrite = IRegWrite,
            OALUSrc = IALUSrc,
            OALUOP = IALUOP,
            OBranch = IBranch,
            OMemWrite = IMemWrite,
            OMemRead = IMemRead,
            ORegStore = IRegStore,
            O1stArg = I1stArg,
            O2ndArg = I2ndArg,
            O3rdArg = I3rdArg,
            OImm = IImm,
            ORs1 = IRs1,
            ORs2 = IRs2,
            ORd = IRd,
        end
    end else begin 
        reg_output = 16'b0000000000000000;
    end
end

endmodule
