.section	.init


.section	.text

.global mainMenu
mainMenu:
// returns into r0 a "pseudo-boolean" if "quit" or "play" - 1=play, 0=quit
	push	{r3,r4,r11,lr}
	
	bl	MainMenuScreen

	//x and y of indicator
	ldr		r0,		=450
	ldr		r1,		=425
	mov 	r2, 	#0
	mov 	r11, 	#1

MMLoop:
	ldr 	r0,		=450
	bl 	drawCursor
	bl 	checkMenu

	cmp		r2, 	#1
	bne 	MMLoop

	mov 	r0, 	r11

	pop		{r3,r4,r11,pc}


/////////////////////////////////////////

drawCursor:
	push 	{r6,r7,r8,r9,r10,lr}

	mov 	r6, 	r0
	mov 	r7, 	r1
	mov 	r8, 	r2
	mov 	r9, 	r3
	mov 	r10,	r4

	// X AND Y VALUES SHOULD ALREADY BE IN r0, r1
	mov 	r2, 	#15
	ldr 	r3, 	=0xFFFF
	mov 	r4, 	#15
	bl 		Rectangle

	mov 	r0, 	r6
	mov 	r1, 	r7
	mov 	r2, 	r8 			// Restoring ALL values to ensure correctness.
	mov 	r3, 	r9
	mov 	r4,		r10

	pop		{r6,r7,r8,r9,r10,pc}

eraseOldCursor:
	push 	{r6,r7,r8,r9,r10,lr}

	mov 	r6, 	r0
	mov 	r7, 	r1
	mov 	r8, 	r2
	mov 	r9, 	r3
	mov 	r10,	r4

	// X AND Y VALUES SHOULD ALREADY BE IN r0, r1
	ldr 	r0,		=450
	mov 	r1,		r4
	mov 	r2, 	#15
	ldr 	r3, 	=0x0000
	mov 	r4, 	#15
	bl 		Rectangle

	mov 	r0, 	r6
	mov 	r1, 	r7
	mov 	r2, 	r8 			// Restoring ALL values to ensure correctness.
	mov 	r3, 	r9
	mov 	r4,		r10

	pop		{r6,r7,r8,r9,r10,pc}



///////////////////////////////////////////

checkMenu:

	// r10 - start/quit?

	push 	{r3,r4,r5,lr}

	mov 	r4,		r1

	bl 		readSNES
	mov 	r5, 	r0 		// store button word for later
 

	// checks if up is pressed
	mov		r1,		#1
	lsl		r1,		r1,		#4
	tst		r5,		r1
	beq		notUp

	cmp 	r11, 	#1
	beq 	notUp
 	
 	mov 	r11, 	#1
 	bl 		eraseOldCursor
	sub 	r4, 	#100
	b 		cursorMoved

notUp:
	// checks if down is pressed
	mov		r1,		#1
	lsl		r1,		r1,		#5
	tst		r5,		r1
	beq		notDown

	cmp 	r11, 	#0
	beq		notDown

	mov 	r11, 	#0
	bl 		eraseOldCursor
	add 	r4,		#100
	b 		cursorMoved

notDown:

	// checks if A is pressed
	mov		r1,		#1
	lsl		r1,		r1,	#8
	tst		r5,		r1
	beq	notA

	mov	r2,	#1
	
notA:

cursorMoved:
	
	mov	r0,	r5
	bl	SNESButtonsPressed

	mov 	r1, 	r4

	pop 	{r3,r4,r5, pc}


.section	.data
