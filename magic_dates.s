// magic_dates source file
.global main

.align 4
.section .rodata
// all constant data goes here
prompt_msg:	.asciz	"Enter a date to see if it is a magic date.\nEnter a month, a day, and a two-digit year:\n"
scan_str:	.asciz	"%d %d %d"
if_msg:		.asciz	"The date %d/%d/%d is a magic date.\nMonth %d times day %d equals year %d\n"
else_msg:	.asciz	"The date %d/%d/%d is not a magic date.\nMonth %d times day %d does not equal year %d\n"

.align 4
.section .bss
// all uninitialized data goes here
day:	.word	0
month:	.word	0
year:	.word	0

.align 4
.section .text
// assembly language code goes here
main: 	push {LR} 		// save link register by pushing it to the stack

				// prompt user
	ldr r0, =prompt_msg	// load into r0 the memory address of prompt_msg
	bl  printf		// call the printf function

				// scan user input
	ldr r0, =scan_str	// load into r0 the memory address of scan_str
	ldr r1, =month		// load into r1 the memory address of month
	ldr r2, =day		// load into r2 the memory address of day
	ldr r3, =year		// load into r3 the memory address of year
	bl  scanf		// call the scanf function

				// process data
	ldr r4, =month		// load into r4 the memory address of month
	ldr r4, [r4]		// load into r4 the data dereferenced from the old r4
	ldr r5, =day		// load into r5 the memory address of day
	ldr r5, [r5]		// load into r5 the data dereferenced from the old r5
	ldr r6, =year		// load into r6 the memory address of year
	ldr r6, [r6]		// load into r6 the data dereferened from the old r6
	mul r7, r4, r5		// store into r7 the product of r4 (month) and r5 (day)
	cmp r6, r7		// compare content inside r6 with the content inside of r7
	bne else_part		// branch to else_part if r4 * r5 != r6

if_part:			// display if message
	ldr  r0, =if_msg	// load into register r0 the memory address of if_msg
	mov  r1, r4		// copy into r1 the contents of r4
	mov  r2, r5		// copy into r2 the contents of r5
	mov  r3, r6		// copy into r3 the contents of r6
	push {r3}		// push r3 onto the stack for the fourth format specifier
	push {r2}		// push r2 onto the stack for the fifth format specifier
	push {r1}		// push r1 onto the stack for the sixth format specifier
	bl   printf		// call the printf function
	add  sp, #12		// put sp back to where it was prior to the three pushes
	bal  end_of_if		// branch always to end_of_if

else_part:			// display else message
	ldr  r0, =else_msg      // load into register r0 the memory address of else_msg
        mov  r1, r4             // copy into r1 the contents of r4
        mov  r2, r5             // copy into r2 the contents of r5
        mov  r3, r6             // copy into r3 the contents of r6
        push {r3}               // push r3 onto the stack for the fourth format specifier
        push {r2}               // push r2 onto the stack for the fifth format specifier
        push {r1}               // push r1 onto the stack for the sixth format specifier
        bl   printf             // call the printf function
	add  sp, #12		// put sp back to where it was prior to the three pushes

end_of_if:
	mov r0, #0 		// return 0
	pop {PC}		// pop the stack onto pc

