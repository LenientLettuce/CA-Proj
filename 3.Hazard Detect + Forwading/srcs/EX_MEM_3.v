`timescale 1ns / 1ps

module EX_MEM_3(
    input clk, reset, flush, IDEX_RegWrite, IDEX_MemRead,  IDEX_MemWrite, IDEX_Branch, Zero,IDEX_MemToReg,
    input [63:0] Adder_out, ALUResult, IDEX_ReadData2,  
    input [4:0] IDEX_rd,
    output reg [4:0] EXM_rd,
    output reg [63:0] EXM_Adder_out, EXM_ReadData2, EXM_ALUResult, 
    output reg  EXM_RegWrite, EXM_MemRead, EXM_MemWrite, EXM_Branch, EXM_Zero, EXM_MemToReg 
);
    always @(posedge clk) begin
        if (reset)
            begin
                EXM_RegWrite <= 0;
                EXM_Branch <= 0;
                EXM_Zero <= 0;
                EXM_MemRead <= 0;
                EXM_MemWrite <= 0;
                EXM_Adder_out <= 0;
                EXM_rd <= 0;
                EXM_MemToReg <= 0;
                EXM_ReadData2 <= 0;
                EXM_ALUResult <= 0;
            end
        else
            begin
                EXM_RegWrite <= IDEX_RegWrite;
                EXM_Branch <= IDEX_Branch;
                EXM_Zero <= Zero;
                EXM_MemRead <= IDEX_MemRead;
                EXM_MemWrite <= IDEX_MemWrite;
                EXM_Adder_out <= Adder_out;
                EXM_rd <= IDEX_rd;
                EXM_MemToReg <= IDEX_MemToReg;
                EXM_ReadData2 <= IDEX_ReadData2;
                EXM_ALUResult <= ALUResult;
            end
//            $display("EX_MEM: ALU_Result = %h, rd = %d, RegWrite = %b", ALUResult, IDEX_rd, IDEX_RegWrite);

    end
endmodule