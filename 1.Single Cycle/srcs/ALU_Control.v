module ALU_Control(
    input [1:0] ALUOp,
    input [3:0] Funct,
    output reg [3:0] Operation
);
always @(*) begin
    case (ALUOp)
        2'b00: Operation = 4'b0010; // Load/store -> ADD
        2'b01: Operation = 4'b0011; // Branch -> SUB (changed to match ALU)
        2'b10: begin // R-type/I-type
            case (Funct)
                4'b0000: Operation = 4'b0010; // ADD/ADDI
                4'b1000: Operation = 4'b0011; // SUB (changed to match ALU)
                4'b0111: Operation = 4'b0000; // AND/ANDI
                4'b0110: Operation = 4'b0001; // OR/ORI  
                4'b0100: Operation = 4'b0100; // XOR/XORI
                default: Operation = 4'b0010; // Default to ADD
            endcase
        end
        default: Operation = 4'b0010; // Default to ADD
    endcase
end
endmodule