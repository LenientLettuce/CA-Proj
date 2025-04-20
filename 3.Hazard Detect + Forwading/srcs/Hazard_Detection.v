`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2025 05:14:09 PM
// Design Name: 
// Module Name: Hazard_Detection
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


module Hazard_Detection(
    input IDEX_MemRead,
    input [4:0] IDEX_rd, IFID_rs1, IFID_rs2,
    input branch_taken,  // New input from EX stage
    output reg IDEX_control_mux, IFID_Write, PC_write
);
    
    always @(*) begin
        // Hazard condition: Load-use dependency AND no branch being taken
        if (IDEX_MemRead && (IDEX_rd == IFID_rs1 || IDEX_rd == IFID_rs2) && !branch_taken) 
        begin
            PC_write = 0;    // Stall PC
            IFID_Write = 0;  // Stall IF/ID
            IDEX_control_mux = 0; // Insert NOP in ID/EX
        end
        else begin
            PC_write = 1;    // Normal operation
            IFID_Write = 1;
            IDEX_control_mux = 1;
        end
    end
endmodule
