`timescale 1ns / 1ps

module Register_File(
    input [63:0] WriteData,
    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] RD,
    input RegWrite,
    input clk,
    input reset,
    output reg [63:0] ReadData1,
    output reg [63:0] ReadData2,
    output [63:0] r2, r3, r4
);
    reg [63:0] Registers [31:0];

    // Initialize all registers (including x0)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            Registers[i] = 64'b0;
    end

    // Handle register writes (synchronous)
    always @(posedge clk) begin
        if (reset) begin
            // Clear all registers except x0 on reset
            for (i = 1; i < 32; i = i + 1)
                Registers[i] <= 64'b0;
        end
        else if (RegWrite && (RD != 0)) begin // Never write to x0
            Registers[RD] <= WriteData;
        end
    end

    // Handle register reads (combinational)
    always @(*) begin
        // x0 is always 0
        ReadData1 = (RS1 == 0) ? 64'b0 : Registers[RS1];
        ReadData2 = (RS2 == 0) ? 64'b0 : Registers[RS2];
       
    end

    // Additional register outputs for debugging
    assign r2 = Registers[2];
    assign r3 = Registers[3];
    assign r4 = Registers[4];
endmodule