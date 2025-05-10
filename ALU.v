module ALU (
    input wire clk,               // Clock input for division
    input wire [4:0] signal,      // Operation selection from signal input 
    input wire [31:0] A, B,       // 32-bit Inputs
    output reg [63:0] Result      // 64-bit Result to go into register Z 
);

    // Wires to store outputs from the submodules
    wire [63:0] and_result, or_result, not_result, add_result, sub_result;
    wire [63:0] mul_result, shl_result, shr_result, shra_result, rol_result, ror_result, neg_result;
    
    // Division result needs a register to hold output for multiple clock cycles
    wire [63:0] div_result;
    reg [5:0] div_counter;  // Counter for 32-cycle division tracking

    // Instantiate ALU operation modules
    andALU and_op (.A(A), .B(B), .Result(and_result));
    orALU or_op (.A(A), .B(B), .Result(or_result));
    notALU not_op (.A(B), .Result(not_result));
    adder add_op (.A(A), .B(B), .Result(add_result));
    subtractor sub_op (.A(A), .B(B), .Result(sub_result));
    booth mult_op (.Q(A), .M(B), .Result(mul_result));
    shiftLeft shl_op (.B(B), .shifts(A[5:0]), .Result(shl_result));
    shiftRight shr_op (.B(B), .shifts(A[5:0]), .Result(shr_result));
    sra sra_op (.B(B), .shifts(A[5:0]), .Result(shra_result));
    rotLeft rol_op (.B(B), .rotate(A[5:0]), .Result(rol_result));
    rotateRight ror_op (.B(B), .rotate(A[5:0]), .Result(ror_result));
    negALU neg_op (.A(B), .Result(neg_result));

    // Instantiate clock-based division module
    divisor div_op (
		  .reset(signal==5'b00110),
        .clk(clk),    // Pass clock to division module
        .Q(A),
        .M(B),
        .Result(div_result)
    );

    always @(posedge clk) begin
        // Default values
        Result = 64'b0;

        case (signal)
            5'b00000: Result = and_result;   // AND
            5'b00001: Result = or_result;    // OR
            5'b00010: Result = not_result;   // NOT
            5'b00011: Result = add_result;   // ADD
            5'b00100: Result = sub_result;   // SUB
            5'b00101: Result = mul_result;   // MUL
            5'b00111: Result = shl_result;   // SHL
            5'b01000: Result = shr_result;   // SHR
            5'b01001: Result = shra_result;  // SRA
            5'b01010: Result = rol_result;   // ROL
            5'b01011: Result = ror_result;   // ROR
            5'b01100: Result = neg_result;   // NEG

            5'b00110: Result = div_result;  // Assign after 33 cycles

				/*
				begin  //DIVISION (Clock-Based)
                if (div_counter < 33) begin
                    div_counter <= div_counter + 1; // Increment counter
                end 
                else begin
                    Result <= div_result;  // Assign after 33 cycles
                    div_counter <= 0;  // Reset counter
                end
            end*/

            default: begin
                Result = 64'b0;
                div_counter = 0; // Reset counter when not dividing
            end
        endcase
    end

endmodule
