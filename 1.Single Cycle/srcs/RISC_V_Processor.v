`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 05:28:36 PM
// Design Name: 
// Module Name: RISC_V_Processor
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


module RISC_V_Processor(
    input clk, 
    input reset
);
    // Program Counter
    wire [63:0] PC_out;
    
    // Register File
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;
    
    // Muxes
    wire [63:0] alu_src_mux_out;   // ALU second operand (rs2 or immediate)
    wire [63:0] pc_next_mux_out;   // Next PC (PC+4 or branch target)
    wire [63:0] writeback_mux_out; // Writeback data (ALU result or memory data)
    
    // Immediate
    wire [63:0] imm_value;
    wire [63:0] shifted_imm;       // Immediate shifted left by 1
    
    // ALU
    wire [63:0] alu_result;
    wire        alu_zero;          // ALU zero flag
    
    // Adders
    wire [63:0] pc_plus4;          // PC + 4
    wire [63:0] branch_target;     // PC + branch offset
    
    // Instruction
    wire [31:0] Instruction;
    wire [6:0]  opcode;
    wire [6:0]  funct7; 
    wire [2:0]  funct3;  
    wire [4:0]  rs1;
    wire [4:0]  rs2;
    wire [4:0]  rd;
    
    // Control Signals
    wire [1:0]  ALUOp;
    wire        RegWrite, MemRead, MemWrite, MemtoReg, ALUsrc, Branch, branch_sel;
    
    // ALU Control
    wire [3:0]  alu_operation;     // ALU control signal
    wire [3:0]  funct_combined;    // Combined funct7 and funct3
    
    // Data Memory
    wire [63:0] mem_read_data;     // Data read from memory
    wire [63:0] array0;
    wire [63:0] array1;
    wire [63:0] array2;
    wire [63:0] array3;
    wire [63:0] array4;

    // Adder: PC + 4
    Adder pc_plus4_adder (
        .a(PC_out),
        .b(64'd4),
        .out(pc_plus4)
    );
    
    // Mux: Select next PC (PC+4 or branch target)
    Mux2to1 pc_next_mux (
        .a(pc_plus4),
        .b(branch_target),
        .selector_bit(Branch & branch_sel),
        .data_out(pc_next_mux_out)
    );

    // Program Counter
    Program_Counter pc (
        .clk(clk),
        .reset(reset),
        .PC_In(pc_next_mux_out),
        .PC_Out(PC_out)
    );

    // Instruction Memory
    Instruction_Memory imem (
        .Instr_Addr(PC_out),
        .Instruction(Instruction)
    );
    
    // Instruction Parser
    Instruction_Parser parser (
        .instruction(Instruction),
        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7)
    );

    // Immediate Generator
    Imm_Gen imm_gen (
        .instruction(Instruction),
        .imm_data(imm_value)
    );
    
    // Control Unit
    Control_Unit control (
        .Opcode(opcode),
        .ALUOp(ALUOp),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUsrc),
        .RegWrite(RegWrite)
    );

    // Register File
    registerFile reg_file (
        .WriteData(writeback_mux_out),
        .RS1(rs1),
        .RS2(rs2),
        .RD(rd),
        .RegWrite(RegWrite),
        .clk(clk),
        .reset(reset),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    // Branch Condition Unit
    Branch_Unit branch_unit (
        .Funct3(funct3),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .sel(branch_sel)
    );
    
    // Shift immediate left by 1 for branch offset
    assign shifted_imm = imm_value << 1;

    // Adder: Calculate branch target address
    Adder branch_target_adder (
        .a(PC_out),
        .b(shifted_imm),
        .out(branch_target)
    ); 

    // Mux: Select ALU second operand (rs2 or immediate)
    Mux2to1 alu_src_mux (
        .a(ReadData2),
        .b(imm_value),
        .selector_bit(ALUsrc),
        .data_out(alu_src_mux_out)
    );
    
    // Combine funct7 and funct3 for ALU Control
    assign funct_combined = {Instruction[30], funct3};

    // ALU Control
    ALU_Control alu_control (
        .ALUOp(ALUOp),
        .Funct(funct_combined),
        .Operation(alu_operation)
    );

    // ALU
    ALU_64_bit alu (
        .a(ReadData1),
        .b(alu_src_mux_out),
        .Cin(1'b0),          // No carry-in
        .ALUOp(alu_operation),
        .Cout(),             // Carry-out unused
        .ZERO(alu_zero),
        .Result(alu_result)
    );
    
    // Data Memory
    Data_Memory dmem (
        .Mem_Addr(alu_result),
        .Write_Data(ReadData2),
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Read_Data(mem_read_data),
        .arr0(array0),
        .arr1(array1),
        .arr2(array2),
        .arr3(array3),
        .arr4(array4)
    );
    
    // Mux: Select writeback data (ALU result or memory data)
    Mux2to1 writeback_mux (
        .a(alu_result),
        .b(mem_read_data),
        .selector_bit(MemtoReg),
        .data_out(writeback_mux_out)
    );
    
endmodule
