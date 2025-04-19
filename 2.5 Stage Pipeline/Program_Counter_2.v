module Program_Counter(clk, reset, PC_in, PC_out);
    input clk, reset;       // Clock and reset signals
    input [63:0] PC_in;     // Next address input
    output reg [63:0] PC_out; // Current address output
    
    always @ (posedge clk)  // Triggered on rising clock edge
    begin
        if (reset == 1'b1)  // Reset condition
            PC_out <= 64'b0;
        else                // Normal operation
            begin
                PC_out <= PC_in; // Update PC value
            end
    end
endmodule
