module ALU_Adder_tb();

//inputs
reg[15:0] first_input;
reg[15:0] second_input;
reg[0:0] clock;

//output
wire signed[15:0] result;

//instantiate any module to test (in this case, the ALU)
ALU_Adder ALU_Adder_uut(
	.FirstInput(first_input),
	.SecondInput(second_input),
	.CLK(clock),
    .OutputData(result)
);

//clockwork
parameter HALF_PERIOD = 50;

integer failures = 0;

initial begin
    clock = 0;
    forever begin
        #(HALF_PERIOD);
        clock = ~clock;
    end
end

initial begin
	
 	//-----TEST 1-----
	//Testing initilization
	$display("Testing inilitilization.");
	
    first_input = 0;
    second_input = 0;
	
	#(2*HALF_PERIOD);
	
	if (result != 0) begin
		$display("The Block does not initialize. No other tests will be run.");
	end
	
	//-----TEST 2-----
	//testing Add values.
	
    first_input = 1;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 2) begin
		$display("There is an error in add: basic addition");
        failures = failures + 1;
	end

    first_input = 15;
    second_input = 28;

    #(2*HALF_PERIOD);

    if (result != 43) begin
		$display("There is an error in add: complex addition");
        failures = failures + 1;
	end

    first_input = -13;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -9) begin
		$display("There is an error in add: basic negative addition");
        failures = failures + 1;
	end

    first_input = -3;
    second_input = -5;

    #(2*HALF_PERIOD);

    if (result != -8) begin
		$display("There is an error in add: complex addition");
        failures = failures + 1;
	end
	$display("TESTS COMPLETE. \n Failures = %d", failures);
end
endmodule