module ALU_64_bit(
    input [63:0] a,         // Operand A
    input [63:0] b,         // Operand B
    input [3:0] ALUOp,      // ALU Operation code
    output reg [63:0] Result, // Computed result
    output ZERO        // Zero flag
);
    
    wire [63:0] and_r, or_r, xor_r, add, sub;
    wire [63:0] slli, srli; // Add this at the top with the other wires 
    
    // Operations
    assign and_r = a & b;
    assign or_r  = a | b;
    assign xor_r = a ^ b;
    assign add = a + b;      
    assign sub = a - b;      
    assign slli = a << b[5:0];  // Use only lower 6 bits for shift amount
    assign srli = a >> b[5:0];  // Use only lower 6 bits for shift amount

    always @(*) begin
        case (ALUOp)
            4'b0000: Result = and_r; // AND
            4'b0001: Result = or_r;  // OR
            4'b0010: Result = add;   // ADD
            4'b0011: Result = sub;   // SUB
            4'b0100: Result = xor_r; // XOR
            4'b0101: Result = slli;  // SLLI
            4'b0110: Result = srli;  // SRLI <-- ADD THIS
            default: Result = 64'b0; // Default to zero
        endcase
    end
           assign ZERO = Result? 0:1; 
endmodule 
