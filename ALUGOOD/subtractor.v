module subtractor(A, B, Result);
    input [31:0] A, B; 
    output [31:0] Result;

    wire [31:0] temp1;
    wire [31:0] temp2;

    assign temp2 = ~B;

    adder add1 (.A(temp2), .B(32'd1), .Result(temp1)); 
    adder add2 (.A(A), .B(temp1), .Result(Result)); 
endmodule
