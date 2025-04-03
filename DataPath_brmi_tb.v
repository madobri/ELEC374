`timescale 1ns / 1ps

module DataPath_brmi_tb;
  reg clk, clear, read;
  reg [4:0] opcode;
  reg [31:0] fromInPort; 
  // Control signals
  reg HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin;
  reg HIout, LOout, MARout, MDRout, zhighout, zlowout, PCout, Cout, Inout, Outout;
  reg IncPC, wren, muxSignal, Gra, Grb, Grc, Rin, Rout, BAout, con_in;
  reg inport_in, outport_in; 

  // Outputs
  wire [31:0] BusLine;
  wire [31:0] R0_data, R1_data, R2_data, R3_data, R4_data,
              R5_data, R6_data, R7_data, R8_data, R9_data,
              R10_data, R11_data, R12_data, R13_data, R14_data,
              R15_data, HI_data, LO_data, MDR_data, z_low_data_out, z_high_data_out,
              Y_data, PC_data, IR_data, Ram_data, C_data, InPort_data, OutUnit, YLine;
  wire [31:0] encode;
  wire [4:0] select_signals;
  wire [63:0] ZLine;
  wire [15:0] Result_in, Result_out;
  wire [8:0] MAR_address;
  wire con_out;

  // Clock generation
  always #10 clk = ~clk;

  // Instantiate the DUT
  DataPath UUT(
    .clk(clk), .clear(clear), .read(read), .opcode(opcode), .fromInPort(fromInPort),
    .HIin(HIin), .LOin(LOin), .MARin(MARin), .MDRin(MDRin), .Yin(Yin), .Zin(Zin),
    .PCin(PCin), .IRin(IRin), .encode(encode),
    .HIout(HIout), .LOout(LOout), .MARout(MARout), .MDRout(MDRout),
    .zhighout(zhighout), .zlowout(zlowout), .PCout(PCout), .Cout(Cout), .Inout(Inout), .Outout(Outout),
    .IncPC(IncPC), .wren(wren), .muxSignal(muxSignal),
    .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
    .con_in(con_in), .con_out(con_out),
    .BusLine(BusLine), .R0_data(R0_data), .R1_data(R1_data), .R2_data(R2_data), .R3_data(R3_data),
    .R4_data(R4_data), .R5_data(R5_data), .R6_data(R6_data), .R7_data(R7_data), .R8_data(R8_data),
    .R9_data(R9_data), .R10_data(R10_data), .R11_data(R11_data), .R12_data(R12_data), .R13_data(R13_data),
    .R14_data(R14_data), .R15_data(R15_data), .HI_data(HI_data), .LO_data(LO_data),
    .MDR_data(MDR_data), .Y_data(Y_data), .PC_data(PC_data), .IR_data(IR_data),
    .Ram_data(Ram_data), .C_data(C_data), .InPort_data(InPort_data), .OutUnit(OutUnit), .YLine(YLine),
    .select_signals(select_signals), .ZLine(ZLine), .z_high_data_out(z_high_data_out), .z_low_data_out(z_low_data_out),
    .Result_in(Result_in), .Result_out(Result_out), .MAR_address(MAR_address), .inport_in(inport_in), .outport_in(outport_in)
  );

  // Initial sequence
  initial begin
    clk <= 0; clear <= 1; read <= 0;
    reset_signals();
	 #1 clear <= 0;
	
	//T0
	 @(posedge clk)
    PCout <= 1; MARin <= 1;
	 
	 //T1
    @(posedge clk); 
	 PCout <= 0; MARin <= 0; IncPC <= 1;
	 fromInPort = 32'b00000000100110000000000000011011;
	 inport_in = 1;
	 
	 //T2
    @(posedge clk); 
	 IncPC = 0; inport_in = 0; Inout = 1; IRin = 1; 
	 
	 //T2
    @(posedge clk); 
	 Inout = 0; IRin = 0; fromInPort = -32'd1; inport_in = 1;
	 
	 @(posedge clk);
	 inport_in = 0; Inout = 1; Gra = 1; Rin = 1;
	 @(posedge clk);
	 Inout = 0; Gra = 0; Rin = 0; Cout = 1; Yin = 1;
	 
	 @(posedge clk);
	 Cout = 0; Yin = 0; PCout = 1; Zin = 1;
	 opcode = 5'b00011;
	 
	 @(posedge clk);
	 Zin = 0; PCout = 0; Gra = 1; Rout = 1; con_in = 1;
	 
	 @(posedge clk);
	 Rout = 0; con_in = 0; zlowout = 1;
	 
	 @(posedge clk);
	 IncPC = 1; 
	 
	 #30
    $stop;

  end

  task reset_signals();
    begin
		HIin  <= 0;
		LOin  <= 0;

		MARin  <= 0;
		MDRin  <= 0;
		Yin    <= 0;
		Zin    <= 0;
		PCin   <= 0;
		IRin   <= 0;

		HIout    <= 0;
		LOout    <= 0;
		MARout   <= 0;
		MDRout   <= 0;
		zhighout <= 0;
		zlowout  <= 0;
		PCout    <= 0;
		Cout     <= 0;
		Inout    <= 0;
		Outout   <= 0;

		IncPC     <= 0;
		wren      <= 0;
		muxSignal <= 0;
		Gra       <= 0;
		Grb       <= 0;
		Grc       <= 0;
		Rin       <= 0;
		Rout      <= 0;
		BAout     <= 0;
		con_in    <= 0;
		inport_in <= 0;
		outport_in <= 0;
		fromInPort <= 32'd0;
    end
  endtask
endmodule