`timescale 1ns / 1ps

module Encoder32to5_test;
	 reg [31:0] encoder_input;
	 wire [4:0] encoder_output;
	 
    Encoder32to5 uut (
		.Data(encoder_input), .signal(encoder_output)
    );
	 

    initial begin
        #10;
		  encoder_input = 32'd2;
		  #50;
		  encoder_input = 32'd64;
		  #50;
		  encoder_input = 32'd3;
		  #50;
		  $stop;
    end

endmodule
