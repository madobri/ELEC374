module sra (
    input signed [31:0] B,   
    input [5:0] shifts,      
    output [63:0] Result     
);
    wire signed [63:0] extended_B; 

    assign extended_B = {{32{B[31]}}, B};  
    assign Result = extended_B >>> shifts;

endmodule

