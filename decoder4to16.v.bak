module decoder4to16 (
    input [3:0] reg_select,  // 4-bit register address
    input enable,            // Enable signal
    output reg [15:0] reg_out
);
    always @(*) begin
        reg_out = 16'b0;
        if (enable)
            reg_out[reg_select] = 1'b1;  // Activate one selected register
    end
endmodule