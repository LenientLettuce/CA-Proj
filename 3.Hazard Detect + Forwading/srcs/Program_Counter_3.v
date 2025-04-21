`timescale 1ns / 1ps

module Program_Counter_3(
    input clk, reset,
    input [63:0] PC_in,
    input PC_Write,
    output reg [63:0] PC_out

);
    always @(posedge clk) begin
    if (reset)
        PC_out <= 64'b0;
    else if (PC_Write)
        PC_out <= PC_in;  // Only update when PC_Write is 1
end

endmodule
