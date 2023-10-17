/*
The immediate generation logic must choose between sign-extending
a 7-bit field in instruction bits 15:9 for M instructions, bits 15:12 for R instructions, 
or bits 15:12 and 5:3 for the conditional branch. 
Since the input is all 16 bits of the instruction, it can use the opcode bits of the instruction
to select the proper field. 
RISC-V opcode bit 6 happens to be 0 for data transfer
instructions and 1 for conditional branches, and RISC-V opcode bit 5 happens to be 0
for load instructions and 1 for store instructions. Thus, bits 5 and 6 can control a 3:1
multiplexor inside the immediate generation logic that selects the appropriate 12-bit
field for load, store, and conditional branch instructions.
*/