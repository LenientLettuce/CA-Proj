`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2025 04:04:07 PM
// Design Name: 
// Module Name: ImmediateDataGenerator_task03
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


module ImmediateDataGenerator_task03(
    input [31:0] instruction,
    output reg [63:0] immediate
);
wire [1:0] opcode;
assign opcode = instruction[6:5];

always @(*) begin
    immediate = 64'b0; // Set immediate to zero at the beginning
    if (instruction[11]) begin
                immediate[63:12] = {52{1'b1}}; // If instruction[31] is 1, extend with 1's
            end else begin
                immediate[63:12] = {52{1'b0}}; // If instruction[31] is 0, extend with 0's
            end
    case (opcode)
        2'b00: begin // If I-type instruction
            immediate[11:0] = instruction[31:20]; // Set immediate 0-11 bits
        end
        2'b01: begin // If S-type instruction
            immediate[4:0] = instruction[11:7]; // Set immediate 0-4 bits
            immediate[11:5] = instruction[31:25]; // Set immediate 5-11 bits
        end
        2'b11: begin // If SB-type instruction
            immediate[0] = 0; // Set immediate 0th bit = 0
            immediate[11] = instruction[7]; // Set immediate 11th bit = instruction 8th bit
            immediate[4:1] = instruction[11:8]; // Set immediate 1-4 bits
            immediate[10:5] = instruction[30:25]; // Set immediate 5-10 bits
            immediate[12] = instruction[31]; // Set immediate 12th bit = instruction 31st bit
        end
        default: begin // Handle any unexpected opcode cases
            immediate = 64'b0;
        end
    endcase
end
endmodule
