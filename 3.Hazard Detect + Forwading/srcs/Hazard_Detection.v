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
    output reg IDEX_control_mux, IFID_Write, PC_write
    );

    always @(*) begin
    
        if (IDEX_MemRead && (IDEX_rd == IFID_rs1 || IDEX_rd == IFID_rs2))
            begin
            PC_write = 0;  //dont move on to next instruction
            IFID_Write = 0; 
            IDEX_control_mux = 0;  //control signals set to 0
        end
        else
            begin //if not any dependency then just continue
            PC_write = 1;
            IFID_Write = 1;
            IDEX_control_mux = 1; 
            
          
        end
    end
endmodule
