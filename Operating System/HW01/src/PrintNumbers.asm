        ; 8080 assembler code
        .hexfile PrintNumbers.hex
        .binfile PrintNumbers.com
        ; try "hex" for downloading in hex format
        .download bin  
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

	; OS call list
PRINT_B		equ 1
PRINT_MEM	equ 2
READ_B		equ 3
READ_MEM	equ 4
PRINT_STR	equ 5
READ_STR	equ 6

	; Position for stack pointer
stack   equ 0F000h

	org 000H
	jmp begin

	; Start of our Operating System
GTU_OS:	
    PUSH D
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop D
	ret
	; ---------------------------------------------------------------
	; YOU SHOULD NOT CHANGE ANYTHING ABOVE THIS LINE        

	;Prints integers from 0 to 50 by steps of 2 on the screen. Each
	;number will be printed on a new line


begin:
	lxi sp, stack   ; always initialize the stack pointer
    mvi d,  52	    ; initialize b with 50	
    mvi e,  0	    ; e = 0 for initialize   

loop:
    mov b, e  		; for printing the value it puts in b register
    mvi a, PRINT_B  ; for print_b function 
    call GTU_OS     ; system call            
    inr e           ; i += 2
    inr e
    mov a, e        ; for comparing e and d
    cmp d           ; compare a and d    
    jnz loop        ; goto loop if a != 50

exit:     
    hlt	; end program