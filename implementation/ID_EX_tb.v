`timescale 1 ns / 1 ps

module ID_EX_tb();

  // Define test bench regs for each input from the given module
  reg [0:0] IRegWrite;
  reg [0:0] IALUSrc;
  reg [2:0] IALUOP;
  reg [0:0] IMemWrite;
  reg [0:0] IMemRead;
  reg [0:0] IRegStore;
  reg [15:0] IPCP2;
  reg [15:0] I1stArg;
  reg [15:0] I2ndArg;
  reg [15:0] I3rdArg;
  reg [15:0] IImm;
  reg [15:0] IRs1;
  reg [15:0] IRs2;
  reg [15:0] IRd;
  reg CLK;
  reg Reset;
  reg RegWrite;

  // Define wires for each output from the given module
  wire [0:0] ORegWrite;
  wire [0:0] OALUSrc;
  wire [2:0] OALUOP;
  wire [0:0] OMemWrite;
  wire [0:0] OMemRead;
  wire [0:0] ORegStore;
  wire [15:0] OPCP2;
  wire [15:0] O1stArg;
  wire [15:0] O2ndArg;
  wire [15:0] O3rdArg;
  wire [15:0] OImm;
  wire [15:0] ORs1;
  wire [15:0] ORs2;
  wire [15:0] ORd;

  // Instantiate the module with connections
  ID_EX uut (
    .IRegWrite(IRegWrite),
    .IALUSrc(IALUSrc),
    .IALUOP(IALUOP),
    .IMemWrite(IMemWrite),
    .IMemRead(IMemRead),
    .IRegStore(IRegStore),
    .IPCP2(IPCP2),
    .I1stArg(I1stArg),
    .I2ndArg(I2ndArg),
    .I3rdArg(I3rdArg),
    .IImm(IImm),
    .IRs1(IRs1),
    .IRs2(IRs2),
    .IRd(IRd),
    .CLK(CLK),
    .Reset(Reset),
    .RegWrite(RegWrite),
    .ORegWrite(ORegWrite),
    .OALUSrc(OALUSrc),
    .OALUOP(OALUOP),
    .OMemWrite(OMemWrite),
    .OMemRead(OMemRead),
    .ORegStore(ORegStore),
    .OPCP2(OPCP2),
    .O1stArg(O1stArg),
    .O2ndArg(O2ndArg),
    .O3rdArg(O3rdArg),
    .OImm(OImm),
    .ORs1(ORs1),
    .ORs2(ORs2),
    .ORd(ORd)
  );

  parameter HALF_PERIOD = 50;

  initial begin
    CLK = 0;
    repeat (20) begin
      #(HALF_PERIOD);
      CLK = ~CLK;
    end
  end

  initial begin
    CLK = 0;
    Reset = 1;
    // Initialize all regs with corresponding values
    IRegWrite = 1'b0;
    IALUSrc = 1'b0;
    IALUOP = 3'b000;
    IMemWrite = 1'b0;
    IMemRead = 1'b0;
    IRegStore = 1'b0;
    IPCP2 = 16'h0000;
    I1stArg = 16'h0000;
    I2ndArg = 16'h0000;
    I3rdArg = 16'h0000;
    IImm = 16'h0000;
    IRs1 = 16'h0000;
    IRs2 = 16'h0000;
    IRd = 16'h0000;
    RegWrite = 1'b0;

    $display("ID_EX Tests finished");
  end


endmodule
