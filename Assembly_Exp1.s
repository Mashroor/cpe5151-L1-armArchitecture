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
;    Code written by: Roger Younger
;    v1.0 Released: Feb. 9, 2017
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
		MOV R5,#(1<<PIOA_PID)  	; R5=0x04
		STR R5,[R4,#PMC_PCER]	; Enables PIOA clock

		LDR R4, =PIOA_BASE		; Reset R4 to be base for PIOA
		MOV R5, #POWERLED		; Set PAO bit 0 to 1, for POWERLED
		STR R5,[R4,#PIO_PER]	; Enable PAO as PIO
		STR R5,[R4,#PIO_OER]	; Enable Output
		STR R5,[R4,#PIO_MDDR]	; Disable Multi-Drive

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
		MOV R5,#(1<<PIOA_PID)  	; R5=0x04
		STR R5,[R4,#PMC_PCER]	; Enables PIOA clock

		LDR R4, =PIOA_BASE		; Reset R4 to be base for PIOA
		MOV R5, #USERLED		; Set bits 2 and 3, for LED1 and LED2
		STR R5,[R4,#PIO_PER]	; Enable PA1 and PA2 as PIO
		STR R5,[R4,#PIO_OER]	; Enable Output
		STR R5,[R4,#PIO_MDDR]	; Disable Multi-Drive

		POP {R4,R5,R6,R14}
		BX R14
		
;***********************************************************
;    Function: Parallel I/O initialization
;
;***********************************************************
		EXPORT SWITCH_INIT
			
SWITCH_INIT
        PUSH {R4,R5,R6,R14}
JOYSTICK_SWITCHES EQU 0x0FC00000
		
		LDR R4,=PMC_BASE		; Enabling Peripheral Clock
		MOV R5,#(1<<PIOB_PID)  	; R5=0x08
		STR R5,[R4,#PMC_PCER]	; Enables PIOB clock
		LDR R4, =PIOB_BASE		; Reset R4 to be base for PIOB
		MOV R5, #JOYSTICK_SWITCHES		; Set bits 22 to 27, for Joystick and Switches
		STR R5,[R4,#PIO_PER]	; Enable PB22 - PB27 to PIO
		STR R5,[R4,#PIO_ODR]	; Disable Output
		STR R5,[R4,#PIO_PUER]	; Enable Pull up res for PB22-27

		POP {R4,R5,R6,R14}
		BX R14
		
;***********************************************************
;    Function: Parallel I/O initialization
;
;***********************************************************
		EXPORT EXT_LEDS_INIT
			
EXT_LEDS_INIT
        PUSH {R4,R5,R6,R14}
EXT_LEDS EQU 0x0FF

		LDR R4,=PMC_BASE		; Enabling Peripheral Clock
		MOV R5,#(1<<PIOC_PID)  	; R5=0x10
		STR R5,[R4,#PMC_PCER]	; Enables PIOC clock
		LDR R4, =PIOC_BASE		; Reset R4 to Base for PIOC
		MOVE R5, #EXT_LEDS		; Set bits 0 to 7, for External LEDs
		STR R5, [R4, #PIO_PER]	; Enable PC0-PC7 to PIO
		STR R5, [R4, #PIO_OER]	; Enable Output
		STR R5,[R4, #PIO_MDDR]	; Disable Multi-Drive

		STR R5,[R4,#PIO_OWER]	; Set up bits 0-7 to be controlled through ODSR

		POP {R4,R5,R6,R14}
		BX R14
		
;***********************************************************
;    Function: Delay Function
;
;***********************************************************
		EXPORT DELAY_1MS
			
DELAY_1MS
        PUSH {R4,R5,R6,R14}
LOOP	MOV R4, #0x02ECC		;Delay value set from calculations in step 12)
REPEAT	SUBS R4, R4, #1
		BNE REPEAT
		SUBS R0, R0, #1			;This is the parameter passed in
		BNE LOOP
		POP {R4,R5,R6,R14}
		BX R14	

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

		TST R0, #LED1			; if statement, check if passed param is set to 1
		BEQ LED1_PARAM_IS_SET	; if 1, send to LED1_NOT_SET
		BIC R5, R5, #LED1		; Clears bit, on
		B END_LED1
LED1_PARAM_IS_SET
		ORR R5, R5, #LED1		; Sets LED1 to 1, off
END_LED1
		STR R5,[R4, #PIO_SODR]	; Sets PA1 to a 0 or 1, based on Branching above

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

		TST R0, #LED2			; if statement, check if passed param is set to 1
		BEQ LED2_PARAM2_IS_SET	; if 1, send to LED1_NOT_SET
		BIC R5, R5, #LED1		; Clears bit, on
		B END_LED2
LED2_PARAM_IS_SET
		ORR R5, R5, #LED2		; Sets LED2 to 1, off
END_LED2
		STR R5,[R4, #PIO_SODR]	; Sets PA2 to a 0 or 1, based on Branching above

		POP {R4,R5,R6,R14}
		BX R14
		
;*************************************************************
;    Function: Counter Function using switch inputs
;*************************************************************
		EXPORT COUNTER_FUNCTION
			
COUNTER_FUNCTION

        PUSH {R4,R5,R6,R14}
		NOP     			; REPLACE NOP'S WITH YOUR CODE
		NOP
		POP {R4,R5,R6,R14}
		BX R14



;*************************************************************
;    Function: Display Function using switch inputs
;*************************************************************
		EXPORT DISPLAY_FUNCTION
			
DISPLAY_FUNCTION

        PUSH {R4,R5,R6,R14}
		NOP     			; REPLACE NOP'S WITH YOUR CODE
		NOP
		POP {R4,R5,R6,R14}
		BX R14

;*************************************************************
;    Function: Read Left Joystick
;*************************************************************
		EXPORT LEFT_JOYSTICK
			
LEFT_JOYSTICK

        PUSH {R4,R5,R6,R14}
		NOP     			; REPLACE NOP'S WITH YOUR CODE
		NOP
		POP {R4,R5,R6,R14}
		BX R14
				
;*************************************************************
;    Function: Read Right Joystick
;*************************************************************
		EXPORT RIGHT_JOYSTICK
			
RIGHT_JOYSTICK

        PUSH {R4,R5,R6,R14}
		NOP     			; REPLACE NOP'S WITH YOUR CODE
		NOP
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
;    Function: Modify Increment Value
;*************************************************************
		
			
MOD_INC_VALUE

        PUSH {R4,R5,R6,R14}
		NOP     			; REPLACE NOP'S WITH YOUR CODE
		NOP
		POP {R4,R5,R6,R14}
		BX R14
		
		
;*************************************************************
;    Function: Modify Decrement Value
;*************************************************************
		
			
MOD_DEC_VALUE

        PUSH {R4,R5,R6,R14}
		NOP     			; REPLACE NOP'S WITH YOUR CODE
		NOP
		POP {R4,R5,R6,R14}
		BX R14




		END