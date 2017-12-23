.section .text

.globl lab02b

lab02b:	ADRP X0, msg1
	ADD X0, X0, :lo12:msg1
	LDURB W1, [X0, 3]		 //load the character into W1
	ADD W1, W1, -0X20		 //encap the letter
	STURB W1, [X0, 3]		//store the new letter
nomodify:
	BR X30
.section	.data
msg1: 	.asciz "This is the test sentence"
