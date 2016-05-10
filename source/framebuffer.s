.section .data
.align 12

FrameBufferInfo:
	.int	1024		// 0 - Width
	.int	768			// 4 - Height
	.int	1024		// 8 - vWidth
	.int	768			// 12 - vHeight
	.int	0			// 16 - Pitch (set by GPU)
	.int	16			// 20 - Bit Depth (bpp)
	.int	0			// 24 - X virtual offset
	.int	0			// 28 - Y virtual offset
	.int	0			// 32 - Framebuffer Pointer (set by GPU)
	.int	0			// 36 - Framebuffer Size (set by GPU)

.align 4
.globl FrameBufferPointer
FrameBufferPointer:
	.int	0

.section .text

/* Initialize the FrameBuffer
 * Return:
 *	r0 - message
 */

.globl InitFrameBuffer
InitFrameBuffer:
	push	{r4, lr}
	infoAdr	.req	r4
	result	.req	r0	

	ldr		infoAdr, =FrameBufferInfo

	mov		r0, infoAdr
	mov		r1, #1
	bl		MailboxWrite			// write FrameBufferInfo address to channel 1 (FrameBuffer) on the mailbox interface

	mov		r0, #1
	bl		MailboxRead				// read from channel 1 (FrameBuffer) on the mailbox interface

	teq		result, #0
	movne	result, #0
	popne	{r4, pc}

pointerWait$:
	ldr		result, [infoAdr, #32]	// load the value of the framebuffer pointer
	teq		result, #0
	beq		pointerWait$			// loop while the pointer is still 0

	ldr		r1,		=FrameBufferPointer
	str		result, [r1]			// store the framebuffer pointer

	mov		result, infoAdr
	pop		{r4, pc}

	.unreq	result
	.unreq	infoAdr

.globl WritePixelMANUAL
WritePixelMANUAL:


	ldr 	r1,		=FrameBufferPointer
	ldr 	r1,		[r1]
	ldr 	r2,		=0xFFFF
	strh 	r2,		[r1]
	add 	r1,		#4 
	ldr 	r2,		=0xFFF
	strh 	r2,		[r1]

.global 	getPixelColor
getPixelColor:	
	
	push 	{r3, r4, lr}

	ldr 	r4, 	=FrameBufferPointer
	add 	r3, 	r4, 	r0
	ldr 	r0, 	[r3]


	pop 	{r3, r4, pc}
