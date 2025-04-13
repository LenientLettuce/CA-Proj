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


module Adder(
    input [63:0] a,      // 64-bit input 'a'
    input [63:0] b,      // 64-bit input 'b'
    output [63:0] out    // 64-bit output 'out'
    );
    
    assign out = a + b;  // Output is the sum of inputs 'a' and 'b'
endmodule
