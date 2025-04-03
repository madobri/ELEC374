module controlUnit(
	input clock, reset, stop,
	input [4:0] IR,
	
	output reg [4:0] opcode,
	output reg HIin, LOin, MARin, MDRin, Yin, Zin, PCin, IRin,
   output reg HIout, LOout, MARout, MDRout, PCout, Cout, Inout, Outout,
   output reg IncPC, wren, muxSignal, zhighout, zlowout,
   output reg Gra, Grb, Grc, Rin, Rout, BAout, inport_in, outport_in,
   output reg con_in, read, clear
);

parameter ADD = 5'b00011, SUB = 5'b00100, MUL = 5'b01111, DIV = 5'b10000, 
	AND = 5'b00101, OR = 5'b00110, SHR = 5'b01001, SHRA = 5'b01010, SHL = 5'b01011,
	 ROR = 5'b00111, ROL = 5'b01000, NEG = 5'b10001, NOT = 5'b10010, LD = 5'b00000, LDI = 5'b00001, ST = 5'b00010,
	 ADDI = 5'b01101, ANDI = 5'b11100, ORI = 5'b01110, BR = 5'b10011, JAL = 5'b10100, JR = 5'b10101, IN = 5'b10110, OUT = 5'b10111, MFLO = 5'b11000,
	 MFHI = 5'b11001, HALT = 5'b11011;
	 
parameter Treset = 5'b11111, Thalt = 5'b11110, T0 = 5'b00000, T1 = 5'b00001, T2 = 5'b00010, T3 = 5'b00011,
				 T4ALU = 5'b00100, T4DM = 5'b00101, T4ALUI = 5'b00110, T4NN = 5'b00111, T4BR = 5'b01000, T4LDST = 5'b01001, T4JAL = 5'b01010,
				 T5ALU = 5'b01011, T5BR = 5'b01100, T5LDI = 5'b01101, T5LD = 5'b01110, T5ST = 5'b01111,
				 T6DM = 5'b10000, T6BR = 5'b10001, T6LD = 5'b10010, T6ST = 5'b10011, 
				 T7LD = 5'b10100, T7ST = 5'b10101;
				 
task zero();begin
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
		read <= 0;
		clear <= 0;
		end
endtask

reg[4:0] present_state = 5'd0;
reg[4:0]next_state = 5'd0; 

