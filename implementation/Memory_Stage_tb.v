`timescale 1 ns / 1 ps 

module Memory_Stage_tb();
    reg reset;
    reg CLK;
    reg IRegWrite;
    reg IRegStore;
    reg MemWrite;
    reg MemRead;
    reg [15:0] IALUResult;
    reg [15:0] thirdArg;
    reg [2:0] rdMem;
    
    wire ORegWrite;
    wire ORegStore;
    wire [15:0] OALUResult;
    wire [15:0] StoreMem;
    wire [2:0] rdWB;

    Memory_Stage uut (
        .reset(reset),
        .clk(CLK),
        .IRegWrite(IRegWrite),
        .IRegStore(IRegStore),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .IALUResult(IALUResult),
        .thirdArg(thirdArg),
        .rdMem(rdMem),
        .ORegWrite(ORegWrite),
        .ORegStore(ORegStore),
        .OALUResult(OALUResult),
        .StoreMem(StoreMem),
        .rdWB(rdWB)
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
        IRegWrite = 1;
        IRegStore = 1;
        MemWrite = 0;
        MemRead = 1;
        IALUResult = 'h0004;
        thirdArg = 'hAAAA;
        rdMem = 'b101;

        #(2*HALF_PERIOD);

        if(ORegWrite != 0 || ORegStore != 0 || OALUResult != 0 || StoreMem != 0 || rdWB != 0) begin
            $display("Test 1 Error: Reset error");
        end

        reset = 0;
        MemWrite = 1;

        #(2*HALF_PERIOD);
        if(ORegWrite != IRegWrite || ORegStore != IRegStore || OALUResult != IALUResult || StoreMem != thirdArg || rdWB != rdMem) begin
            $display("Test 2 Error: Memory Stage output is wrong");
        end

        $display("Write Stage Test finished");

    end

endmodule