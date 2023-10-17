/*
The immediate generation logic must choose between sign-extending a field in instruction bits 
15:12 for R register instructions, 
13:9 for I immediate instructions,
15:12 and 5:3 for Y conditional branch,
15:9 for M memory instructions, 
15:6 for J jump instructions.
Since the input is all 16 bits of the instruction, it can use the opcode bits of the instruction to select the proper field. 

RISC-V opcode bit 6 happens to be 0 for data transfer
instructions and 1 for conditional branches, and RISC-V opcode bit 5 happens to be 0
for load instructions and 1 for store instructions. Thus, bits 5 and 6 can control a 3:1
multiplexor inside the immediate generation logic that selects the appropriate 12-bit
field for load, store, and conditional branch instructions.
*/