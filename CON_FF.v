module CON_FF(
    input [31:0] bus,
    input [1:0] ir, 
    input con_in,
    input clock,
    output reg con_out
);

    
    wire [31:0] notBus;
    wire D;
	 wire [3:0] out;
	 
    assign notBus = ~bus;  // Bitwise NOT on the entire bus

    decoder2_to_4 decoder(.in(ir), .out(out));  // Decoder instance

    // Compare the entire bus value to generate D
    assign D = (out[0] & (notBus == 32'h00000000)) |  // bus is all 0s
               (out[1] & (bus    == 32'h00000000)) |  // bus is all 0s
               (out[2] & (notBus[31]))           |  // MSB is 0
               (out[3] & (bus[31]));              // MSB is 1

    // Initialize con_out to avoid 'X' issue
    initial con_out = 0;

    always @(posedge clock) begin
        if (con_in) begin
            con_out <= D;
        end
    end

endmodule
