`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 03:33:08 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top;
    // Declare inputs as regs and outputs as wires
    reg [31:0] instruction;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;

    // Instantiate the top module
    top uut (
        .instruction(instruction),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Test sequence
    initial begin
        // Initialize the instruction to some value 
        instruction = 32'h00000000; 
        
        // Apply some delays and check outputs
        #10;
        $display("ReadData1: %h, ReadData2: %h", ReadData1, ReadData2);

        // Change instruction to another example
        instruction = 32'h01000000; // Another example instruction
        
        #10;
        $display("ReadData1: %h, ReadData2: %h", ReadData1, ReadData2);

        // End simulation
        $finish;
    end
endmodule

