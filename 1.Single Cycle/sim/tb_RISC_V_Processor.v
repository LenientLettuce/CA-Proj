`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 06:18:49 PM
// Design Name: 
// Module Name: tb_RISC_V_Processor
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

module tb_RISC_V_Processor();

    // Clock and reset
    reg clk;
    reg reset;

    // Instantiate the processor
    RISC_V_Processor _Processor (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize
    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        // Let the processor run for some time
        #5000;

        $finish;
    end


endmodule
