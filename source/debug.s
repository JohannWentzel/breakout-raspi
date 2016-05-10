.section    .init




.section .text

.global SNESButtonsPressed
SNESButtonsPressed:
	push	{lr}



	// prints A if A is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#8
	tst	r0,	r1
	beq	notA
	mov	r3,	#'A'
	bl	echochar
notA:
	// prints < if < is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#6
	tst	r0,	r1
	beq	notLeft
	mov	r3,	#'<'
	bl	echochar
notLeft:
	// prints > if > is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#7
	tst	r0,	r1
	beq	notRight
	mov	r3,	#'>'
	bl	echochar
notRight:
	// prints S if start is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#3
	tst	r0,	r1
	beq	notS
	mov	r3,	#'S'
	bl	echochar
notS:


	// checks if up is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#4
	tst	r5,	r1
	beq	notUp
	mov	r3,	#'^'
	bl	echochar


notUp:

	// checks if down is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#5
	tst	r5,	r1
	beq	notDown
	mov	r3,	#'v'
	bl	echochar


notDown:

	pop	{pc}







.global SNEScheckIfButtonsPressed
SNEScheckIfButtonsPressed:

	push	{r1-r4, lr}

	ldr	r1,	=0x0000ffff
bitch:	ldr	r2,	=0xffff0000
	bic	r0,	r2
	teq	r0,	r1
	bne	derp
	mov 	r3, 	#'N'	
	bl	echochar
	b 	done
	
derp:	mov	r3,	#'Y'
	bl	echochar

done:	


	pop	{r1-r4, pc}




.section .data
