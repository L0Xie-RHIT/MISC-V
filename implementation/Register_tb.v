`timescale 1 ns / 1 ps 

module Register_tb();
    reg [15:0] reg_input;
    reg reg_write;
    reg reset;
    reg CLK;

    wire [15:0] reg_output;

    Register UUT(
        .reg_input(reg_input),
        .reg_write(reg_write),
        .reset(reset),
        .CLK(CLK),
        .reg_output(reg_output)
    );

    parameter HALF_PERIOD = 50;

    initial begin 
        CLK = 0;
        repeat (100) begin
            #(HALF_PERIOD);
            CLK = ~CLK;
        end
    end

    initial begin
        reset = 0;
        reg_write = 0;

        #(10*HALF_PERIOD);
        reset = 1;
        #(2*HALF_PERIOD);
        reset = 0;

        if(reg_output != 16'b0000000000000000) begin
            $display("Register Test 1 failed: reset error");
        end

        #(10*HALF_PERIOD);

        reg_input = 16'b1000100010001000;
        reg_write = 1;
        #(2*HALF_PERIOD);

        if(reg_output != 16'b1000100010001000) begin
            $display("Register Test 2 failed: input persistance error");
        end

        #(10*HALF_PERIOD);

        reg_write = 0;
        reg_input = 16'b1111111111111111;

        #(2*HALF_PERIOD);
        
        if(reg_output != 16'b1000100010001000) begin
            $display("Register Test 3 failed: register writes in all cases");
        end

        $display("Register Test finished");

        $finish;
    end

endmodule