`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2025 01:06:20 PM
// Design Name: 
// Module Name: Program_Counter
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


module Program_Counter(
    input wire clk,          // Clock signal
    input wire reset,        // Reset signal
    input wire [63:0] PC_In, // 64-bit input
    output reg [63:0] PC_Out // 64-bit output
    );
    
     // Always block to update PC_Out at the positive edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_Out <= 64'b0; // If reset is high, set PC_Out to 0
        end else begin
            PC_Out <= PC_In; // Otherwise, reflect PC_In to PC_Out
        end
    end
    
endmodule
