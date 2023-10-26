module IF_ID(
    input [15:0] IPC,
    input [15:0] IIR,
    input CLK,
    input Reset,
    input RegWrite,
    output reg[15:0] OPC,
    output reg[15:0] OIR
);

always @ (posedge(CLK))
begin
    if (reset != 1) begin
        if(RegWrite == 1) begin
            OPC = IPC;
            OIR = IIR;
        end
    end else begin 
        OPC = 'h0000;
        OIR = 'h0000;
    end
end

endmodule
