`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 11:34:15 PM
// Design Name: 
// Module Name: Branch_Unit
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


module Branch_Unit(
    input [2:0] Funct3,
    input [63:0] ReadData1, ReadData2,
    output reg sel
);
    always @(*) begin
        case(Funct3)
            3'b000: sel = (ReadData1 == ReadData2);           // BEQ
            3'b001: sel = (ReadData1 != ReadData2);           // BNE
            3'b100: sel = ($signed(ReadData1) < $signed(ReadData2));  // BLT
            3'b101: sel = ($signed(ReadData1) >= $signed(ReadData2));  // BGE
            3'b110: sel = (ReadData1 < ReadData2);            // BLTU
            3'b111: sel = (ReadData1 >= ReadData2);           // BGEU
            default: sel = 1'b0;
        endcase
    end
endmodule