/*
Bradley STaple
10086742
Assignment 3 CPSC 359 fall 2013

basic text based System, with a simple breakout style game
*/

	// UART init values
	.equ	AUX_MU_IO_REG,	0x20215040
	.equ	AUX_MU_LSR_REG,	0x20215054
	.equ	AUX_ENABLES,	0x20215004
	.equ	AUX_MU_IER_REG,	0x20215044
	.equ	AUX_MU_CNTL_REG,0x20215060
	.equ	AUX_MU_LCR_REG,	0x2021504C
	.equ	AUX_MU_MCR_REG,	0x20215050
	.equ	AUX_MU_IIR_REG,	0x20215048
	.equ	AUX_MU_BAUD_REG,0x20215068
	.equ	GPPUD,		0x20200094
	.equ	GPPUDCLK0,	0x20200098

.section    .init

.section .text

.globl initUART
initUART:	
	push	{lr}

	ldr	r0,	=AUX_ENABLES					// enable miniUART
	mov	r1,	#0x00000001
	str	r1,	[r0]		

	ldr	r0,	=AUX_MU_IER_REG					// disable interups
	mov	r1,	#0
	str	r1,	[r0]

	ldr	r0,	=AUX_MU_CNTL_REG				// disable tansimit reg
	str	r1,	[r0]

	ldr	r0,	=AUX_MU_LCR_REG					// set symbol width,
	mov	r1,	#3
	str	r1,	[r0]

	ldr	r0, 	=AUX_MU_MCR_REG					// set RTS line, set to high
	mov	r1,	#0
	str	r1,	[r0]

	ldr	r0,	=AUX_MU_IIR_REG					// clear I/O buffers
	mov	r1,	#0x000000C6
	str	r1,	[r0]

	ldr	r0,	=AUX_MU_BAUD_REG				// set baud rate
	ldr	r1,	=270
	str	r1,	[r0]

	ldr	r0,	=0x20200004					// set RXD and TXD GPIO lines to alt func 5
	ldr	r1,	[r0]
	mov	r2,	#0b111
	lsl	r2,	r2,	#12
	bic	r1,	r2						// man this is borring....
	mov	r2,	#0b010
	lsl	r2,	r2,	#12
	orr	r1,	r2	
	
									// RXD's turn to get set
	mov	r2,	#0b111
	lsl	r2,	r2,	#15
	bic	r1,	r2
	mov	r2,	#0b010						// painful...
	lsl	r2,	r2,	#15
	orr	r1,	r2	
	str	r1,	[r0]
	
									 
	ldr	r0,	=GPPUD						// disable pull-up/pull-down for RXD and TDX
	mov	r1,	#0						// clear PUD bits
	str	r1,	[r0]									

	mov	r1,	#150						// wait 150 cycles, you know just for fun.
	mov	r0,	#0
	bl	cyclehold

	ldr	r0,	=GPPUDCLK0					// set clock lines 14 & 15 in GPIO pull-up/pull-down Clock Reg 0
	mov	r1,	#0x0000C000
	str	r1,	[r0]
									
	mov	r1,	#150						// wait 150 cycles, ONE MORE TIME!.
	mov	r0,	#0
	bl	cyclehold

	ldr	r0,	=GPPUDCLK0					// clear the clock lines, "bust out the pipe clears!"
	mov	r1,	#0
	str	r1,	[r0]


	ldr	r0,	=AUX_MU_CNTL_REG				// enable sending/receiving, Set Receiver and Transmitter Enable bits
	mov	r1,	#3						// is that it? is GPIO enabled now? what?!
	str	r1,	[r0]	

	pop	{pc}	

//////////////////////////////////////
.global	cyclehold
cyclehold:
	push	{lr}
cycloop:
	add		r0,		#1
	cmp		r0,		r1
	beq		cycloop

	pop	{pc}

//////////////////////////////////
// timehold is a time-based wait counter, not a LOOP-based wait counter. 
.global timehold
timehold:
	push 	{r4, r5, lr}	
	ldr	r0,	=0x20030004
	ldr	r4, 	[r0]
	add	r5, 	r4, 	r1 		// Adding delay
	timeloop:
		ldr 	r4, 	[r0]
		cmp	r4, 	r5		// Does current time = original time + delay?
		ble 	timeover
		b	timeloop
	timeover:

	pop	{r4, r5, pc}



.section .data








