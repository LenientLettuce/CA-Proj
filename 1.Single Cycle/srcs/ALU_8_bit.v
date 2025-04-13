`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 03:34:38 PM
// Design Name: 
// Module Name: ALU_8_bit
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


module ALU_8_bit(
    input [7:0] a,         // A
    input [7:0] b,         // B
    input Cin,       // Carry-in
    input [3:0] ALUOp, //ALU Operation
    output Cout,     // Carry-out
    output [7:0] Result    // Result
    );
    wire [6:0] carry; //Passing carry
    
    
    //Instatiaing 8 1 bit ALUs
    ALU_1_bit alu0 (
        .a(a[0]), 
        .b(b[0]), 
        .Cin(Cin), 
        .ALUOp(ALUOp), 
        .Cout(carry[0]), 
        .Result(Result[0])
    );
    
    ALU_1_bit alu1 (
        .a(a[1]), 
        .b(b[1]), 
        .Cin(carry[0]),
        .ALUOp(ALUOp), 
        .Cout(carry[1]), 
        .Result(Result[1])
    );
    
    ALU_1_bit alu2 (
        .a(a[2]), 
        .b(b[2]), 
        .Cin(carry[1]),
        .ALUOp(ALUOp), 
        .Cout(carry[2]), 
        .Result(Result[2])
    );
    
    ALU_1_bit alu3 (
        .a(a[3]), 
        .b(b[3]), 
        .Cin(carry[2]),
        .ALUOp(ALUOp), 
        .Cout(carry[3]), 
        .Result(Result[3])
    );
    
    ALU_1_bit alu4 (
        .a(a[4]), 
        .b(b[4]), 
        .Cin(carry[3]),
        .ALUOp(ALUOp), 
        .Cout(carry[4]), 
        .Result(Result[4])
    );
    
    ALU_1_bit alu5 (
        .a(a[5]), 
        .b(b[5]), 
        .Cin(carry[4]),
        .ALUOp(ALUOp), 
        .Cout(carry[5]), 
        .Result(Result[5])
    );
    
    ALU_1_bit alu6 (
        .a(a[6]), 
        .b(b[6]), 
        .Cin(carry[5]),
        .ALUOp(ALUOp), 
        .Cout(carry[6]), 
        .Result(Result[6])
    );
    
    ALU_1_bit alu7 (
        .a(a[7]), 
        .b(b[7]), 
        .Cin(carry[6]),
        .ALUOp(ALUOp), 
        .Cout(Cout), 
        .Result(Result[7])
    );
    
endmodule
