`timescale 1ns / 1ps

module Mux21(out, in, sel);

input[1: 0]in;

input sel;

output out;

wire s1, s2, s3;

not NOT1(s1, sel); // ~Sel
and AND1(s2, in[0], s1); // ~sel & A
and AND2(s3, in[1], sel); // B & Sel

or OR1(out, s2, s3); // (~sel & A) || (B & Sel)

endmodule
