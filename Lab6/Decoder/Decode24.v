`timescale 1ns / 1ps

module Decode24(out, in);

input[1: 0]in;

output[3: 0]out;

assign out[0] = ~in[0] & ~in[1];
assign out[1] = in[0] & ~in[1];
assign out[2] = ~in[0] & in[1];
assign out[3] = in[0] & in[1];

endmodule


