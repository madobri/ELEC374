module C_sign_extender (
    input wire clock,
    input wire clear,
    input wire [17:0] data_in,  
    input wire Cout,           
    output reg [31:0] BusLine
);

    reg [31:0] sign_extended_value;

    always @(posedge clock or posedge clear) begin
        if (clear)
            sign_extended_value <= 32'b0;
        else
            sign_extended_value <= {{14{data_in[17]}}, data_in};
    end

    always @(*) begin
        if (Cout)
            BusLine = sign_extended_value;
        else
            BusLine = 32'bz;
    end

endmodule
