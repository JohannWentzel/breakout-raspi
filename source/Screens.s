.equ 	WHITE, 	0xFFFF
.equ 	BLACK, 	0x0000
.equ 	YELLOW, 0xFF00
.equ 	GREEN, 	0x0FFF
.equ 	BLUE, 	0x00FF
.equ	RED, 	0xF800

// Drawing the main game screen.
.global GameScreen
	// r7 = color cycle counter (for differently coloured bricks)
	// r5 = counter for number of bricks per row
	// r6 = counter for number of brick rows drawn
	// r8 = storage for original x (to reset draw coordinate)
	// r9 = storage for original y (to reset draw coordinate)

GameScreen:

Bricks:
	push 	{r3, r4, lr}

	ldr 	r0, 	=0
	ldr 	r1, 	=30
	ldr 	r2, 	=1024
	ldr 	r3, 	=WHITE 				// THIS IS THE TOP LINE UNDER THE SCORE
	ldr 	r4, 	=2
	bl 		Rectangle

	ldr 	r0, 	=112
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=BLUE
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=212
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=YELLOW
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=312
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=RED
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=412
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=BLUE
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=512
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=YELLOW
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=612
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=RED
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=712
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=BLUE
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=812
	ldr 	r1, 	=50
	ldr 	r2, 	=90
	ldr 	r3, 	=YELLOW
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=112
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=YELLOW
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=212
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=RED
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=312
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=BLUE
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=412
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=YELLOW
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=512
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=RED
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=612
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=BLUE
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=712
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=YELLOW
	ldr 	r4, 	=25
	bl 		Rectangle

	ldr 	r0, 	=812
	ldr 	r1, 	=85
	ldr 	r2, 	=90
	ldr 	r3, 	=RED
	ldr 	r4, 	=25
	bl 		Rectangle

Paddle:
	ldr 	r0, 	=462
	ldr 	r1, 	=727
	ldr 	r2, 	=100
	ldr 	r3, 	=WHITE
	ldr 	r4, 	=15
	bl 		Rectangle

Ball:

	ldr 	r0, 	=512
	ldr 	r1, 	=716
	ldr 	r2, 	=10
	ldr 	r3, 	=WHITE
	ldr 	r4, 	=10
	bl 		Rectangle
 
Score:
	ldr 	r0, 	=466
	mov 	r1, 	#5
	mov 	r2, 	#15
	ldr 	r3, 	=WHITE
	bl 		VerticalLine

	ldr 	r0, 	=473
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=468
	mov 	r1, 	#5
	ldr 	r2, 	=473
	bl 		HorizontalLine

	ldr 	r0, 	=480
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=475
	mov 	r1, 	#5
	ldr 	r2, 	=480
	bl 		HorizontalLine

	ldr 	r0, 	=487
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=482
	mov 	r1, 	#5
	ldr 	r2, 	=487
	bl 		HorizontalLine




	pop 	{r3, r4, pc}

.global MainMenuScreen
MainMenuScreen:

Title:
	push	{lr}

	ldr 	r0, 	=200
	ldr 	r1, 	=200
	ldr 	r2, 	=280
	ldr 	r3, 	=WHITE
	bl 		VerticalLine

	ldr 	r0,		=200
	ldr 	r1, 	=200
	ldr 	r2, 	=245
	bl 		HorizontalLine

	ldr 	r0, 	=245
	ldr 	r1, 	=200
	ldr 	r2, 	=240
	bl 		VerticalLine

	ldr 	r0, 	=200
	ldr 	r1, 	=240
	ldr 	r2, 	=250
	bl 		HorizontalLine

	ldr 	r0, 	=200
	ldr 	r1, 	=280
	ldr 	r2, 	=250
	bl 		HorizontalLine

	ldr 	r0, 	=250
	ldr 	r1, 	=240
	ldr 	r2,	 	=280
	bl 		VerticalLine

	ldr 	r0, 	=255
	ldr 	r1, 	=200
	ldr 	r2, 	=280
	ldr 	r3, 	=WHITE
	bl 		VerticalLine

	ldr 	r0, 	=255
	ldr 	r1, 	=200
	ldr 	r2, 	=305
	ldr 	r3, 	=WHITE
	bl 		HorizontalLine

	ldr 	r0, 	=255
	ldr 	r1, 	=240
	ldr 	r2, 	=305
	ldr 	r3, 	=WHITE
	bl 		HorizontalLine

	ldr 	r0, 	=305
	ldr 	r1, 	=200
	ldr 	r2, 	=240
	bl 		VerticalLine

	ldr 	r0, 	=300
	ldr 	r1, 	=240
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=315
	ldr 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=325
	ldr 	r1, 	=200
	ldr 	r2, 	=375
	bl 		HorizontalLine

	ldr 	r0, 	=325
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=325
	ldr 	r1, 	=280
	ldr 	r2, 	=375
	bl 		HorizontalLine

	ldr 	r0, 	=385
	ldr 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=385
	ldr 	r1, 	=240
	ldr 	r2, 	=410
	bl 		HorizontalLine

	ldr 	r0, 	=410
	ldr 	r1, 	=220
	ldr 	r2, 	=260
	bl 		VerticalLine

	ldr 	r0, 	=410
	ldr 	r1, 	=220
	ldr 	r2, 	=435
	bl 		HorizontalLine

	ldr 	r0, 	=410
	ldr 	r1, 	=260
	ldr 	r2, 	=435
	bl 		HorizontalLine

	ldr 	r0, 	=435
	ldr 	r1, 	=200
	ldr 	r2, 	=220
	bl 		VerticalLine

	ldr 	r0, 	=435
	ldr 	r1, 	=260
	ldr 	r2, 	=280
	bl 		VerticalLine
	