always @(*) begin
	case(present_state)
		T0:begin
		zero();
		PCout <= 1; MARin <= 1;
		next_state <= T1;
		end
		T1:begin
		PCout <= 0; MARin <= 0; IncPC <= 1; read <= 1; MDRin <= 1;
		next_state <= T2;
		end
		T2:begin 
		IncPC <= 0; read <= 0; MDRin <= 0;
		MDRout <= 1; IRin <= 1;
		next_state <= T3;
		end
		T3:begin
		MDRout <= 0; IRin <= 0;
		opcode = IR; 
		case (opcode)
			MUL,DIV:begin
				next_state <= T4DM;
				Gra = 1; Rout = 1; Yin = 1;
			end
			
			ADD, SUB, AND, OR, ROR, ROL, SHR, SHRA, SHL:begin
				next_state <= T4ALU;
				Grb = 1; Rout = 1; Yin = 1;
			end
			
			ADDI, ANDI, ORI:begin
				next_state <= T4ALUI;
				Grb = 1; Rout = 1; Yin = 1;
			end
			
			NEG, NOT:begin
				next_state <= T4NN;
				Grb = 1; Rout = 1;
			end
			BR:begin
				next_state <= T4BR;
				Cout = 1; Yin = 1;
			end
			
			LD, LDI, ST:begin
				next_state <= T4LDST;
				Grb = 1; Rout = 1; BAout = 1; Yin = 1;
			end
			
			JAL:begin
				next_state <= T4JAL;
				Grb = 1; Rin = 1; PCout = 1;
			end
			
			JR:begin
				next_state <= T0;
				Grb = 1; Rout = 1; PCin = 1;
			end
			
			HALT:begin
				next_state <= Thalt;
			end
			
			IN:begin
				next_state <= T0;
				inport_in = 1; 
			end
			
			OUT:begin
				next_state <= T0;
				Gra = 1; Rout = 1; outport_in = 1; 
			end
			
			MFHI:begin
				next_state <= T0;
				Gra = 1; HIout = 1; Rin = 1;
			end
			
			MFLO:begin
				next_state <= T0;
				Gra = 1; LOout = 1; Rin = 1;
			end
			
			default: next_state = T0;
			
		endcase
		end
		
		T4DM:begin
			Gra = 0; Rout = 0; Yin = 0;
			Grb = 1; Rout = 1; Zin = 1;
			next_state <= T5ALU;
		end
		
		T4ALU:begin
			Grb = 0; Rout = 0; Yin = 0;
			Grc = 1; Rout = 1; Zin = 1; 
			next_state <= T5ALU;
		end
		
		T4ALUI:begin
		Grb = 0; Rout = 0; Yin = 0;
		Cout = 1; Zin = 1; 
		next_state <= T5ALU;
		end
		
		T4NN:begin
		Zin = 1;
		next_state <=T5ALU;
		end
		
		T4BR:begin
		Cout = 0; Yin = 0; opcode = ADD;
		PCout = 1; Zin = 1; 
		next_state = T5BR; 
		end
		
		T4LDST:begin
		Grb = 0; Rout = 0; Yin = 0; BAout = 0;
		Cout = 1; opcode = ADD; Zin = 1;
		if(IR == LD) next_state = T5LD;
		else if(IR == LDI) next_state = T5LDI;
		else next_state = T5ST;
		end
		
		T4JAL:begin
		Grb = 0; Rin = 0; PCout = 0;
		Gra = 1; Rout = 1; PCin = 1;
		next_state = T0;
		end
		
		T5ALU:begin
		if(opcode == DIV | opcode == MUL)begin
		next_state = T6DM;
		Grc = 0; Rout = 0; Zin = 0; Cout = 0;
		zlowout = 1; LOin = 1;
		end else begin
		next_state = T0;
		Grc = 0; Grb =0; Rout = 0; Zin = 0; Cout = 0;
		zlowout = 1; Gra = 1; Rin = 1;
		end
		end
		
		T5BR:begin
		PCout = 0; Zin = 0; opcode = BR;
		Gra = 1; Rout = 1; con_in = 1;
		next_state = T6BR; 
		end
		
		T5LD:begin
		Cout = 0; opcode = IR; Zin = 0;
		zlowout = 1; MARin = 1;
		next_state = T6LD;
		end
		
		T5LDI:begin
		Cout = 0; opcode = IR; Zin = 0;
		zlowout = 1; Gra = 1; Rin = 1;
		next_state = T0;
		end
		
		T5ST:begin
		Cout = 0; opcode = ST; Zin = 0;
		zlowout = 1; MARin = 1;
		next_state = T6ST;
		end
		
		T6DM:begin
		zlowout = 0; LOin = 0;
		zhighout = 1; HIin = 1;
		next_state = T0;
		end
		
		T6BR:begin
		Gra = 0; Rout = 0; con_in = 0;
		zlowout = 1;
		next_state = T0;
 		end
		
		T6LD:begin
		zlowout = 0; MARin = 0;
		read = 1; MDRin = 1;
		next_state = T7LD;
		end
		
		T6ST:begin
		zlowout = 0; MARin = 0; 
		Gra = 1; Rout = 1; MDRin = 1;
		next_state = T7ST;
		end
		
		T7LD:begin
		read = 0; MDRin = 0;
		Gra = 1; Rin = 1; MDRout = 1;
		next_state = T0;
		end
		
		T7ST:begin
		Gra = 0; Rout = 0; MDRin = 0;
		wren = 1;
		next_state = T0;
		end
		
		Treset:begin
		clear = 1;
		opcode = 5'd0;
		next_state = T0;
		end
		
		Thalt:begin
		$stop;
		end
		
		
	endcase
end

always @(posedge clock) begin
	if(reset)begin
		present_state = Treset;
	end
	else if (stop) begin
		present_state = Thalt;
	end else
	present_state <= next_state;
	end

endmodule 