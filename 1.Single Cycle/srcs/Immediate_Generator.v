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


module Immediate_Generator(
    input [31:0] instruction,
    output reg [63:0] immediate
);
    wire [1:0] opcode;
    assign opcode = instruction[6:5];

    always @(*) begin
        case (opcode)
            2'b00: begin // I-type
                immediate = {{52{instruction[31]}}, instruction[31:20]};
            end
            2'b01: begin // S-type
                immediate = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            2'b11: begin // SB-type
                immediate = {{52{instruction[31]}}, instruction[7], instruction[30:25], 
                            instruction[11:8], 1'b0};
            end
            default: begin
                immediate = 64'b0;
            end
        endcase
    end
endmodule