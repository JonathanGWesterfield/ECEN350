
	.globl lab04b

lab04b:
	// do stack operations
	SUB SP, SP, #32 // allocate space 32 on the stack
	STUR X1, [SP, #16]
	STUR X30, [SP, #0]

IF:
	CBNZ X0, ELSE
	ORR X0, XZR, #1
	B END

ELSE:
	ADD X1, X0, XZR // stores X0 in X1
	SUB X0, X0, #1 // decrement n by 1 -> n--
	BL lab04b
	BL my_mul


END:
	// Do stack operations
	LDUR X30, [SP, #0]
	LDUR X1, [SP, #16]
	ADD SP, SP, #32 // decrement the stack pointer to the old link function
	BR X30 // return

