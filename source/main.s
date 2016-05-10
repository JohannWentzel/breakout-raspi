/*
Bradley STaple
10086742
Assignment 3 CPSC 359 fall 2013

basic text based System, with a simple breakout style game


*/
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
.globl     _start

_start:
    b       main

.section .text

main:
   	mov     sp,	#0x8000
	bl		EnableJTAG


	bl	initUART							// init UART
	bl	InitFrameBuffer							// init a frame buffer

	bl	Clear


.global systemhold
systemhold:


	mov	r8,	#0						// start counter in r8

	bl	printprompt						// just writting out everyboys favourate prompting arrow
	bl	getstring						// get me some of that string

	mov	r3,	#0x0a						// making room
	bl	echochar	

	cmp	r8,	#4						// no point in checking a string thats shorter than all the commands.
	bmi	nocmderror



	b	funcselect
//////////////////////////////////////////////////
// testing to select function
funcselect:								// time to decide what to do with this string
	ldr	r0,	=string
	ldr	r1,	=echocmdstring
	mov	r2,	#0

	bl	echotest
	bl	ledontest
	bl	ledofftest						// one testing function for each command
	bl	drawmenutest
	bl	drawgametest
	bl	drawovertest
	bl	drawwontest
	bl	gametest


	b	nocmderror						// and of course a function of bad inputs


//////////
gametest:
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=gamecmdstring
	mov	r2,	#8						// gather the required info
gameloop:	
	cmp	r2,	#0
	beq	mainGame
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	gameloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notgame
notgame:	
	pop	{pc}
	
//////////
drawwontest:
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=woncmdstring
	mov	r2,	#17						// gather the required info
drawwonloop:	
	cmp	r2,	#0
	beq	drawwon
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	drawwonloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notdrawwon
notdrawwon:	
	pop	{pc}

//////////
drawovertest:
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=overcmdstring
	mov	r2,	#18						// gather the required info
drawoverloop:	
	cmp	r2,	#0
	beq	drawover
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	drawoverloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notdrawover
notdrawover:	
	pop	{pc}

//////////
drawgametest:
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=gamescreencmdstring
	mov	r2,	#14						// gather the required info
drawgameloop:	
	cmp	r2,	#0
	beq	drawgame
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	drawgameloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notdrawgame
notdrawgame:	
	pop	{pc}

//////////
drawmenutest:
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=menucmdstring
	mov	r2,	#14						// gather the required info
drawmenuloop:	
	cmp	r2,	#0
	beq	drawmenu
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	drawmenuloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notdrawmenu
notdrawmenu:	
	pop	{pc}

//////////			
echotest:
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=echocmdstring
	mov	r2,	#5						// gather the required info
echoloop:	
	cmp	r2,	#0
	beq	echo
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	echoloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notecho	
notecho:	
	pop	{pc}

//////////
ledontest:								//should we try and turn on the LED?
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=ledoncmdstring
	mov	r2,	#6						// gather the required info
ledonloop:	
	cmp	r2,	#0
	beq	ledon
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	ledonloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notledon	
notledon:	
	pop	{pc}

//////////
ledofftest:								//should we try and turn off the LED?
	push	{lr}

	ldr	r0,	=string
	ldr	r1,	=ledoffcmdstring
	mov	r2,	#7						// gather the required info
ledoffloop:	
	cmp	r2,	#0
	beq	ledoff
	sub	r2,	#1
	bl	loadtwobytes
	cmp	r6,	r7
	add	r0,	#1
	add	r1,	#1
	beq	ledoffloop						//	compare characters form input and memory 
									//	while decreasing a counter = the length of the command being check for
	bne	notledoff	
notledoff:	
	pop	{pc}


//////////////////////////////////////////////////
//writes the input string minus the word echo back to the terminal
echo:
	ldr	r0,	=string
	mov	r1,	#5
	bl	printstring

	b	systemhold
//////////////////////////////////////////////////
// draw the game won screen
drawwon:

	bl	Clear
	bl	Frame
	bl	YouWinScreen
	b	systemhold
//////////////////////////////////////////////////
// draw the game over screen
drawover:

	bl	Clear
	bl	Frame
	bl	GameOverScreen
	b	systemhold
//////////////////////////////////////////////////
// draw the menu screen
drawmenu:

	bl	Clear
	bl	Frame
	bl	MainMenuScreen
	b	systemhold
//////////////////////////////////////////////////
// draw the game screen
drawgame:

	bl	Clear
	bl	Frame
	bl	GameScreen
	b	systemhold

//////////////////////////////////////////////////
// a little message to let you know that the input wasn't one of the commands
nocmderror:
	ldr	r0,	=nocmderrorstring
	mov	r1,	#0
	mov	r8,	#21
	bl	printstring
	
	b	systemhold
//////////////////////////////////////////////////
// loads the two bytes at r0, and r1 into r6 and r7
loadtwobytes:
	push	{lr}
	ldrb	r6,	[r0]
	ldrb	r7,	[r1]
	pop	{pc}
