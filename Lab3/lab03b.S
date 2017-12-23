	// for( i =0; i <10; i ++) {
	// UIN = UIN−1;
	// }

	.globl lab03b
// UIN is incoming to function so it will be coming from X0
// X1 represents the UIN

lab03b:
	SUB X1, X1, X1 // will always equal 0
	ADD X0, X1, #10 // make X1 = 10 for i
	ADRP X2, UIN
	ADD X2, X2, :lo12:UIN // store UIN into X2
	LDUR X3, [X2, #0]
	B loop

loop:

	CBZ X0, exit
	SUB X3, X3, #1
	SUB X0, X0, #1
	B loop

exit:
	STUR X3, [X2, #0]
	BR X30

 .section       .data
 	UIN: .word  32 // 224005649
