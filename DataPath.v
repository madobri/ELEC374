module DataPath(
    input clear, clock, read,
    input [31:0] Mdatain,
    output wire [31:0] BusLine,
    
    input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in,
    input R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
    input HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin,
    
    input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,
    input R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    input HIout, LOout, MARout, MDRout, Zhighout, Zlowout, PCout,
	 
	 input IncPC,
    
    output wire [31:0] R0_data, R1_data, R2_data, R3_data, R4_data,
                R5_data, R6_data, R7_data, R8_data, R9_data,
                R10_data, R11_data, R12_data, R13_data, R14_data,
                R15_data, HI_data, LO_data, MAR_data, MDR_data,
					 Y_data, Z_data, PC_data, IR_data,
					 
	output wire [4:0] encoded_signal,
	output wire [31:0] select_signals,
	input wire [4:0] opcode,
	output wire [63:0] ZLine
);




register R0 (clear, clock, R0in, R0out, BusLine, R0_data);
register R1 (clear, clock, R1in, R1out, BusLine, R1_data);
register R2 (clear, clock, R2in, R2out, BusLine, R2_data);
register R3 (clear, clock, R3in, R3out, BusLine, R3_data);
register R4 (clear, clock, R4in, R4out, BusLine, R4_data);
register R5 (clear, clock, R5in, R5out, BusLine, R5_data);
register R6 (clear, clock, R6in, R6out, BusLine, R6_data);
register R7 (clear, clock, R7in, R7out, BusLine, R7_data);
register R8 (clear, clock, R8in, R8out, BusLine, R8_data);
register R9 (clear, clock, R9in, R9out, BusLine, R9_data);
register R10 (clear, clock, R10in, R10out, BusLine, R10_data);
register R11 (clear, clock, R11in, R11out, BusLine, R11_data);
register R12 (clear, clock, R12in, R12out, BusLine, R12_data);
register R13 (clear, clock, R13in, R13out, BusLine, R13_data);
register R14 (clear, clock, R14in, R14out, BusLine, R14_data);
register R15 (clear, clock, R15in, R15out, BusLine, R15_data);

register HI (clear, clock, HIin, HIout, BusLine, HI_data);
register LO (clear, clock, LOin, LOout, BusLine, LO_data);
register MAR (clear, clock, MARin, MARout, BusLine, MAR_data);
register_64 Z(clear, clock, Zin, Zhighout, Zlowout, ZLine, Z_data);
register Y(clear, clock, Yin, 1, BusLine, Y_data);
PC_register PC(clear, clock, PCin, PCout, IncPC, BusLine, PC_data);
register IR(clear, clock, IRin, 1, BusLine, IR_data);

MDR_register MDR (clear, clock, MDRin, MDRout, BusLine, Mdatain, read, MDR_data);


assign select_signals = {9'b0, PCout, Zhighout, Zlowout, MDRout, MARout, LOout, HIout, R15out, R14out,
                         R13out, R12out, R11out, R10out, R9out, R8out,
                         R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out};

Bus bus(
    .select_signals(select_signals),
    .R0_data(R0_data), .R1_data(R1_data), .R2_data(R2_data), .R3_data(R3_data), .R4_data(R4_data),
    .R5_data(R5_data), .R6_data(R6_data), .R7_data(R7_data), .R8_data(R8_data), .R9_data(R9_data),
    .R10_data(R10_data), .R11_data(R11_data), .R12_data(R12_data), .R13_data(R13_data), .R14_data(R14_data),
    .R15_data(R15_data), .HI_data(HI_data), .LO_data(LO_data), .MAR_data(MAR_data), .MDR_data(MDR_data),
	 .Z_data(Z_data), .PC_data(PC_data),
    .BusMuxOut(BusLine),
    .encoded_signal(encoded_signal)
);

ALU alu(
	.clk(clock), .signal(opcode), .A(Y_data), .B(BusLine), .Result(ZLine)

);

endmodule
