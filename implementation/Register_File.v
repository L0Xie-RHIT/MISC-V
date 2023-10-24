module Register_File(
    input [2:0] Reg_address1,
    input [2:0] Reg_address2,
    input [2:0] Reg_address3,
    input [15:0] Reg_input_data,
    input CLK,
    input Reset,
    input Reg_Write,
    output reg [15:0] Reg_output1,
    output reg [15:0] Reg_output2,
    output reg [15:0] Reg_output3
);

// Internal storage
reg [15:0] registers[7:0];

wire [7:0] decoder_output;
decoder3b8 decoder_inst (.in(Reg_address3), .out(decoder_output));

// Register Instantiations
Register reg0(.reg_input(Reg_input_data), .reg_write(decoder_output[0] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[0]));
Register reg1(.reg_input(Reg_input_data), .reg_write(decoder_output[1] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[1]));
Register reg2(.reg_input(Reg_input_data), .reg_write(decoder_output[2] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[2]));
Register reg3(.reg_input(Reg_input_data), .reg_write(decoder_output[3] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[3]));
Register reg4(.reg_input(Reg_input_data), .reg_write(decoder_output[4] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[4]));
Register reg5(.reg_input(Reg_input_data), .reg_write(decoder_output[5] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[5]));
Register reg6(.reg_input(Reg_input_data), .reg_write(decoder_output[6] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[6]));
Register reg7(.reg_input(Reg_input_data), .reg_write(decoder_output[7] && Reg_Write),
    .reset(Reset), .CLK(CLK), .reg_output(registers[7]));

    // Reading first address
    wire [15:0] mux_connection1[1:0];
    wire [15:0] output1;
    mux16b4 lower1_mux1(.a(registers[0]), .b(registers[1]), .c(registers[2]), .d(registers[3]), 
                .s(Reg_address1[1:0]), .r(mux_connection1[0]));
    mux16b4 lower2_mux1(.a(registers[4]), .b(registers[5]), .c(registers[6]), .d(registers[7]), 
                .s(Reg_address1[1:0]), .r(mux_connection1[1]));

    mux16b2 upper_mux1(.a(mux_connection1[0]), .b(mux_connection1[1]), .s(Reg_address1[2]), .r(output1));



    // Reading second address
    wire [15:0] mux_connection2[1:0];
    wire [15:0] output2;
    mux16b4 lower1_mux2(.a(registers[0]), .b(registers[1]), .c(registers[2]), .d(registers[3]), 
                .s(Reg_address2[1:0]), .r(mux_connection2[0]));
    mux16b4 lower2_mux2(.a(registers[4]), .b(registers[5]), .c(registers[6]), .d(registers[7]), 
                .s(Reg_address2[1:0]), .r(mux_connection2[1]));

    mux16b2 upper_mux2(.a(mux_connection2[0]), .b(mux_connection2[1]), .s(Reg_address2[2]), .r(output2));



    // Reading second address
    wire [15:0] mux_connection3[1:0];
    wire [15:0] output3;
    mux16b4 lower1_mux3(.a(registers[0]), .b(registers[1]), .c(registers[2]), .d(registers[3]), 
                .s(Reg_address3[1:0]), .r(mux_connection3[0]));
    mux16b4 lower2_mux3(.a(registers[4]), .b(registers[5]), .c(registers[6]), .d(registers[7]), 
                .s(Reg_address3[1:0]), .r(mux_connection3[1]));

    mux16b2 upper_mux3(.a(mux_connection3[0]), .b(mux_connection3[1]), .s(Reg_address3[2]), .r(output3));

always @ (negedge(CLK))
begin
    Reg_output1 <= output1;
    Reg_output2 <= output2;
    Reg_output3 <= output3;
end

endmodule
