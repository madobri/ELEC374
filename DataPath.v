module DataPath(
    input clear, clock, read,
    input [31:0] fromInPort,
    output wire [31:0] BusLine,
    
    input HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin,
    
    input HIout, LOout, MARout, MDRout, Zhighout, Zlowout, PCout, Cout, Inout,
    
    input IncPC,
    
	 input wren,
	 
    output wire [31:0] R0_data, R1_data, R2_data, R3_data, R4_data,
                R5_data, R6_data, R7_data, R8_data, R9_data,
                R10_data, R11_data, R12_data, R13_data, R14_data,
                R15_data, HI_data, LO_data, MAR_data, MDR_data,
                Y_data, Z_data, PC_data, IR_data, Ram_data, C_data, InPort_data, OutUnit,
    
    output wire [4:0] encoded_signal,
    output wire [31:0] select_signals,
    input wire [4:0] opcode,
    output wire [63:0] ZLine,
    
    output wire [15:0] Result_in, Result_out,
	 
	 output wire [8:0] MAR_address,
    
    input Gra, Grb, Grc, Rin, Rout, BAout,
    
    input con_in,
    output wire con_out
);

wire Out = (Rout | HIout | LOout | MARout | MDRout | Zhighout | Zlowout | PCout | Cout);

SelectAndEncoder select_and_encoder(
    .IR(IR_data),
    .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
    .Result_in(Result_in), .Result_out(Result_out)
);

register R0 (clear, clock, Result_in[0], Result_out[0], BusLine, R0_data);
register R1 (clear, clock, Result_in[1], Result_out[1], BusLine, R1_data);
register R2 (clear, clock, Result_in[2], Result_out[2], BusLine, R2_data);
register R3 (clear, clock, Result_in[3], Result_out[3], BusLine, R3_data);
register R4 (clear, clock, Result_in[4], Result_out[4], BusLine, R4_data);
register R5 (clear, clock, Result_in[5], Result_out[5], BusLine, R5_data);
register R6 (clear, clock, Result_in[6], Result_out[6], BusLine, R6_data);
register R7 (clear, clock, Result_in[7], Result_out[7], BusLine, R7_data);
register R8 (clear, clock, Result_in[8], Result_out[8], BusLine, R8_data);
register R9 (clear, clock, Result_in[9], Result_out[9], BusLine, R9_data);
register R10 (clear, clock, Result_in[10], Result_out[10], BusLine, R10_data);
register R11 (clear, clock, Result_in[11], Result_out[11], BusLine, R11_data);
register R12 (clear, clock, Result_in[12], Result_out[12], BusLine, R12_data);
register R13 (clear, clock, Result_in[13], Result_out[13], BusLine, R13_data);
register R14 (clear, clock, Result_in[14], Result_out[14], BusLine, R14_data);
register R15 (clear, clock, Result_in[15], Result_out[15], BusLine, R15_data);

register HI (clear, clock, HIin, HIout, BusLine, HI_data);
register LO (clear, clock, LOin, LOout, BusLine, LO_data);
MAR_register MAR (clear, clock, MARin, MARout, BusLine, MAR_data, MAR_address);
register_64 Z(clear, clock, Zin, Zhighout, Zlowout, ZLine, Z_data);
register Y(clear, clock, Yin, 1, BusLine, Y_data);
PC_register PC(clear, clock, PCin, PCout, IncPC, BusLine, PC_data);
register IR(clear, clock, IRin, 1, BusLine, IR_data);

MDR_register MDR (clear, clock, MDRin, MDRout, BusLine, RAM_data, read, MDR_data);


CON_FF con_ff(
    .bus(BusLine),
    .ir(IR_data[20:19]),        
    .con_in(con_in),          
    .clock(clock),           
    .con_out(con_out),                      
);

assign select_signals = {7'b0, Inout, Cout, PCout, Zhighout, Zlowout, MDRout, MARout, LOout, HIout, Result_out};

Bus bus(
    .select_signals(select_signals),
    .R0_data(R0_data), .R1_data(R1_data), .R2_data(R2_data), .R3_data(R3_data), .R4_data(R4_data),
    .R5_data(R5_data), .R6_data(R6_data), .R7_data(R7_data), .R8_data(R8_data), .R9_data(R9_data),
    .R10_data(R10_data), .R11_data(R11_data), .R12_data(R12_data), .R13_data(R13_data), .R14_data(R14_data),
    .R15_data(R15_data), .HI_data(HI_data), .LO_data(LO_data), .MAR_data(MAR_data), .MDR_data(MDR_data),
    .Z_data(Z_data), .PC_data(PC_data), .clock(clock), .Rout(Out), .C_data(C_data), .InPort_data(InPort_data), 
    .BusMuxOut(BusLine),
    .encoded_signal(encoded_signal)
);

ALU alu(
    .clk(clock), .signal(opcode), .A(Y_data), .B(BusLine), .Result(ZLine)
);

memram ram(.address(MAR_address), .clock(clock), .data(MDR_data), .wren(wren), .q(RAM_data));

C_sign_extender C_sign(.clock(clock), .clear(clear), .data_in(IR_data[17:0]), .Cout(Cout), .BusLine	(C_data));

register InPort(clear, clock, 1, Inout, fromInPort, InPort_data);
register OutPort(clear, clock, 1, Outout, BusLine, OutUnit);

endmodule
