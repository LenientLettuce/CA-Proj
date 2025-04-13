`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 03:22:54 PM
// Design Name: 
// Module Name: top
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


module top(
    input [31:0] instruction, // Input instruction (32-bit)
    output [63:0] ReadData1, // Output data from source register 1
    output [63:0] ReadData2 // Output data from source register 2
    );
    
    // Internal wires to hold parts of the instruction
    wire [6:0] funct7;  // 7-bit function field
    wire [4:0] rs2;     // 5-bit source register 2
    wire [4:0] rs1;     // 5-bit source register 1
    wire [2:0] funct3;  // 3-bit function field
    wire [4:0] rd;      // 5-bit destination register
    wire [6:0] opcode;  // 7-bit opcode
    
    // Control signals
    wire clk = 1;        // Clock signal (always high for simplicity)
    wire reset = 0;      // Reset signal (active low)
    wire RegWrite = 1;   // Enable writing to the register file
    wire WriteData = 64'd35; // Data to be written to register file
    
     // Instantiate instruction parser to decode the instruction
    InstructionParser_task02 test_1(instruction, opcode, rd, funct3, rs1, rs2, funct7);
    
    // Instantiate register file and connect signals
    registerFile test_2(WriteData, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
    
endmodule
