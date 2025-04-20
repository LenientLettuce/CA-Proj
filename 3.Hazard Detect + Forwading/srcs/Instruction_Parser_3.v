module Instruction_Parser_3(
    input [31:0] instruction,    // 32-bit instruction input
    output [6:0] opcode,         // 7-bit opcode output
    output [4:0] rd,             // 5-bit rd output
    output [2:0] funct3,         // 3-bit funct3 output
    output [4:0] rs1,            // 5-bit rs1 output
    output [4:0] rs2,            // 5-bit rs2 output
    output [6:0] funct7          // 7-bit funct7 output
    );
    
    assign opcode = instruction[6:0];    // Extract opcode
    assign rd = instruction[11:7];       // Extract rd
    assign funct3 = instruction[14:12];  // Extract funct3
    assign rs1 = instruction[19:15];     // Extract rs1
    assign rs2 = instruction[24:20];     // Extract rs2
    assign funct7 = instruction[31:25];  // Extract funct7
endmodule
