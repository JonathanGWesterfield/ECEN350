`timescale 1ns / 1ps

module HalfAdd(Cout, Sum, A, B);

input A, B;

output Cout, Sum;

wire S1, S2, S3;  
nand NANDA (S3, A, B);  
nand NANDB (S1, A, S3);  
nand NANDC (S2, S3, B);  
nand NANDD (Sum, S1, S2);  
nand NANDCout(Cout, S3, S3); 

endmodule
