`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 02:45:18 PM
// Design Name: 
// Module Name: ALU_1_bit
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


module ALU_1_bit(
    input a,         // A
    input b,         // B
    input Cin,       // Carry-in
    input [3:0] ALUOp, //ALU Operation
    output Cout,     // Carry-out
    output Result    // Result
    );
    wire a_bar, b_bar, and_r, or_r,xor_r, add, sub; //wires for various operations
    
    //assigning A not and B not
    assign a_bar = ~a;
    assign b_bar = ~b;
    
    
    //Calculating results
    assign and_r = a & b;
    assign or_r = a | b;
    assign xor_r = a ^ b;
    
    assign add = a + b + Cin;
    assign sub = a - b + Cin;
    
    assign Cout = (a & Cin) | (b & Cin) | (a&b);
    
    //Figuring out which result to output
    assign Result = (ALUOp == 4'b0000) ? and_r :    // AND
                    (ALUOp == 4'b0001) ? or_r :     // OR
                    (ALUOp == 4'b0010) ? add :     // ADD
                    (ALUOp == 4'b0011) ? sub :     // SUB
                    (ALUOp == 4'b0100) ? xor_r :   // XOR
                    1'b0;
endmodule
