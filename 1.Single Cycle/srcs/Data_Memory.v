`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2025 03:14:35 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input [63:0] mem_add,
    input [63:0] write_data,
    input clk,
    input mem_write,
    input mem_read,
    output reg [63:0] read_data,
    // Array outputs for monitoring - 7 integers (4 bytes each)
    output [31:0] arr0,
    output [31:0] arr1,
    output [31:0] arr2,
    output [31:0] arr3,
    output [31:0] arr4,
    output [31:0] arr5,
    output [31:0] arr6
);
    // 512 bytes of memory (0x000 to 0x1FF)
    reg [7:0] Data_Memory [511:0]; 
    integer i;
    
        initial begin
        // Initialize all memory to 0
        for (i = 0; i < 512; i = i + 1)
            Data_Memory[i] = 0;
        
        // Initialize array at memory address 0x100 (256 decimal)
        // Each integer is 4 bytes (32 bits)
        // Initialize 7 integers for sorting
        
//            // First integer at 0x100
//            Data_Memory[256] = 8'd9;
//            Data_Memory[257] = 8'd0;
//            Data_Memory[258] = 8'd0;
//            Data_Memory[259] = 8'd0;
            
//            // Second integer at 0x104
//            Data_Memory[260] = 8'd2;
//            Data_Memory[261] = 8'd0;
//            Data_Memory[262] = 8'd0;
//            Data_Memory[263] = 8'd0;
            
//            // Third integer at 0x108
//            Data_Memory[264] = 8'd7;
//            Data_Memory[265] = 8'd0;
//            Data_Memory[266] = 8'd0;
//            Data_Memory[267] = 8'd0;
            
//            // Fourth integer at 0x10C
//            Data_Memory[268] = 8'd1;
//            Data_Memory[269] = 8'd0;
//            Data_Memory[270] = 8'd0;
//            Data_Memory[271] = 8'd0;
            
//            // Fifth integer at 0x110
//            Data_Memory[272] = 8'd8;
//            Data_Memory[273] = 8'd0;
//            Data_Memory[274] = 8'd0;
//            Data_Memory[275] = 8'd0;
            
//            // Sixth integer at 0x114
//            Data_Memory[276] = 8'd4;
//            Data_Memory[277] = 8'd0;
//            Data_Memory[278] = 8'd0;
//            Data_Memory[279] = 8'd0;
            
//            // Seventh integer at 0x118
//            Data_Memory[280] = 8'd6;
//            Data_Memory[281] = 8'd0;
//            Data_Memory[282] = 8'd0;
//            Data_Memory[283] = 8'd0;
         $monitor("arr0: %d, arr1: %d, arr2: %d, arr3: %d, arr4: %d, arr5: %d, arr6: %d",
             arr0, arr1, arr2, arr3, arr4, arr5, arr6);
    end

    // Map array outputs to monitor sorting progress
    // Each integer is 32-bits (4 bytes) - we only need 32 bits for each integer
    assign arr0 = {Data_Memory[259], Data_Memory[258], Data_Memory[257], Data_Memory[256]};
    assign arr1 = {Data_Memory[263], Data_Memory[262], Data_Memory[261], Data_Memory[260]};
    assign arr2 = {Data_Memory[267], Data_Memory[266], Data_Memory[265], Data_Memory[264]};
    assign arr3 = {Data_Memory[271], Data_Memory[270], Data_Memory[269], Data_Memory[268]};
    assign arr4 = {Data_Memory[275], Data_Memory[274], Data_Memory[273], Data_Memory[272]};
    assign arr5 = {Data_Memory[279], Data_Memory[278], Data_Memory[277], Data_Memory[276]};
    assign arr6 = {Data_Memory[283], Data_Memory[282], Data_Memory[281], Data_Memory[280]};
    
    always @(*) begin
        if (mem_read == 1'b1) begin
            // Read 64 bits (8 bytes) from memory
            read_data[7:0] <= Data_Memory[mem_add];
            read_data[15:8] <= Data_Memory[mem_add+1];
            read_data[23:16] <= Data_Memory[mem_add+2];
            read_data[31:24] <= Data_Memory[mem_add+3];
            read_data[39:32] <= Data_Memory[mem_add+4];
            read_data[47:40] <= Data_Memory[mem_add+5];
            read_data[55:48] <= Data_Memory[mem_add+6];
            read_data[63:56] <= Data_Memory[mem_add+7];
        end
        else
            read_data <= 64'b0;
    end
    
    always @(posedge clk) begin
        if (mem_write == 1'b1) begin
                // Write 32 bits (4 bytes) to memory - proper byte order
                Data_Memory[mem_add]     <= write_data[7:0];
                Data_Memory[mem_add + 1] <= write_data[15:8];
                Data_Memory[mem_add + 2] <= write_data[23:16];
                Data_Memory[mem_add + 3] <= write_data[31:24];
                
                // Only write 32 bits at a time for array elements
                if (mem_add >= 256 && mem_add <= 280) begin
                    $display("Writing %d to address %h", write_data[31:0], mem_add);
            end
        end
    end

endmodule

