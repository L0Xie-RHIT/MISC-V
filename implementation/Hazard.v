module Hazard(
    input [1:0] rs1,
    input [1:0] rs2,
    input [1:0] rdEX,
    input [1:0] rdMEM,
    input [1:0] rdWB,
    input mem_read, // MEM stage is a load instruction
    input mem_write, // MEM stage is a store instruction
    input write_enable_ex, // Write enable signal for the EX stage
    input write_enable_mem, // Write enable signal for the MEM stage
    output wire stall, // Stall signal to insert bubbles in the pipeline
    output wire flush // Flush signal to reset the pipeline
);

    assign stall = ((rs1 == rd_ex || rs2 == rd_ex) && write_enable_ex) || 
                   ((rs1 == rd_mem || rs2 == rd_mem) && (write_enable_mem || mem_read || mem_write));

    assign flush = ((rs1 == rd_ex || rs2 == rd_ex) && write_enable_ex) || 
                   ((rs1 == rd_mem || rs2 == rd_mem) && (write_enable_mem || mem_read || mem_write)) || 
                   ((rs1 == rd_wb || rs2 == rd_wb) && (write_enable_mem || write_enable_ex));

endmodule
