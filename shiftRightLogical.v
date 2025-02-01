module shiftRightLogical (
    input signed [31:0] B,
    input [4:0] shifts,
    output [31:0] Result
);
    assign Result = $signed(B) >>> shifts;
	 
endmodule
