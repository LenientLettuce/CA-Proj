module Register_File_3(
    input [63:0] WriteData,
    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] RD,
    input RegWrite,
    input clk,
    input reset,
    output reg [63:0] ReadData1,
    output reg [63:0] ReadData2
);
    reg [63:0] Registers [31:0];

    // Initialize all registers (including x0)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            Registers[i] = 64'b0;
    end

    // Handle register writes (synchronous)
    always @(posedge clk) begin
        if (reset) begin
            // Clear all registers except x0 on reset
            for (i = 1; i < 32; i = i + 1)
                Registers[i] <= 64'b0;
        end
        else if (RegWrite && (RD != 0)) begin // Never write to x0
            Registers[RD] <= WriteData;
            // Monitor specific register writes
//            case (RD)
//                5'd12, 5'd13, 5'd17, 5'd18, 5'd19, 5'd20: 
//                    $display("[%0t] REG WRITE: x%d = %h (decimal: %0d)", 
//                            $time, RD, WriteData, $signed(WriteData));
//            endcase
        end
    end

    // Handle register reads (combinational)
    always @(*) begin
        // x0 is always 0
        ReadData1 = (RS1 == 0) ? 64'b0 : Registers[RS1];
        ReadData2 = (RS2 == 0) ? 64'b0 : Registers[RS2];
    end
    
    // Display specific register reads
    always @(RS1, RS2) begin
        // Check RS1
//        case (RS1)
//            5'd12, 5'd13, 5'd17, 5'd18, 5'd19, 5'd20:
//                //$display("[%0t] REG READ: x%d = %h (decimal: %0d)", 
//                        //$time, RS1, Registers[RS1], $signed(Registers[RS1]));
//        endcase
        
        // Check RS2
//        case (RS2)
//            5'd12, 5'd13, 5'd17, 5'd18, 5'd19, 5'd20:
//               // $display("[%0t] REG READ: x%d = %h (decimal: %0d)", 
//                        //$time, RS2, Registers[RS2], $signed(Registers[RS2]));
//        endcase
    end

    
    // Continuous monitoring of specific registers
    always @(posedge clk) begin
        $display("[%0t] REG MONITOR: x12=%h x13=%h x17=%h x18=%h x19=%h x20=%h",
                $time,
                Registers[12],
                Registers[13],
                Registers[17],
                Registers[18],
                Registers[19],
                Registers[20]);
    end
endmodule
