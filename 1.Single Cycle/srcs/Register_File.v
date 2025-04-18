`timescale 1ns / 1ps

module Register_File(WriteData, RS1, RS2, RD, RegWrite,clk,reset,ReadData1,ReadData2,r2,r3,r4 );
    input [63:0] WriteData;
    input [4:0] RS1;
    input [4:0] RS2;
    input [4:0] RD;
    input RegWrite;
    input clk;
    input reset;
    output reg [63:0] ReadData1;
    output reg [63:0] ReadData2;
    
    output [63:0] r2,r3,r4;
    reg [63:0] Registers [31:0];
  
    integer i;
    initial begin
    for (i = 0 ; i < 31 ; i = i + 1)
        Registers[i] = 0; //initializing values as 0
    end
    
    always @(*) begin
    if (reset) //if reset==1, reset readata1 and readata2
       begin
       ReadData1<=64'd0;
       ReadData2<=64'd0;
       end
       else begin
      
        ReadData1 <= Registers[RS1];  //if reset==0, readdata1 as reg[rs1] and readdata2 as reg[rs2]
        ReadData2 <= Registers[RS2];
        end
      end
    
    always @(posedge clk) //if posedge of clk and regwrite==1, write data in rd
    begin 
       if (RegWrite)
       begin
       Registers[RD] <= WriteData;
       end
    end
endmodule
