
;CodeVisionAVR C Compiler V3.24 Evaluation
;(C) Copyright 1998-2015 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_0x0:
	.DB  0x57,0x45,0x4C,0x43,0x4F,0x4D,0x45,0x20
	.DB  0x54,0x4F,0x0,0x45,0x4D,0x52,0x20,0x43
	.DB  0x4C,0x55,0x42,0x0,0x49,0x6E,0x76,0x61
	.DB  0x6C,0x69,0x64,0x20,0x49,0x6E,0x70,0x75
	.DB  0x74,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0B
	.DW  _0x8B
	.DW  _0x0*2

	.DW  0x09
	.DW  _0x8B+11
	.DW  _0x0*2+11

	.DW  0x0E
	.DW  _0x95
	.DW  _0x0*2+20

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;This program was created by the CodeWizardAVR V3.24
;Automatic Program Generator
;© Copyright 1998-2015 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : To design a calulator using a microcontroller, lcd and keypad.
;Version :
;Date    : 02-09-2017
;Author  : Damodar Mahto
;Company : NIT Kurukshetra
;Comments:
;************************ Header files and Macros *******************************/
;
;#include <io.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <mega8.h>
;#include <math.h>
;#define F_XTAL 12000000L
;
;#define E PORTC.0           //enable pin of LCD
;#define RS PORTC.1          //Register Select pin of LCD
;
;#define RowA PORTD.0        //to send the data to keypad
;#define RowB PORTD.1
;#define RowC PORTD.2
;#define RowD PORTD.3
;
;#define Col1 PIND.4        //to receive the data from keypad
;#define Col2 PIND.5
;#define Col3 PIND.6
;#define Col4 PIND.7
;/**************************** Global variables *****************************/
;
;
;/**************************** LCD functions *****************************/
;
;void lcd_cmd(char a)
; 0000 0027 {

	.CSEG
_lcd_cmd:
; .FSTART _lcd_cmd
; 0000 0028     E=1;
	ST   -Y,R17
	MOV  R17,R26
;	a -> R17
	SBI  0x15,0
; 0000 0029     RS=0;
	CBI  0x15,1
; 0000 002A     PORTB=a;
	RCALL SUBOPT_0x0
; 0000 002B     delay_ms(5);
; 0000 002C     E=0;
; 0000 002D     delay_ms(5);
; 0000 002E }
	RJMP _0x2080001
; .FEND
;
;void lcd_data(char b)
; 0000 0031 {
_lcd_data:
; .FSTART _lcd_data
; 0000 0032     E=1;
	RCALL SUBOPT_0x1
;	b -> R17
	SBI  0x15,0
; 0000 0033     RS=1;
	SBI  0x15,1
; 0000 0034     PORTB =b;
	RCALL SUBOPT_0x0
; 0000 0035     delay_ms(5);
; 0000 0036     E=0;
; 0000 0037     delay_ms(5);
; 0000 0038 }
	RJMP _0x2080001
