.globl WritePixelAUTO
WritePixelAUTO:
	// x - r0
	// y - r1
	// color = r3 | MUST ALREADY BE LOADED
	// r4 = final calculated offset to add to FramePointer
	// Temporary new x = r5
	// Temporary new y = r6
	// offset = r6
	// Pointer = r7

	push	{r4, r5, r6, r7, lr}

	ldr 	r7,		=FrameBufferPointer
	ldr 	r7,		[r7]
	mov 	r5, 	r0
	mov 	r6, 	r1
	lsl 	r6, 	#10
	add 	r6, 	r5
	lsl		r6, 	#1
	mov 	r4, 	r6
	add 	r7,		r4	// Adding offset to FramePointer
	strh 	r3,		[r7]

	pop 	{r4, r5, r6, r7, pc}
////////////////////////////////////////////////////////////////////////////////

.global HorizontalLine
HorizontalLine:
	// r0 = begin x coordinate
	// r1 = y coordinate
	// r2 = end x coordinate
	// r3 = color

	push	{lr}

	LineLoop:
	cmp		r0, 	r2
	bgt	 	DoneDrawing


	bl 		WritePixelAUTO
	add		r0, 	#1


	b 		LineLoop

	DoneDrawing:
	pop		{pc}
////////////////////////////////////////////////////////////////////////////////

.global VerticalLine
VerticalLine:
	// r0 = x coordinate
	// r1 = y coordinate
	// r2 = end y coordinate
	// r3 = color

	push	{lr}

	LineLoop2:
	cmp		r1, 	r2
	bgt	 	DoneDrawing2


	bl 		WritePixelAUTO
	add		r1, 	#1


	b 		LineLoop2

	DoneDrawing2:
	pop		{pc}
////////////////////////////////////////////////////////////////////////////////

.global Rectangle
Rectangle:
	// r0 = x-coordinate of TOP LEFT CORNER
	// r1 = y coordinate of TOP LEFT CORNER
	// r2 = length (horizontal)
	// r3 = color
	// r4 = width (vertical)
	// r5 = original x value (to reset x in horizontal line)
	// r6 = original y value (to reset y in horizontal line)
	push	{r5, lr}
	
	add		r2, 	r0		// end x coord = begin x + length
	mov 	r5, 	r0

	RectLoop:
	cmp 	r4, 	#0
	beq		RectComplete
	bl 		HorizontalLine
	add 	r1, 	#1
	sub 	r4, 	#1
	mov 	r0, 	r5


	b 		RectLoop



RectComplete:

	pop		{r5, pc}
