`timescale 1ns/1ps

module Register_File_tb();

    // Declare signals for the Register_File inputs and outputs
    reg [2:0] Reg_address1;
    reg [2:0] Reg_address2;
    reg [2:0] Reg_address3;
    reg [15:0] Reg_input_data;
    reg CLK;
    reg Reset;
    reg Reg_Read;
    reg Reg_Write;

    wire [15:0] Reg_output1;
    wire [15:0] Reg_output2;
    wire [15:0] Reg_output3;

    // Instantiate the Register_File module
    Register_File UUT (
        .Reg_address1(Reg_address1),
        .Reg_address2(Reg_address2),
        .Reg_address3(Reg_address3),
        .Reg_input_data(Reg_input_data),
        .CLK(CLK),
        .Reset(Reset),
        .Reg_Read(Reg_Read),
        .Reg_Write(Reg_Write),
        .Reg_output1(Reg_output1),
        .Reg_output2(Reg_output2),
        .Reg_output3(Reg_output3)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // Generate clock with a period of 10ns
    end

    // Testbench logic
    initial begin

        // Reset sequence
        Reset = 1;
        Reg_Write = 0;
        Reg_Read = 0;
        #10;
        Reset = 0;
        #10;

        // Test Writing
        Reg_address3 = 3'b001;
        Reg_input_data = 16'd1234;
        Reg_Write = 1;
        #10;
        Reg_Write = 0;
        #10;

        // Test Reading
        Reg_address1 = 3'b001;
        Reg_address2 = 3'b010;
        Reg_address3 = 3'b011;
        Reg_Read = 1;
        #10;
        Reg_Read = 0;
        #10;

        // Complete the simulation
        $finish;
    end

endmodule
