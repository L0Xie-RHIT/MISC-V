`timescale 1 ns / 1 ps

module Control_tb();


    parameter HALF_PERIOD = 50;

    initial begin 
        CLK = 0;
        repeat (20) begin
            #(HALF_PERIOD);
            CLK = ~CLK;
        end
    end

    // Testbench logic
    initial begin
        
    $display("Control Tests finished");

    end

endmodule
