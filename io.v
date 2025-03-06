module io(
	//input signals
	
	//clock signal 
	input wire clk,
	
	//resets registers (clear)
	input wire clr, 
	input wire [63:0] inData,
	input wire inStrobe,
	input wire inEnable,
	input wire [63:0] outData,
	input wire outEnable,
	
	//when inData, inEnable, inStrobe are high
	output reg [63:0] inPort,
	
	//when outData and outEnable are high
	output reg [63:0] outPort
	);
	
	always @(posedge clk or posedge clr)
	begin 
	
		//this will clear the input port when clr is active 
		if (clr)
			inPort <=64'b0;
			
		//if enable and strobe are active, data will be loaded into the in port
		else if (inEnable && inStrobe)
			inPort<=inData;
			
	end 
	
	always @(posedge clk or posedge clr)
	begin 
		if (clr)
			outPort <= 64'b0;
		//if out enable is high will write data
		else if (outEnable)
			outPort<=outData;
	end 
	
endmodule
	
	
			
	
	