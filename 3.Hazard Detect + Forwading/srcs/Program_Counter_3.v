module Program_Counter_3(
    input clk, reset,
    input [63:0] PC_in,
    input PC_Write,
    output reg [63:0] PC_out

);
    always @ (posedge clk)  // Triggered on rising clock edge
    begin
        if (reset == 1'b1)  // Reset condition
           PC_out <= 64'b0;
        else if (PC_Write == 1'b0)
            PC_out <= PC_in; // Update PC value
        else 
            PC_out = PC_in;
    end
endmodule
