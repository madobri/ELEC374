
module select_and_encoder(
input [31:0] instruction, 
input wire Gra, Grb, Grc, Rin, Rout, BAout,
output wire [15:0] Result_in, Result_out,
output wire [31:0] c_sign_extended

);
wire [3:0] decoder_input;
wire [15:0] decoder_output;

assign decoder_input = (instruction[26:23] & {4{Gra}}) | (instruction[22:19] & {4{Grb}}) | (instruction[18:15] & {4{Grc}});

decoder_4_to_16 decoderStuff(.decoder_input(decoder_input), .decoder_output(decoder_output));

assign Result_in = (decoder_output & {16{Rin}});
assign Result_out = decoder_output & ({16{Rout}} | {16{BAout}});
assign c_sign_extended = {{18{instruction[14]}},instruction[14:0]};

endmodule