module Mux32to1 (
    input [31:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31,
    input [4:0] signal,
    output reg [31:0] BusMuxOut
);


always @(*) begin
    case (signal)
        5'b00000: BusMuxOut = I0;
        5'b00001: BusMuxOut = I1;
        5'b00010: BusMuxOut = I2;
        5'b00011: BusMuxOut = I3;
        5'b00100: BusMuxOut = I4;
        5'b00101: BusMuxOut = I5;
        5'b00110: BusMuxOut = I6;
        5'b00111: BusMuxOut = I7;
        5'b01000: BusMuxOut = I8;
        5'b01001: BusMuxOut = I9;
        5'b01010: BusMuxOut = I10;
        5'b01011: BusMuxOut = I11;
        5'b01100: BusMuxOut = I12;
        5'b01101: BusMuxOut = I13;
        5'b01110: BusMuxOut = I14;
        5'b01111: BusMuxOut = I15;
        5'b10000: BusMuxOut = I16;
        5'b10001: BusMuxOut = I17;
        5'b10010: BusMuxOut = I18;
        5'b10011: BusMuxOut = I19;
        5'b10100: BusMuxOut = I20;
        5'b10101: BusMuxOut = I21;
        5'b10110: BusMuxOut = I22;
        5'b10111: BusMuxOut = I23;
        5'b11000: BusMuxOut = I24;
        5'b11001: BusMuxOut = I25;
        5'b11010: BusMuxOut = I26;
        5'b11011: BusMuxOut = I27;
        5'b11100: BusMuxOut = I28;
        5'b11101: BusMuxOut = I29;
        5'b11110: BusMuxOut = I30;
        5'b11111: BusMuxOut = I31;
        default: BusMuxOut = 32'd0;
    endcase
end

endmodule
