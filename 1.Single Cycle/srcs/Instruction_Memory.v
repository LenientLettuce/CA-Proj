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
     reg [7:0] Inst_memory [151:0];
        initial begin
            {Inst_memory[3], Inst_memory[2], Inst_memory[1], Inst_memory[0]} = 32'h00900093; // Instruction 1
            {Inst_memory[7], Inst_memory[6], Inst_memory[5], Inst_memory[4]} = 32'h00200113; // Instruction 2
            {Inst_memory[11], Inst_memory[10], Inst_memory[9], Inst_memory[8]} = 32'h00700193; // Instruction 3
            {Inst_memory[15], Inst_memory[14], Inst_memory[13], Inst_memory[12]} = 32'h00100213; // Instruction 4
            {Inst_memory[19], Inst_memory[18], Inst_memory[17], Inst_memory[16]} = 32'h00800293; // Instruction 5
            {Inst_memory[23], Inst_memory[22], Inst_memory[21], Inst_memory[20]} = 32'h00400313; // Instruction 6
            {Inst_memory[27], Inst_memory[26], Inst_memory[25], Inst_memory[24]} = 32'h00600393; // Instruction 7
            {Inst_memory[31], Inst_memory[30], Inst_memory[29], Inst_memory[28]} = 32'h10102023; // Instruction 8
            {Inst_memory[35], Inst_memory[34], Inst_memory[33], Inst_memory[32]} = 32'h10202223; // Instruction 9
            {Inst_memory[39], Inst_memory[38], Inst_memory[37], Inst_memory[36]} = 32'h10302423; // Instruction 10
            {Inst_memory[43], Inst_memory[42], Inst_memory[41], Inst_memory[40]} = 32'h10402623; // Instruction 11
            {Inst_memory[47], Inst_memory[46], Inst_memory[45], Inst_memory[44]} = 32'h10502823; // Instruction 12
            {Inst_memory[51], Inst_memory[50], Inst_memory[49], Inst_memory[48]} = 32'h10602a23; // Instruction 13
            {Inst_memory[55], Inst_memory[54], Inst_memory[53], Inst_memory[52]} = 32'h10702c23; // Instruction 14
            {Inst_memory[59], Inst_memory[58], Inst_memory[57], Inst_memory[56]} = 32'h10000513; // Instruction 15
            {Inst_memory[63], Inst_memory[62], Inst_memory[61], Inst_memory[60]} = 32'h00700593; // Instruction 16
            {Inst_memory[67], Inst_memory[66], Inst_memory[65], Inst_memory[64]} = 32'h00000613; // Instruction 17
            {Inst_memory[71], Inst_memory[70], Inst_memory[69], Inst_memory[68]} = 32'h00000693; // Instruction 18
            {Inst_memory[75], Inst_memory[74], Inst_memory[73], Inst_memory[72]} = 32'hfff58713; // Instruction 19
            {Inst_memory[79], Inst_memory[78], Inst_memory[77], Inst_memory[76]} = 32'h04e65263; // Instruction 20
            {Inst_memory[83], Inst_memory[82], Inst_memory[81], Inst_memory[80]} = 32'hfff58793; // Instruction 21
            {Inst_memory[87], Inst_memory[86], Inst_memory[85], Inst_memory[84]} = 32'h40c787b3; // Instruction 22
            {Inst_memory[91], Inst_memory[90], Inst_memory[89], Inst_memory[88]} = 32'h02f6d863; // Instruction 23
            {Inst_memory[95], Inst_memory[94], Inst_memory[93], Inst_memory[92]} = 32'h00269813; // Instruction 24
            {Inst_memory[99], Inst_memory[98], Inst_memory[97], Inst_memory[96]} = 32'h010508b3; // Instruction 25
            {Inst_memory[103], Inst_memory[102], Inst_memory[101], Inst_memory[100]} = 32'h00488913; // Instruction 26
            {Inst_memory[107], Inst_memory[106], Inst_memory[105], Inst_memory[104]} = 32'h0008a983; // Instruction 27
            {Inst_memory[111], Inst_memory[110], Inst_memory[109], Inst_memory[108]} = 32'h00092a03; // Instruction 28
            {Inst_memory[115], Inst_memory[114], Inst_memory[113], Inst_memory[112]} = 32'h013a4663; // Instruction 29
            {Inst_memory[119], Inst_memory[118], Inst_memory[117], Inst_memory[116]} = 32'h00168693; // Instruction 30
            {Inst_memory[123], Inst_memory[122], Inst_memory[121], Inst_memory[120]} = 32'hfd9ff06f; // Instruction 31
            {Inst_memory[127], Inst_memory[126], Inst_memory[125], Inst_memory[124]} = 32'h0148a023; // Instruction 32
            {Inst_memory[131], Inst_memory[130], Inst_memory[129], Inst_memory[128]} = 32'h01392023; // Instruction 33
            {Inst_memory[135], Inst_memory[134], Inst_memory[133], Inst_memory[132]} = 32'hff1ff06f; // Instruction 34
            {Inst_memory[139], Inst_memory[138], Inst_memory[137], Inst_memory[136]} = 32'h00160613; // Instruction 35
            {Inst_memory[143], Inst_memory[142], Inst_memory[141], Inst_memory[140]} = 32'hfb9ff06f; // Instruction 36
        end

    
    
     always @(Instr_Addr)

         begin
         Instruction[31:24] <= Inst_memory[Instr_Addr + 3];
         Instruction[23:16] <= Inst_memory[Instr_Addr + 2];
         Instruction[15:8] <= Inst_memory[Instr_Addr + 1];
         Instruction[7:0] <= Inst_memory[Instr_Addr];

     end
 endmodule



