`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2025 01:33:25 PM
// Design Name: 
// Module Name: Instruction_Fetch
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


module Instruction_Fetch(
    input clk,              // Clock signal
    input reset,            // Reset signal
    output [31:0] instruction // 32-bit instruction output
    );
    
    wire [63:0] PC_In;      // Input to Program Counter
    wire [63:0] PC_Out;     // Output from Program Counter
    wire [63:0] b = 64'd4;  // Constant value of 4 (for incrementing PC)
    
    // Instantiating Program Counter to hold the current PC value
    Program_Counter test_PC(clk, reset, PC_In, PC_Out);
    
    // Instantiating Adder to add 4 to PC value for next instruction address
    Adder test_adder(PC_Out, b, PC_In);
    
    // Instantiating Instruction Memory to fetch instruction at current PC
    Instruction_Memory test_IM(PC_Out, instruction);
endmodule
