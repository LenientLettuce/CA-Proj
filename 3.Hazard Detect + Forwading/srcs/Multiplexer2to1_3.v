module Multiplexer2to1_3(a, b, selector_bit, data_out);
    input [63:0] a;         // First input data
    input [63:0] b;         // Second input data
    input selector_bit;     // Selection control
    output reg [63:0] data_out; // Output register
    
    always @(*) begin       // Combinational logic block
        data_out <= selector_bit ? b : a;  // Select b when selector=1, a when selector=0
    end
endmodule
