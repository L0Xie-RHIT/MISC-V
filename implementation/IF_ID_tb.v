`timescale 1 ns / 1 ps 

module IF_ID_tb();
    reg [15:0] IPC;
    reg [15:0] IIR;
    reg reg_write;
    reg reset;
    reg CLK;

    wire [15:0] OPC;
    wire [15:0] OIR;

    IF_ID uut (
        .IPC(IPC),
        .IIR(IPC),
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
        Reset = 1;
        reg_write = 0;

        #(2*HALF_PERIOD);

        if(OPC != 0 || OIR != 0) begin
            $display("Test 1: Reset error");
        end

        IPC = 'h1234;
        IIR = 'h5678;

        #(2*HALF_PERIOD);

        if(OPC != IPC || OIR != IIR) begin
            $display("Test 2: Register persistence error");
        end

        $display("IF ID Test finished");

        $finish;
    end

endmodule