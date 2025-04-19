`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2025 02:45:04 PM
// Design Name: 
// Module Name: Instruction_Memory
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

 module Instruction_Memory(
     input [63:0] Instr_Addr,    // 64-bit instruction address input
     output reg [31:0] Instruction   // 32-bit instruction output
     );
    
     // Declaring a memory array with 16 entries of 8-bit width (bytes)
     reg [7:0] Inst_memory [147:0];
        initial begin
            {Inst_memory[3], Inst_memory[2], Inst_memory[1], Inst_memory[0]} = 32'h00900093; // addi x1 x0 9
            {Inst_memory[7], Inst_memory[6], Inst_memory[5], Inst_memory[4]} = 32'h00200113; // addi x2 x0 2
            {Inst_memory[11], Inst_memory[10], Inst_memory[9], Inst_memory[8]} = 32'h00700193; // addi x3 x0 7
            {Inst_memory[15], Inst_memory[14], Inst_memory[13], Inst_memory[12]} = 32'h00100213; // addi x4 x0 1
            {Inst_memory[19], Inst_memory[18], Inst_memory[17], Inst_memory[16]} = 32'h00800293; // addi x5 x0 8
            {Inst_memory[23], Inst_memory[22], Inst_memory[21], Inst_memory[20]} = 32'h00400313; // addi x6 x0 4
            {Inst_memory[27], Inst_memory[26], Inst_memory[25], Inst_memory[24]} = 32'h00600393; // addi x7 x0 6
            {Inst_memory[31], Inst_memory[30], Inst_memory[29], Inst_memory[28]} = 32'h10102023; // sw x1 256(x0)
            {Inst_memory[35], Inst_memory[34], Inst_memory[33], Inst_memory[32]} = 32'h10202223; // sw x2 260(x0)
            {Inst_memory[39], Inst_memory[38], Inst_memory[37], Inst_memory[36]} = 32'h10302423; // sw x3 264(x0)
            {Inst_memory[43], Inst_memory[42], Inst_memory[41], Inst_memory[40]} = 32'h10402623; // sw x4 268(x0)
            {Inst_memory[47], Inst_memory[46], Inst_memory[45], Inst_memory[44]} = 32'h10502823; // sw x5 272(x0)
            {Inst_memory[51], Inst_memory[50], Inst_memory[49], Inst_memory[48]} = 32'h10602a23; // sw x6 276(x0)
            {Inst_memory[55], Inst_memory[54], Inst_memory[53], Inst_memory[52]} = 32'h10702c23; // sw x7 280(x0)
            {Inst_memory[59], Inst_memory[58], Inst_memory[57], Inst_memory[56]} = 32'h10000513; // addi x10 x0 256
            {Inst_memory[63], Inst_memory[62], Inst_memory[61], Inst_memory[60]} = 32'h00700593; // addi x11 x0 7
            {Inst_memory[67], Inst_memory[66], Inst_memory[65], Inst_memory[64]} = 32'h00000613; // addi x12 x0 0
            {Inst_memory[71], Inst_memory[70], Inst_memory[69], Inst_memory[68]} = 32'h00000693; // addi x13 x0 0
            {Inst_memory[75], Inst_memory[74], Inst_memory[73], Inst_memory[72]} = 32'hfff58713; // addi x14 x11 -1
            {Inst_memory[79], Inst_memory[78], Inst_memory[77], Inst_memory[76]} = 32'h04e65263; // bge x12 x14 68
            {Inst_memory[83], Inst_memory[82], Inst_memory[81], Inst_memory[80]} = 32'hfff58793; // addi x15 x11 -1
            {Inst_memory[87], Inst_memory[86], Inst_memory[85], Inst_memory[84]} = 32'h40c787b3; // sub x15 x15 x12
            {Inst_memory[91], Inst_memory[90], Inst_memory[89], Inst_memory[88]} = 32'h02f6d863; // bge x13 x15 48
            {Inst_memory[95], Inst_memory[94], Inst_memory[93], Inst_memory[92]} = 32'h00269813; // slli x16 x13 2
            {Inst_memory[99], Inst_memory[98], Inst_memory[97], Inst_memory[96]} = 32'h010508b3; // add x17 x10 x16
            {Inst_memory[103], Inst_memory[102], Inst_memory[101], Inst_memory[100]} = 32'h00488913; // addi x18 x17 4
            {Inst_memory[107], Inst_memory[106], Inst_memory[105], Inst_memory[104]} = 32'h0008a983; // lw x19 0(x17)
            {Inst_memory[111], Inst_memory[110], Inst_memory[109], Inst_memory[108]} = 32'h00092a03; // lw x20 0(x18)
            {Inst_memory[115], Inst_memory[114], Inst_memory[113], Inst_memory[112]} = 32'h013a4663; // blt x20 x19 12
            {Inst_memory[119], Inst_memory[118], Inst_memory[117], Inst_memory[116]} = 32'h00168693; // addi x13 x13 1
            {Inst_memory[123], Inst_memory[122], Inst_memory[121], Inst_memory[120]} = 32'hfc000ce3; // 	beq x0 x0 -40   # always taken
            {Inst_memory[127], Inst_memory[126], Inst_memory[125], Inst_memory[124]} = 32'h0148a023; // sw x20 0(x17)
            {Inst_memory[131], Inst_memory[130], Inst_memory[129], Inst_memory[128]} = 32'h01392023; // sw x19 0(x18)
            {Inst_memory[135], Inst_memory[134], Inst_memory[133], Inst_memory[132]} = 32'hfe0008e3; // beq x0 x0 -16
            {Inst_memory[139], Inst_memory[138], Inst_memory[137], Inst_memory[136]} = 32'h00160613; // addi x12 x12 1
            {Inst_memory[143], Inst_memory[142], Inst_memory[141], Inst_memory[140]} = 32'hfa000ce3; // beq x0 x0 -72
            {Inst_memory[147], Inst_memory[146], Inst_memory[145], Inst_memory[144]} = 32'h00000013; // addi,x0,x0,0
        end

    
    
     always @(Instr_Addr)

         begin
         Instruction[31:24] <= Inst_memory[Instr_Addr + 3];
         Instruction[23:16] <= Inst_memory[Instr_Addr + 2];
         Instruction[15:8] <= Inst_memory[Instr_Addr + 1];
         Instruction[7:0] <= Inst_memory[Instr_Addr];

     end
 endmodule



