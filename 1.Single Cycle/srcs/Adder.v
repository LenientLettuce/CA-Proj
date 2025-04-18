`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2025 01:13:18 PM
// Design Name: 
// Module Name: Adder
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


module Adder(a, b, out);
    input [63:0] a;      // First operand
    input [63:0] b;      // Second operand
    output reg [63:0] out; // Result register
    
    always @ (*)         // Sensitivity to any input change
        out <= a + b;    // Addition operation
endmodule
