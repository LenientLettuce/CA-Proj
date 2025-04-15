module Program_Counter(
    input clk,          // Clock signal
    input reset,        // Reset signal
    input [63:0] PC_In, // 64-bit input (next instruction address)
    output reg [63:0] PC_Out // 64-bit output (current PC address)
);

    // Initialize PC_Out to 0
    initial begin
        PC_Out = 0;
    end

    // Always block to update PC at the positive edge of the clock or reset
    always @(posedge clk) begin
        if (reset) begin
            PC_Out <= 0; // Reset PC to 0
        end else begin
            PC_Out <= PC_In; // Update PC normally
        end
    end

endmodule
