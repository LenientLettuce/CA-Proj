module ALU_Control(
    input [1:0] ALUOp,
    input [3:0] Funct,
    output reg [3:0] Operation
);
always @(*) begin
    case (ALUOp)
        2'b00: Operation = 4'b0010; // Load/store -> ADD
        2'b01: Operation = 4'b0011; // Branch -> SUB
        2'b10: begin // R-type/I-type
            case (Funct)
                4'b0000: Operation = 4'b0010; // ADD/ADDI
                4'b1000: Operation = 4'b0011; // SUB
                4'b0111: Operation = 4'b0000; // AND/ANDI
                4'b0110: Operation = 4'b0001; // OR/ORI  
                4'b0100: Operation = 4'b0100; // XOR/XORI
                4'b0001: Operation = 4'b0101; // SLL/SLLI (Shift Left Logical)
                4'b0101: Operation = 4'b0110; // SRL/SRLI (Shift Right Logical)
                default: Operation = 4'b0010; // Default to ADD
            endcase
        end
        default: Operation = 4'b0010; // Default to ADD
    endcase
end
endmodule
