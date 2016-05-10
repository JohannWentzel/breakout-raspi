.section 	.init



.section 	.text

// .global ballScan
// //	ball x in r0, ball y in r1
// ballScan:
// 	push	{r2, r3, lr}

// 	ldr 	r3, 	=757
// 	cmp	r1,	r3
// 	bge	HorizontalWall
	
// 	ldr 	r2, 	=1012
// 	cmp	r0,	r2
// 	bge	VerticalWall

// 	ldr 	r3, 	=50
// 	cmp	r1,	r3
// 	ble	HorizontalWall
	
// 	ldr 	r2, 	=1
// 	cmp	r0,	r2
// 	ble	VerticalWall

// 	mov	r0,	#1
// 	mov	r1,	#1

// 	b	done

// HorizontalWall:
// 	mov	r0,	#1
// 	mov	r1,	#-1
// 	b done

// VerticalWall:
// 	mov	r0,	#-1
// 	mov	r1,	#1

// done:

	
// 	pop	{r2, r3, pc}

////////////////////////////////////////////////

.global ballColorScan
ballColorScan:
// r0 - ball X (passed in), becomes pixel to scan's X
// r1 - ball Y (passed in), becomes pixel to scan's Y
// r5 - scanning bound
// r6 - storage for ball x (to restore)
// r7 - storage for ball y (to restore)

	push	 {r5, r6, r7, r10,lr}

	mov 	r6, 	r0
	mov 	r7, 	r1			// storing original x, y for later

scanTop:
	// select pixel diagonally up-left from ball
	add 	r5, 	r6, 	#10 	// scans top from diag. up left to diag. up right from ball
	sub 	r1, 	#1

	scanloop1:
	bl 		getPixelColor
	cmp 	r2, 	#0 			// if color is 0...

	blne 	flipY 				// flip the ball's Y vector.

	bne 	scanLeft			// done checking top/bottom.

	add 	r0, 	#1			// if color isn't 0, add 1 to scanned x value
	cmp 	r0, 	r5 			// are we at the bound?
	bgt 	scanBottom
	b 		scanloop1			// add 1 to the x value scanned and loop again.

scanBottom:
	// select pixel diagonally down-left from ball
	add 	r5, 	r6, 	#10
	mov 	r0, 	r6 	
	add 	r1, 	r7, 	#10

	scanloop2:
	bl 		getPixelColor
	cmp		r2, 	#0

	blne 	flipY

	cmp		r2, 	#0
	bne 	scanLeft

	add 	r0, 	#1
	cmp 	r0, 	r5
	bgt 	scanLeft
	b 		scanloop2

scanLeft:
	// select pixel directly to the left of upper-left ball pixel. (x=ballx-1)
	add 	r5, 	r7, 	#9
	sub 	r0, 	r6, 	#1
	mov 	r1, 	r7

	scanloop3:
	bl 		getPixelColor
	cmp 	r2, 	#0

	blne 	flipX

	bne 	doneScan

	add 	r1, 	#1
	cmp		r1, 	r5
	bgt 	scanRight
	b 		scanloop3

scanRight:
	// select pixel direclty to right of upper-right ball pixel (x=ballx+10)
	add 	r5, 	r7, 	#9
	add 	r0, 	r6, 	#11
	mov 	r1, 	r7

	scanloop4:
	bl 		getPixelColor
	cmp 	r2, 	#0

	blne 	flipX

	bne 	doneScan

	add 	r1, 	#1
	cmp	 	r1, 	r5
	bgt 	doneScan
	b 		scanloop4


doneScan:

	pop 	{r5, r6, r7, r10, pc}

////////////////////////////////////////////////////////////


getPixelColor:

	// PARAMETERS:
	// r0 - X value of pixel
	// r1 - Y value of pixel
	// 	calculates (x + 1024y) * 2
	// RETURNS:
	// r2 - pixel color

	push 	{r4,r5,r6,lr}

	ldr 	r4, 	=1024
	mul 	r4,		r1, 	r4
	add 	r4, 	r0, 	r4
	lsl		r4, 	#1
	ldr 	r5, 	=FrameBufferPointer			// Add physical address of frame
	ldr 	r5, 	[r5]
	add 	r6, 	r5,		r4					// r6 now has address of pixel
	mov 	r2, 	#0 							// clearing register to get rid of any garbage upper bits
	ldrh 	r2, 	[r6]						// r0 now has color of pixel at address.

	pop 	{r4,r5,r6,pc}

.section 	.data

































