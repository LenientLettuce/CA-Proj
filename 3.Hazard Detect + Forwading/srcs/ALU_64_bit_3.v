`timescale 1ns / 1ps

module ALU_64_bit_3(
    input [63:0] a,         // Operand A
    input [63:0] b,         // Operand B
    input [3:0] ALUOp,      // ALU Operation code
    output reg [63:0] Result, // Computed result
    output reg ZERO        // Zero flag
);

    wire [63:0] and_r, or_r, xor_r, add, sub;
    wire [63:0] slli, srli;

    // Combinational logic for basic ALU operations
    assign and_r = a & b;
    assign or_r  = a | b;
    assign xor_r = a ^ b;
    assign add   = a + b;
    assign sub   = a - b;
    assign slli  = a << b[5:0];  // Only lower 6 bits used for shift amount
    assign srli  = a >> b[5:0];

    always @(*) begin
        case (ALUOp)
            4'b0000: Result = and_r;
            4'b0001: Result = or_r;
            4'b0010: Result = add;
            4'b0011: Result = sub;
            4'b0100: Result = xor_r;
            4'b0101: Result = slli;
            4'b0110: Result = srli;
            default: Result = 64'b0;
        endcase

        // Set the ZERO flag
        if (a == b) begin
            ZERO = 1;
        end
        else begin
            ZERO = 0;
        end
            
        $display("[%0t] ALU OP: %b, A=%h, B=%h, Result=%h", 
        $time, ALUOp, a, b, Result);
    end

endmodule
