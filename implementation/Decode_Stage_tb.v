`timescale 1 ns / 1 ps

module Decode_Stage_tb();
  reg [15:0] IPCP2;
  reg [15:0] pc_in;
  reg [15:0] ir_in;
  reg [15:0] loadAddr;
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
    repeat (20) begin
      #(HALF_PERIOD);
      clk = ~clk;
    end
  end

  initial begin
    clk = 0;
    reset = 1;
    rf_write = 1;

    IPCP2 = 16'h1234; // Initialize input values as needed
    pc_in = 16'h5678;
    ir_in = 16'h9abc;
    loadAddr = 16'hdef0;
    loadData = 16'h5678;
    reset = 0;

    $display("Decode_Stage Tests finished");
  end

endmodule