; .FEND
;
;void print_string(char *str)
; 0000 003B {
_print_string:
; .FSTART _print_string
; 0000 003C      while(*str!='\0')
	RCALL __SAVELOCR2
	MOVW R16,R26
;	*str -> R16,R17
_0xF:
	MOVW R26,R16
	LD   R30,X
	CPI  R30,0
	BREQ _0x11
; 0000 003D      {
; 0000 003E       lcd_data(*str);
	LD   R26,X
	RCALL _lcd_data
; 0000 003F       str++;
	__ADDWRN 16,17,1
; 0000 0040      }
	RJMP _0xF
_0x11:
; 0000 0041 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;void init_LCD()
; 0000 0044 {
_init_LCD:
; .FSTART _init_LCD
; 0000 0045 
; 0000 0046   lcd_cmd(0x38);        //LCD initialization
	LDI  R26,LOW(56)
	RCALL _lcd_cmd
; 0000 0047   lcd_cmd(0x0c);        //display on cursor off
	LDI  R26,LOW(12)
	RCALL _lcd_cmd
; 0000 0048   lcd_cmd(0x01);        //clear display screen
	RCALL SUBOPT_0x2
; 0000 0049   lcd_cmd(0x06);        //shift
	LDI  R26,LOW(6)
	RCALL _lcd_cmd
; 0000 004A   lcd_cmd(0x02);        //return to home
	LDI  R26,LOW(2)
	RCALL _lcd_cmd
; 0000 004B }
	RET
; .FEND
;
;void port_init()
; 0000 004E {
_port_init:
; .FSTART _port_init
; 0000 004F     DDRB=0xFF;    //LCD
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 0050     DDRC=0XFF;    //LCD
	OUT  0x14,R30
; 0000 0051     DDRD=0x0F;    //Keypad ( upper nibble-in, lower nibble-out )
	LDI  R30,LOW(15)
	OUT  0x11,R30
; 0000 0052 }
	RET
; .FEND
;
;/**************************** Keypad functions *****************************/
;
;char READ_SWITCHES(void)
; 0000 0057 {
_READ_SWITCHES:
; .FSTART _READ_SWITCHES
; 0000 0058     RowA = 1; RowB = 0; RowC = 0; RowD = 0;     //Test Row A
	SBI  0x12,0
	CBI  0x12,1
	CBI  0x12,2
	CBI  0x12,3
; 0000 0059     if (Col1 == 1) { delay_ms(10); while (Col1==1); return '7'; }
	SBIS 0x10,4
	RJMP _0x1A
	RCALL SUBOPT_0x3
_0x1B:
	SBIC 0x10,4
	RJMP _0x1B
	LDI  R30,LOW(55)
	RET
; 0000 005A     if (Col2 == 1) { delay_ms(10); while (Col2==1); return '8'; }
_0x1A:
	SBIS 0x10,5
	RJMP _0x1E
	RCALL SUBOPT_0x3
_0x1F:
	SBIC 0x10,5
	RJMP _0x1F
	LDI  R30,LOW(56)
	RET
; 0000 005B     if (Col3 == 1) { delay_ms(10); while (Col3==1); return '9'; }
_0x1E:
	SBIS 0x10,6
	RJMP _0x22
	RCALL SUBOPT_0x3
_0x23:
	SBIC 0x10,6
	RJMP _0x23
	LDI  R30,LOW(57)
	RET
; 0000 005C     if (Col4 == 1) { delay_ms(10); while (Col4==1); return '/'; }
_0x22:
	SBIS 0x10,7
	RJMP _0x26
	RCALL SUBOPT_0x3
_0x27:
	SBIC 0x10,7
	RJMP _0x27
	LDI  R30,LOW(47)
	RET
; 0000 005D 
; 0000 005E     RowA = 0; RowB = 1; RowC = 0; RowD = 0;     //Test Row B
_0x26:
	CBI  0x12,0
	SBI  0x12,1
	CBI  0x12,2
	CBI  0x12,3
; 0000 005F     if (Col1==1) { delay_ms(10); while (Col1==1); return '4'; }
	SBIS 0x10,4
	RJMP _0x32
	RCALL SUBOPT_0x3
_0x33:
	SBIC 0x10,4
	RJMP _0x33
	LDI  R30,LOW(52)
	RET
; 0000 0060     if (Col2==1) { delay_ms(10); while (Col2==1); return '5'; }
_0x32:
	SBIS 0x10,5
	RJMP _0x36
	RCALL SUBOPT_0x3
_0x37:
	SBIC 0x10,5
	RJMP _0x37
	LDI  R30,LOW(53)
	RET
; 0000 0061     if (Col3==1) { delay_ms(10); while (Col3==1); return '6'; }
_0x36:
	SBIS 0x10,6
	RJMP _0x3A
	RCALL SUBOPT_0x3
_0x3B:
	SBIC 0x10,6
	RJMP _0x3B
	LDI  R30,LOW(54)
	RET
; 0000 0062     if (Col4==1) { delay_ms(10); while (Col4==1); return '*'; }
_0x3A:
	SBIS 0x10,7
	RJMP _0x3E
	RCALL SUBOPT_0x3
_0x3F:
	SBIC 0x10,7
	RJMP _0x3F
	LDI  R30,LOW(42)
	RET
; 0000 0063 
; 0000 0064     RowA = 0; RowB = 0; RowC = 1; RowD = 0;     //Test Row C
_0x3E:
	CBI  0x12,0
	CBI  0x12,1
	SBI  0x12,2
	CBI  0x12,3
; 0000 0065     if (Col1==1) { delay_ms(10); while (Col1==1); return '1'; }
	SBIS 0x10,4
	RJMP _0x4A
	RCALL SUBOPT_0x3
_0x4B:
	SBIC 0x10,4
	RJMP _0x4B
	LDI  R30,LOW(49)
	RET
; 0000 0066     if (Col2==1) { delay_ms(10); while (Col2==1); return '2'; }
_0x4A:
	SBIS 0x10,5
	RJMP _0x4E
	RCALL SUBOPT_0x3
_0x4F:
	SBIC 0x10,5
	RJMP _0x4F
	LDI  R30,LOW(50)
	RET
; 0000 0067     if (Col3==1) { delay_ms(10); while (Col3==1); return '3'; }
_0x4E:
	SBIS 0x10,6
	RJMP _0x52
	RCALL SUBOPT_0x3
_0x53:
	SBIC 0x10,6
	RJMP _0x53
	LDI  R30,LOW(51)
	RET
; 0000 0068     if (Col4==1) { delay_ms(10); while (Col4==1); return '-'; }
_0x52:
	SBIS 0x10,7
	RJMP _0x56
	RCALL SUBOPT_0x3
_0x57:
	SBIC 0x10,7
	RJMP _0x57
	LDI  R30,LOW(45)
	RET
; 0000 0069 
; 0000 006A     RowA = 0; RowB = 0; RowC = 0; RowD = 1;     //Test Row D
_0x56:
	CBI  0x12,0
	CBI  0x12,1
	CBI  0x12,2
	SBI  0x12,3
; 0000 006B     if (Col1==1) { delay_ms(10); while (Col1==1); return 'C'; }
	SBIS 0x10,4
	RJMP _0x62
	RCALL SUBOPT_0x3
_0x63:
	SBIC 0x10,4
	RJMP _0x63
	LDI  R30,LOW(67)
	RET
; 0000 006C     if (Col2==1) { delay_ms(10); while (Col2==1); return '0'; }
_0x62:
	SBIS 0x10,5
	RJMP _0x66
	RCALL SUBOPT_0x3
_0x67:
	SBIC 0x10,5
	RJMP _0x67
	LDI  R30,LOW(48)
	RET
; 0000 006D     if (Col3==1) { delay_ms(10); while (Col3==1); return '='; }
_0x66:
	SBIS 0x10,6
	RJMP _0x6A
	RCALL SUBOPT_0x3
_0x6B:
	SBIC 0x10,6
	RJMP _0x6B
	LDI  R30,LOW(61)
	RET
; 0000 006E     if (Col4==1) { delay_ms(10); while (Col4==1); return '+'; }
_0x6A:
	SBIS 0x10,7
	RJMP _0x6E
	RCALL SUBOPT_0x3
_0x6F:
	SBIC 0x10,7
	RJMP _0x6F
	LDI  R30,LOW(43)
	RET
; 0000 006F 
; 0000 0070     return 'n';               // Means no key has been pressed
_0x6E:
	LDI  R30,LOW(110)
	RET
; 0000 0071 }
; .FEND
;
;
;char get_key(void)           //get key from user
; 0000 0075 {
_get_key:
; .FSTART _get_key
; 0000 0076     char key = 'n';              //assume no key pressed
; 0000 0077 
; 0000 0078     while(key=='n')              //wait untill a key is pressed
	ST   -Y,R17
;	key -> R17
	LDI  R17,110
_0x72:
	CPI  R17,110
	BRNE _0x74
; 0000 0079     {
; 0000 007A       key = READ_SWITCHES();   //scan the keys again and again
	RCALL _READ_SWITCHES
	MOV  R17,R30
; 0000 007B     }
	RJMP _0x72
_0x74:
; 0000 007C         lcd_data(key);
	MOV  R26,R17
	RCALL _lcd_data
; 0000 007D         delay_ms(20);
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 007E     return key;                  //when key pressed then return its value
	MOV  R30,R17
	RJMP _0x2080001
; 0000 007F }
; .FEND
;
;/**************************** Calculator related functions**************************/
;
;char IsOperator(char ch)
; 0000 0084 {
_IsOperator:
; .FSTART _IsOperator
; 0000 0085   if(ch == '*' || ch=='+' || ch=='/' || ch=='-')
	RCALL SUBOPT_0x1
;	ch -> R17
	CPI  R17,42
	BREQ _0x76
	CPI  R17,43
	BREQ _0x76
	CPI  R17,47
	BREQ _0x76
	CPI  R17,45
	BRNE _0x75
_0x76:
; 0000 0086     return 1;
	LDI  R30,LOW(1)
	RJMP _0x2080001
; 0000 0087   else
_0x75:
; 0000 0088     return '\0';
	LDI  R30,LOW(0)
	RJMP _0x2080001
; 0000 0089 }
; .FEND
;
;char IsDigit(char ch)
; 0000 008C {
_IsDigit:
; .FSTART _IsDigit
; 0000 008D   if(ch>=48 && ch<=57)
	RCALL SUBOPT_0x1
;	ch -> R17
	CPI  R17,48
	BRLO _0x7A
	CPI  R17,58
	BRLO _0x7B
_0x7A:
	RJMP _0x79
_0x7B:
; 0000 008E    return 1;
	LDI  R30,LOW(1)
	RJMP _0x2080001
; 0000 008F   else
_0x79:
; 0000 0090    return '\0';
	LDI  R30,LOW(0)
	RJMP _0x2080001
; 0000 0091 }
; .FEND
;
;char IsClear(char ch)
; 0000 0094 {
_IsClear:
; .FSTART _IsClear
; 0000 0095   if(ch=='C')
	RCALL SUBOPT_0x1
;	ch -> R17
	CPI  R17,67
	BRNE _0x7D
; 0000 0096    return 1;
	LDI  R30,LOW(1)
	RJMP _0x2080001
; 0000 0097   else
_0x7D:
; 0000 0098    return '\0';
	LDI  R30,LOW(0)
; 0000 0099 }
_0x2080001:
	LD   R17,Y+
	RET
; .FEND
;
;void print_result(int res)
; 0000 009C {
_print_result:
; .FSTART _print_result
; 0000 009D   char pos = 0xCF;
; 0000 009E   lcd_cmd(pos);
	RCALL __SAVELOCR4
	MOVW R18,R26
;	res -> R18,R19
;	pos -> R17
	LDI  R17,207
	MOV  R26,R17
	RCALL _lcd_cmd
; 0000 009F    if(res==0)
	MOV  R0,R18
	OR   R0,R19
	BRNE _0x7F
; 0000 00A0    {
; 0000 00A1      lcd_data('0');
	LDI  R26,LOW(48)
	RCALL _lcd_data
; 0000 00A2    }
; 0000 00A3 
; 0000 00A4    while(res!=0)
_0x7F:
_0x80:
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x82
; 0000 00A5    {
; 0000 00A6      lcd_data(res%10 + '0');
	MOVW R26,R18
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __MODW21
	SUBI R30,-LOW(48)
	MOV  R26,R30
	RCALL _lcd_data
; 0000 00A7      pos = pos - 1;
	SUBI R17,LOW(1)
; 0000 00A8      res = res/10;
	MOVW R26,R18
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __DIVW21
	MOVW R18,R30
; 0000 00A9      lcd_cmd(pos);
	MOV  R26,R17
	RCALL _lcd_cmd
; 0000 00AA    }
	RJMP _0x80
_0x82:
; 0000 00AB }
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;
;void Calculate(int op1, int op2, char Operation)
; 0000 00AE {
_Calculate:
; .FSTART _Calculate
; 0000 00AF    int res=0;
; 0000 00B0    if(Operation == '+')
	RCALL __SAVELOCR6
	MOV  R19,R26
	__GETWRS 20,21,6
;	op1 -> Y+8
;	op2 -> R20,R21
;	Operation -> R19
;	res -> R16,R17
	__GETWRN 16,17,0
	CPI  R19,43
	BRNE _0x83
; 0000 00B1     res = op1+op2;
	RCALL SUBOPT_0x4
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
; 0000 00B2    else if(Operation == '-')
	RJMP _0x84
_0x83:
	CPI  R19,45
	BRNE _0x85
; 0000 00B3     res = op1-op2;
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SUB  R30,R20
	SBC  R31,R21
	MOVW R16,R30
; 0000 00B4    else if(Operation == '*')
	RJMP _0x86
_0x85:
	CPI  R19,42
	BRNE _0x87
; 0000 00B5     res = op1*op2;
	RCALL SUBOPT_0x4
	RCALL __MULW12
	MOVW R16,R30
; 0000 00B6    else if(Operation == '/')
	RJMP _0x88
_0x87:
	CPI  R19,47
	BRNE _0x89
; 0000 00B7     res = op1/op2;
	RCALL SUBOPT_0x4
	RCALL __DIVW21
	MOVW R16,R30
; 0000 00B8    else
	RJMP _0x8A
_0x89:
; 0000 00B9    res=op1;
	__GETWRS 16,17,8
; 0000 00BA    print_result(res);
_0x8A:
_0x88:
_0x86:
_0x84:
	MOVW R26,R16
	RCALL _print_result
; 0000 00BB }
	RCALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;
;/**************************** Main and other functions *****************************/
;
;void device_init()
; 0000 00C0 {
_device_init:
; .FSTART _device_init
; 0000 00C1     port_init();
	RCALL _port_init
; 0000 00C2     init_LCD();
	RCALL _init_LCD
; 0000 00C3 }
	RET
; .FEND
;
;void print_welcome_msg()
; 0000 00C6 {
; 0000 00C7     lcd_cmd(0x83);
; 0000 00C8     print_string("WELCOME TO");
; 0000 00C9     lcd_cmd(0xC5);
; 0000 00CA     print_string("EMR CLUB");
; 0000 00CB     delay_ms(20);
; 0000 00CC }

	.DSEG
_0x8B:
	.BYTE 0x14
;
;
;void main()
; 0000 00D0 {

	.CSEG
_main:
; .FSTART _main
; 0000 00D1     char flag_op = 0;
; 0000 00D2     int op1=0, op2=0;
; 0000 00D3     char Operator = 'n';
; 0000 00D4 
; 0000 00D5     device_init();
;	flag_op -> R17
;	op1 -> R18,R19
;	op2 -> R20,R21
;	Operator -> R16
	LDI  R17,0
	RCALL SUBOPT_0x5
	LDI  R16,110
	RCALL _device_init
; 0000 00D6    // print_welcome_msg();
; 0000 00D7     lcd_cmd(0x01);
	RCALL SUBOPT_0x2
; 0000 00D8     lcd_cmd(0x80);
	LDI  R26,LOW(128)
	RCALL _lcd_cmd
; 0000 00D9   while(1)
_0x8C:
; 0000 00DA   {
; 0000 00DB      char ch = get_key();
; 0000 00DC      if(IsDigit(ch))
	SBIW R28,1
;	ch -> Y+0
	RCALL _get_key
	ST   Y,R30
	LD   R26,Y
	RCALL _IsDigit
	CPI  R30,0
	BREQ _0x8F
; 0000 00DD     {
; 0000 00DE         if(flag_op == 0)
	CPI  R17,0
	BRNE _0x90
; 0000 00DF         {
; 0000 00E0           op1 = 10*op1 + (ch - '0');
	MOVW R30,R18
	RCALL SUBOPT_0x6
	MOVW R18,R30
; 0000 00E1         }
; 0000 00E2         else
	RJMP _0x91
_0x90:
; 0000 00E3         {
; 0000 00E4           op2 = 10*op2 + (ch - '0');
	MOVW R30,R20
	RCALL SUBOPT_0x6
	MOVW R20,R30
; 0000 00E5         }
_0x91:
; 0000 00E6     }
; 0000 00E7     else if(IsOperator(ch))
	RJMP _0x92
_0x8F:
	LD   R26,Y
	RCALL _IsOperator
	CPI  R30,0
	BREQ _0x93
; 0000 00E8     {
; 0000 00E9        if(flag_op==1){ lcd_cmd(0x01); lcd_cmd(0x80); print_string("Invalid Input");continue;}
	CPI  R17,1
	BRNE _0x94
	RCALL SUBOPT_0x2
	LDI  R26,LOW(128)
	RCALL _lcd_cmd
	__POINTW2MN _0x95,0
	RCALL _print_string
	ADIW R28,1
	RJMP _0x8C
; 0000 00EA 
; 0000 00EB        Operator = ch;
_0x94:
	LDD  R16,Y+0
; 0000 00EC        flag_op = 1;
	LDI  R17,LOW(1)
; 0000 00ED     }
; 0000 00EE     else if(IsClear(ch))
	RJMP _0x96
_0x93:
	LD   R26,Y
	RCALL _IsClear
	CPI  R30,0
	BREQ _0x97
; 0000 00EF     {
; 0000 00F0       flag_op = 0;
	LDI  R17,LOW(0)
; 0000 00F1       lcd_cmd(0x01);
	RCALL SUBOPT_0x2
; 0000 00F2       lcd_cmd(0x80);
	LDI  R26,LOW(128)
	RCALL _lcd_cmd
; 0000 00F3       Operator = 'n';
	RJMP _0x9B
; 0000 00F4     }
; 0000 00F5     else if(ch=='=')
_0x97:
	LD   R26,Y
	CPI  R26,LOW(0x3D)
	BRNE _0x99
; 0000 00F6     {
; 0000 00F7       Calculate(op1, op2, Operator);
	ST   -Y,R19
	ST   -Y,R18
	ST   -Y,R21
	ST   -Y,R20
	MOV  R26,R16
	RCALL _Calculate
; 0000 00F8 	  op1=0;
	RCALL SUBOPT_0x5
; 0000 00F9 	  op2=0;
; 0000 00FA 	  Operator='n';
_0x9B:
	LDI  R16,LOW(110)
; 0000 00FB     }
; 0000 00FC  }
_0x99:
_0x96:
_0x92:
	ADIW R28,1
	RJMP _0x8C
; 0000 00FD }
_0x9A:
	RJMP _0x9A
; .FEND

	.DSEG
_0x95:
	.BYTE 0xE
;
;

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	OUT  0x18,R17
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x15,0
	LDI  R26,LOW(5)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	ST   -Y,R17
	MOV  R17,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(1)
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(10)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	MOVW R30,R20
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	RCALL __MULW12
	MOVW R26,R30
	LD   R30,Y
	LDI  R31,0
	SBIW R30,48
	ADD  R30,R26
	ADC  R31,R27
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	NEG  R27
	NEG  R26
	SBCI R27,0
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
