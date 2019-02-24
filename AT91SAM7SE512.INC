REGS512			EQU		1

; Standard definitions of Mode bits and Interrupt (I & F) flags in PSRs

Mode_USR        EQU     0x10
Mode_FIQ        EQU     0x11
Mode_IRQ        EQU     0x12
Mode_SVC        EQU     0x13
Mode_ABT        EQU     0x17
Mode_UND        EQU     0x1B
Mode_SYS        EQU     0x1F

I_Bit           EQU     0x80            ; when I bit is set, IRQ is disabled
F_Bit           EQU     0x40            ; when F bit is set, FIQ is disabled

; Internal Memory Base Addresses
FLASH_BASE      EQU     0x00100000   
RAM_BASE        EQU     0x00200000









; Embedded Flash Controller (EFC) definitions
EFC_BASE        EQU     0xFFFFFF00      ; EFC Base Address
EFC0_FMR        EQU     0x60            ; EFC0_FMR Offset
EFC1_FMR        EQU     0x70            ; EFC1_FMR Offset

;// <e> Embedded Flash Controller 0 (EFC0)
;//   <o1.16..23> FMCN: Flash Microsecond Cycle Number <0-255>
;//               <i> Number of Master Clock Cycles in 1us
;//   <o1.8..9>   FWS: Flash Wait State
;//               <0=> Read: 1 cycle / Write: 2 cycles
;//               <1=> Read: 2 cycle / Write: 3 cycles
;//               <2=> Read: 3 cycle / Write: 4 cycles
;//               <3=> Read: 4 cycle / Write: 4 cycles
;// </e>
EFC0_SETUP      EQU     1
EFC0_FMR_Val    EQU     0x00320100

;// <e> Embedded Flash Controller 1 (EFC1)
;//   <o1.16..23> FMCN: Flash Microsecond Cycle Number <0-255>
;//               <i> Number of Master Clock Cycles in 1us
;//   <o1.8..9>   FWS: Flash Wait State
;//               <0=> Read: 1 cycle / Write: 2 cycles
;//               <1=> Read: 2 cycle / Write: 3 cycles
;//               <2=> Read: 3 cycle / Write: 4 cycles
;//               <3=> Read: 4 cycle / Write: 4 cycles
;// </e>
EFC1_SETUP      EQU     0
EFC1_FMR_Val    EQU     0x00320100






; PID Number Definitions (shifted '1')
PIOA_PID_BIT		EQU		1<<2
PIOB_PID_BIT		EQU		1<<3
PIOC_PID_BIT		EQU		1<<4
SPI_PID_BIT			EQU		1<<5
USART0_PID_BIT		EQU		1<<6
USART1_PID_BIT		EQU		1<<7
SSC_PID_BIT			EQU		1<<8
TWI_PID_BIT			EQU		1<<9
PWMC_PID_BIT		EQU		1<<10
UDP_PID_BIT			EQU		1<<11
TC0_PID_BIT			EQU		1<<12
TC1_PID_BIT			EQU		1<<13
TC2_PID_BIT			EQU		1<<14
ADC_PID_BIT			EQU		1<<15

; PID Number Definitions
PIOA_PID			EQU		2
PIOB_PID			EQU		3
PIOC_PID			EQU		4
SPI_PID				EQU		5
USART0_PID			EQU		6
USART1_PID			EQU		7
SSC_PID				EQU		8
TWI_PID				EQU		9
PWMC_PID			EQU		10
UDP_PID				EQU		11
TC0_PID				EQU		12
TC1_PID				EQU		13
TC2_PID				EQU		14
ADC_PID				EQU		15


