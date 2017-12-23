// int j = initial_value;

// for( i =0; i <10; i ++) {
// 	   my_array [ i ] = j ;

//  	j++;
// }


	.section .text
	.globl lab03c

lab03c:
	ADD X1, XZR, XZR // set X1 to 0 as i

	SUB X2, X2, X2 // X2 - X2 = 0 which will be my_value
	ADD X2, X2, #2 // my_value = 2 = j

	ADRP X5, my_array
	ADD X5, X5, :lo12:my_array // store my_array into X6
	ADD X10, X5, XZR // stores a copy of X5 at
	// x 10 so don't have to worry about losing X5

	B loop // enter the loop

loop:
	SUB X11, X1, #10 // subtract X1 from 10
	CBZ X11, exit // if X1 - 10 = 0

	LSL X9, X1, #3 // use this value to get the space between words
	ADD X10, X5, X9 // adds value of X9 to base address
	STUR X2, [X10, #0] // store j in A[i]

	ADD X2, X2, #1 // increment j by 1 -> j++
	SUB X1, X1, #1 // decrement i by 1 -> i--

	B loop // loop again

exit:
	BR X30

	.section	.data
	my_array: .space 40
