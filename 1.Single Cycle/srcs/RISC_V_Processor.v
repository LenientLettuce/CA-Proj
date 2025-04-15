`timescale 1ns / 1ps
module RISC_V_Processor(
    input clk, 
    input reset
    );
    wire [63:0] pc_in;
    wire [63:0] pc_out;
    wire [31:0] instruction;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] func3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] func7;
    wire branch;
    wire mem_read;
    wire mem_to_reg;
    wire [1:0] alu_op;
    wire mem_write;
    wire alu_src;
    wire reg_write;
    wire [63:0] imm;
    wire [63:0] rs1_data;
    wire [63:0] rs2_data;
    wire [63:0] next_instruction_address;
    wire [63:0] branch_instruction_address;
    wire [3:0] operation;
    wire [63:0] alu_second_operand;
    wire zero;
    wire sel;  // Added for branch condition
    
    wire [63:0] alu_result;
    wire [63:0] read_data;
    wire [63:0] write_data_reg;
    wire [63:0] write_data_mem;
    
    // Array outputs from data memory
    wire [63:0] array0;
    wire [63:0] array1;
    wire [63:0] array2;
    wire [63:0] array3;
    wire [63:0] array4;
    
    // Program counter to track the instruction address
    Program_Counter pc(clk,reset,pc_in,pc_out);
    
    // Computes next instruction address by adding 4 to PC
    Adder adder1 (pc_out, 64'd4, next_instruction_address);
    
    // Fetches instruction from memory
    Instruction_Memory im (pc_out,instruction);
    
    // Parses the instruction into opcode, register addresses, and function codes
    Instruction_Parser ip (instruction, opcode, rd, func3, rs1, rs2, func7);
    
    // Generates immediate values from instruction
    Immediate_Generator ig (instruction, imm);
    
    // Computes branch address by adding immediate to PC
    wire [63:0] shifted_imm;
    assign shifted_imm = imm << 1;
    Adder adder2 (pc_out, shifted_imm, branch_instruction_address);
    
    // Branch condition unit
    Branch_Unit bu(func3, rs1_data, rs2_data, sel);
    
    // Selects next PC value based on branch conditions
    Mux2to1 pc_mux (next_instruction_address, branch_instruction_address, (branch & sel), pc_in);
    
    // Control unit generates control signals based on opcode
    Control_Unit cu (opcode, alu_op, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write);
    
    // Register file stores and provides data for registers
    Register_File rf (write_data_reg, rs1, rs2, rd, reg_write, clk, reset, rs1_data, rs2_data);
    
    // Selects second operand for ALU (register data or immediate)
    Mux2to1 reg_mux (rs2_data, imm, alu_src, alu_second_operand);
    
    // Determines ALU operation based on instruction type
    wire [3:0] funct;
    assign funct[3] = instruction[30];
    assign funct[2:0] = instruction[14:12];
    ALU_Control aluc (alu_op, funct, operation);
    
    // Performs arithmetic and logical operations (modified to match first module's interface)
    ALU_64_bit alu (rs1_data, alu_second_operand, operation, alu_result, zero);
    
    // Memory unit for data load and store operations (added array outputs)
    assign write_data_mem = rs2_data;
    Data_Memory dm (alu_result, write_data_mem, clk, mem_write, mem_read, read_data, 
                   array0, array1, array2, array3, array4);
    
    // Selects data to write back to register (ALU result or memory read data)
    Mux2to1 mem_mux (alu_result, read_data, mem_to_reg, write_data_reg);
endmodule