; Power Mangement Controller (PMC) definitions
PMC_BASE        EQU     0xFFFFFC00      ; PMC Base Address
PMC_MOR         EQU     0x20            ; PMC_MOR Offset
PMC_MCFR        EQU     0x24            ; PMC_MCFR Offset
PMC_PLLR        EQU     0x2C            ; PMC_PLLR Offset
PMC_MCKR        EQU     0x30            ; PMC_MCKR Offset
PMC_SR          EQU     0x68            ; PMC_SR Offset
PMC_MOSCEN      EQU     (1<<0)          ; Main Oscillator Enable
PMC_OSCBYPASS   EQU     (1<<1)          ; Main Oscillator Bypass
PMC_OSCOUNT     EQU     (0xFF<<8)       ; Main OScillator Start-up Time
PMC_DIV         EQU     (0xFF<<0)       ; PLL Divider
PMC_PLLCOUNT    EQU     (0x3F<<8)       ; PLL Lock Counter
PMC_OUT         EQU     (0x03<<14)      ; PLL Clock Frequency Range
PMC_MUL         EQU     (0x7FF<<16)     ; PLL Multiplier
PMC_USBDIV      EQU     (0x03<<28)      ; USB Clock Divider
PMC_CSS         EQU     (3<<0)          ; Clock Source Selection
PMC_PRES        EQU     (7<<2)          ; Prescaler Selection
PMC_MOSCS       EQU     (1<<0)          ; Main Oscillator Stable
PMC_LOCK        EQU     (1<<2)          ; PLL Lock Status
PMC_MCKRDY      EQU     (1<<3)          ; Master Clock Status
PMC_SCER		EQU		0x0000
PMC_SCDR		EQU		0x0004
PMC_SCSR		EQU		0x0008
PMC_PCER		EQU		0x0010
PMC_PCDR		EQU		0x0014
PMC_PCSR		EQU		0x0018
PMC_PCK0		EQU		0x0040
PMC_PCK1		EQU		0x0044
PMC_PCK2		EQU		0x0048
PMC_IER			EQU		0x0060
PMC_IDR			EQU		0x0064
PMC_IMR			EQU		0x006C

;// <e> Power Mangement Controller (PMC)
;//   <h> Main Oscillator
;//     <o1.0>      MOSCEN: Main Oscillator Enable
;//     <o1.1>      OSCBYPASS: Oscillator Bypass
;//     <o1.8..15>  OSCCOUNT: Main Oscillator Startup Time <0-255>
;//   </h>
;//   <h> Phase Locked Loop (PLL)
;//     <o2.0..7>   DIV: PLL Divider <0-255>
;//     <o2.16..26> MUL: PLL Multiplier <0-2047>
;//                 <i> PLL Output is multiplied by MUL+1
;//     <o2.14..15> OUT: PLL Clock Frequency Range
;//                 <0=> 80..160MHz  <1=> Reserved
;//                 <2=> 150..220MHz <3=> Reserved
;//     <o2.8..13>  PLLCOUNT: PLL Lock Counter <0-63>
;//     <o2.28..29> USBDIV: USB Clock Divider
;//                 <0=> None  <1=> 2  <2=> 4  <3=> Reserved
;//   </h>
;//   <o3.0..1>   CSS: Clock Source Selection
;//               <0=> Slow Clock
;//               <1=> Main Clock
;//               <2=> Reserved
;//               <3=> PLL Clock
;//   <o3.2..4>   PRES: Prescaler
;//               <0=> None
;//               <1=> Clock / 2    <2=> Clock / 4
;//               <3=> Clock / 8    <4=> Clock / 16
;//               <5=> Clock / 32   <6=> Clock / 64
;//               <7=> Reserved
;// </e>
PMC_SETUP       EQU     1
PMC_MOR_Val     EQU     0x00000601
PMC_PLLR_Val    EQU     0x00491C0E
PMC_MCKR_Val    EQU     0x00000007

;Universal Synchronous Asynchronous Receiver Transmitter (USART)

USART0_BASE		EQU		0xFFFC0000
USART1_BASE		EQU		0xFFFC4000
US_CR			EQU		0x0000
US_MR			EQU		0x0004
US_IER			EQU		0x0008
US_IDR			EQU		0x000C
US_IMR			EQU		0x0010
US_CSR			EQU		0x0014
US_RHR			EQU		0x0018
US_THR			EQU		0x001C
US_BRGR			EQU		0x0020
US_RTOR			EQU		0x0024
US_TTGR			EQU		0x0028
US_FIDI			EQU		0x0040
US_NER			EQU		0x0044
US_IF			EQU		0x004C


