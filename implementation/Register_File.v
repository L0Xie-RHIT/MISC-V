module Register_File(
    input [2:0] Reg_address1,
    input [2:0] Reg_address2,
    input [2:0] Reg_address3,
    input [15:0] Reg_input_data,
    input CLK,
    input Reset,
    input Reg_Read,
    input Reg_Write,
    output [15:0] Reg_output1,
    output [15:0] Reg_output2,
    output [15:0] Reg_output3
);

// Internal storage
reg [15:0] registers[7:0];

// Register Instantiations
Register reg0(.reg_input(registers[0]), .reset(Reset), .CLK(CLK), .reg_output(registers[0]));
Register reg1(.reg_input(registers[1]), .reset(Reset), .CLK(CLK), .reg_output(registers[1]));
Register reg2(.reg_input(registers[2]), .reset(Reset), .CLK(CLK), .reg_output(registers[2]));
Register reg3(.reg_input(registers[3]), .reset(Reset), .CLK(CLK), .reg_output(registers[3]));
Register reg4(.reg_input(registers[4]), .reset(Reset), .CLK(CLK), .reg_output(registers[4]));
Register reg5(.reg_input(registers[5]), .reset(Reset), .CLK(CLK), .reg_output(registers[5]));
Register reg6(.reg_input(registers[6]), .reset(Reset), .CLK(CLK), .reg_output(registers[6]));
Register reg7(.reg_input(registers[7]), .reset(Reset), .CLK(CLK), .reg_output(registers[7]));

// Mux for Reading
mux16b4 mux1(.a(registers[0]), .b(registers[1]), .c(registers[2]), .d(registers[3]), 
             .s(Reg_address1[1:0]), .r(Reg_output1));
mux16b4 mux2(.a(registers[0]), .b(registers[1]), .c(registers[2]), .d(registers[3]), 
             .s(Reg_address2[1:0]), .r(Reg_output2));
mux16b4 mux3(.a(registers[0]), .b(registers[1]), .c(registers[2]), .d(registers[3]), 
             .s(Reg_address3[1:0]), .r(Reg_output3));

// Logic for Writing
always @(posedge CLK) begin
    if (Reg_Write) begin
        case (Reg_address3)
            3'b000: registers[0] <= Reg_input_data;
            3'b001: registers[1] <= Reg_input_data;
            3'b010: registers[2] <= Reg_input_data;
            3'b011: registers[3] <= Reg_input_data;
            3'b100: registers[4] <= Reg_input_data;
            3'b101: registers[5] <= Reg_input_data;
            3'b110: registers[6] <= Reg_input_data;
            3'b111: registers[7] <= Reg_input_data;
        endcase
    end
end

endmodule
