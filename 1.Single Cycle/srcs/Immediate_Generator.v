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
    always @(*) begin
        case (instruction[6:0])
            7'b1100011: begin
                immediate = {{52{instruction[31]}}, 
                           instruction[31], 
                           instruction[7], 
                           instruction[30:25], 
                           instruction[11:8] 
                           };
            end
            7'b0000011, 7'b0010011, 7'b1100111: begin // I-type (load, addi, jalr)
                immediate = {{52{instruction[31]}}, instruction[31:20]};
            end
            7'b0100011: begin // S-type (store)
                immediate = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            7'b1101111: begin // J-type (jal)
                immediate = {{44{instruction[31]}}, instruction[31], instruction[19:12], instruction[20],
                             instruction[30:21]};
            end
            7'b0110111, 7'b0010111: begin // U-type (lui, auipc)
                immediate = {instruction[31:12], 12'b0};
            end
            default: immediate = 64'd0;
        endcase
    end
endmodule
