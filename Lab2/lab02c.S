.section .text
.globl lab02c

lab02c:
       ADRP X3, hextable
       ADD X3,X3, :lo12:hextable
       ADRP X5, result
       ADD X5,X5, :lo12:result
       LSR     X1, X0, 4       //get upper 4 bits // left shift right 4 times so 128/2^4 = 128 / 16
       ADD X2, X1, X3  			//get address in hextable
       LDURB W4, [X2,0] 		//get character
       STURB W4, [X5,0] 		// first digit of the result
       AND  X1, X0, 0xf        //get lower 4 bits
       ADD X2, X3, X1			//get address in hextable
       LDURB W4, [X2,0] 		//get character
       STURB W4, [X5,1] 		// second digit of the result
       BR X30
.section .data
hextable:
.asciz "0123456789abcdef"
msg1:
.asciz "Your number in Hex is: "
result:
.byte 2
