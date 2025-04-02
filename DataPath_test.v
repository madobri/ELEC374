`timescale 1ns / 1ps

module DataPath_tb;
    reg clear, clock, read;
    reg [31:0] Mdatain;
    wire [31:0] BusLine;

    reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in;
    reg R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
    reg HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin;
    reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
    reg R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
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
	 
    DataPath uut (
        .clear(clear), .clock(clock), .read(read), .Mdatain(Mdatain), .BusLine(BusLine),
        
        .R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in),
        .R5in(R5in), .R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in),
        .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in),
        .HIin(HIin), .LOin(LOin), .MARin(MARin), .MDRin(MDRin), .Yin(Yin), .Zin(Zin), .PCin(PCin),
		  .IRin(IRin),

        .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out),
        .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), .R9out(R9out),
        .R10out(R10out), .R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out),
        .HIout(HIout), .LOout(LOout), .MARout(MARout), .MDRout(MDRout), .Zhighout(Zhighout), .Zlowout(Zlowout),
		  .PCout(PCout),
		  
		  .IncPC(IncPC),
		  
        .R0_data(R0_data), .R1_data(R1_data), .R2_data(R2_data), .R3_data(R3_data), .R4_data(R4_data),
        .R5_data(R5_data), .R6_data(R6_data), .R7_data(R7_data), .R8_data(R8_data), .R9_data(R9_data),
        .R10_data(R10_data), .R11_data(R11_data), .R12_data(R12_data), .R13_data(R13_data), .R14_data(R14_data),
        .R15_data(R15_data), .HI_data(HI_data), .LO_data(LO_data), .MAR_data(MAR_data), .MDR_data(MDR_data),
		  .Y_data(Y_data),
		  .Z_data(Z_data),
		  .PC_data(PC_data),
		  .IR_data(IR_data),
		  
		  .encoded_signal(encoded_signal), .select_signals(select_signals), .opcode(opcode), .ZLine(ZLine)
    );
    
    always #5 clock = ~clock;
    
    initial begin
        clock = 0; clear = 0; read = 0;
        R0in = 0; R1in = 0; R2in = 0;
		  R3in = 0; R4in = 0; R5in = 0; 
		  R6in = 0; R7in = 0; R8in = 0; 
		  R9in = 0; R10in = 0; R11in = 0;
		  R12in = 0; R13in = 0; R14in = 0;
		  R15in = 0; HIin = 0; LOin = 0;
		  MARin = 0; MDRin = 0; Yin = 0;
		  Zin = 0; PCin = 0; IRin = 0;
		  
        R0out = 0; R1out = 0; R2out = 0;
		  R3out = 0; R4out = 0; R5out = 0;
		  R6out = 0; R7out = 0; R8out = 0;
		  R9out = 0; R10out = 0; R11out = 0;
		  R12out = 0; R13out = 0; R14out = 0;
		  R15out = 0; HIout = 0; LOout = 0;
		  MARout = 0; MDRout = 0; Zhighout = 0;
		  Zlowout = 0; PCout = 0;
		  opcode = 5'd0;
		  IncPC = 0;
		  read = 0;
		  
		  #10
		  Mdatain = 32'd1;
		  read = 1;
		  MDRin = 1;
		  #10 //10
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  R3in = 1;
		  #10 //20
		  MDRout = 0;
		  R3in = 0;
		  Mdatain = 32'd2;
		  read = 1;
		  MDRin = 1;
		  #10 //30
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  R7in = 1;
		  #10 //40
		  R7in = 0;
		  MDRout = 0;
		  Mdatain = 32'd6;
		  read = 1;
		  MDRin = 1;
		  #10 //50
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  R0in = 1;
		  #10 //60
		  R0in = 0;
		  MDRout = 0;
		  Mdatain = 32'd35;
		  read = 1;
		  MDRin = 1;
		  #10 //70
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  R2in = 1;
		  #10 //80
		  R2in = 0;
		  MDRout = 0;
		  Mdatain = 32'd6;
		  read = 1;
		  MDRin = 1;
		  #10 //90
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  R6in = 1;
		  #10 //100
		  R6in = 0;
		  MDRout = 0;
		  
		  
		  PCout = 1;
		  MARin = 1;
		  #10
		  PCout = 0;
		  MARin = 0;
		  IncPC = 1;
		  #10
		  IncPC = 0;
		  #10//120
		  
		  Mdatain = 32'h2A1B8000; //AND
		  read = 1;
		  MDRin = 1;
		  #10//130
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//140
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//150
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b00000;
		  #10//160
		  Zin = 1;
		  #10//170
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//200 AND RESULT
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10
		  R4out = 0;
		  
		  Mdatain = 32'h321B8000; //OR
		  read = 1;
		  MDRin = 1;
		  #10//200
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//210
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//220
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b00001;
		  #10//230
		  Zin = 1;
		  #10//240
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//270 OR RESULT
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//260
		  R4out = 0;
		  
		  Mdatain = 32'h1A1B8000; //add
		  read = 1;
		  MDRin = 1;
		  #10//270
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//280
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//290
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b00011;
		  #10//300
		  Zin = 1;
		  #10//310
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//340 ADD Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//330
		  R4out = 0;
		  
		  Mdatain = 32'h221B8000; //sub
		  read = 1;
		  MDRin = 1;
		  #10//340
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//350
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//360
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b00100;
		  #10//370
		  Zin = 1;
		  #10//380
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//410 SUB Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//400
		  R4out = 0;
		  
		  Mdatain = 32'h4A1B8000; //shr
		  read = 1;
		  MDRin = 1;
		  #10//410
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//420
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//430
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b01000;
		  #10//440
		  Zin = 1;
		  #10//450
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//480 SHR Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//470
		  R4out = 0;
		  
		  Mdatain = 32'h521B8000; //shra
		  read = 1;
		  MDRin = 1;
		  #10//480
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//490
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//500
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b01001;
		  #10//510
		  Zin = 1;
		  #10//520
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//550 SHRA Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//540
		  R4out = 0;
		  
		  Mdatain = 32'h5A1B8000; //shl
		  read = 1;
		  MDRin = 1;
		  #10//550
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//560
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//570
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b00111;
		  #10//580
		  Zin = 1;
		  #10//590
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//620 SHL Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//610
		  R4out = 0;
		  
		  Mdatain = 32'h3A1B8000; //ror
		  read = 1;
		  MDRin = 1;
		  #10//620
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//630
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//640
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b01011;
		  #10//650
		  Zin = 1;
		  #10//660
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//690 ROR Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//680
		  R4out = 0;
		  
		  Mdatain = 32'h421B8000; //rol
		  read = 1;
		  MDRin = 1;
		  #10//690
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//700
		  MDRout = 0;
		  IRin = 0;
		  R3out = 1;
		  Yin = 1;
		  #10//710
		  R3out = 0;
		  Yin = 0;
		  R7out = 1;
		  opcode = 5'b01010;
		  #10//720
		  Zin = 1;
		  #10//730
		  R7out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R4in = 1;
		  #10//760 ROL Result
		  Zlowout = 0;
		  R4in = 0;
		  R4out = 1;
		  #10//750
		  R4out = 0;
		  
		  Mdatain = 32'h8A800000; //neg
		  read = 1;
		  MDRin = 1;
		  #10//760
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//770
		  MDRout = 0;
		  IRin = 0;
		  R0out = 1;
		  opcode = 5'b01100;
		  #10//780
		  Zin = 1;
		  #10//790
		  R0out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R5in = 1;
		  #10//820 NEG Result
		  Zlowout = 0;
		  R5in = 0;
		  R5out = 1;
		  #10//810
		  R5out = 0;
		  
		  Mdatain = 32'h92800000; //not
		  read = 1;
		  MDRin = 1;
		  #10//820
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//830
		  MDRout = 0;
		  IRin = 0;
		  R0out = 1;
		  opcode = 5'b00010;
		  #10//840
		  Zin = 1;
		  #10//850
		  R0out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  R5in = 1;
		  #10//880 NOT Result
		  Zlowout = 0;
		  R5in = 0;
		  R5out = 1;
		  #10//870
		  R5out = 0;
		  
		  Mdatain = 32'h81300000; //MUL
		  read = 1;
		  MDRin = 1;
		  #10//880
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//890
		  MDRout = 0;
		  IRin = 0;
		  R2out = 1;
		  Yin = 1;
		  #10//900
		  R2out = 0;
		  Yin = 0;
		  R6out = 1;
		  opcode = 5'b00101;
		  #10//910
		  Zin = 1;
		  #10//920
		  R6out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  LOin = 1;
		  #10//930
		  Zlowout = 0;
		  LOin = 0;
		  #10
		  Zhighout = 1;
		  HIin = 1;
		  #10
		  HIin = 0;
		  Zhighout = 0;
		  LOout = 1; //LO result 970
		  #10//HI result 980
		  LOout = 0;
		  HIout = 1;
		  #20
		  HIout = 0;
		  
		  Mdatain = 32'h79300000; //DIV
		  read = 1;
		  MDRin = 1;
		  #10//950
		  read = 0;
		  MDRin = 0;
		  MDRout = 1;
		  IRin = 1;
		  #10//960
		  MDRout = 0;
		  IRin = 0;
		  R2out = 1;
		  Yin = 1;
		  #10//970
		  R2out = 0;
		  Yin = 0;
		  R6out = 1;
		  opcode = 5'b00110;
		  #350//1320
		  Zin = 1;
		  #10//1330
		  R6out = 0;
		  Zin = 0;
		  Zlowout = 1;
		  LOin = 1;
		  #10
		  Zlowout = 0;
		  LOin = 0;
		  #10
		  Zhighout = 1;
		  HIin = 1;
		  #10
		  HIin = 0;
		  Zhighout = 0;
		  LOout = 1; //LO result 1420
		  #10//HI result 1430
		  LOout = 0;
		  HIout = 1;
		  #10
		  HIout = 0;
		  
        #20
		  $stop;
		  
    end
endmodule
