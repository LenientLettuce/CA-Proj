`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2025 02:45:04 PM
// Design Name: 
// Module Name: Instruction_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Memory(
    input [63:0] Instr_Addr,    // 64-bit instruction address input
    output [31:0] Instruction   // 32-bit instruction output
    );
    
    // Declaring a memory array with 16 entries of 8-bit width (bytes)
    reg [7:0] Inst_Memory[15:0];  
    
    // Initializing the instruction memory with values
    initial begin
         Inst_Memory[0] = 8'b10000011;
         Inst_Memory[1] = 8'b00110100;
         Inst_Memory[2] = 8'b00000101;
         Inst_Memory[3] = 8'b00001111;
         Inst_Memory[4] = 8'b10110011;
         Inst_Memory[5] = 8'b10000100;
         Inst_Memory[6] = 8'b10011010;
         Inst_Memory[7] = 8'b00000000;
         Inst_Memory[8] = 8'b10010011;
         Inst_Memory[9] = 8'b10000100;
         Inst_Memory[10] = 8'b00010100;
         Inst_Memory[11] = 8'b00000000;
         Inst_Memory[12] = 8'b00100011;
         Inst_Memory[13] = 8'b00111000;
         Inst_Memory[14] = 8'b10010101;
         Inst_Memory[15] = 8'b00001110;
    end
    
    // Read 4 consecutive bytes starting from Instr_Addr to form a 32-bit instruction
    assign Instruction[7:0] = Inst_Memory[Instr_Addr];        // Lower byte
    assign Instruction[15:8] = Inst_Memory[Instr_Addr + 1];   // Second byte
    assign Instruction[23:16] = Inst_Memory[Instr_Addr + 2];  // Third byte
    assign Instruction[31:24] = Inst_Memory[Instr_Addr + 3];  // Upper byte
    
endmodule