;Advanced Interrupt Control (AIC)

AIC_BASE		EQU		0xFFFFF000
; SOURCE MODE REGISTERS (SOURCE# * 4)
AIC_SMR1		EQU		0x0004
AIC_SMR6		EQU		0x0018
AIC_SMR15		EQU		0x003C
; SOURCE VECTOR REGISTERS ((SOURCE# * 4) + 0x80)
AIC_SVR1		EQU		0x0084
AIC_SVR6		EQU		0x0098
AIC_SVR15		EQU		0x00BC
AIC_IVR			EQU 	0x0100
AIC_FVR			EQU		0x0104
AIC_ISR			EQU		0x0108
AIC_IPR			EQU		0x010C
AIC_IMR			EQU		0x0110
AIC_CISR		EQU		0x0114
AIC_IECR		EQU		0x0120
AIC_IDCR		EQU		0x0124
AIC_ICCR		EQU		0x0128
AIC_ISCR		EQU		0x012C
AIC_EOICR		EQU		0x0130
AIC_SPU			EQU		0x0134
AIC_DCR			EQU		0x0138
AIC_FFER		EQU		0x0140
AIC_FFDR		EQU		0x0144
AIC_FFSR		EQU		0x0148


; Parallel Input Output Controller
PIOA_BASE		EQU		0xFFFFF400
PIOB_BASE		EQU		0xFFFFF600
PIOC_BASE		EQU		0xFFFFF800
PIO_PER			EQU		0x0000
PIO_PDR			EQU		0x0004
PIO_PSR			EQU		0x0008
PIO_OER			EQU		0x0010
PIO_ODR			EQU		0x0014
PIO_OSR			EQU		0x0018
PIO_IFER		EQU		0x0020
PIO_IFDR		EQU		0x0024
PIO_IFSR		EQU		0x0028
PIO_SODR		EQU		0x0030
PIO_CODR		EQU		0x0034
PIO_ODSR		EQU		0x0038
PIO_PDSR		EQU		0x003C
PIO_IER			EQU		0x0040
PIO_IDR			EQU		0x0044
PIO_IMR			EQU		0x0048
PIO_ISR			EQU		0x004C
PIO_MDER		EQU		0x0050
PIO_MDDR		EQU		0x0054
PIO_MDSR		EQU		0x0058
PIO_PUDR		EQU		0x0060
PIO_PUER		EQU		0x0064
PIO_PUSR		EQU		0x0068
PIO_ASR			EQU		0x0070
PIO_BSR			EQU		0x0074
PIO_ABSR		EQU		0x0078
PIO_OWER		EQU		0x00A0
PIO_OWDR		EQU		0x00A4
PIO_OWSR		EQU		0x00A8

; Analog to Digital Converter (ADC)
ADC_BASE		EQU		0xFFFD8000
ADC_CR			EQU		0x0000
ADC_MR			EQU		0x0004
ADC_CHER		EQU		0x0010
ADC_CHDR		EQU		0x0014
ADC_CHSR		EQU		0x0018
ADC_SR			EQU		0x001C
ADC_LCDR		EQU		0x0020
ADC_IER			EQU		0x0024
ADC_IDR			EQU		0x0028
ADC_IMR			EQU		0x002C
ADC_CDR0		EQU		0x0030
ADC_CDR1		EQU		0x0034
ADC_CDR2		EQU		0x0038
ADC_CDR3		EQU		0x003C
ADC_CDR4		EQU		0x0040
ADC_CDR5		EQU		0x0044
ADC_CDR6		EQU		0x0048
ADC_CDR7		EQU		0x004C


;  Pulse Width Modulator (PWM)
PWM_BASE		EQU		0xFFFCC000
PWM_MR			EQU		0x0000
PWM_ENA			EQU		0x0004
PWM_DIS			EQU		0x0008
PWM_SR			EQU		0x000C
PWM_IER			EQU		0x0010
PWM_IDR			EQU		0x0014
PWM_IMR			EQU		0x0018
PWM_ISR			EQU		0x001C
PWM_CMR0		EQU		0x0200
PWM_CDTY0		EQU		0x0204
PWM_CPRD0		EQU		0x0208
PWM_CCNT0		EQU		0x020C
PWM_CUPD0		EQU		0x0210
PWM_CMR1		EQU		0x0220
PWM_CDTY1		EQU		0x0224
PWM_CPRD1		EQU		0x0228
PWM_CCNT1		EQU		0x022C
PWM_CUPD1		EQU		0x0230
PWM_CMR2		EQU		0x0240
PWM_CDTY2		EQU		0x0244
PWM_CPRD2		EQU		0x0248
PWM_CCNT2		EQU		0x024C
PWM_CUPD2		EQU		0x0250
PWM_CMR3		EQU		0x0260
PWM_CDTY3		EQU		0x0264
PWM_CPRD3		EQU		0x0268
PWM_CCNT3		EQU		0x026C
PWM_CUPD3		EQU		0x0270


; Timer/Counter (TC)
TC_BASE			EQU		0xFFFA0000
TC0_BASE		EQU 	0xFFFA0000
TC1_BASE		EQU		0xFFFA0040
TC2_BASE		EQU		0xFFFA0080
TC_BCR			EQU		0xC0
TC_BMR			EQU		0xC4
; Timer/Counter Channel Registers
TC_CCR			EQU		0x00
TC_CMR			EQU		0x04
TC_CV			EQU		0x10
TC_RA			EQU		0x14
TC_RB			EQU		0x18
TC_RC			EQU		0x1C
TC_SR			EQU		0x20
TC_IER			EQU		0x24
TC_IDR			EQU		0x28
TC_IMR			EQU		0x2C


; Real-Time Timer

RTT_BASE		EQU		0xFFFFFD20
RTT_MR			EQU		0x00
RTT_AR			EQU		0x04
RTT_VR 			EQU		0x08
RTT_SR			EQU		0x0C
	
; Periodic Interval Timer

PITC_BASE		EQU		0xFFFFFD30
PITC_MR			EQU		0x00
PITC_SR			EQU		0x04
PITC_PIVR		EQU		0x08
PITC_PIIR		EQU		0x0C
	
; Serial Peripheral Interface (SPI)
SPI_BASE		EQU		0xFFFE0000
SPI_CR			EQU		0x00
SPI_MR			EQU		0x04
SPI_RDR			EQU		0x08
SPI_TDR			EQU		0x0C
SPI_SR			EQU		0X10
SPI_IER			EQU		0x14
SPI_IDR			EQU		0x18
SPI_IMR			EQU		0x1C
SPI_CSR0		EQU		0x30
SPI_CSR1		EQU		0x34
SPI_CSR2		EQU		0x38
SPI_CSR3		EQU		0x3C

; Synchronous Serial Controller (SSC)
SSC_BASE		EQU		0xFFFD4000
SSC_CR			EQU		0x00
SSC_CMR			EQU		0x04
SSC_RCMR		EQU		0x10
SSC_RFMR		EQU		0x14
SSC_TCMR		EQU		0x18
SSC_TFMR		EQU		0x1C
SSC_RHR			EQU		0x20
SSC_THR			EQU		0x24
SSC_RSHR		EQU		0x30
SSC_TSHR		EQU		0x34
SSC_RC0R		EQU		0x38
SSC_RC1R		EQU		0x3C
SSC_SR			EQU		0x40
SSC_IER			EQU		0x44
SSC_IDR			EQU		0x48
SSC_IMR			EQU		0x4C

; Two Wire Interface (TWI)
TWI_BASE		EQU		0xFFFB8000
TWI_CR			EQU		0x00
TWI_MMR			EQU		0x04
TWI_SMR		    EQU		0x08
TWI_IADR		EQU		0x0C
TWI_CWGR		EQU		0x10
TWI_SR			EQU		0x20
TWI_IER			EQU		0x24
TWI_IDR			EQU		0x28
TWI_IMR			EQU		0x2C
TWI_RHR         EQU     0x30
TWI_THR			EQU		0x34
	
; Peripheral DMA Controller
USART0_PDMA_BASE	EQU	0xFFFC0100
USART1_PDMA_BASE	EQU	0xFFFC4100
SPI_PDMA_BASE		EQU	0xFFFE0100
SSC_PDMA_BASE		EQU	0xFFFD4100
ADC_PDMA_BASE		EQU	0xFFFD8100
PDC_RPR         EQU 	0x00000000
PDC_RCR         EQU 	0x00000004
PDC_TPR         EQU 	0x00000008
PDC_TCR         EQU 	0x0000000C
PDC_RNPR        EQU 	0x00000010
PDC_RNCR        EQU 	0x00000014
PDC_TNPR        EQU 	0x00000018
PDC_TNCR        EQU 	0x0000001C
PDC_PTCR        EQU 	0x00000020
PDC_PTSR        EQU 	0x00000024
	
; Clock Generator Contoller
CKGR_BASE		 EQU	0xFFFFFC20	
CKGR_MOR         EQU	0x00000000
CKGR_MCFR        EQU	0x00000004
CKGR_PLLR        EQU	0x0000000C
	
; Reset Controller
RSTC_BASE		EQU		0xFFFFFD00
RSTC_CR        	EQU 	0x00000000    	;(RSTC_RCR) Reset Control Register
RSTC_SR        	EQU 	0x00000004		;(RSTC_RSR) Reset Status Register
RSTC_MR        	EQU 	0x00000008		;(RSTC_RMR) Reset Mode Register
	
	
; Watch Dog Timer
WDT_BASE		EQU		0xFFFFFD40
WDT_CR       	EQU 	0x00000000		;(WDTC_WDCR) Watchdog Control Register
WDT_MR       	EQU 	0x00000004		;(WDTC_WDMR) Watchdog Mode Register
WDT_SR       	EQU 	0x00000008		;(WDTC_WDSR) Watchdog Status Register
	
; USB Controller Interface
UDP_BASE		EQU		0xFFFB0000
UDP_FRM_NUM     EQU 	0x00000000		;(UDP_FRM_NUM) Frame Number Register
UDP_GLBSTATE    EQU		0x00000004		;(UDP_GLBSTATE) Global State Register
UDP_FADDR       EQU 	0x00000008		;(UDP_FADDR) Function Address Register
UDP_IER         EQU 	0x00000010		;(UDP_IER) Interrupt Enable Register
UDP_IDR         EQU 	0x00000014		;(UDP_IDR) Interrupt Disable Register
UDP_IMR         EQU 	0x00000018		;(UDP_IMR) Interrupt Mask Register
UDP_ISR         EQU 	0x0000001C		;(UDP_ISR) Interrupt Status Register
UDP_ICR         EQU 	0x00000020		;(UDP_ICR) Interrupt Clear Register
UDP_RSTEP       EQU 	0x00000028		;(UDP_RSTEP) Reset Endpoint Register
UDP_CSR0        EQU 	0x00000030		;(UDP_CSR) Endpoint Control and Status Register 0
UDP_CSR1        EQU 	0x00000034		;(UDP_CSR) Endpoint Control and Status Register 1
UDP_CSR2        EQU 	0x00000038		;(UDP_CSR) Endpoint Control and Status Register 2
UDP_CSR3        EQU 	0x0000003C		;(UDP_CSR) Endpoint Control and Status Register 3
UDP_CSR4        EQU 	0x00000040		;(UDP_CSR) Endpoint Control and Status Register 4
UDP_CSR5        EQU 	0x00000044		;(UDP_CSR) Endpoint Control and Status Register 5
UDP_CSR6        EQU 	0x00000048		;(UDP_CSR) Endpoint Control and Status Register 6
UDP_CSR7        EQU 	0x0000004C		;(UDP_CSR) Endpoint Control and Status Register 7
UDP_FDR0        EQU 	0x00000050		;(UDP_FDR) Endpoint FIFO Data Register 0
UDP_FDR1        EQU 	0x00000054		;(UDP_FDR) Endpoint FIFO Data Register 1
UDP_FDR2        EQU 	0x00000058		;(UDP_FDR) Endpoint FIFO Data Register 2
UDP_FDR3        EQU 	0x0000005C		;(UDP_FDR) Endpoint FIFO Data Register 3
UDP_FDR4        EQU 	0x00000060		;(UDP_FDR) Endpoint FIFO Data Register 4
UDP_FDR5        EQU 	0x00000064		;(UDP_FDR) Endpoint FIFO Data Register 5
UDP_FDR6        EQU 	0x00000068		;(UDP_FDR) Endpoint FIFO Data Register 6
UDP_FDR7        EQU 	0x0000006C		;(UDP_FDR) Endpoint FIFO Data Register 7
UDP_TXVC        EQU 	0x00000074		;(UDP_TXVC) Transceiver Control Register
	
; External Bus interface
EBI_BASE       	EQU 	0xFFFFFF80		;(EBI) Base Address
EBI_CSA         EQU 	0x00000000		;(EBI_CSA) EBI Chip Select Assignment Register
	
SMC_BASE       	EQU 	0xFFFFFF90		;(SMC) Base Address	
SMC_CSR0       	EQU 	0x00000000		;(SMC_CSR0) SMC Chip Select Register 0
SMC_CSR1       	EQU 	0x00000004		;(SMC_CSR1) SMC Chip Select Register 1
SMC_CSR2       	EQU 	0x00000008		;(SMC_CSR2) SMC Chip Select Register 2
SMC_CSR3       	EQU 	0x0000000C		;(SMC_CSR3) SMC Chip Select Register 3
SMC_CSR4       	EQU 	0x00000010		;(SMC_CSR4) SMC Chip Select Register 4
SMC_CSR5       	EQU 	0x00000014		;(SMC_CSR5) SMC Chip Select Register 5
SMC_CSR6       	EQU 	0x00000018		;(SMC_CSR6) SMC Chip Select Register 6
SMC_CSR7       	EQU 	0x0000001C		;(SMC_CSR7) SMC Chip Select Register 7
	
SDRC_BASE      	EQU 	0xFFFFFFB0		;(SDRC) Base Address	
SDRC_MR         EQU 	0x00000000		;(SDRC_MR) SDRAM Controller Mode Register
SDRC_TR         EQU 	0x00000004		;(SDRC_TR) SDRAM Controller Refresh Timer Register
SDRC_CR         EQU 	0x00000008		;(SDRC_CR) SDRAM Controller Configuration Register
SDRC_SRR        EQU 	0x0000000C		;(SDRC_SRR) SDRAM Controller Self Refresh Register
SDRC_LPR        EQU 	0x00000010		;(SDRC_LPR) SDRAM Controller Low Power Register
SDRC_IER        EQU 	0x00000014		;(SDRC_IER) SDRAM Controller Interrupt Enable Register
SDRC_IDR        EQU 	0x00000018		;(SDRC_IDR) SDRAM Controller Interrupt Disable Register
SDRC_IMR        EQU 	0x0000001C		;(SDRC_IMR) SDRAM Controller Interrupt Mask Register
SDRC_ISR        EQU 	0x00000020		;(SDRC_ISR) SDRAM Controller Interrupt Mask Register
;IPB_VER         EQU 	0x00000024		;(IPB_VER) SDRAM Controller Version Register
	
ECC_BASE      	EQU 	0xFFFFFFDC		;(HECC) Base Address
ECC_CR          EQU 	0x00000000		;(ECC_CR)  ECC reset register
ECC_MR          EQU 	0x00000004		;(ECC_MR)  ECC Page size register
ECC_SR          EQU 	0x00000008		;(ECC_SR)  ECC Status register
ECC_PR          EQU 	0x0000000C		;(ECC_PR)  ECC Parity register
ECC_NPR         EQU 	0x00000010		;(ECC_NPR)  ECC Parity N register
;ECC_VR          EQU 	0x00000014		;(ECC_VR)  ECC Version register
	
				END