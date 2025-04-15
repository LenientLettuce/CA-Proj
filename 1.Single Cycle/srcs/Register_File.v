`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 02:42:44 PM
// Design Name: 
// Module Name: registerFile
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


module Register_File(
    input [63:0] WriteData,      // 64-bit input data for writing to a register
    input [4:0] RS1,             // 5-bit address of register 1 (for reading)
    input [4:0] RS2,             // 5-bit address of register 2 (for reading)
    input [4:0] RD,              // 5-bit address of register destination (for writing)
    input RegWrite,              // Control signal for enabling register write
    input clk,                   // Clock signal for synchronizing the write operation
    input reset,                 // Reset signal to clear output registers
    output reg [63:0] ReadData1, // 64-bit output data for the first register read
    output reg [63:0] ReadData2  // 64-bit output data for the second register read
);

    // 32 registers of 64-bits each
    reg [63:0] Registers [31:0]; 
    integer i;
    
    // Initialize Registers with random values (here we initialize them with values 1 to 32 for simplicity)
    initial begin
        for(i = 0; i < 32; i = i + 1) begin 
            Registers[i] = i + 1;  // Initialize registers with values 1, 2, ..., 32
        end
    end
    
    // Write to the register on the rising edge of the clock when RegWrite is asserted
    always @(posedge clk) begin 
        if (RegWrite==1) begin
            Registers[RD] <= WriteData;  // Non-blocking assignment for writing to a register
        end
    end

    // Read from the registers
    always @(*) begin
        if (reset==1) begin
            ReadData1 = 64'b0;  // Reset output to 0
            ReadData2 = 64'b0;  // Reset output to 0
        end else begin
            ReadData1 <= Registers[RS1];  // Output data from register specified by RS1
            ReadData2 <= Registers[RS2];  // Output data from register specified by RS2
        end
    end
    
endmodule

