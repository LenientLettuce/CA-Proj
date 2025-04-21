`timescale 1ns / 1ps

module Data_Memory_3(
    input [63:0] mem_add,       // 64-bit memory address
    input [63:0] write_data,    // 64-bit data to write
    input clk,                  // Clock signal
    input mem_write,            // Memory write control signal
    input mem_read,             // Memory read control signal
    output reg [63:0] read_data, // 64-bit data read from memory
    // Array outputs for monitoring (7 integers, 4 bytes each)
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

    // Initialize memory at startup
    initial begin
        for (i = 0; i < 512; i = i + 1)
            Data_Memory[i] = 8'b0;
            
        // Initialize array at memory address 0x100 (256 decimal)
        // Each integer is 4 bytes (32 bits)
        // Initialize 7 integers for sorting
    end

    // Map array outputs to monitor sorting progress (7 integers)
    assign arr0 = {Data_Memory[259], Data_Memory[258], Data_Memory[257], Data_Memory[256]};
    assign arr1 = {Data_Memory[263], Data_Memory[262], Data_Memory[261], Data_Memory[260]};
    assign arr2 = {Data_Memory[267], Data_Memory[266], Data_Memory[265], Data_Memory[264]};
    assign arr3 = {Data_Memory[271], Data_Memory[270], Data_Memory[269], Data_Memory[268]};
    assign arr4 = {Data_Memory[275], Data_Memory[274], Data_Memory[273], Data_Memory[272]};
    assign arr5 = {Data_Memory[279], Data_Memory[278], Data_Memory[277], Data_Memory[276]};
    assign arr6 = {Data_Memory[283], Data_Memory[282], Data_Memory[281], Data_Memory[280]};

    // Read data from memory (signed or unsigned)
    always @(*) begin
        if (mem_read == 1'b1) begin
            // Read 32 bits (4 bytes) from memory and extend to 64 bits
            read_data[31:0] = {Data_Memory[mem_add + 3], 
                               Data_Memory[mem_add + 2], 
                               Data_Memory[mem_add + 1], 
                               Data_Memory[mem_add]}; 
            
            // Sign-extend the 32-bit value to 64 bits (for signed load, LW)
            read_data[63:32] = {32{read_data[31]}};  // Replicate the sign bit

            // For unsigned load (LWU), uncomment below line for zero-extension
            // read_data[63:32] = 32'b0;  // Zero-extend for unsigned load

        end else begin
            read_data <= 64'b0; // Default to 0 if not reading
        end
    end

    // Write data to memory (store 32-bit data)
    always @(posedge clk) begin
        if (mem_write == 1'b1) begin
            // Write 32 bits (4 bytes) to memory - proper byte order
            Data_Memory[mem_add]     <= write_data[7:0];     // LSB
            Data_Memory[mem_add + 1] <= write_data[15:8];    // 2nd byte
            Data_Memory[mem_add + 2] <= write_data[23:16];   // 3rd byte
            Data_Memory[mem_add + 3] <= write_data[31:24];   // MSB

            // Optionally, display write information for debugging
            // $display("Writing %d to address %h", write_data[31:0], mem_add);
        end
    end

endmodule

