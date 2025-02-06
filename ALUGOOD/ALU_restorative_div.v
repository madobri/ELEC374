module ALU_restorative_div (M, quotient, Q, remainder);

    input [32:0] M;
    input [31:0] Q; 
    output reg [31:0] quotient; 
    output reg [32:0] remainder;  

    reg [31:0] Q_reg;  //for quotient because we can't modify input Q
    reg [32:0] A; 
	 
    integer i;  

    always @(*) begin

        A = 33'b0; //Set A to 0
        Q_reg = Q;   // Variable for Q that can be modified for quotient
		  
        for (i = 0; i < 32; i = i + 1) begin
		  
            {A, Q_reg} = {A, Q_reg} << 1;  //Shift left
            A = A - M; //Subtract M from A

            if (A[32] == 0) 
				begin	
                Q_reg[0] = 1;  //Append 1 to quotient
            end 
            else if (A[32] == 1)
				begin
                Q_reg[0] = 0;  //Append 0 to quotient
                A = A + M;  //Restore A if it is negative 
            end
        end	  
        quotient = Q_reg; 
        remainder = A;  
    end

endmodule
