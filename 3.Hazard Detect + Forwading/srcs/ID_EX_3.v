`timescale 1ns / 1ps

module ID_EX_3 (
    input [3:0] Funct,
    input clk, reset, flush, RegWrite, MemRead, MemToReg, MemWrite, Branch, branch_sel, ALUSrc,
    input [1:0] ALUOp,
    input [4:0] rs1, rs2, rd,
    input [63:0] IFID_PC_out, ReadData1, ReadData2, ImmData, 
    output reg [3:0] IDEX_Funct,
    output reg IDEX_RegWrite, IDEX_MemRead, IDEX_MemToReg, IDEX_MemWrite, IDEX_Branch, IDEX_branch_sel, IDEX_ALUSrc, 
    output reg [1:0] IDEX_ALUOp,
    output reg [63:0] IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_ImmData,
    output reg [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd
);    
    always @(posedge clk) 
    begin
       if(reset)
            begin
                IDEX_RegWrite <= 0;
                IDEX_MemRead <= 0;
                IDEX_MemWrite <= 0;
                IDEX_Branch <= 0;
                IDEX_branch_sel <= 0;
                IDEX_MemToReg <= 0;
                IDEX_ALUSrc <= 0;
                IDEX_ALUOp <= 0; 
                IDEX_Funct <= 0; 
                IDEX_ImmData <= 0;
                IDEX_rs1 <= 0; 
                IDEX_rs2 <= 0; 
                IDEX_rd <= 0; 
                IDEX_PC_out <= 0;
                IDEX_ReadData1 <= 0; 
                IDEX_ReadData2 <= 0;
            end
        else
            begin
                IDEX_RegWrite <= RegWrite;
                 IDEX_Branch <= Branch;
                 IDEX_branch_sel <= branch_sel;
                IDEX_MemRead <= MemRead;
                IDEX_MemWrite <= MemWrite;
                IDEX_ALUSrc <= ALUSrc;
                IDEX_MemToReg <= MemToReg;
                IDEX_ALUOp <= ALUOp;
                IDEX_ImmData <= ImmData;
                IDEX_Funct <= Funct;
                IDEX_rs1 <= rs1;
                IDEX_rs2 <= rs2;
                IDEX_rd <= rd;
                IDEX_PC_out <= IFID_PC_out;
                IDEX_ReadData1 <= ReadData1;
                IDEX_ReadData2 <= ReadData2;
            end     
//            $display("ID_EX: rs1 = %d, rs2 = %d, rd = %d", IDEX_rs1, IDEX_rs2, IDEX_rd);

    end
endmodule
