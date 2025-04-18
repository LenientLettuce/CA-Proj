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


module Multiplexer(a, b, selector_bit, data_out);
    input [63:0] a;         // First input data
    input [63:0] b;         // Second input data
    input selector_bit;     // Selection control
    output reg [63:0] data_out; // Output register
    
    always @(*) begin       // Combinational logic block
        data_out <= selector_bit ? b : a;  // Select b when selector=1, a when selector=0
    end
endmodule