StartButton:
	ldr 	r0, 	=500
	ldr 	r1, 	=400
	ldr 	r2, 	=530
	bl 		HorizontalLine

	ldr 	r0, 	=500
	ldr 	r1, 	=425
	ldr 	r2, 	=530
	bl 		HorizontalLine

	ldr 	r0, 	=500
	ldr 	r1, 	=450
	ldr 	r2, 	=530
	bl 		HorizontalLine

	ldr 	r0, 	=500
	ldr 	r1, 	=400
	ldr 	r2, 	=425
	bl 		VerticalLine

	ldr 	r0, 	=530
	ldr 	r1, 	=425
	ldr 	r2, 	=450
	bl 		VerticalLine

	ldr 	r0, 	=535
	ldr 	r1, 	=400
	ldr 	r2, 	=565
	bl 		HorizontalLine

	ldr 	r0,		=550
	ldr 	r1, 	=400
	ldr 	r2, 	=450
	bl 		VerticalLine

	ldr 	r0, 	=570
	ldr 	r1, 	=400
	ldr 	r2, 	=450
	bl 		VerticalLine

	ldr 	r0, 	=570
	ldr 	r1, 	=400
	ldr 	r2, 	=600
	bl 		HorizontalLine

	ldr 	r0, 	=600
	ldr 	r1, 	=400
	ldr 	r2, 	=450
	bl 		VerticalLine

	ldr 	r0, 	=570
	ldr 	r1, 	=425
	ldr 	r2, 	=600
	bl 		HorizontalLine

	ldr 	r0, 	=605
	ldr 	r1, 	=400
	ldr 	r2, 	=450
	bl 		VerticalLine

	ldr 	r0, 	=605
	ldr 	r1, 	=400
	ldr 	r2, 	=635
	bl 		HorizontalLine

	ldr 	r0, 	=635
	ldr 	r1, 	=400
	ldr 	r2, 	=425
	bl 		VerticalLine

	ldr 	r0, 	=605
	ldr 	r1, 	=425
	ldr 	r2, 	=635
	bl 		HorizontalLine

	ldr 	r0, 	=630
	ldr 	r1, 	=425
	ldr 	r2, 	=450
	bl 		VerticalLine

	ldr 	r0, 	=640
	ldr 	r1, 	=400
	ldr 	r2, 	=665
	bl 		HorizontalLine

	ldr 	r0,		=650
	ldr 	r1, 	=400
	ldr 	r2, 	=450
	bl 		VerticalLine

QuitButton:

	// Q

	ldr 	r0,		=500
	ldr 	r1, 	=500
	ldr	 	r2, 	=525
	bl 		HorizontalLine

	ldr 	r0, 	=500
	ldr 	r1, 	=550
	ldr 	r2, 	=530
	bl 		HorizontalLine

	ldr 	r0, 	=500
	ldr 	r1, 	=500
	ldr 	r2, 	=550
	bl 		VerticalLine

	ldr 	r0, 	=525
	ldr 	r1, 	=500
	ldr 	r2, 	=550
	bl 		VerticalLine

	// U

	ldr	 	r0, 	=535
	ldr 	r1, 	=500
	ldr 	r2, 	=550
	bl 		VerticalLine

	ldr 	r0, 	=565
	ldr 	r1, 	=500
	ldr 	r2, 	=550
	bl 		VerticalLine

	ldr 	r0, 	=535
	ldr 	r1, 	=550
	ldr 	r2, 	=565
	bl 		HorizontalLine

	// I

	ldr 	r0, 	=575
	ldr 	r1, 	=500
	ldr 	r2,		=550
	bl 		VerticalLine

	// T

	ldr 	r0, 	=585
	ldr 	r1, 	=500
	ldr 	r2, 	=615
	bl 		HorizontalLine

	ldr 	r0,		=600
	ldr 	r1, 	=500
	ldr 	r2, 	=550
	bl 		VerticalLine

	pop 	{pc}

