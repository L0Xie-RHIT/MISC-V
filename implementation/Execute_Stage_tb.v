`timescale 1 ns / 1 ps

module Execute_Stage_tb();

    // Define test bench inputs as regs
    reg IRegWrite;
    reg IALUSrc;
    reg [2:0] IALUOp;
    reg IMemWrite;
    reg IMemRead;
    reg IRegStore;
    reg [15:0] IOPCP2;
    reg [15:0] I1stArg;
    reg [15:0] I2ndArg;
    reg [15:0] I3rdArg;
    reg [15:0] Imm;
    reg [15:0] IRs1;
    reg [15:0] IRs2;
    reg [15:0] IRd;
    reg [15:0] rdMEM;
    reg [15:0] rdWB;
    reg [15:0] ALUResultMEM;
    reg [15:0] loadDataWB;
    reg reset;
    reg clk;

    // Define test bench outputs as wires
    wire ORegWrite;
    wire OMemWrite;
    wire OMemRead;
    wire ORegStore;
    wire [15:0] OPCP2;
    wire [15:0] OALUResult;
    wire [15:0] O3rdArg;
    wire [15:0] ORd;

    // Instantiate the module under test
    Execute_Stage UUT (
        .IRegWrite(IRegWrite),
        .IALUSrc(IALUSrc),
        .IALUOp(IALUOp),
        .IMemWrite(IMemWrite),
        .IMemRead(IMemRead),
        .IRegStore(IRegStore),
        .IOPCP2(IOPCP2),
        .I1stArg(I1stArg),
        .I2ndArg(I2ndArg),
        .I3rdArg(I3rdArg),
        .Imm(Imm),
        .IRs1(IRs1),
        .IRs2(IRs2),
        .IRd(IRd),
        .rdMEM(rdMEM),
        .rdWB(rdWB),
        .ALUResultMEM(ALUResultMEM),
        .loadDataWB(loadDataWB),
        .reset(reset),
        .clk(clk),
        .ORegWrite(ORegWrite),
        .OMemWrite(OMemWrite),
        .OMemRead(OMemRead),
        .ORegStore(ORegStore),
        .OPCP2(OPCP2),
        .OALUResult(OALUResult),
        .O3rdArg(O3rdArg),
        .ORd(ORd)
    );

    parameter HALF_PERIOD = 50;

    initial begin 
        clk = 0;
        repeat (20) begin
            #(HALF_PERIOD);
            clk = ~clk;
        end
    end

    initial begin
        clk = 0;
        reset = 1;
        // Initialize all regs with non-zero values
        IRegWrite = 1;
        IALUSrc = 0;
        IALUOp = 3'b001;
        IMemWrite = 0;
        IMemRead = 1;
        IRegStore = 1;
        IOPCP2 = 16'hA5A5;
        I1stArg = 16'h1234;
        I2ndArg = 16'h5678;
        I3rdArg = 16'h9ABC;
        Imm = 16'hDEAD;
        IRs1 = 16'hBEEF;
        IRs2 = 16'hCAFE;
        IRd = 16'hF00D;
        rdMEM = 16'h1234;
        rdWB = 16'h5678;
        ALUResultMEM = 16'h9ABC;
        loadDataWB = 16'hDEAD;

        $display("Execute_Stage Tests finished");
    end

endmodule
