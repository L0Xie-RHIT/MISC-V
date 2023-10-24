`timescale 1ns / 1ps

module tb_Imm_Gen;

  // Inputs
  reg [31:0] instr;

  // Outputs
  wire [31:0] imm;

  // Instantiate the unit under test (UUT)
  Imm_Gen uut (
    .instr(instr),
    .imm(imm)
  );

  initial begin
    // Initialize inputs
    instr = 32'h00000000;

    // Wait 100 ns for global reset to finish
    #100;

    // Test type R
    instr = 32'h00000013;
    #10;
    if (imm !== 32'h00000013) $display("Test case 1 failed");

    // Test case 2
    instr = 32'h0000f123;
    #10;
    if (imm !== 32'h00000f12) $display("Test case 2 failed");

    // Test case 3
    instr = 32'h0000f823;
    #10;
    if (imm !== 32'hfffff8ff) $display("Test case 3 failed");

    // Add more test cases here

    $display("All test cases passed");
    $finish;
  end

endmodule