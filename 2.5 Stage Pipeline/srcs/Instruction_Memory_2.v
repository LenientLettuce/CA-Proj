module Instruction_Memory_2(
     input [63:0] Instr_Addr,    // 64-bit instruction address input
     output reg [31:0] Instruction   // 32-bit instruction output
     );
    
     // Declaring a memory array with 16 entries of 8-bit width (bytes)
     reg [7:0] Inst_memory [147:0];
        reg [7:0] Inst_memory [147:0];
        initial begin
            // addi x1, x0, 10
            {Inst_memory[3], Inst_memory[2], Inst_memory[1], Inst_memory[0]} = 32'h00a00093;
        
            // 2 NOPs
            {Inst_memory[7], Inst_memory[6], Inst_memory[5], Inst_memory[4]}   = 32'h00000013;
            {Inst_memory[11], Inst_memory[10], Inst_memory[9], Inst_memory[8]} = 32'h00000013;
        
            // addi x2, x0, 20
            {Inst_memory[15], Inst_memory[14], Inst_memory[13], Inst_memory[12]} = 32'h01400113;
        
            // 2 NOPs
            {Inst_memory[19], Inst_memory[18], Inst_memory[17], Inst_memory[16]} = 32'h00000013;
            {Inst_memory[23], Inst_memory[22], Inst_memory[21], Inst_memory[20]} = 32'h00000013;
        
            // addi x3, x0, 3
            {Inst_memory[27], Inst_memory[26], Inst_memory[25], Inst_memory[24]} = 32'h00300193;
        
            // 2 NOPs
            {Inst_memory[31], Inst_memory[30], Inst_memory[29], Inst_memory[28]} = 32'h00000013;
            {Inst_memory[35], Inst_memory[34], Inst_memory[33], Inst_memory[32]} = 32'h00000013;
        
            // add x1, x2, x3
            {Inst_memory[39], Inst_memory[38], Inst_memory[37], Inst_memory[36]} = 32'h003101b3;
        
            // 2 NOPs
            {Inst_memory[43], Inst_memory[42], Inst_memory[41], Inst_memory[40]} = 32'h00000013;
            {Inst_memory[47], Inst_memory[46], Inst_memory[45], Inst_memory[44]} = 32'h00000013;
        
            // sub x1, x2, x3
            {Inst_memory[51], Inst_memory[50], Inst_memory[49], Inst_memory[48]} = 32'h403101b3;
        
            // 2 NOPs
            {Inst_memory[55], Inst_memory[54], Inst_memory[53], Inst_memory[52]} = 32'h00000013;
            {Inst_memory[59], Inst_memory[58], Inst_memory[57], Inst_memory[56]} = 32'h00000013;
        
            // slli x1, x3, 3
            {Inst_memory[63], Inst_memory[62], Inst_memory[61], Inst_memory[60]} = 32'h00319193;
        
            // 2 NOPs
            {Inst_memory[67], Inst_memory[66], Inst_memory[65], Inst_memory[64]} = 32'h00000013;
            {Inst_memory[71], Inst_memory[70], Inst_memory[69], Inst_memory[68]} = 32'h00000013;
        
            // addi x1, x0, 1
            {Inst_memory[75], Inst_memory[74], Inst_memory[73], Inst_memory[72]} = 32'h00100093;
        
            // lw x3, 0(x0)
            {Inst_memory[79], Inst_memory[78], Inst_memory[77], Inst_memory[76]} = 32'h00002183;
        
            // 2 NOPs (to wait for x3 to be loaded from memory)
            {Inst_memory[83], Inst_memory[82], Inst_memory[81], Inst_memory[80]} = 32'h00000013;
            {Inst_memory[87], Inst_memory[86], Inst_memory[85], Inst_memory[84]} = 32'h00000013;
        
            // sw x2, 256(x0)
            {Inst_memory[91], Inst_memory[90], Inst_memory[89], Inst_memory[88]} = 32'h00318463;
        
            // addi x3, x0, 2
            {Inst_memory[95], Inst_memory[94], Inst_memory[93], Inst_memory[92]} = 32'h00200193;
        
            // 2 NOPs
            {Inst_memory[99], Inst_memory[98], Inst_memory[97], Inst_memory[96]} = 32'h00000013;
            {Inst_memory[103], Inst_memory[102], Inst_memory[101], Inst_memory[100]} = 32'h00000013;
        
            // blt x3, x2, 8
            {Inst_memory[107], Inst_memory[106], Inst_memory[105], Inst_memory[104]} = 32'h0021c463;
        
            // addi x2, x0, 4
            {Inst_memory[111], Inst_memory[110], Inst_memory[109], Inst_memory[108]} = 32'h00400113;
        end

    
    
     always @(Instr_Addr)

         begin
         Instruction[31:24] <= Inst_memory[Instr_Addr + 3];
         Instruction[23:16] <= Inst_memory[Instr_Addr + 2];
         Instruction[15:8] <= Inst_memory[Instr_Addr + 1];
         Instruction[7:0] <= Inst_memory[Instr_Addr];

     end
 endmodule