.global GameOverScreen
GameOverScreen:
	push 	{lr}

	ldr 	r3, 	=WHITE
	// G

	ldr 	r0, 	=200
	ldr 	r1, 	=200
	ldr 	r2, 	=250
	bl 		HorizontalLine

	ldr 	r0,		=200
	ldr 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=200
	ldr 	r1, 	=280
	ldr 	r2, 	=250
	bl 		HorizontalLine

	ldr 	r0, 	=250
	ldr 	r1, 	=240
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=225
	ldr 	r1, 	=240
	ldr 	r2, 	=250
	bl 		HorizontalLine

	// A

	ldr 	r0, 	=255
	ldr 	r1, 	=200
	ldr 	r2, 	=305
	bl 		HorizontalLine

	ldr 	r0, 	=255
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=255
	ldr 	r1, 	=240
	ldr 	r2, 	=305
	bl 		HorizontalLine

	ldr 	r0, 	=305
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	// M

	ldr 	r0, 	=310
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=360
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=310
	ldr 	r1, 	=200
	ldr 	r2, 	=360
	bl 		HorizontalLine

	ldr 	r0, 	=335
	ldr	 	r1, 	=200
	ldr 	r2, 	=240
	bl 		VerticalLine

	// E

	ldr 	r0, 	=365
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=365
	ldr 	r1, 	=200
	ldr 	r2, 	=415
	bl 		HorizontalLine

	ldr 	r0, 	=365
	ldr 	r1, 	=240
	ldr 	r2, 	=415
	bl 		HorizontalLine

	ldr 	r0, 	=365
	ldr 	r1, 	=280
	ldr 	r2, 	=415
	bl 		HorizontalLine

	// O

	ldr 	r0, 	=450
	ldr 	r1, 	=200
	ldr 	r2, 	=500
	bl 		HorizontalLine

	ldr 	r0, 	=450
	ldr 	r1, 	=280
	ldr 	r2, 	=500
	bl 		HorizontalLine

	ldr 	r0, 	=450
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=500
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	// V

	ldr 	r0, 	=505
	ldr	 	r1, 	=200
	ldr 	r2, 	=260
	bl 		VerticalLine

	ldr 	r0, 	=555
	ldr	 	r1, 	=200
	ldr 	r2, 	=260
	bl 		VerticalLine

	ldr 	r0, 	=505
	ldr	 	r1, 	=200
	ldr 	r2, 	=260
	bl 		VerticalLine

	ldr 	r0, 	=518
	ldr	 	r1, 	=260
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=542
	ldr	 	r1, 	=260
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=518
	ldr 	r1, 	=280
	ldr 	r2, 	=542
	bl 		HorizontalLine

	ldr 	r0, 	=505
	ldr 	r1, 	=260
	ldr 	r2, 	=518
	bl 		HorizontalLine

	ldr 	r0, 	=542
	ldr 	r1, 	=260
	ldr 	r2, 	=555
	bl 		HorizontalLine

	// E

	ldr 	r0, 	=560
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=560
	ldr 	r1, 	=200
	ldr 	r2, 	=610
	bl 		HorizontalLine

	ldr 	r0, 	=560
	ldr 	r1, 	=240
	ldr 	r2, 	=610
	bl 		HorizontalLine

	ldr 	r0, 	=560
	ldr 	r1, 	=280
	ldr 	r2, 	=610
	bl 		HorizontalLine

	// R

	ldr 	r0, 	=615
	ldr 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=615
	ldr 	r1, 	=200
	ldr 	r2, 	=665
	bl 		HorizontalLine

	ldr 	r0, 	=615
	ldr 	r1, 	=240
	ldr 	r2, 	=665
	bl 		HorizontalLine

	ldr 	r0, 	=665
	ldr 	r1, 	=200
	ldr 	r2, 	=240
	bl 		VerticalLine

	ldr 	r0, 	=660
	ldr 	r1, 	=240
	ldr 	r2, 	=280
	bl 		VerticalLine

	// SCORE

	ldr 	r0, 	=466
	mov 	r1, 	#5
	mov 	r2, 	#15
	ldr 	r3, 	=WHITE
	bl 		VerticalLine

	ldr 	r0, 	=473
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=468
	mov 	r1, 	#5
	ldr 	r2, 	=473
	bl 		HorizontalLine

	ldr 	r0, 	=480
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=475
	mov 	r1, 	#5
	ldr 	r2, 	=480
	bl 		HorizontalLine

	ldr 	r0, 	=487
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=482
	mov 	r1, 	#5
	ldr 	r2, 	=487
	bl 		HorizontalLine

	pop 	{pc}

