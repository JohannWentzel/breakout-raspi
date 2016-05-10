.section    .init


.section .text



.global mainGame
mainGame:
	push	{r5, r10, r11, r12,lr}

	bl	initSNES

gametop:
	bl	Clear
	bl	Frame

	bl	mainMenu
	cmp	r0,	#1
	bne	quit

	bl	Clear
	bl	Frame
	bl 	initBall
	bl 	initPaddle
	bl	GameScreen

	mov 	r0, 	#0
	mov 	r12,	#0
GameLoop:
	
	

	bl	movePaddle

	mov 	r0,		r0
	bl		moveBall
	bl 		didILose
	losecheck:
	cmp 	r12,	#1
	beq 	gameLost

	b	GameLoop

gameLost:
	bl 	Clear
	bl 	GameOverScreen
	bl 	gameOverWait
	b 	gametop

quit:
	//bl 	Clear
	b	systemhold	// Needed for game exit

	pop	{r5, r10, r11, r12, pc}



////////////////////////////////////////////////////////////////////////////////
// moves the ball!
moveBall:
	push	{r3-r9, lr}

	ldr		r4,	=ballInfo
	ldr		r0,	[r4]		// load X value
	ldr		r1, [r4, #4]	// load Y value
	ldr		r2,	[r4, #12]	// load dX value
	ldr 	r3,	[r4, #16]	// load dY value

	bl	ballColorScan 		// calls the scan method


	ldr		r4,		=ballInfo
	ldr		r0,		[r4]			// load X value
	ldr		r1,		[r4, #12]		// load dX value	
	ldr		r2, 	[r4, #4]		// load Y value
	ldr 	r3,		[r4, #16]		// load dY value

	bl 	drawBall 			// draws the updated ball.

	ldr	r2,	=ballInfo		// updates the ball's information.
	add	r3,	r2,	#4

	str	r0,	[r2]
	str	r1,	[r3]

	pop	{r3-r9, pc}


////////////////////////////////////////////////////////////////////////////////
//moves the paddle
movePaddle:
	push	{r4, r5, lr}

	bl	readSNES
	mov	r5,	r0

	ldr	r4,	=paddleInfo
	ldr	r0,	[r4]

	mov	r1,	#1
	lsl	r1,	r1,	#6
	tst	r5,	r1
	beq	notLeft
	// do stuff for left pressed
	mov	r1,	#-1
	bl	drawPaddle
	

notLeft:

	// prints > if > is pressed
	mov	r1,	#1
	lsl	r1,	r1,	#7
	tst	r5,	r1
	beq	notRight
	// do stuff for right pressed
	mov	r1,	#1
	bl	drawPaddle

notRight:

	ldr	r1,	=paddleInfo
	str	r0,	[r1]	

	cmp	r5,	#0
	beq	noButton

	mov	r0,	r5
	bl	SNESButtonsPressed
	b pressed

noButton:
	mov 	r7, 	#0
	ldr 	r8, 	=20000
lagLoop:				// This slows down the ball to a playable pace.
	add 	r7,		#1
	cmp	 	r7, 	r8
	ble 	lagLoop

pressed:

	pop	{r4, r5, pc}

/////////////////////////////////////////////////////////////////////////
.global flipX
flipX:
// Flips the dX value (reverses left/right direction)

	push 	{r4,r5,r6,r7,lr}
	
	mov 	r7, 	#-1
	ldr 	r4, 	=ballInfo
	ldr		r5,		[r4, #12]	// load dX value
	mul		r6, 	r5, 	r7 	// flip the value (-1 to 1 or 1 to -1)
	str		r6,		[r4, #12]	// store back
	
	pop 	{r4,r5,r6,r7,pc}

/////////////////////////////////////////////////////////////////////////
.global flipY
flipY:
// Flips the dY value (reverses up/down ball direction)

	push 	{r4,r5,r6,r7,lr}

	mov 	r7, 	#-1
	ldr 	r4, 	=ballInfo
	ldr 	r5,		[r4, #16]	// load dY value
	mul		r6, 	r5, 	r7	// flip the value (-1 to 1 or 1 to -1)
	str		r6,		[r4, #16]	// store back

	pop 	{r4,r5,r6,r7,pc}
		
////////////////////////////////////////////////////////////////////////

initBall:
	// the ball doesn't reset upon relaunching the game!
	// this will fix it.
	push 	{r4, r5, lr}

	ldr 	r4, 	=ballInfo
	ldr 	r5, 	=512
	str 	r5, 	[r4]
	ldr 	r5, 	=716
	str 	r5, 	[r4, #4]
	mov 	r5, 	#1
	str 	r5, 	[r4, #12]
	mov 	r5, 	#-1
	str 	r5, 	[r4, #16]

	pop 	{r4, r5, pc}
//////////////////////////////////////////////////////////////////
initPaddle:
	// upon relaunching the game, the paddle doesn't start in the same place!
	// This will fix it.

	push 	{r4,r5,lr}

	ldr 	r4, 	=paddleInfo
	ldr 	r5, 	=462
	str 	r5, 	[r4]

	pop 	{r4,r5,pc}


///////////////////////////////////////////////////////
paddleWithBall:
	// This is for moving the paddle with the ball initially.

	push 	{lr}



	pop 	{pc}
//////////////////////////////////////////////////////
didILose:
	// check if the ball has hit the bottom.
	push 	{r4,r5,r6,lr}

	ldr		r4, 	=ballInfo
	ldr 	r5, 	[r4,#4]
	ldr 	r6,		=757
	cmp 	r5, 	r6
	movge 	r12, 	#1
	movlt	r12, 	#0

	pop 	{r4,r5,r6,pc}

////////////////////////////////////////////
gameOverWait:
	// loop in the Game Over screen until a button is pressed.
	push 	{r4, lr}

	GameOverLoop:

	bl 		readSNES
	ldr 	r4, 	=0xFFFFFFFF
	tst 	r0, 	r4
	beq 	GameOverLoop

	pop 	{r4, pc}



.section .data

paddleInfo:
	.int	462								//paddle X
	.int	0xFFFF								//Paddle colour

ballInfo:
	.int 	512,	716,	0xffff,	1,	-1					//ball X, Y, colour, dX, dY

