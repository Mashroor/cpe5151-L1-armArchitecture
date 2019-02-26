;*********************************************************************
;    Assembly_Exp1 - This file contains "do-nothing" functions
;        that are setup so that they can be called from a C program
;        using the extern keyword in C.  The exported label is the
;        name of the function in C.  The functions save and restore
;        some registers so that they can be used in the function, but
;        not altered in the C program.
;
;        The do-nothing functions are program stubs that the student
;        can use as a starting point for their solution.
;*********************************************************************
;    Code template written by: Roger Younger
;    v1.0 Released: Feb. 9, 2017
;
;	Code written by: Mashroor Rashid
;	Date: Feb. 25, 2019
;*********************************************************************
;    CONSTANT DEFINITIONS
;*********************************************************************
		INCLUDE AT91SAM7SE512.INC

;*********************************************************************
;    VARIABLE DEFINITIONS
;*********************************************************************
         PRESERVE8


		AREA VARIABLES,DATA,READWRITE
			
VARIABLE_1 DCD 0
VARIABLE_2 DCD 0
VARIABLE_3 DCD 0

;***********************************************************
;    AREA DEFINITION AND OPTIONS
;***********************************************************
		PRESERVE8

		AREA EXAMPLE,CODE,READONLY
		ARM

;***********************************************************
;    Function: Parallel I/O initialization
;
;***********************************************************
		EXPORT POWERLED_INIT
			
POWERLED_INIT
        PUSH {R4,R5,R6,R14}
