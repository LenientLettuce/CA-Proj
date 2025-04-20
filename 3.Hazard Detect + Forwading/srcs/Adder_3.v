`timescale 1ns / 1ps

module Adder_3(a, b, out);
    input [63:0] a;      // First operand
    input [63:0] b;      // Second operand
    output reg [63:0] out; // Result register
    
    always @ (*)         // Sensitivity to any input change
        out <= a + b;    // Addition operation
endmodule
