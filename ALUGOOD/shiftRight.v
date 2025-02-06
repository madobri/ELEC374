module shiftRight ( 
    input [31:0] B,
    input [4:0] shifts,
    output [31:0] Result
);
    assign Result = B >> shifts;
	 
endmodule
