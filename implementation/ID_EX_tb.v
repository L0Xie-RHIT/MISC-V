`timescale 1 ns / 1 ps 

module IF_ID_tb();
    //inputs
    reg [0:0] IRegWrite,
    reg [0:0] IALUSrc,
    reg [2:0] IALUOP,
    reg [0:0] IMemWrite,
    reg [0:0] IMemRead,
    reg [0:0] IRegStore,
    reg [15:0] I1stArg,
    reg [15:0] I2ndArg,
    reg [15:0] I3rdArg,
    reg [15:0] IImm,
    reg [15:0] IRs1,
    reg [15:0] IRs2,
    reg [15:0] IRd,
    reg reg_write;
    reg reset;
    reg CLK;
    //outputs
    wire[0:0] ORegWrite,
    wire[0:0] OALUSrc,
    wire[2:0] OALUOP,
    wire[0:0] OMemWrite,
    wire[0:0] OMemRead,
    wire[0:0] ORegStore,
    wire[15:0] O1stArg,
    wire[15:0] O2ndArg,
    wire[15:0] O3rdArg,
    wire[15:0] OImm,
    wire[15:0] ORs1,
    wire[15:0] ORs2,
    wire[15:0] ORd

    IF_ID uut (
        .IPC(IPC),
        .IIR(IIR),
        .CLK(CLK),
        .Reset(reset),
        .RegWrite(reg_write),
        .OPC(OPC),
        .OIR(OIR)
    );

    parameter HALF_PERIOD = 50;

    initial begin 
        CLK = 0;
        repeat (20) begin
            #(HALF_PERIOD);
            CLK = ~CLK;
        end
    end

    initial begin
        CLK = 0;
        reset = 1;
        reg_write = 0;

        #(2*HALF_PERIOD);

        if(OPC != 0 || OIR != 0) begin
            $display("Test 1: Reset error");
        end

        reset = 0;
        reg_write = 1;
        IPC = 'h1234;
        IIR = 'h5678;

        #(2*HALF_PERIOD);

        if(OPC != IPC || OIR != IIR) begin
            $display("Test 2: Register persistence error");
        end

        reg_write = 0;
        IPC = 'hFFFF;
        IIR = 'hAAAA;

        #(2*HALF_PERIOD);

        if(OPC == IPC || OIR == IIR) begin
            $display("Test 3: Register writes without write bit set");
        end

        $display("IF ID Test finished");

    end

endmodule