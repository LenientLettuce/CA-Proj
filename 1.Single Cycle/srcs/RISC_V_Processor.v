`timescale 1ns / 1ps
//single cycle bubble sort
module RISC_V_Processor(
    input clk, 
    input reset
    );
    //program counter
    wire [63:0] PC_out;
    //reg file
    wire [63:0]ReadData1;
    wire [63:0] ReadData2;
    //mux
    wire [63:0] mux2out; //rs2 and imm
    wire [63:0] mux1out; //pc and branch
    wire [63:0] mux3out; //write back mux
    //imm
    wire [63:0] imm_data;
    wire [63:0] imm_data1;
    //alu
    wire [63:0] result; 
    //adders
    wire [63:0] out; //pc+4
    wire [63:0] out1; //branch adder
    //instruction
    wire [31:0] Instruction;
    wire [6:0] opcode;
    wire [6:0]funct7; 
    wire [2:0] funct3;  
    wire [4:0] rs1;
    wire [4:0]rs2;
    wire [4:0] rd;
    wire [1:0] ALUOp;
    //alu control
    wire [3:0] operation;
    wire [3:0]Funct;
    //control unit
    wire RegWrite, MemRead, MemWrite, MemtoReg, ALUsrc, zero, Branch, sel ; 
    //data memory
    wire [63:0] ReadData;
    //array in data memory
    wire [31:0] array0;
    wire [31:0] array1;
    wire [31:0] array2;
    wire [31:0] array3;
    wire [31:0] array4;
    wire [31:0] array5;
    wire [31:0] array6;
    
    //calling
    
    //pc+4 
    Adder c6(PC_out, 64'd4, out);
    
    //pc vs branch
    Multiplexer m1(out, out1, (Branch & sel), mux1out);

    //program counter gives PC_out (address) of instruction
    Program_Counter c5(clk, reset, mux1out, PC_out);

    //instruction memory gives 32 bits instruction at the PC_out
    Instruction_Memory t(PC_out, Instruction); 
    
    //divides the instruction
    Instruction_Parser t2(Instruction, opcode, rd, funct3, rs1, rs2, funct7);

    //extends the 12 bit immediate to 64 bits
    Immediate_Generator t6(Instruction, imm_data);
    
    //gives the control signals of the instruction
    Control_Unit t3(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite);

    //gives values at rs1 and rs2
    // Selects between ALU result and memory read data for write back
    Multiplexer m3(result, ReadData, MemtoReg, mux3out);

    Register_File t4(mux3out, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
    
    //checks whether the instrcution is beq,blt,bgt and gives 1 if branch is taken else 0
    Branch_Unit b1(funct3, ReadData1, ReadData2, sel);
    
    //shift left immediate by 1
    assign imm_data1 = imm_data << 1;

    //add the shifted immediate and PC_out to give the offset of the label 
    Adder a1(PC_out, imm_data1, out1); 

    //selects rs2 or immediate based on the ALUsrc
    Multiplexer m2(ReadData2, imm_data, ALUsrc, mux2out);
    
    //Funct is 3 bits of fucnt3 and 1 bit of funct7
    wire [2:0] funct3_only = Instruction[14:12];
    wire is_r_type = (opcode == 7'b0110011);
    assign Funct = is_r_type ? {Instruction[30], funct3_only} : {1'b0, funct3_only}; 

    //gives the 4 bits of operation based on aluop
    ALU_Control t7(ALUOp, Funct, operation);

    //performs operation
    ALU_64_bit a2(
        .a(ReadData1),
        .b(mux2out),
        .ALUOp(operation),
        .ZERO(zero),
        .Result(result)
    );
    
    //accessed if instruction needs memory e.g ld/sd
    Data_Memory t5(result, ReadData2, clk, MemWrite, MemRead, ReadData,array0,array1,array2,array3,array4,array5,array6);
    
endmodule