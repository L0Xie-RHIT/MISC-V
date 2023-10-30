module ALU_tb();

//inputs
reg[15:0] first_input;
reg[15:0] second_input;
reg[2:0] opcode;
reg[0:0] clock;

//output
wire signed[15:0] result;

//instantiate any module to test (in this case, the ALU)
ALU ALU_uut(
	.FirstInput(first_input),
	.SecondInput(second_input),
	.ALUOp(opcode),
	.CLK(clock),
    .OutputData(result),
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
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
		$stop;
	end

    repeat (5) begin
        first_input = $random;
        second_input = $random;
	
	    #(2*HALF_PERIOD);
	
	    if (result != 0 || is_zero != 1) begin
		    $display("There is an error in noop. Somehow.");
            $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
		    $stop;
	    end
    end
	
	//-----TEST 3-----
	//testing Add values.
    opcode = 1;
	
    first_input = 1;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 2 || is_zero != 1) begin
		$display("There is an error in add: basic addition");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 15;
    second_input = 28;

    #(2*HALF_PERIOD);

    if (result != 43 || is_zero != 0) begin
		$display("There is an error in add: complex addition");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -13;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -9 || is_zero != 0) begin
		$display("There is an error in add: basic negative addition.");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -3;
    second_input = -5;

    #(2*HALF_PERIOD);

    if (result != -8 || is_zero != 0) begin
		$display("There is an error in add: complex addition");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
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
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 15;
    second_input = 28;

    #(2*HALF_PERIOD);

    if (result != -13 || is_zero != 0) begin
		$display("There is an error in subtract: complex subtraction");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -13;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -17 || is_zero != 0) begin
		$display("There is an error in subtract: basic negative subtraction, headed negative");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 13;
    second_input = -4;

    #(2*HALF_PERIOD);

    if (result != 17 || is_zero != 0) begin
		$display("There is an error in subtract: basic negative subtraction, headed positive");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -3;
    second_input = -5;

    #(2*HALF_PERIOD);

    if (result != 2 || is_zero != 0) begin
		$display("There is an error in subtract: double negative subtraction");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
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
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -15;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != -11 || is_zero != 0) begin
		$display("There is an error in or: complex or");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 0;
    second_input = 0;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in or: zero or");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
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
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -15;
    second_input = 4;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 1) begin
		$display("There is an error in and: complex and");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -15;
    second_input = 3;

    #(2*HALF_PERIOD);

    if (result != 1 || is_zero != 0) begin
		$display("There is an error in and: complex and 2");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    //-----TEST 7-----
	//testing Shift left values.
    opcode = 6;
	
    first_input = 1;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 2 || is_zero != 1) begin
		$display("There is an error in left shift: simple shift");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 10;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 20 || is_zero != 0) begin
		$display("There is an error in left shift: simple shift 2");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -4;
    second_input = 3;

    #(2*HALF_PERIOD);

    if (result != -32 || is_zero != 0) begin
		$display("There is an error in left shift: complex shift");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 8;
    second_input = -3;

    #(2*HALF_PERIOD);

    if (result != 1 || is_zero != 0) begin
		$display("There is an error in left shift: possible fail shift (TESTING FOR RIGHT MERGE)");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 0;
    second_input = $random;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 0) begin
		$display("There is an error in left shift: shifting zero");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    //-----TEST 8-----
	//testing Shift right values.
    opcode = 7;
	
    first_input = 2;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 1 || is_zero != 0) begin
		$display("There is an error in left right: simple shift");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 10;
    second_input = 1;

    #(2*HALF_PERIOD);

    if (result != 5 || is_zero != 0) begin
		$display("There is an error in left right: simple shift 2");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = -8;
    second_input = 3;

    #(2*HALF_PERIOD);

    if (result != -1 || is_zero != 0) begin
		$display("There is an error in right shift: complex shift");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 8;
    second_input = -3;

    #(2*HALF_PERIOD);

    if (result != 64 || is_zero != 0) begin
		$display("There is an error in right shift: possible fail shift (TESTING FOR LEFT MERGE)");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

    first_input = 0;
    second_input = $random;

    #(2*HALF_PERIOD);

    if (result != 0 || is_zero != 0) begin
		$display("There is an error in right shift: shifting zero");
        $display("result:%d is_zero: %d Time: %d", result, is_zero, $time);
        failures = failures + 1;
	end

	$display("TESTS COMPLETE. \n Failures = %d", failures);
	$stop;
end
endmodule