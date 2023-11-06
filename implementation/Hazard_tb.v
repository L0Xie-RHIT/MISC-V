module Hazard_tb;

    reg [1:0] rs1, rs2, rdEX, rdMEM, rdWB;
    reg mem_read, mem_write, write_enable_ex, write_enable_mem;
    wire stall, flush;

    Hazard UUT (
        .rs1(rs1),
        .rs2(rs2),
        .rdEX(rdEX),
        .rdMEM(rdMEM),
        .rdWB(rdWB),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .write_enable_ex(write_enable_ex),
        .write_enable_mem(write_enable_mem),
        .stall(stall),
        .flush(flush)
    );

    initial begin
        // Test case 1: stall required
        rs1 = 2'b01;
        rs2 = 2'b10;
        rdEX = 2'b01;
        rdMEM = 2'b00;
        rdWB = 2'b11;
        mem_read = 1;
        mem_write = 0;
        write_enable_ex = 1;
        write_enable_mem = 0;
        #10;
        if (stall && !flush) $display("Test case 1 passed");
        else $display("Test case 1 failed");

        // Test case 2: flush required
        rs1 = 2'b01;
        rs2 = 2'b10;
        rdEX = 2'b11;
        rdMEM = 2'b00;
        rdWB = 2'b00;
        mem_read = 0;
        mem_write = 0;
        write_enable_ex = 1;
        write_enable_mem = 0;
        #10;
        if (!stall && flush) $display("Test case 2 passed");
        else $display("Test case 2 failed");

        $stop;
    end

endmodule
