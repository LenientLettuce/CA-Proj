`timescale 1ns / 1ps

module RISC_V_Processor_2(
    input  clk,
    input  reset
);

  wire [63:0] PC_in, PC_out, PC_plus4;
  wire [31:0] Instruction;
  
  wire [63:0] IFID_PC_out;
  wire [31:0] IFID_instruction;

  wire [6:0]  opcode, funct7;
  wire [2:0]  funct3;
  wire [4:0]  rs1, rs2, rd;
  
  wire [63:0] imm_data;
  wire [63:0] ReadData1, ReadData2, WB_data;
  wire [4:0]  MWB_rd;
  wire        MWB_RegWrite,MWB_MemToReg;
  
  wire        RegWrite, MemRead, MemWrite, MemtoReg, ALUsrc, Branch;
  wire [1:0]  ALUOp;
  wire [3:0] Funct;
  wire branch_sel;
  
  wire IDEX_RegWrite, IDEX_MemRead, IDEX_MemToReg,IDEX_MemWrite, IDEX_Branch, IDEX_ALUSrc;
  wire [1:0]  IDEX_ALUOp;
  wire [3:0]  IDEX_Funct;
  wire [4:0]  IDEX_rs1, IDEX_rs2, IDEX_rd;
  wire [63:0] IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_imm_data;
  
  wire [63:0] ALU_operand2;
  
  wire [3:0] operation;
  wire [63:0] ALU_Result;
  wire        zero_flag;
  wire [63:0] branch_target;
  
  wire EXM_RegWrite, EXM_MemRead, EXM_MemToReg,EXM_MemWrite, EXM_Branch, EXM_zero;
  wire [63:0] EXM_Adder_out, EXM_ALU_Result, EXM_ReadData2;
  wire [4:0]  EXM_rd;

  wire [63:0] ReadData;
  wire [31:0] array0,array1,array2,array3,array4,array5,array6;
  wire [63:0] MWB_ReadData,MWB_ALUResult;
  
  //
  // 1) IF stage
  //

  Adder_2 pc_adder (
    .a   (PC_out),
    .b   (64'd4),
    .out (PC_plus4)
  );
  
  Multiplexer_2 PC_mux (
    .a   (PC_plus4),
    .b   (EXM_Adder_out), 
    .selector_bit (EXM_Branch),
    .data_out (PC_in)
  );

  Program_Counter_2 pc_reg (
    .clk     (clk),
    .reset   (reset),
    .PC_in (PC_in),
    .PC_out  (PC_out)
  );

  Instruction_Memory_2 imem (
    .Instr_Addr     (PC_out),
    .Instruction (Instruction)
  );


  //
  // 2) IF/ID pipeline register
  //

  IF_ID if_id_reg (
    .clk                (clk),
    .reset              (reset),
    .PC_out             (PC_out),
    .Instruction        (Instruction),
    .IFID_PC_out        (IFID_PC_out),
    .IFID_instruction   (IFID_instruction)
  );

  //
  // 3) ID stage
  //

  Instruction_Parser_2 parser (
    .instruction (IFID_instruction),
    .opcode      (opcode),
    .rd          (rd),
    .funct3      (funct3),
    .rs1         (rs1),
    .rs2         (rs2),
    .funct7      (funct7)
  );
  
  Immediate_Generator_2 imm_gen (
    .instruction (IFID_instruction),
    .immediate(imm_data)
  );

  Control_Unit_2 control (
    .Opcode    (opcode),
    .ALUOp     (ALUOp),
    .Branch    (Branch),
    .MemRead   (MemRead),
    .MemtoReg  (MemtoReg),
    .MemWrite  (MemWrite),
    .ALUSrc    (ALUsrc),
    .RegWrite  (RegWrite)
  );

  Register_File_2 regfile (
    .WriteData  (WB_data),
    .RS1        (rs1),
    .RS2        (rs2),
    .RD         (MWB_rd),
    .RegWrite   (MWB_RegWrite),
    .clk        (clk),
    .reset      (reset),
    .ReadData1  (ReadData1),
    .ReadData2  (ReadData2)
  );

  assign Funct = (opcode == 7'b0110011)
               ? {IFID_instruction[30], IFID_instruction[14:12]}  // R-type
               : {1'b0,                 IFID_instruction[14:12]}; // I-type
               

  Branch_Unit_2 branch_unit (
    .Funct3    (funct3),
    .ReadData1 (ReadData1),
    .ReadData2 (ReadData2),
    .sel       (branch_sel)
  );

  //
  // 4) ID/EX pipeline register
  //

  ID_EX id_ex_reg (
    .clk             (clk),
    .reset           (reset),
    .RegWrite        (RegWrite),
    .MemRead         (MemRead),
    .MemToReg        (MemtoReg),
    .MemWrite        (MemWrite),
    .Branch          ((branch_sel & Branch)),
    .ALUOp           (ALUOp),
    .ALUSrc          (ALUsrc),
    .IFID_PC_out     (IFID_PC_out),
    .ReadData1       (ReadData1),
    .ReadData2       (ReadData2),
    .imm_data        (imm_data),
    .rs1             (rs1),
    .rs2             (rs2),
    .rd              (rd),
    .Funct           (Funct),
    .IDEX_RegWrite   (IDEX_RegWrite),
    .IDEX_MemRead    (IDEX_MemRead),
    .IDEX_MemToReg   (IDEX_MemToReg),
    .IDEX_MemWrite   (IDEX_MemWrite),
    .IDEX_Branch     (IDEX_Branch),
    .IDEX_ALUOp      (IDEX_ALUOp),
    .IDEX_ALUSrc     (IDEX_ALUSrc),
    .IDEX_PC_out     (IDEX_PC_out),
    .IDEX_ReadData1  (IDEX_ReadData1),
    .IDEX_ReadData2  (IDEX_ReadData2),
    .IDEX_imm_data   (IDEX_imm_data),
    .IDEX_rs1        (IDEX_rs1),
    .IDEX_rs2        (IDEX_rs2),
    .IDEX_rd         (IDEX_rd),
    .IDEX_Funct      (IDEX_Funct)
  );

  //
  // 5) EX stage
  //
  
  Adder_2 branch_adder (
    .a   (IDEX_PC_out),
    .b   (IDEX_imm_data),
    .out (branch_target)
  );
  
   Multiplexer_2 alu_src_mux (
    .a   (IDEX_ReadData2),
    .b   (IDEX_imm_data),
    .selector_bit (IDEX_ALUSrc),
    .data_out (ALU_operand2)
  );
  
  ALU_Control_2 alu_ctrl (
    .ALUOp     (IDEX_ALUOp),
    .Funct     (IDEX_Funct),
    .Operation (operation)
  );

  ALU_64_bit_2 alu_exec (
    .a      (IDEX_ReadData1),
    .b      (ALU_operand2),
    .ALUOp  (operation),
    .Result (ALU_Result),
    .ZERO   (zero_flag)
  );

  //
  // 6) EX/MEM pipeline register
  //

  EX_MEM ex_mem_reg (
    .clk               (clk),
    .reset             (reset),
    .IDEX_RegWrite     (IDEX_RegWrite),
    .IDEX_MemRead      (IDEX_MemRead),
    .IDEX_MemToReg     (IDEX_MemToReg),
    .IDEX_MemWrite     (IDEX_MemWrite),
    .IDEX_Branch       (IDEX_Branch),
    .Adder_out         (branch_target),
    .ALU_Result        (ALU_Result),
    .zero              (zero_flag),
    .IDEX_ReadData2    (IDEX_ReadData2),
    .IDEX_rd           (IDEX_rd),
    .EXM_RegWrite      (EXM_RegWrite),
    .EXM_MemRead       (EXM_MemRead),
    .EXM_MemToReg      (EXM_MemToReg),
    .EXM_MemWrite      (EXM_MemWrite),
    .EXM_Branch        (EXM_Branch),
    .EXM_Adder_out     (EXM_Adder_out),
    .EXM_ALU_Result    (EXM_ALU_Result),
    .EXM_zero          (EXM_zero),
    .EXM_ReadData2     (EXM_ReadData2),
    .EXM_rd            (EXM_rd)
  );

  //
  // 7) MEM stage + next-PC
  //
  
  Data_Memory_2 dmem (
    .mem_add   (EXM_ALU_Result),
    .write_data (EXM_ReadData2),
    .clk       (clk),
    .mem_write  (EXM_MemWrite),
    .mem_read   (EXM_MemRead),
    .read_data  (ReadData),
    .arr0    (array0),
    .arr1    (array1),
    .arr2    (array2),
    .arr3    (array3),
    .arr4    (array4),
    .arr5    (array5),
    .arr6    (array6)
  );

  //
  // 8) MEM/WB pipeline register
  //

  MEM_WB mem_wb_reg (
    .clk            (clk),
    .reset          (reset),
    .EXM_RegWrite   (EXM_RegWrite),
    .EXM_MemToReg   (EXM_MemToReg),
    .ReadData       (ReadData),
    .EXM_ALUResult  (EXM_ALU_Result),
    .EXM_rd         (EXM_rd),
    .MWB_RegWrite   (MWB_RegWrite),
    .MWB_MemToReg   (MWB_MemToReg),
    .MWB_ReadData   (MWB_ReadData),
    .MWB_ALUResult  (MWB_ALUResult),
    .MWB_rd         (MWB_rd)
  );

  //
  // 9) WB stage
  //
  
  Multiplexer_2 wb_mux (
    .a   (MWB_ALUResult),
    .b   (MWB_ReadData),
    .selector_bit (MWB_MemToReg),
    .data_out (WB_data)
  );

endmodule
