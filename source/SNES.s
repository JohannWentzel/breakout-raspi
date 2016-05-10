.section    .init

	.equ	LAT,	9							// GPIO line
	.equ	DAT,	10							// GPIO line
	.equ	CLK,	11							// GPIO line
	.equ	HCYC,	6							// half cycle length
	.equ	FCYC,	12							// full cycle length


.section .text

// init the SNES controller
.global initSNES
initSNES:				
	push	{lr}

// set clock line to output

	ldr	r0,	=0x20200004
	ldr	r1,	[r0]
	mov	r2,	#0b111
	lsl	r2,	r2,	#3
	bic	r1,	r2
	mov	r2,	#0b001
	lsl	r2,	r2,	#3
	orr	r1,	r2
	str	r1,	[r0]							// line 11 set to output.

// set latch line to output

	ldr	r0,	=0x20200000
	ldr	r1,	[r0]
	mov	r2,	#0b111
	lsl	r2,	r2,	#27
	bic	r1,	r2
	mov	r2,	#0b001
	lsl	r2,	r2,	#27
	orr	r1,	r2
	str	r1,	[r0]							// line	9 set to output.

// set data line to input

	ldr	r0,	=0x20200004
	ldr	r1,	[r0]
	mov	r2,	#0b111
	bic	r1,	r2
	str	r1,	[r0]							// line 10 set to input.

	pop 	{pc}

//////////////////////////////////////////////////////////////
.global readSNES
// Reads the SNES signal, intreprets buttons accordingly. 
// Returns in r0 and inverts signals (pressed buttons are 1) for sanity.
readSNES:
	push	{r4, r5, r6, lr}

	pattern	.req	r4
	mask	.req	r5

	// line 11 slash clock to 1
	ldr	r0,	=0x2020001C
	mov	r1,	#0x800
	str	r1,	[r0]		

	// line 9 slash latch to 1
	mov	r1, 	#0x200
	str 	r1,	[r0]


	// waitting 12 microsecs for fun
	mov	r1,	#12
	bl timehold

	// make latch 0
	ldr	r0,	=0x20200028
	mov	r1,	#0x200
	str	r1,	[r0]	

	mov	pattern,	#0
	mov	mask,	#1

clockloop:
	
	// wait half a cycle
	mov	r1,	#HCYC
	bl timehold

	// set clock to zero
	ldr	r0,	=0x2020001c
	mov	r1,	#0x800
	str	r1,	[r0]	

	// Wait half a cycle

	mov	r1,	#HCYC
	bl timehold
	
	// read data line
	ldr	r0,	=0x20200034
	ldr	r6,	[r0]
	tst	r6, 	#0x400
	orreq 	pattern,	mask		// add a 0 bit if button pressed

	// read the data line and add a 0 if button pressed, add 1 if not pressed
	
	// set clock to 1
	ldr	r0,	=0x20200028
	mov	r1,	#0x800
	str	r1,	[r0]

	lsl	mask,	#1
	cmp	mask,	#65536
	blo	clockloop


	mov	r0,	pattern
										// return the pattern of buttons... I hope

	pop	{r4, r5, r6, pc}

.section .data


