module Hazard_Detection(
    input IDEX_MemRead,
    input [4:0] IDEX_rd, IFID_rs1, IFID_rs2,
    output reg IDEX_control_mux, IFID_Write, PC_write
);
    
    always @(*) begin
        // Hazard condition: Load-use dependency AND no branch being taken
        if (IDEX_MemRead && (IDEX_rd == IFID_rs1 || IDEX_rd == IFID_rs2)) 
        begin
            PC_write = 0;    // Stall PC
            IFID_Write = 0;  // Stall IF/ID
            IDEX_control_mux = 0; // Insert NOP in ID/EX
        end
        else begin
            PC_write = 1;    // Normal operation
            IFID_Write = 1;
            IDEX_control_mux = 1;
        end
    end
endmodule
