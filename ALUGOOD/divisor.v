module divisor (
    input clk,                  // Clock input
    input signed [31:0] M,       // 32-bit Divisor (will be extended to 33-bit)
    input signed [31:0] Q,       // 32-bit Dividend
    output reg signed [63:0] Result // Quotient + Remainder output
);

    reg [31:0] Q_reg;         // Register to hold the quotient
    reg signed [32:0] A;      // 33-bit accumulator for remainder
    reg signed [32:0] M_neg, M_Pos; // Modified divisor values
    reg signed [32:0] M_extended;   // 3-bit sign-extended divisor
    integer count; // Iteration counter

    always @(posedge clk) begin
        if (count == 0) begin
            // Sign-extend M from 32-bit to 33-bit
            M_extended <= {M[31], M}; // Adds one extra sign bit

            // Initialize division registers
            A <= 33'b0;    
            Q_reg <= Q;     
            count <= 1;     

            // Handle signed division cases correctly
            if (M_extended[32] == 1) begin
                M_neg <= M_extended;        // If M is negative, store as is
                M_Pos <= -M_extended;
            end else begin
                M_neg <= -M_extended;       // If M is positive, negate
                M_Pos <= M_extended;
            end
        end 
        else if (count < 32) begin
            // Perform Restoring Division Iterations

            // Shift left {A, Q_reg} (Shift remainder + quotient)
            {A, Q_reg} <= {A, Q_reg} << 1;
            
            // Subtract `M_neg` from A (Restore if needed later)
            A <= A + M_neg; 

            if (A[32] == 1) begin  //If A is negative, restore and append 0
                A <= A + M_Pos;
                Q_reg[0] <= 0;
            end else begin
                Q_reg[0] <= 1;
            end

            count <= count + 1; // Increment counter

            // On last cycle (count == 31), store the final result
            if (count == 31) begin
                Result <= {A, Q_reg}; // Store Quotient & Remainder
            end
        end
    end

endmodule
