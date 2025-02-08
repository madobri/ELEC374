module negALU(
    input [31:0] A,
    output [31:0] Result
);
    assign Result = ~A + 1; 
endmodule