//////////////////////////////////////////////////
// executes the light switch, oh and it prints a message
ledon:

	mov	r1,	#0x00010000	
	ldr	r0,	=0x20200028
	str	r1,	[r0]	

	ldr	r0,	=ledoncmdstring
	mov	r1,	#0
	mov	r8,	#6	
	bl printstring

	b	systemhold

//////////////////////////////////////////////////
// if I have to explian what a function called led off does.... well I do I? I guess that mesage print could be confusing...
ledoff:
	mov	r1,	#0x00010000	
	ldr	r0,	=0x2020001C
	str	r1,	[r0]	

	ldr	r0,	=ledoffcmdstring
	mov	r1,	#0
	mov	r8,	#7
	bl printstring

	b	systemhold

//////////////////////////////////////////////////
// clears the string/buffer, #loljk doesn't work
clearstring:
	push	{lr}
	ldr	r0,	=string
	mov	r1,	#0
	
clearloop:
	str	r1,	[r0]
	add	r0,	#1
	cmp	r0,	#128
	bne	clearloop

	pop	{pc}
//////////////////////////////////////////////////
//	prints strings  address of string in r0, starting offset in r1, NOTE: |string| > offset or else, and length in r8
printstring:		
	push	{lr}

	mov	r5,	#0
	add	r5,	r0,	r8
	add	r0,	r1
printloop:								//load the address of the string to read and set max size
									//gets and then sends the chars to be printed
	bl	loadchar						//only print r8 chars, meaning previous strings dont reappear
									
	bl	echochar

	add	r0,	#1
	cmp	r0,	r5
	bne	printloop
	

	pop	{pc}
//////////////////////////////////////////////////
//loads a char to a reg
loadchar:
	push	{lr}
	ldrb	r3,	[r0]
	pop	{pc}
//////////////////////////////////////////////////
// gets a string an stores it in memory.
getstring:
	push	{lr}
getloop:
	bl	getchar
	bl	storechar
	add	r8,	#1
	bl	echochar

	cmp	r3,	#0x0d
	bne	getloop								// get a char, store it, inc r8 and echo to terminal

	mov	r3,	#0x87
	bl	storechar
	pop	{pc}

/////////////////////////////////////////////
//	gets a char from periferal, stores in r3
getchar:
	push	{lr}

	ldr	r2,	=AUX_MU_LSR_REG				// line status reg

getcharwaitloop:
	ldr	r1,	[r2]
	tst	r1,	#0x1					// test bit 0
	beq	getcharwaitloop					// wait for data

	ldr	r2,	=AUX_MU_IO_REG
	ldrb	r3,	[r2]					// get the (hopefully) char input


	pop	{pc}
//////////////////////////////////////////////////////////////////
//stores the inputed char
storechar:
	push	{lr}

	ldr	r2,	=string
	add	r2,	r8
	strb	r3,	[r2]

	
	pop	{pc}
//////////////////////////////////////////////////////////////////
//prints the byte in r3 to the screen
.global	echochar
echochar:
	push	{r0,	r1,	r2,	r3,	r4,	lr}						// store return address
	ldr	r2,	=AUX_MU_LSR_REG				// line status register

echowaitloop:
	ldr	r1,	[r2]					// load  contence.... contentce.... the stuff in LSR
	tst	r1,	#0x20					// test bit 5 of the LSR
	beq	echowaitloop					// wait until line can accept at least one byte	
								
	ldr	r2,	=AUX_MU_IO_REG				
	str	r3,	[r2]					// print the byte to screen

	pop	{r0,	r1,	r2,	r3,	r4,	pc}
///////////////////////////////////////////////////
printprompt:
	push	{lr}						// adds a newline and a return before printing the arrow
		
	mov	r3,	#0x0a
	bl	echochar

	mov	r3,	#0x0d
	bl	echochar

	mov	r3,	#0x3e
	bl	echochar

	pop	{pc}
//////////////////////////////////////////////////
//debug print
debug:								// just something to help me find all the bugs
	push	{lr}
	push	{r8}
	ldr	r0,	=debugstring
	mov	r1,	#0
	mov	r8,	#4
	bl	printstring
	pop	{r8}
	pop	{lr}
	
	
//////////////////////////////////////////////////
haltLoop$:
	b		haltLoop$

.section .data

gamecmdstring:
	.asciz	"breakout"

ledoncmdstring:
	.asciz	"led on"
ledoncmdstringend:

ledoffcmdstring:
	.asciz	"led off"
ledoffcmdstringend:

echocmdstring:
	.asciz	"echo "
echocmdstringend:

debugstring:
	.asciz	"bug!"

nocmderrorstring:
	.asciz	"that is not a command"

menucmdstring:
	.asciz	"drawMenuScreen"

gamescreencmdstring:
	.asciz	"drawGameScreen"

overcmdstring:
	.asciz	"drawGameOverScreen"

woncmdstring:
	.asciz	"drawGameWonScreen"

left:
	.asciz	"LEFT"
right:
	.asciz	"RIGHT"
ay:
	.asciz	"AYYYYYYYYYYYYYYYYYYYYYYYYYYY"

string:
	.rep	128
	.byte	0
	.endr
stringend:

