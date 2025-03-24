`timescale 1ns / 1ps

module DataPath_P2_tb;
    reg clear, clock, read;
    reg [31:0] Mdatain;
    wire [31:0] BusLine;

    reg HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin;
	 
    reg HIout, LOout, MARout, MDRout, Zhighout, Zlowout, PCout;
	 
	 reg IncPC;
    
    wire [31:0] R0_data, R1_data, R2_data, R3_data, R4_data;
    wire [31:0] R5_data, R6_data, R7_data, R8_data, R9_data;
    wire [31:0] R10_data, R11_data, R12_data, R13_data, R14_data;
    wire [31:0] R15_data, HI_data, LO_data, MAR_data, MDR_data, Y_data, Z_data, IR_data, PC_data;
	 
	 wire [4:0] encoded_signal;
	 wire [31:0] select_signals;
	 reg [4:0] opcode; 
    wire [63:0] ZLine;
	 
	 wire [15:0] Result_in, Result_out;
	 
	 reg Gra, Grb, Grc, Rin, Rout, BAout;
	 
    DataPath uut (
    .clear(clear), .clock(clock), .read(read), .Mdatain(Mdatain), .BusLine(BusLine),
    
    .HIin(HIin), .LOin(LOin), .MARin(MARin), .MDRin(MDRin), .Yin(Yin), .Zin(Zin), .PCin(PCin),
    .IRin(IRin),
    
    .HIout(HIout), .LOout(LOout), .MARout(MARout), .MDRout(MDRout), .Zhighout(Zhighout), .Zlowout(Zlowout),
    .PCout(PCout),
    
    .IncPC(IncPC),
    
    .R0_data(R0_data), .R1_data(R1_data), .R2_data(R2_data), .R3_data(R3_data), .R4_data(R4_data),
    .R5_data(R5_data), .R6_data(R6_data), .R7_data(R7_data), .R8_data(R8_data), .R9_data(R9_data),
    .R10_data(R10_data), .R11_data(R11_data), .R12_data(R12_data), .R13_data(R13_data), .R14_data(R14_data),
    .R15_data(R15_data), .HI_data(HI_data), .LO_data(LO_data), .MAR_data(MAR_data), .MDR_data(MDR_data),
    .Y_data(Y_data), .Z_data(Z_data), .PC_data(PC_data), .IR_data(IR_data),
    
    .encoded_signal(encoded_signal), .select_signals(select_signals), .opcode(opcode), .ZLine(ZLine),
    .Result_in(Result_in), .Result_out(Result_out),
    
    .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout)
	);
    
    always #5 clock = ~clock;
	 
	 initial begin 
	 clock = 0; clear = 0; read = 0;
	 
	 HIin = 0; LOin = 0; MARin = 0;
	 MDRin = 0; Yin = 0; Zin = 0; 
	 PCin = 0; IRin = 0;
	 
	 HIout = 0; LOout = 0; MARout = 0; 
	 MDRout = 0; Zhighout = 0; Zlowout = 0; 
	 PCout = 0; opcode = 5'd0; IncPC = 0;
	 
	 Gra = 0; Grb = 0; Grc = 0; Rin = 0;
	 Rout = 0;
	 
	 Mdatain = 32'b11000000111000011001100000010101;
	 read = 1;
	 MDRin = 1;
	 #10
	 read = 0;
	 MDRin = 0; 
	 MDRout = 1; 
	 IRin = 1;
	 #10
	 IRin = 0;
	 Rin = 1;
	 Gra = 1;
	 #10
	 MDRout = 0;
	 Rin = 0;
	 Rout = 1;
	 #20
	 Gra = 0;
	 Rout = 0;
	 Grb = 1;
	 Rin = 1;
	 #10
	 Rin = 0;
	 Rout = 1;
	 #10
	 $stop;
	 end
endmodule 
	 
	 
	 