`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 02:17:52 PM
// Design Name: 
// Module Name: testbench_TopControl
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

module testbench_TopControl();
    reg [6:0] Opcode;               // Input: 7-bit Opcode for instruction type
    reg [3:0] Funct;                // Input: 4-bit Function code for ALU operation
    wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;  // Control signals
    wire [3:0] Operation;           // Output: ALU operation control signal

    // Instantiate the top_control module
    top_control test(Opcode, Funct, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Operation);

    initial begin
        // Test case 1: R-type instruction with Funct = 0000 (ADD)
        Opcode = 7'b0110011;
        Funct = 4'b0000;
        #100; 
        
        // Test case 2: R-type instruction with Funct = 1000 (SUB)
        Opcode = 7'b0110011;
        Funct = 4'b1000;
        #100;  
        
        // Test case 3: R-type instruction with Funct = 0111 (AND)
        Opcode = 7'b0110011;
        Funct = 4'b0111;
        #100;  
        
        // Test case 4: R-type instruction with Funct = 0110 (OR)
        Opcode = 7'b0110011;
        Funct = 4'b0110;
        #100;  
        
        // Test case 5: I-type load instruction
        Opcode = 7'b0000011;
        #100;  
        
        // Test case 6: S-type store instruction
        Opcode = 7'b0100011;
        #100;  
        
        // Test case 7: SB-type branch instruction
        Opcode = 7'b1100011;
        #100;  
        
    end
endmodule


