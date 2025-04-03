`timescale 1ns / 1ps

module DataPath_P3_tb;
    // Testbench signals
    reg clk;
    wire clear;
	 reg reset;
    reg [31:0] fromInPort;
    
    // Outputs from DataPath
    wire [4:0] opcode;
    wire HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin;
    wire HIout, LOout, MARout, MDRout, PCout, Cout, Inout, Outout;
    wire IncPC, wren, muxSignal, zhighout, zlowout;
    wire Gra, Grb, Grc, Rin, Rout, BAout, inport_in, outport_in;
    wire con_in, read;
    wire [31:0] encode, BusLine;
    wire [31:0] R0_data, R1_data, R2_data, R3_data, R4_data;
    wire [31:0] R5_data, R6_data, R7_data, R8_data, R9_data;
    wire [31:0] R10_data, R11_data, R12_data, R13_data, R14_data;
    wire [31:0] R15_data, HI_data, LO_data, MDR_data;
    wire [31:0] Y_data, PC_data, IR_data, Ram_data, C_data, z_high_data_out, z_low_data_out;
    wire [31:0] InPort_data, OutUnit, YLine;
    wire [4:0] select_signals;
    wire [63:0] ZLine;
    wire [15:0] Result_in, Result_out;
    wire [8:0] MAR_address;
    wire con_out;
    
    // Instantiate the DataPath module
    DataPath uut (
        .clk(clk),
        .clear(clear),
		  .reset(reset),
        .fromInPort(fromInPort),
        .opcode(opcode),
        .HIin(HIin), .LOin(LOin), .MARin(MARin), .MDRin(MDRin), .Yin(Yin), .Zin(Zin), .PCin(PCin), .IRin(IRin),
        .HIout(HIout), .LOout(LOout), .MARout(MARout), .MDRout(MDRout), .PCout(PCout), .Cout(Cout), .Inout(Inout), .Outout(Outout),
        .IncPC(IncPC), .wren(wren), .muxSignal(muxSignal), .zhighout(zhighout), .zlowout(zlowout),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .inport_in(inport_in), .outport_in(outport_in),
        .con_in(con_in), .read(read),
        .encode(encode), .BusLine(BusLine),
        .R0_data(R0_data), .R1_data(R1_data), .R2_data(R2_data), .R3_data(R3_data), .R4_data(R4_data),
        .R5_data(R5_data), .R6_data(R6_data), .R7_data(R7_data), .R8_data(R8_data), .R9_data(R9_data),
        .R10_data(R10_data), .R11_data(R11_data), .R12_data(R12_data), .R13_data(R13_data), .R14_data(R14_data),
        .R15_data(R15_data), .HI_data(HI_data), .LO_data(LO_data), .MDR_data(MDR_data),
        .Y_data(Y_data), .PC_data(PC_data), .IR_data(IR_data), .Ram_data(Ram_data), .C_data(C_data), .z_high_data_out(z_high_data_out), .z_low_data_out(z_low_data_out),
        .InPort_data(InPort_data), .OutUnit(OutUnit), .YLine(YLine),
        .select_signals(select_signals),
        .ZLine(ZLine),
        .Result_in(Result_in), .Result_out(Result_out),
        .MAR_address(MAR_address),
        .con_out(con_out)
    );
    
    always begin
        #5 clk = ~clk;
    end
	 
    initial begin
        clk = 0; reset = 1;
		  #10
		  reset = 0;
		  #2710
		  $stop;
    end
    
endmodule
