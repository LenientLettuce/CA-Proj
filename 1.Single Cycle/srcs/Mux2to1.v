`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2025 02:45:08 PM
// Design Name: 
// Module Name: Multiplexer_task01
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


module Mux2to1(
    input[63:0] a,//input a (64 bits)
    input[63:0] b,//input b (64 bits)
    input selector_bit, //selection bit 
    output[63:0] data_out
    );
    
   assign data_out = selector_bit? b:a; 
   //If selection bit is 1, output is b. 
   //If selection but is 0, output is a. 
endmodule
