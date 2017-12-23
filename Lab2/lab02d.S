	.globl lab02d

lab02d:
	ADD X1, X0, #1000
	// STUR X1, [X1, #0]
	ADRP X2, myvalue

	ADD X2, X2, :lo12:myvalue
	STUR W1, [X2, #0]
	ADD X0, X2, XZR
	BR X30

.section	.data
myvalue:
