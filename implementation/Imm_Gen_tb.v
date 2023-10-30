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
    // Test type R
    instr = 16'b0000000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type R positive case failed");
    #10;
    instr = 16'b0000000000001000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type R negative case failed");
    #10;

    // Test type I
    instr = 16'b0010000000000100;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type I positive case failed");
    #10;
    instr = 16'b0010000000100000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type I negative case failed");
    #10;

    // Test type M
    instr = 16'b0100000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type M positive case 1 failed");
    #10;
    instr = 16'b0100000001000000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type M negative case 1 failed");
    #10;
    instr = 16'b0110000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type M positive case 2 failed");
    #10;
    instr = 16'b0110000001000000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type M negative case 2 failed");
    #10;

    // Test type Y
    instr = 16'b1000000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type Y positive case 1 failed");
    #10;
    instr = 16'b1001000000000000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type Y negative case 1 failed");
    #10;
    instr = 16'b1010000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type Y positive case 2 failed");
    #10;
    instr = 16'b1011000000000000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type Y negative case 2 failed");
    #10;

    // Test type J
    instr = 16'b1100000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type J positive case 1 failed");
    #10;
    instr = 16'b1101000000000000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type J negative case 1 failed");
    #10;
    instr = 16'b1110000000000001;
    #10;
    if (imm !== 16'b0000000000000001) $display("Type J positive case 2 failed");
    #10;
    instr = 16'b1111000000000000;
    #10;
    if (imm !== 16'b1111111111111000) $display("Type J negative case 2 failed");
    #10;

    $display("All test cases passed");
    $finish;
  end

endmodule