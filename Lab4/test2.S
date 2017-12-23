.globl test2

test2:

    SUB X1, X0, X1 // put this value in X1

    ADRP X0, output
    ADD X0,X0, :lo12:output // load the string into X0

    SUB SP, SP, #16 // get space on the stack
    STUR X30, [SP, #0] // store the old X30 for the branch

    BL printf

    LDUR X30, [SP, #0] // get old branch address back
    ADD SP, SP, #16 // increment stack pointer

    BR X30

.section    .data

output:    .asciz "The output of test2(6, 5) =  %d"