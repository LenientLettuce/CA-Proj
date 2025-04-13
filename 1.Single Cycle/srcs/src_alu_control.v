`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 02:01:35 PM
// Design Name: 
// Module Name: src_alu_control
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


module ALU_Control(
    input [1:0] ALUOp,        // ALU operation control input
    input [3:0] Funct,        // Function code to further control the ALU operation
    output [3:0] Operation    // 4-bit ALU operation output
    );

// Determine the ALU operation based on ALUOp and Funct
assign Operation =
    ALUOp == 2'b00 ? 4'b0010 :       // ALUOp = 00: Perform ADD operation (opcode 0010)
    ALUOp == 2'b01 ? 4'b0110 :       // ALUOp = 01: Perform SUB operation (opcode 0110)
    ALUOp == 2'b10 ?                // ALUOp = 10: Perform R-type operations based on Funct
    Funct == 4'b0000 ? 4'b0010 :     // Funct = 0000: ADD
    Funct == 4'b1000 ? 4'b0110 :     // Funct = 1000: SUB
    Funct == 4'b0111 ? 4'b0000 :     // Funct = 0111: AND
    4'b0001 : 4'bx;                 // Default: Unknown operation (4'bx)

endmodule

