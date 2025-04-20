`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2025 05:14:09 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    input EXM_RegWrite, MWB_RegWrite,
    input [4:0] IDEX_rs1, IDEX_rs2, EXM_rd, MWB_rd,
    output reg [1:0] Forward_A, Forward_B
    );
    always @(*)begin
    //for rs1->forward a
    if ((EXM_rd == IDEX_rs1) && (EXM_RegWrite == 1) && (EXM_rd != 0))
        Forward_A = 2'b10;
    else if ((MWB_rd == IDEX_rs1) && (MWB_RegWrite == 1) && (MWB_rd != 0) && !(EXM_RegWrite == 1 && EXM_rd != 0 && EXM_rd == IDEX_rs1))
        Forward_A = 2'b01;
    else
        Forward_A = 2'b00;
    //for rs2->forward b
    if ((EXM_rd == IDEX_rs2) && (EXM_RegWrite == 1) && (EXM_rd != 0))
        Forward_B = 2'b10;
    else if ((MWB_rd == IDEX_rs2) && (MWB_RegWrite == 1) && (MWB_rd != 0) && !(EXM_RegWrite == 1 && EXM_rd != 0 && EXM_rd == IDEX_rs2))
        Forward_B = 2'b01;
    else
        Forward_B = 2'b00;
    end
endmodule
