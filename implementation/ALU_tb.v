module ALU_tb();

//inputs
reg[15:0] first_input;
reg[15:0] second_input;
reg[2:0] opcode;
reg[0:0] clock;

//output
wire[15:0] result;
wire[0:0] is_zero;

//instantiate any module to test (in this case, the ALU)
ALU ALU_uut(
	.FirstInput(first_input),
	.SecondInput(second_input),
	.ALUOp(opcode),
	.CLK(clock),
    .OutputData(result),
    .Zero(is_zero)
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
    opcode = 0;
	
	#(2*HALF_PERIOD);
	
	if (result != 0 || is_zero != 1) begin
		$display("The Block does not initialize. No other tests will be run.");
		$stop;
	end

    //-----TEST 2-----
	//Testing noop
	$display("Testing noop.");
    opcode = 0;
	
    first_input = 0;
    second_input = 0;
	
	#(2*HALF_PERIOD);
	
	if (result != 0 || is_zero != 1) begin
		$display("There is an error in noop. Somehow.");
		$stop;
	end

    repeat (5) begin
        first_input = $random;
        second_input = $random;
	
	    #(2*HALF_PERIOD);
	
	    if (result != 0 || is_zero != 1) begin
		    $display("There is an error in noop. Somehow.");
		    $stop;
	    end
    end
	
	//-----TEST 3-----
	//testing Add values.
    opcode = 1;
	
    first_input = 1;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 2 || is_zero != 0) begin
		$display("There is an error in add: basic addition");
        failures = failures + 1;
	end

    first_input = 15;
    second_input = 28;

    #(2*HALF_PERIOD);

    if (result != 43 || is_zero != 0) begin
		$display("There is an error in add: complex addition");
        failures = failures + 1;
	end

    first_input = -13;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -9 || is_zero != 0) begin
		$display("There is an error in add: basic negative addition");
        failures = failures + 1;
	end

    first_input = -3;
    second_input = -5;

    #(2*HALF_PERIOD);

    if (result != -8 || is_zero != 0) begin
		$display("There is an error in add: complex addition");
        failures = failures + 1;
	end


	//-----TEST 4-----
	//testing subtract values.
    opcode = 2;
	
    first_input = 1;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in subtract: basic subtraction");
        failures = failures + 1;
	end

    first_input = 15;
    second_input = 28;

    #(2*HALF_PERIOD);

    if (result != -13 || is_zero != 0) begin
		$display("There is an error in subtract: complex subtraction");
        failures = failures + 1;
	end

    first_input = -13;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -17 || is_zero != 0) begin
		$display("There is an error in subtract: basic negative subtraction, headed negative");
        failures = failures + 1;
	end

    first_input = 13;
    second_input = -4;

    #(2*HALF_PERIOD);

    if (result != 17 || is_zero != 0) begin
		$display("There is an error in subtract: basic negative subtraction, headed positive");
        failures = failures + 1;
	end

    first_input = -3;
    second_input = -5;

    #(2*HALF_PERIOD);

    if (result != 2 || is_zero != 0) begin
		$display("There is an error in subtract: double negative subtraction");
        failures = failures + 1;
	end

    //-----TEST 5-----
	//testing or values.
    opcode = 3;
	
    first_input = 1;
    second_input = 2;

    #(2*HALF_PERIOD);

    if (result != 3 || is_zero != 0) begin
		$display("There is an error in or: simple or");
        failures = failures + 1;
	end

    first_input = -15;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -11 || is_zero != 0) begin
		$display("There is an error in or: complex or");
        failures = failures + 1;
	end

    first_input = 0;
    second_input = 0;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in or: zero or");
        failures = failures + 1;
	end

    //-----TEST 6-----
	//testing and values.
    opcode = 4;
	
    first_input = 1;
    second_input = 2;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in and: simple and");
        failures = failures + 1;
	end

    first_input = -15;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in and: complex and");
        failures = failures + 1;
	end

    first_input = -15;
    second_input = 3;

    #(2*HALF_PERIOD);

    if (result != 1 || is_zero != 0) begin
		$display("There is an error in and: complex and 2");
        failures = failures + 1;
	end

	$display("TESTS COMPLETE. \n Failures = %d", failures);
	$stop;

    //-----TEST 7-----
	//testing Shift left values.
    opcode = 6;
	
    first_input = 1;
    second_input = 2;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in and: simple and");
        failures = failures + 1;
	end
end
endmodule