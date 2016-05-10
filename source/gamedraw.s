.section 	.init

	.equ 	PADDLE_Y,	727
	.equ	PADDLE_LENGTH, 	100
	.equ	PADDLE_WIDTH,	15
	.equ 	WHITE,	 	0xFFFF
	.equ	BLACK,		0x0000
	.equ	BALL_SIZE,	10

.section	.text

//////////////////////
// Draws the paddle.

.global drawPaddle
drawPaddle:

// r0 = old x parameter
// r1 = change in X

	push 	{r6, r7, lr}

check:
	oldX	.req	r6
	deltaX	.req	r7

	mov	oldX, 		r0
	mov	deltaX, 	r1

	add	r2,	oldX,	deltaX
	cmp	r2,	#0
	ble	paddleDrawn
	ldr	r3,	=923
	cmp	r2,	r3
	bge	paddleDrawn


// NON-WORKING (but better-optimized) PADDLE CODE
/*fuck:
	cmp	deltaX,	#1
	beq 	paddleRight
	
	// Changing paddle when it moves left
paddleLeft:
	
	mov 	r0,	oldX
	sub	r0,	r0,	#1
	ldr	r1, 	=PADDLE_Y
	add 	r2, 	r1, 	#14
	ldr	r3,	=WHITE
	bl	VerticalLine
shit:
	add 	r0,	oldX,	#PADDLE_LENGTH
	ldr	r1, 	=PADDLE_Y
	add 	r2, 	r1, 	#14
	ldr	r3,	=BLACK
	bl	VerticalLine
damn:

	b	paddleDrawn

paddleRight:

	mov 	r0,	oldX
	ldr	r1, 	=PADDLE_Y
	add 	r2, 	r1, 	#14
	ldr	r3,	=BLACK
	bl	VerticalLine

	add 	r0,	oldX,	#PADDLE_LENGTH
	add 	r0,	r0,	#1
	ldr	r1, 	=PADDLE_Y
	add 	r2, 	r1, 	#14
	ldr	r3,	=WHITE
	bl	VerticalLine*/

//WORKING (but crappier) PADDLE CODE
	mov	r0,	oldX							// erasing the old paddle
	ldr 	r1, 	=PADDLE_Y
	ldr 	r2, 	=PADDLE_LENGTH
	ldr 	r3, 	=BLACK
	ldr 	r4, 	=PADDLE_WIDTH
	bl 		Rectangle
	
	add	r0,	oldX,	deltaX						// erasing the old paddle
	ldr 	r1, 	=PADDLE_Y
	ldr 	r2, 	=PADDLE_LENGTH
	ldr 	r3, 	=WHITE
	ldr 	r4, 	=PADDLE_WIDTH
	bl 		Rectangle



	add	r0,	oldX,	deltaX		
	
	.unreq		oldX
	.unreq		deltaX


paddleDrawn:

	pop	{r6, r7, pc}	

////////////////////////////////
// Draws the ball.

.global drawBall
drawBall:

	// r0 = old x parameter
	// r1 = change in X
	// r2 = old y parameter
	// r3 = change in y

	push 	{r4, r5, r6, r7, r8, r9, lr}

	oldX	.req	r6					// Assigning register names
	deltaX	.req	r7
	oldY	.req	r8
	deltaY	.req	r9

	mov	oldX, 	r0
	mov	deltaX, r1
	mov	oldY,	r2
	mov	deltaY,	r3


	mov	r0,	oldX							// erasing the old ball
	mov	r1, 	oldY
	mov 	r2, 	#BALL_SIZE
	ldr 	r3, 	=BLACK
	mov 	r4, 	#BALL_SIZE
	bl 		Rectangle

	add	r0,	oldX,	deltaX						// drawing the new ball
	add	r1, 	oldY, 	deltaY
	ldr 	r2, 	=BALL_SIZE
	ldr 	r3, 	=WHITE
	ldr 	r4, 	=BALL_SIZE
	bl 		Rectangle
	add	r0,	oldX,	deltaX						
	add	r1, 	oldY, 	deltaY

	

ballBound:

	pop	{r4, r5, r6, r7, r8, r9, pc}	

.section 	.data
