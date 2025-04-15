module ALU_Control(
    input [1:0] ALUOp,        // ALU operation control input
    input [3:0] Funct,        // Function code
    output reg [3:0] Operation  // ALU operation output
);

always @(*) begin
    if (ALUOp == 2'b00) begin
        Operation <= 4'b0010; // Load/store -> ADD
    end 
    else if (ALUOp == 2'b01) begin
        Operation <= 4'b0110; // Branch -> SUB
    end 
    else if (ALUOp == 2'b10) begin // Ensure we check ALUOp before Funct
        if (Funct == 4'b0000) begin
            Operation <= 4'b0010; // ADD / ADDI
        end 
        else if (Funct == 4'b1000) begin
            Operation <= 4'b0110; // SUB
        end 
        else if (Funct == 4'b0111) begin
            Operation <= 4'b0000; // AND / ANDI
        end 
        else if (Funct == 4'b0110) begin
            Operation <= 4'b0001; // OR / ORI
        end 
        else if (Funct == 4'b0100) begin
            Operation <= 4'b0100; // XOR / XORI
        end 
        else begin
            Operation <= 4'bxxxx; // Undefined
        end
    end 
    else begin
        Operation <= 4'bxxxx; // Undefined
    end
end

endmodule
