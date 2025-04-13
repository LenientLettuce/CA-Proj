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
        #200;

        $finish;
    end

    // Monitor signals and display results
    initial begin
     $display("Time | PC | Inst | rs1 | rs2 | rd | WriteData | ReadData1 | ReadData2 | Imm_Data | ALU_In1 | ALU_Result | Mem_Addr | Read_Data");
     $monitor("%0t | %0d | %032b | %0d | %0d | %0d | %0d | %0d | %0d | %0d | %0d | %0d | %0d | %0d", 
             $time,
             _Processor.PC_out[31:0],
             _Processor.Instruction,
             _Processor.rs1, _Processor.rs2, _Processor.rd,
             _Processor.writeback_mux_out[31:0], // WriteData
             _Processor.ReadData1[31:0], _Processor.ReadData2[31:0],
             _Processor.imm_value[31:0],
             _Processor.alu_src_mux_out[31:0],
             _Processor.alu_result[31:0],
             _Processor.branch_target[31:0],
             _Processor.writeback_mux_out[31:0]  // Assuming this is Read_Data
             );
    end


endmodule
