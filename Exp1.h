#ifndef EXAMPLE_ASSEMBLY_H
#define EXAMPLE_ASSEMBLY_H


/*----------------------*/
/* Constant Definitions */
/*----------------------*/



//   Function Prototypes

void POWERLED_INIT(void); 
void USER_LEDS_INIT(void); 
void SWITCH_INIT(void); 
void EXT_LEDS_INIT(void); 
void DELAY_1MS(unsigned int a);
void POWERLED_CONTROL(unsigned int a);
void LED1_CONTROL(unsigned int a);
void LED2_CONTROL(unsigned int a);
void COUNTER_FUNCTION(unsigned int a);
void DISPLAY_FUNCTION(unsigned int a);
void LEFT_JOYSTICK(void); 
void RIGHT_JOYSTICK(void); 
void POWER_LED_LOOP(void); 

#endif