.global YouWinScreen
YouWinScreen:

	push 	{lr}

	ldr 	r3, 	=WHITE

	// Y

	ldr 	r0, 	=200
	ldr		r1, 	=200
	ldr		r2, 	=240
	bl 		VerticalLine

	ldr 	r0, 	=250
	ldr		r1, 	=200
	ldr		r2, 	=240
	bl 		VerticalLine

	ldr 	r0, 	=225
	ldr		r1, 	=240
	ldr		r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=200
	ldr 	r1, 	=240
	ldr	 	r2, 	=250
	bl 		HorizontalLine

	// O

	ldr 	r0, 	=255
	ldr 	r1, 	=200
	ldr 	r2, 	=305
	bl 		HorizontalLine

	ldr 	r0, 	=255
	ldr 	r1, 	=280
	ldr 	r2, 	=305
	bl 		HorizontalLine

	ldr 	r0, 	=255
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=305
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	// U

	ldr 	r0, 	=310
	ldr 	r1, 	=280
	ldr 	r2, 	=355
	bl 		HorizontalLine

	ldr 	r0, 	=310
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=355
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	// W

	ldr 	r0, 	=400
	ldr 	r1, 	=280
	ldr 	r2, 	=450
	bl 		HorizontalLine

	ldr 	r0, 	=400
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=450
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=425
	ldr	 	r1, 	=240
	ldr 	r2, 	=280
	bl 		VerticalLine

	// I

	ldr 	r0, 	=460
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	// N

	ldr 	r0, 	=470
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=520
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=495
	ldr	 	r1, 	=200
	ldr 	r2, 	=280
	bl 		VerticalLine

	ldr 	r0, 	=470
	ldr	 	r1, 	=200
	ldr 	r2, 	=495
	bl 		HorizontalLine

	ldr 	r0, 	=495
	ldr	 	r1, 	=280
	ldr 	r2, 	=520
	bl 		HorizontalLine

	// !

	ldr 	r0, 	=530
	ldr	 	r1, 	=200
	ldr 	r2, 	=255
	bl 		VerticalLine

	ldr 	r0, 	=530
	ldr	 	r1, 	=270
	ldr 	r2, 	=280
	bl 		VerticalLine

	// SCORE

	ldr 	r0, 	=466
	mov 	r1, 	#5
	mov 	r2, 	#15
	ldr 	r3, 	=WHITE
	bl 		VerticalLine

	ldr 	r0, 	=473
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=468
	mov 	r1, 	#5
	ldr 	r2, 	=473
	bl 		HorizontalLine

	ldr 	r0, 	=480
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=475
	mov 	r1, 	#5
	ldr 	r2, 	=480
	bl 		HorizontalLine

	ldr 	r0, 	=487
	mov 	r1, 	#5
	mov 	r2, 	#15
	bl 		VerticalLine

	ldr 	r0, 	=482
	mov 	r1, 	#5
	ldr 	r2, 	=487
	bl 		HorizontalLine

	pop 	{pc}

.global Clear
Clear:
	// Blacking out the screen to reset.
	push 	{r0-r4, lr}
	
	ldr 	r0, 	=0
	ldr 	r1, 	=0
	ldr		r2, 	=1024
	ldr 	r3, 	=0x0000
	ldr 	r4, 	=768
	bl 		Rectangle

	pop 	{r0-r4, pc}

.global Frame
Frame:

	// Draws the frame of the screen to show the resolution.

	push	{lr}

	ldr 	r3, 	=WHITE

	mov 	r0, 	#0
	mov 	r1, 	#0
	ldr 	r2, 	=767
	bl 		VerticalLine

	ldr 	r0, 	=1023
	mov 	r1, 	#0
	ldr 	r2, 	=767
	bl 		VerticalLine

	mov		r0,		#0
	mov 	r1, 	#0
	ldr 	r2, 	=1023
	bl 		HorizontalLine

	mov 	r0, 	#0
	ldr 	r1, 	=767
	ldr 	r2, 	=1023
	bl 		HorizontalLine

	pop		{pc}
	// White border to define the screen space.

	
	
