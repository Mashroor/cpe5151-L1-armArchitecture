/******************************************************************************
* Experiment1.C                                                    
******************************************************************************
* This program provides a start point to call assembly functions.            
* The functions are defined in the source code as extern for easier editing.               
* Instead, the programmer may wish to use a header file to define the functions.        
* The examples are intended to show how assembly functions are defined and        
* and called as well as how parameters are passed and values returned.  
******************************************************************************/
/*****************************************************************************
* NAME: Mashroor Rashid
*****************************************************************************/
                  
#include <AT91SAM7SE512.H>              /* AT91SAM7SE512 definitions          */
#include "AT91SAM7SE-EK.h"           /* AT91SAM7SE-EK board definitions    */
//#include "Exp1.h"

extern void POWERLED_INIT(void); 
extern void USER_LEDS_INIT(void); 
extern void SWITCH_INIT(void); 
extern void EXT_LEDS_INIT(void); 
extern void DELAY_1MS(unsigned int a);
extern void POWERLED_CONTROL(unsigned int a);
extern void LED1_CONTROL(unsigned int a);
extern void LED2_CONTROL(unsigned int a);
//extern void COUNTER_FUNCTION(unsigned int a);
extern void COUNTER_FUNCTION(void);
extern void DISPLAY_FUNCTION(unsigned int a);
extern void POWER_LED_LOOP(void);
extern void MOD_INC_DEC_VALUE(void);
extern void MOD_COUNTER(void);


 
/*
 * Main Program
 */

int main (void) {
  // Initialization Area

  SWITCH_INIT();
  POWERLED_INIT();
  USER_LEDS_INIT();
	EXT_LEDS_INIT();

  
  for (;;) {
		// Endless Loop
		// POWER_LED_LOOP(); // Commented out for next section fo experiment
		// COUNTER_FUNCTION();
		MOD_INC_DEC_VALUE();
	  // MOD_COUNTER();

   		
  }
}

/*
7)  DIV = 0x05  MUL = 0x0019  MCK = 47.9232 MHz
Calculation: MCK=(18.432*(25+1))/(5*(1/2))

12) executionTime = 1/Freq
    20.866ns = 1/47.9232
    1ms = (4* delay_value)*29.866ns
    Solve for delay_value: 1/(4*20.866e-6) = 11981.2

18) Execution Time at first time at breakpoint: 	 .00481213 sec
		Execution Time at second time at breakpoint:	1.00915015 sec


*/
