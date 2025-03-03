`timescale 1ns / 1ps

module Bus_tb;
    reg [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4; 
    reg [31:0] BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10; 
    reg [31:0] BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15; 
    reg [31:0] BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_MDR, BusMuxIn_MAR;
    reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out;
    reg R11out, R12out, R13out, R14out, R15out, HIout, LOout, MARout, MDRout;
    wire [31:0] BusMuxOut;
    wire [4:0] encoded_signal;
    
    Bus uut (
        .BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), 
        .BusMuxIn_R3(BusMuxIn_R3), .BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5), 
        .BusMuxIn_R6(BusMuxIn_R6), .BusMuxIn_R7(BusMuxIn_R7), .BusMuxIn_R8(BusMuxIn_R8), 
        .BusMuxIn_R9(BusMuxIn_R9), .BusMuxIn_R10(BusMuxIn_R10), .BusMuxIn_R11(BusMuxIn_R11), 
        .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13), .BusMuxIn_R14(BusMuxIn_R14), 
        .BusMuxIn_R15(BusMuxIn_R15), .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), 
        .BusMuxIn_MDR(BusMuxIn_MDR), .BusMuxIn_MAR(BusMuxIn_MAR), .R0out(R0out), .R1out(R1out), 
        .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), 
        .R8out(R8out), .R9out(R9out), .R10out(R10out), .R11out(R11out), .R12out(R12out), .R13out(R13out), 
        .R14out(R14out), .R15out(R15out), .HIout(HIout), .LOout(LOout), .MARout(MARout), .MDRout(MDRout), 
        .BusMuxOut(BusMuxOut), .encoded_signal(encoded_signal)
    );
    
    initial begin
        BusMuxIn_R0 = 32'h00000001;
        BusMuxIn_R1 = 32'h00000002;
        BusMuxIn_R2 = 32'h00000003;
        BusMuxIn_R3 = 32'h00000004;
        BusMuxIn_R4 = 32'h00000005;
        BusMuxIn_R5 = 32'h00000006;
        BusMuxIn_R6 = 32'h00000007;
        BusMuxIn_R7 = 32'h00000008;
        BusMuxIn_R8 = 32'h00000009;
        BusMuxIn_R9 = 32'h0000000A;
        BusMuxIn_R10 = 32'h0000000B;
        BusMuxIn_R11 = 32'h0000000C;
        BusMuxIn_R12 = 32'h0000000D;
        BusMuxIn_R13 = 32'h0000000E;
        BusMuxIn_R14 = 32'h0000000F;
        BusMuxIn_R15 = 32'h00000010;
        BusMuxIn_HI = 32'h00000011;
        BusMuxIn_LO = 32'h00000012;
        BusMuxIn_MDR = 32'h00000013;
        BusMuxIn_MAR = 32'h00000014;
        
        R0out = 1; R1out = 0; R2out = 0; R3out = 0; R4out = 0; R5out = 0; R6out = 0; R7out = 0;
        R8out = 0; R9out = 0; R10out = 0; R11out = 0; R12out = 0; R13out = 0; R14out = 0; R15out = 0;
        HIout = 0; LOout = 0; MARout = 0; MDRout = 0;
        
        #10 R0out = 0; 
		  R1out = 1;
        #10 R1out = 0; 
		  R2out = 1;
        #10 R2out = 0; 
		  R3out = 1;
        #10 R3out = 0; 
		  R4out = 1;
        #10 R4out = 0;
		  R5out = 1;
        #10 R5out = 0; 
		  R6out = 1;
        #10 R6out = 0; 
		  R7out = 1;
        #10 R7out = 0; 
		  R8out = 1;
        #10 R8out = 0; 
		  R9out = 1;
        #10 R9out = 0; 
		  R10out = 1;
        #10 R10out = 0; 
		  R11out = 1;
        #10 R11out = 0;
		  R12out = 1;
        #10 R12out = 0; 
		  R13out = 1;
        #10 R13out = 0; 
		  R14out = 1;
        #10 R14out = 0; 
		  R15out = 1;
        #10 R15out = 0; 
		  HIout = 1;
        #10 HIout = 0; 
		  LOout = 1;
        #10 LOout = 0; 
		  MARout = 1;
        #10 MARout = 0; 
		  MDRout = 1;
        #10 MDRout = 0;
   
        #10 $stop;
    end
endmodule
