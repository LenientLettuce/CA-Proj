module Immediate_Generator_3(
    input [31:0] instruction,
    output reg [63:0] immediate
);
    wire [12:0] imm_SB;
    wire [11:0] imm_I;
    wire [11:0] imm_S;
    wire [20:0] imm_J;

    assign imm_SB = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    assign imm_I = instruction[31:20];
    assign imm_S = {instruction[31:25], instruction[11:7]};
    assign imm_J = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};

    always @(*) begin
        case (instruction[6:0])
            7'b1100011: // SB-type (e.g., beq)
                immediate = {{51{imm_SB[12]}}, imm_SB};
            7'b0000011, 7'b0010011, 7'b1100111: // I-type
                immediate = {{52{imm_I[11]}}, imm_I};
            7'b0100011: // S-type
                immediate = {{52{imm_S[11]}}, imm_S};
            7'b1101111: // J-type (jal)
                immediate = {{43{instruction[31]}}, imm_J};
            7'b0110111, 7'b0010111: // U-type (lui, auipc)
                immediate = {instruction[31:12], 12'b0};
            default:
                immediate = 64'd0;
        endcase
    end
endmodule
