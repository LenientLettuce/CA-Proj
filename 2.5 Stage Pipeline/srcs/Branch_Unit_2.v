module Branch_Unit_2(
    input [2:0] Funct3,
    input [63:0] ReadData1, 
    input [63:0] ReadData2,
    output reg sel
);

    initial begin
        sel = 1'b0;
    end
    always @(*) begin
        sel = 1'b0;  // Default value
            case (Funct3)
                3'b000: begin // beq
                    sel = (ReadData1 == ReadData2);
                end
                3'b001: begin // bne
                    sel = (ReadData1 != ReadData2); 
                end
                3'b100: begin // blt (signed)
                    sel = ($signed(ReadData1) < $signed(ReadData2));
                end
                3'b101: begin // bge (signed)
                    sel = ($signed(ReadData1) >= $signed(ReadData2));
                end
                3'b110: begin // bltu (unsigned)
                    sel = (ReadData1 < ReadData2);
                end
                3'b111: begin // bgeu (unsigned)
                    sel = (ReadData1 >= ReadData2);
                end
                default: sel = 1'b0;
            endcase
    end
endmodule