POWERLED EQU 1<<0				; Set Bit 0 to 1 for POWERLED

		LDR R4,=PMC_BASE		; Enabling Peripheral Clock
		MOV R5,#(1<<PIOA_PID)  	; R5 = 0x04
		STR R5,[R4,#PMC_PCER]	; Enables PIOA clock

		LDR R4, =PIOA_BASE		; Reset R4 to be base for PIOA
		MOV R5, #POWERLED		; Set PAO bit 0 to 1, for POWERLED
		STR R5,[R4,#PIO_PER]	; Enable PAO as PIO
		STR R5,[R4,#PIO_OER]	; Enable Output
		STR R5,[R4,#PIO_MDDR]	; Disable Multi-Drive
		STR R5,[R4, #PIO_SODR]	; Set POWERLED to ON

		POP {R4,R5,R6,R14}
		BX R14
;***********************************************************
;    Function: Parallel I/O initialization
;
;***********************************************************
		EXPORT USER_LEDS_INIT
			
USER_LEDS_INIT
        PUSH {R4,R5,R6,R14}
LED1 EQU 1<<1
LED2 EQU 1<<2
USERLED EQU LED1 :OR: LED2		; Set bits 1, 2 to 1 for both LEDs

		LDR R4,=PMC_BASE		; Enabling Peripheral Clock
		MOV R5,#(1<<PIOA_PID)  	; R5 = 0x04
		STR R5,[R4,#PMC_PCER]	; Enables PIOA clock

		LDR R4, =PIOA_BASE		; Reset R4 to be base for PIOA
		MOV R5, #USERLED		; Set bits 2 and 3, for LED1 and LED2
		STR R5,[R4,#PIO_PER]	; Enable PA1 and PA2 as PIO
		STR R5,[R4,#PIO_OER]	; Enable Output
		STR R5,[R4,#PIO_MDDR]	; Disable Multi-Drive
		STR R5, [R4, #PIO_SODR]	; Clear to turn off LED at initialization

		POP {R4,R5,R6,R14}
		BX R14
;***********************************************************
;    Function: Parallel I/O initialization
;
;***********************************************************
		EXPORT SWITCH_INIT
			
SWITCH_INIT
        PUSH {R4,R5,R6,R14}
JOYSTICK_SWITCHES EQU 0x0FC00000; This number signifies the bits between 22 and 27 as 1
		
		LDR R4,=PMC_BASE		; Enabling Peripheral Clock
		MOV R5,#(1<<PIOB_PID)  	; R5 = 0x08
		STR R5,[R4,#PMC_PCER]	; Enables PIOB clock

		LDR R4, =PIOB_BASE			; Reset R4 to be base for PIOB
		MOV R5, #JOYSTICK_SWITCHES	; Set bits 22 to 27, for Joystick and Switches
		STR R5,[R4,#PIO_PER]		; Enable PB22 - PB27 to PIO
		STR R5,[R4,#PIO_ODR]		; Disable Output
		STR R5,[R4,#PIO_PUER]		; Enable Pull up res for PB22-27

		POP {R4,R5,R6,R14}
		BX R14	
;***********************************************************
;    Function: Parallel I/O initialization
;
;***********************************************************
		EXPORT EXT_LEDS_INIT
			
EXT_LEDS_INIT
        PUSH {R4,R5,R6,R14}
EXT_LEDS EQU 0x0FF				; This value signifies the bits 0 to 7 as 1's

		LDR R4,=PMC_BASE		; Enabling Peripheral Clock
		MOV R5,#(1<<PIOC_PID)  	; R5 = 0x10
		STR R5,[R4,#PMC_PCER]	; Enables PIOC clock
		
		LDR R4, =PIOC_BASE		; Reset R4 to Base for PIOC
		MOV R5, #EXT_LEDS		; Set bits 0 to 7, for External LEDs
		STR R5,[R4, #PIO_PER]	; Enable PC0-PC7 to PIO
		STR R5,[R4, #PIO_OER]	; Enable Output

		STR R5,[R4, #PIO_MDDR]	; Disable Multi-Drive
		STR R5,[R4, #PIO_OWER]	; Set up bits 0-7 to be controlled through ODSR
		STR R5,[R4, #PIO_ODSR]	; Turn off all LEDs on initialization

		POP {R4,R5,R6,R14}
		BX R14	
;***********************************************************
;    Function: Delay Function
;
;***********************************************************
		EXPORT DELAY_1MS
			
DELAY_1MS
        PUSH {R4,R5,R6,R14}
LOOP	MOV R4, #0x2F00			; Delay value set from calculations in step 12
REPEAT	SUBS R4, R4, #1			; Number is smaller than expected; 12032, opposed to exactly what was in step 12
		BNE REPEAT
		SUBS R0, R0, #1			; This is the parameter passed in
		BNE LOOP
		POP {R4,R5,R6,R14}
		BX R14	
								; 22)	Delta T = T1 - T0
								;		1.01 sec = 2.07 sec - 1.06 sec
;***********************************************************
;    Function: LED Control
;
;***********************************************************
		EXPORT POWERLED_CONTROL

POWERLED_CONTROL			
        PUSH {R4,R5,R6,R14}
		LDR R4,=PIOA_BASE		; PIOA base address placed in R4
		MOV R5,#POWERLED		; Bit 0 set to 1 for PA0 (power LED)

		TEQ R0, #1				; If Statement, check if passed param is 1
		BNE NOT_1
		STR R5,[R4,#PIO_SODR]	; Set PAO to 1, LED is on
		B END_PWRLED
NOT_1
		STR R5,[R4,#PIO_CODR]	; Clear PA0 to 0, LED is off
END_PWRLED
		POP {R4,R5,R6,R14}
		BX R14
;***********************************************************
;    Function: LED Control
;
;***********************************************************
		EXPORT LED1_CONTROL
			
LED1_CONTROL
        PUSH {R4,R5,R6,R14}
		LDR R4, =PIOA_BASE		; PIOA base address, for storing/loading
		MOV R5, #LED1			; Bit 1, for UserLED1

		TEQ R0, #0				; If statement, check if passed param is set to 0
		BEQ LED1_PARAM_IS_SET	; If 1, send to LED1_NOT_SET
		STR R5,[R4, #PIO_CODR]	; Turn ON LED1
		B END_LED1
LED1_PARAM_IS_SET
		STR R5,[R4, #PIO_SODR]	; Turn OFF LED1
END_LED1

		POP {R4,R5,R6,R14}
		BX R14
;***********************************************************
;    Function: LED Control
;
;***********************************************************
		EXPORT LED2_CONTROL
			
LED2_CONTROL
        PUSH {R4,R5,R6,R14}
		LDR R4, =PIOA_BASE		; PIOA base address, for storing/loading
		MOV R5, #LED2			; Bit 1, for UserLED2

		TEQ R0, #0				; If statement, check if passed param is set to 0
		BEQ LED2_PARAM_IS_SET	; If 1, send to LED2_NOT_SET
		STR R5, [R4, #PIO_CODR]	; Turn ON LED2
		B END_LED2
LED2_PARAM_IS_SET
		STR R5,[R4, #PIO_SODR]	; Turn OFF LED2
END_LED2
		
		POP {R4,R5,R6,R14}
		BX R14	
;*************************************************************
;    Function: Counter Function using switch inputs
;*************************************************************
		EXPORT COUNTER_FUNCTION
			
COUNTER_FUNCTION

LEFTPB EQU 1<<25
RIGHTPB EQU 1<<22
DELAY_WAIT EQU 50
	
        PUSH {R4,R5,R6,R14}
		LDR R4, =PIOB_BASE 	; Read from PDSR
		LDR R5,[R4, #PIO_PDSR]
							; Increment statement
		TST R5, #LEFTPB		; PB25 == 0
		BNE LEFT_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; debounce switch with 50 ms delay
		TST R5, #LEFTPB		; PB25 == 0
		BNE LEFT_NOT_PRESSED_DELAY
		ADD R8, R8, #1		; Increment counter into R8. R8 will serve as my counter 
		MOV R0, R8			; Move counter to passed param
		BL DISPLAY_FUNCTION	; Link to DISPLAY_FUNCTION
LEFT_NOT_PRESSED_DELAY		
LEFT_NOT_PRESSED
							; Decrement statement
		TST R5, #RIGHTPB	; PB22 == 0
		BNE RIGHT_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; Debounce switch with 50 ms delay
		TST R5, #RIGHTPB	; PB22 == 0
		BNE RIGHT_NOT_PRESSED_DELAY
		SUB R8, R8, #1		; Decrement counter into R8 R8 will serve as my counter 
		MOV R0, R8			; Move counter to passed param
		BL DISPLAY_FUNCTION	; Link to DISPLAY_FUNCTION
RIGHT_NOT_PRESSED_DELAY
RIGHT_NOT_PRESSED
		
		POP {R4,R5,R6,R14}
		BX R14
;*************************************************************
;    Function: Display Function using switch inputs
;*************************************************************
		EXPORT DISPLAY_FUNCTION
			
DISPLAY_FUNCTION
        
		PUSH {R4,R5,R6,R14}
		LDR R4, =PIOC_BASE		; Load R4 with Base for PIOC. Then Store R6 value into ODSR of PIOC 
		MVN R5, R0				; Take one's compliment of R8 (counter) 
		STR R5,[R4, #PIO_ODSR]	; Store R5 to ODSR for PIOC
		
		POP {R4,R5,R6,R14}
		BX R14
;*************************************************************
;    Function: Power LED control loop
;*************************************************************
		EXPORT POWER_LED_LOOP
			
POWER_LED_LOOP

        PUSH {R4,R5,R6,R14}
		MOV R0, #1			; Set POWERLED on, branch to PowerLED with new R0
		BL POWERLED
		MOV R0, #500		; Delay for 500, branch to DELAY_1MS with new R0
		BL DELAY_1MS
		MOV R0, #0			; Set POWERLED off, branch to PowerLED with new R0
		BL POWERLED
		MOV R0, #500		; Delay for 500, branch to DELAY_1MS with new R0
		BL DELAY_1MS

		POP {R4,R5,R6,R14}
		BX R14		
;*************************************************************
;    Function: Modify Increment/Decrement Value
;*************************************************************
		EXPORT MOD_INC_DEC_VALUE
			
MOD_INC_DEC_VALUE

UP_JOYSTICK EQU 1<<23
DOWN_JOYSTICK EQU 1<<24
RIGHT_JOYSTICK EQU 1<<26
LEFT_JOYSTICK EQU 1<<27
	
        PUSH {R4,R5,R6,R14}	
		LDR R4, =PIOB_BASE 		; Read from PDSR
		LDR R5,[R4, #PIO_PDSR]
		
		TST R5, #LEFT_JOYSTICK	; PB27 == 0
		BNE LEFT_JOYSTICK_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS
		TST R5, #LEFT_JOYSTICK	; PB27 == 0
		BNE LEFT_JOYSTICK_NOT_PRESSED_DELAY
		BL MOD_INC_VALUE		; Call Modify Inc Value function
LEFT_JOYSTICK_NOT_PRESSED_DELAY
LEFT_JOYSTICK_NOT_PRESSED		
		
		POP {R4,R5,R6,R14}
		BX R14
;*************************************************************
;    Function: Modify Increment Value
;*************************************************************
			
MOD_INC_VALUE

WHILE_LOOP_TRUE EQU 0x01
WHILE_LOOP_FALSE EQU 0x00
	
        PUSH {R4,R5,R6,R14}	
		MOV R0, #1			; Set Param to 1
		BL LED1_CONTROL		; Turn on LED1
		
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; Debounce Delay, to allow user to let go of stick
		
START_DO_LOOP
		
		LDR R4, =PIOB_BASE 	; Read from PDSR
		LDR R5,[R4, #PIO_PDSR]
		
		MOV R11, #WHILE_LOOP_TRUE	; Set while loop condition to true as long as in loop
									; Inc Value increase
		TST R5, #UP_JOYSTICK		; PB23 == 0
		BNE UP_JOYSTICK_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS				; Debounce Delay
		TST R5, #UP_JOYSTICK		; PB23 == 0
		BNE UP_JOYSTICK_NOT_PRESSED_DELAY
		ADD R9, R9, #1				; Increment Inc value
		CMP R9, #16					; If R9 > 16
		BLS LOWER_16
		MOV R9, #16					; Set to 16 of >16
LOWER_16
UP_JOYSTICK_NOT_PRESSED_DELAY
UP_JOYSTICK_NOT_PRESSED

		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; Debounce Delay
									: Inc Value decrease
		TST R5, #DOWN_JOYSTICK		; PB24 == 0
		BNE DOWN_JOYSTICK_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS				; Debounce Delay
		TST R5, #DOWN_JOYSTICK		; PB24 == 0
		BNE DOWN_JOYSTICK_NOT_PRESSED_DELAY
		SUB R9, R9, #1				; Decrement value
		TEQ R9, #0					; If R10 == 0
		BNE EQUALS_0
		MOV R9, #1					; Set to 16 of >16
EQUALS_0
DOWN_JOYSTICK_NOT_PRESSED_DELAY
DOWN_JOYSTICK_NOT_PRESSED

		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; Debounce Delay

		MOV R0, R9					; Move Inc amount to passed param
		BL DISPLAY_FUNCTION			; Link to DISPLAY_FUNCTION
									; Quit inc loop
		TST R5, #LEFT_JOYSTICK		; PB27 == 0
		BNE LEFT_JOYSTICK_NOT_PRESSED_EXIT
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS
		TST R5, #LEFT_JOYSTICK
		BNE LEFT_JOYSTICK_NOT_PRESSED_DELAY_EXIT
		MOV R11, #WHILE_LOOP_FALSE	; Set Exit
LEFT_JOYSTICK_NOT_PRESSED_DELAY_EXIT
LEFT_JOYSTICK_NOT_PRESSED_EXIT

		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; Debounce Delay

		TEQ R11, #WHILE_LOOP_FALSE	; Check condition True/false
		BNE START_DO_LOOP			; Branch to start of Do while
		MOV R10, R9					; R10 will have the final increment value, from R9
		MOV R0, #0					; Set Param to 1
		BL LED1_CONTROL				; Turn on LED1
		
		POP {R4,R5,R6,R14}
		BX R14		
;*************************************************************
;    Function: Modified Counter Function
;*************************************************************
		EXPORT MOD_COUNTER
			
MOD_COUNTER

        PUSH {R4,R5,R6,R14}	
		LDR R4, =PIOB_BASE 	; Read from PDSR
		LDR R5,[R4, #PIO_PDSR]
							; Increment statement
		TST R5, #LEFTPB		; PB25 == 0
		BNE MOD_LEFT_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; Debounce switch with 50 ms delay
		TST R5, #LEFTPB		; PB25 ==0
		BNE MOD_LEFT_NOT_PRESSED_DELAY
		ADD R8, R8, R10		; Increment counter into R8. R10 is the new value for decrement
		MOV R0, R8			; Move counter to passed param
		BL DISPLAY_FUNCTION	; Link to DISPLAY_FUNCTION
MOD_LEFT_NOT_PRESSED_DELAY		
MOD_LEFT_NOT_PRESSED
							; Decrement statement
		TST R5, #RIGHTPB	; PB22 == 0
		BNE MOD_RIGHT_NOT_PRESSED
		MOV R0, #DELAY_WAIT
		BL DELAY_1MS		; debounce switch with 50 ms delay
		TST R5, #RIGHTPB	; PB22 == 0
		BNE MOD_RIGHT_NOT_PRESSED_DELAY
		SUB R8, R8, R10		; Decrement counter into R8. R10 is the new value for decrement 
		MOV R0, R8			; Move counter to passed param
		BL DISPLAY_FUNCTION	; Link to DISPLAY_FUNCTION
MOD_RIGHT_NOT_PRESSED_DELAY
MOD_RIGHT_NOT_PRESSED

		POP {R4,R5,R6,R14}
		BX R14
;*************************************************************
;    Function: Modified Counter Function
;*************************************************************
		EXPORT SET_COUNTERS
			
SET_COUNTERS

        PUSH {R4,R5,R6,R14}
		MOV R10, #1			; Initialize final inc/dec register to 1
		MOV R9, #1			; initialize temp inc/dec register to 1	
		
		POP {R4,R5,R6,R14}
		BX R14	
		
		END