`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 02:05:36 PM
// Design Name: 
// Module Name: top_control
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

module top_control(
    input [6:0] Opcode,           // 7-bit input Opcode representing instruction type
    input [3:0] Funct,           // 4-bit function code for ALU operation
    output Branch,                // Branch control signal
    output MemRead,               // Memory Read control signal
    output MemtoReg,              // Memory to Register control signal
    output MemWrite,              // Memory Write control signal
    output ALUSrc,                // ALU Source control signal (use of immediate or register)
    output RegWrite,              // Register Write control signal
    output [3:0] Operation        // ALU operation output
    );
    
    wire [1:0] ALUOp;  // Intermediate ALU operation control signal
    
    // Instantiate Control Unit to generate control signals based on Opcode
    Control_Unit cu_test(Opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
    
    // Instantiate ALU Control to generate the ALU operation based on ALUOp
    ALU_Control alu_test(ALUOp, Funct, Operation);
    
endmodule

