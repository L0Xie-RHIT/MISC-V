`timescale 1 ns / 1 ps

module Decode_Stage_tb();
  reg [15:0] IPCP2;
  reg [15:0] pc_in;
  reg [15:0] ir_in;
  reg [3:0] loadAddr;
  reg [15:0] loadData;
  reg rf_write;
  reg reset;
  reg clk;
  wire RegWrite;
  wire ALUSrc;
  wire [2:0] ALUOp;
  wire [0:0] MemWrite;
  wire [0:0] MemRead;
  wire [0:0] RegStore;
  wire [15:0] OPCP2;
  wire [15:0] 1stArg;
  wire [15:0] 2ndArg;
  wire [15:0] 3rdArg;
  wire [15:0] Imm;
  wire [15:0] Rs1;
  wire [15:0] Rs2;
  wire [15:0] Rd;
  wire [15:0] new_pc;
  wire [0:0] jump;

  Decode_Stage uut (
    .IPCP2(IPCP2),
    .pc_in(pc_in),
    .ir_in(ir_in),
    .loadAddr(loadAddr),
    .loadData(loadData),
    .rf_write(rf_write),
    .reset(reset),
    .clk(clk),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .RegStore(RegStore),
    .OPCP2(OPCP2),
    .1stArg(1stArg),
    .2ndArg(2ndArg),
    .3rdArg(3rdArg),
    .Imm(Imm),
    .Rs1(Rs1),
    .Rs2(Rs2),
    .Rd(Rd),
    .new_pc(new_pc),
    .jump(jump)
  );

  parameter HALF_PERIOD = 50;

  initial begin 
    clk = 0;
    forever begin
      #(HALF_PERIOD);
      clk = ~clk;
    end
  end

  initial begin
    reset = 1;
    rf_write = 0;

    #(4*HALF_PERIOD);

    if ( RegWrite != 0
      ALUSrc != 0
      ALUOp != 0
      MemWrite != 0
      MemRead != 0
      RegStore != 0
      OPCP2 != 0
      1stArg != 0
      2ndArg != 0
      3rdArg != 0
      Imm != 0
      Rs1 != 0
      Rs2 != 0
      Rd != 0
      new_pc != 0
      jump != 0) begin
      $display("The Block does not initialize. No other tests will be run.");
		  $stop;
    end

    reset = 0;
    #(4*HALF_PERIOD);

    IPCP2 = $random;
    pc_in = $random;
    ir_in = $random;
    loadAddr = $random;
    loadData = $random;
    reset = 0;

    if ( RegWrite != 0
      ALUSrc != 0
      ALUOp != 0
      MemWrite != 0
      MemRead != 0
      RegStore != 0
      OPCP2 != 0
      1stArg != 0
      2ndArg != 0
      3rdArg != 0
      Imm != 0
      Rs1 != 0
      Rs2 != 0
      Rd != 0
      new_pc != 0
      jump != 0) begin
      $display("The Block writes when it should not. No further testing will be done.");
		  $stop;
    end

    rf_write = 1;

    // IPCP2 = ;
    // pc_in = ;
    // ir_in = ;
    // loadAddr = ;
    // loadData = ;
    // #(2*HALF_PERIOD);

    // if ( RegWrite !=  ||
    //   ALUSrc !=  ||
    //   ALUOp !=  || 
    //   MemWrite !=  ||
    //   MemRead !=  || 
    //   RegStore !=  ||
    //   OPCP2 !=  ||
    //   1stArg !=  ||
    //   2ndArg !=  ||
    //   3rdArg !=  ||
    //   Imm !=  ||
    //   Rs1 !=  ||
    //   Rs2 !=  ||
    //   Rd !=  ||
    //   new_pc !=  ||
    //   jump != ) begin
    //   $display("Error:");
    // // end

    IPCP2 = 200;
    pc_in = 0;
    ir_in = 0;
    loadAddr = 0;
    loadData = 0;
    #(2*HALF_PERIOD);

    if ( RegWrite != 0 ||
      ALUSrc != 0 ||
      ALUOp != 0 || 
      MemWrite != 0 ||
      MemRead != 0 || 
      RegStore != 0 ||
      OPCP2 != 200 ||
      1stArg != 0 ||
      2ndArg != 0 ||
      3rdArg != 0 ||
      Imm != 0 ||
      Rs1 != 0 ||
      Rs2 != 0 ||
      Rd != 0 ||
      new_pc != 0 ||
      jump != 0) begin
      $display("Error: PC + 2 does not propogate correctly.");
    end

    IPCP2 = 0;
    pc_in = 13;
    ir_in = 0;
    loadAddr = 0;
    loadData = 0;
    #(2*HALF_PERIOD);

    if ( RegWrite != 0 ||
      ALUSrc != 0 ||
      ALUOp != 0 ||
      MemWrite != 0 ||
      MemRead != 0 ||
      RegStore != 0 ||
      OPCP2 != 0 ||
      1stArg != 0 ||
      2ndArg != 0 ||
      3rdArg != 0 ||
      Imm != 0 ||
      Rs1 != 0 ||
      Rs2 != 0 ||
      Rd != 0 ||
      new_pc != 13 ||
      jump != 0) begin
      $display("Error: PC in does not add correctly.");
    end

    // IPCP2 = 0;
    // pc_in = 0;
    // ir_in = 0;
    // loadAddr = 0;
    // loadData = 0;
    // #(2*HALF_PERIOD);

    // if ( RegWrite != 0 ||
    //   ALUSrc != 0 ||
    //   ALUOp != 0 ||
    //   MemWrite != 0 ||
    //   MemRead != 0 ||
    //   RegStore != 0 ||
    //   OPCP2 != 0 ||
    //   1stArg != 0 ||
    //   2ndArg != 0 ||
    //   3rdArg != 0 ||
    //   Imm != 0 ||
    //   Rs1 != 0 ||
    //   Rs2 != 0 ||
    //   Rd != 0 ||
    //   new_pc != 0 ||
    //   jump != 0) begin
    //   $display("Error: PC + 2 does not propogate corectly.");
    // end

    $display("Decode_Stage Tests finished");
  end

endmodule
