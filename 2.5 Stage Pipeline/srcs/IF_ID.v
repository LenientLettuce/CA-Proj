`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 11:40:39 PM
// Design Name: 
// Module Name: IF_ID
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



`timescale 1ns / 1ps

module IF_ID(clk, reset, PC_out, Instruction, IFID_PC_out, IFID_instruction); 
    
    //inputs
    input clk, reset; 
    input [31:0] Instruction; 
    input [63:0] PC_out; 
    
    //outputs
    output reg [31:0] IFID_instruction; 
    output reg [63:0] IFID_PC_out; 
    
    always @ (posedge clk) 
    begin
        if (reset)
           // reset 1 
                begin
                IFID_instruction <= 0;
                IFID_PC_out <= 0;
                end
         if(reset==0) // reset 0
                begin
                IFID_instruction <= Instruction;
                IFID_PC_out <= PC_out;
                end
        
    end
endmodule
