`timescale 1ns / 1ps

module io_tb;

    
    reg clk;
    reg clr;
    reg [63:0] inData;
    reg inStrobe;
    reg inEnable;
    reg [63:0] outData;
    reg outEnable;
    wire [63:0] inPort;
    wire [63:0] outPort;

  
    io uut (
        .clk(clk),
        .clr(clr),
        .inData(inData),
        .inStrobe(inStrobe),
        .inEnable(inEnable),
        .outData(outData),
        .outEnable(outEnable),
        .inPort(inPort),
        .outPort(outPort)
    );

    always #10 clk = ~clk; 

    initial begin
      
        clk = 0;
        clr = 1;
        inData = 64'hA5A5A5A5A5A5A5A5;
        inStrobe = 0;
        inEnable = 0;
        outData = 64'hA5A5A5A5A5A5A5A5;
        outEnable = 0;

        #15 clr = 0;

  
        #10 inStrobe = 1; inEnable = 1; inData = 64'hABCDEF0123456789; 
        #20 inStrobe = 0; inEnable = 0;
        
        
        #10 outEnable = 1; outData = 64'h123456789ABCDEF0;
        #20 outEnable = 0; 
        
       
        #10 clr = 1;
        #10 clr = 0;
		  
		  $stop;
    end
	 
    initial begin
        $monitor("Time=%0t | in_port=%h | out_port=%h", $time, inPort, outPort);
    end

endmodule
