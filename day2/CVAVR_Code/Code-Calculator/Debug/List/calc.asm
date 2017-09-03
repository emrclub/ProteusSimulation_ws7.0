
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

_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
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
;
;void cmd(char a)
; 0000 0015 {

	.CSEG
_cmd:
; .FSTART _cmd
; 0000 0016     E=1;
	ST   -Y,R17
	MOV  R17,R26
;	a -> R17
	SBI  0x15,0
; 0000 0017     RS=0;
	CBI  0x15,1
; 0000 0018     PORTB=a;
	RCALL SUBOPT_0x0
; 0000 0019     delay_ms(5);
; 0000 001A     E=0;
; 0000 001B     delay_ms(5);
; 0000 001C }
	RJMP _0x2080001
; .FEND
;
;void lcd1(char b)
; 0000 001F {
_lcd1:
; .FSTART _lcd1
; 0000 0020     E=1;
	ST   -Y,R17
	MOV  R17,R26
;	b -> R17
	SBI  0x15,0
; 0000 0021     RS=1;
	SBI  0x15,1
; 0000 0022     PORTB =b;
	RCALL SUBOPT_0x0
; 0000 0023     delay_ms(5);
; 0000 0024     E=0;
; 0000 0025     delay_ms(5);
; 0000 0026 }
	RJMP _0x2080001
; .FEND
;
;void string1(char *str)
; 0000 0029 {
; 0000 002A      while(*str!='\0')
;	*str -> R16,R17
; 0000 002B      {
; 0000 002C       lcd1(*str);
; 0000 002D       str++;
; 0000 002E      }
; 0000 002F }
;
;void init_LCD()
; 0000 0032 {
_init_LCD:
; .FSTART _init_LCD
; 0000 0033 
; 0000 0034   cmd(0x38);        //LCD initialization
	LDI  R26,LOW(56)
	RCALL _cmd
; 0000 0035   cmd(0x0c);        //display on cursor off
	LDI  R26,LOW(12)
	RCALL _cmd
; 0000 0036   cmd(0x01);        //clear display screen
	RCALL SUBOPT_0x1
; 0000 0037   cmd(0x06);        //shift
	LDI  R26,LOW(6)
	RCALL _cmd
; 0000 0038   cmd(0x02);        //return to home
	LDI  R26,LOW(2)
	RCALL _cmd
; 0000 0039 }
	RET
; .FEND
;
;void delay(int a)
; 0000 003C {
; 0000 003D   int i;
; 0000 003E   for(i=0;i<a;i++);
;	a -> R18,R19
;	i -> R16,R17
; 0000 003F }
;
;char READ_SWITCHES(void)
; 0000 0042 {
_READ_SWITCHES:
; .FSTART _READ_SWITCHES
; 0000 0043     RowA = 0; RowB = 1; RowC = 1; RowD = 1;     //Test Row A
	CBI  0x12,0
	SBI  0x12,1
	SBI  0x12,2
	SBI  0x12,3
; 0000 0044     if (Col1 == 0) { delay_ms(10); while (Col1==0); return '7'; }
	SBIC 0x10,4
	RJMP _0x1D
	RCALL SUBOPT_0x2
_0x1E:
	SBIS 0x10,4
	RJMP _0x1E
	LDI  R30,LOW(55)
	RET
; 0000 0045     if (Col2 == 0) { delay_ms(10); while (Col2==0); return '8'; }
_0x1D:
	SBIC 0x10,5
	RJMP _0x21
	RCALL SUBOPT_0x2
_0x22:
	SBIS 0x10,5
	RJMP _0x22
	LDI  R30,LOW(56)
	RET
; 0000 0046     if (Col3 == 0) { delay_ms(10); while (Col3==0); return '9'; }
_0x21:
	SBIC 0x10,6
	RJMP _0x25
	RCALL SUBOPT_0x2
_0x26:
	SBIS 0x10,6
	RJMP _0x26
	LDI  R30,LOW(57)
	RET
; 0000 0047     if (Col4 == 0) { delay_ms(10); while (Col4==0); return '/'; }
_0x25:
	SBIC 0x10,7
	RJMP _0x29
	RCALL SUBOPT_0x2
_0x2A:
	SBIS 0x10,7
	RJMP _0x2A
	LDI  R30,LOW(47)
	RET
; 0000 0048 
; 0000 0049     RowA = 1; RowB = 0; RowC = 1; RowD = 1;     //Test Row B
_0x29:
	SBI  0x12,0
	CBI  0x12,1
	SBI  0x12,2
	SBI  0x12,3
; 0000 004A     if (Col1 == 0) { delay_ms(10); while (Col1==0); return '4'; }
	SBIC 0x10,4
	RJMP _0x35
	RCALL SUBOPT_0x2
_0x36:
	SBIS 0x10,4
	RJMP _0x36
	LDI  R30,LOW(52)
	RET
; 0000 004B     if (Col2 == 0) { delay_ms(10); while (Col2==0); return '5'; }
_0x35:
	SBIC 0x10,5
	RJMP _0x39
	RCALL SUBOPT_0x2
_0x3A:
	SBIS 0x10,5
	RJMP _0x3A
	LDI  R30,LOW(53)
	RET
; 0000 004C     if (Col3 == 0) { delay_ms(10); while (Col3==0); return '6'; }
_0x39:
	SBIC 0x10,6
	RJMP _0x3D
	RCALL SUBOPT_0x2
_0x3E:
	SBIS 0x10,6
	RJMP _0x3E
	LDI  R30,LOW(54)
	RET
; 0000 004D     if (Col4 == 0) { delay_ms(10); while (Col4==0); return 'x'; }
_0x3D:
	SBIC 0x10,7
	RJMP _0x41
	RCALL SUBOPT_0x2
_0x42:
	SBIS 0x10,7
	RJMP _0x42
	LDI  R30,LOW(120)
	RET
; 0000 004E 
; 0000 004F     RowA = 1; RowB = 1; RowC = 0; RowD = 1;     //Test Row C
_0x41:
	SBI  0x12,0
	SBI  0x12,1
	CBI  0x12,2
	SBI  0x12,3
; 0000 0050     if (Col1 == 0) { delay_ms(10); while (Col1==0); return '1'; }
	SBIC 0x10,4
	RJMP _0x4D
	RCALL SUBOPT_0x2
_0x4E:
	SBIS 0x10,4
	RJMP _0x4E
	LDI  R30,LOW(49)
	RET
; 0000 0051     if (Col2 == 0) { delay_ms(10); while (Col2==0); return '2'; }
_0x4D:
	SBIC 0x10,5
	RJMP _0x51
	RCALL SUBOPT_0x2
_0x52:
	SBIS 0x10,5
	RJMP _0x52
	LDI  R30,LOW(50)
	RET
; 0000 0052     if (Col3 == 0) { delay_ms(10); while (Col3==0); return '3'; }
_0x51:
	SBIC 0x10,6
	RJMP _0x55
	RCALL SUBOPT_0x2
_0x56:
	SBIS 0x10,6
	RJMP _0x56
	LDI  R30,LOW(51)
	RET
; 0000 0053     if (Col4 == 0) { delay_ms(10); while (Col4==0); return '-'; }
_0x55:
	SBIC 0x10,7
	RJMP _0x59
	RCALL SUBOPT_0x2
_0x5A:
	SBIS 0x10,7
	RJMP _0x5A
	LDI  R30,LOW(45)
	RET
; 0000 0054 
; 0000 0055     RowA = 1; RowB = 1; RowC = 1; RowD = 0;     //Test Row D
_0x59:
	SBI  0x12,0
	SBI  0x12,1
	SBI  0x12,2
	CBI  0x12,3
; 0000 0056     if (Col1 == 0) { delay_ms(10); while (Col1==0); return 'C'; }
	SBIC 0x10,4
	RJMP _0x65
	RCALL SUBOPT_0x2
_0x66:
	SBIS 0x10,4
	RJMP _0x66
	LDI  R30,LOW(67)
	RET
; 0000 0057     if (Col2 == 0) { delay_ms(10); while (Col2==0); return '0'; }
_0x65:
	SBIC 0x10,5
	RJMP _0x69
	RCALL SUBOPT_0x2
_0x6A:
	SBIS 0x10,5
	RJMP _0x6A
	LDI  R30,LOW(48)
	RET
; 0000 0058     if (Col3 == 0) { delay_ms(10); while (Col3==0); return '='; }
_0x69:
	SBIC 0x10,6
	RJMP _0x6D
	RCALL SUBOPT_0x2
_0x6E:
	SBIS 0x10,6
	RJMP _0x6E
	LDI  R30,LOW(61)
	RET
; 0000 0059     if (Col4 == 0) { delay_ms(10); while (Col4==0); return '+'; }
_0x6D:
	SBIC 0x10,7
	RJMP _0x71
	RCALL SUBOPT_0x2
_0x72:
	SBIS 0x10,7
	RJMP _0x72
	LDI  R30,LOW(43)
	RET
; 0000 005A 
; 0000 005B     return 'n';               // Means no key has been pressed
_0x71:
	LDI  R30,LOW(110)
	RET
; 0000 005C }
; .FEND
;
;
;char get_key(void)           //get key from user
; 0000 0060 {
_get_key:
; .FSTART _get_key
; 0000 0061     char key = 'n';              //assume no key pressed
; 0000 0062 
; 0000 0063     while(key=='n')              //wait untill a key is pressed
	ST   -Y,R17
;	key -> R17
	LDI  R17,110
_0x75:
	CPI  R17,110
	BRNE _0x77
; 0000 0064     {
; 0000 0065       key = READ_SWITCHES();   //scan the keys again and again
	RCALL _READ_SWITCHES
	MOV  R17,R30
; 0000 0066     }
	RJMP _0x75
_0x77:
; 0000 0067     return key;                  //when key pressed then return its value
	MOV  R30,R17
_0x2080001:
	LD   R17,Y+
	RET
; 0000 0068 }
; .FEND
;
;
;
;
;char IsOperator(char ch)
; 0000 006E {
; 0000 006F   if(ch == '*' || ch=='+' || ch=='/' || ch=='-')
;	ch -> R17
; 0000 0070     return 1;
; 0000 0071   else
; 0000 0072     return '\0';
; 0000 0073 }
;
;char IsDigit(char ch)
; 0000 0076 {
; 0000 0077   if(ch<=48 && ch<=57)
;	ch -> R17
; 0000 0078    return 1;
; 0000 0079   else
; 0000 007A    return '\0';
; 0000 007B }
;
;char IsClear(char ch)
; 0000 007E {
; 0000 007F   if(ch=='C')
;	ch -> R17
; 0000 0080    return 1;
; 0000 0081   else
; 0000 0082    return '\0';
; 0000 0083 }
;
;void Calculate(int op1, int op2, char Operation)
; 0000 0086 {
; 0000 0087    int res;
; 0000 0088    char pos = 0xCE;
; 0000 0089    if(Operation == '+')
;	op1 -> Y+8
;	op2 -> R20,R21
;	Operation -> R18
;	res -> R16,R17
;	pos -> R19
; 0000 008A     res = op1+op2;
; 0000 008B    else if(Operation == '-')
; 0000 008C     res = op1-op2;
; 0000 008D    else if(Operation == '*')
; 0000 008E     res = op1*op2;
; 0000 008F    else if(Operation == '/')
; 0000 0090     {
; 0000 0091       float res1 = (1.0)*(((1.0)*op1)/((1.0)*(op2)));
; 0000 0092       res = res1;
;	op1 -> Y+12
;	res1 -> Y+0
; 0000 0093     }
; 0000 0094 
; 0000 0095    else return;
; 0000 0096 
; 0000 0097    cmd(pos);
; 0000 0098 
; 0000 0099    if(res==0)
; 0000 009A    {
; 0000 009B      lcd1('0');
; 0000 009C    }
; 0000 009D 
; 0000 009E    while(res!=0)
; 0000 009F    {
; 0000 00A0      lcd1(res%10 + '0');
; 0000 00A1      pos = pos - 1;
; 0000 00A2      res = res/10;
; 0000 00A3    }
; 0000 00A4 }
;
;void main()
; 0000 00A7 {
_main:
; .FSTART _main
; 0000 00A8     char flag_op = 0;
; 0000 00A9     int op1=0, op2=0;
; 0000 00AA     int count=0;
; 0000 00AB     char Operator = 'n';
; 0000 00AC 
; 0000 00AD     DDRB=0xFF;
	SBIW R28,2
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
;	flag_op -> R17
;	op1 -> R18,R19
;	op2 -> R20,R21
;	count -> Y+0
;	Operator -> R16
	LDI  R17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	LDI  R16,110
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 00AE     DDRD=0x0F;
	LDI  R30,LOW(15)
	OUT  0x11,R30
; 0000 00AF 
; 0000 00B0     init_LCD();
	RCALL _init_LCD
; 0000 00B1 
; 0000 00B2 /*cmd(0x83);
; 0000 00B3 string1("WELCOMWE TO");
; 0000 00B4 cmd(0xPORTD.7);
; 0000 00B5 string1("EMR CLUB");
; 0000 00B6 delay_ms(100);
; 0000 00B7 */
; 0000 00B8     cmd(0x01);
	RCALL SUBOPT_0x1
; 0000 00B9     cmd(0x80);
	LDI  R26,LOW(128)
	RCALL _cmd
; 0000 00BA     lcd1('3');
	LDI  R26,LOW(51)
	RCALL _lcd1
; 0000 00BB     delay_ms(20);
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00BC     cmd(0x01);
	RCALL SUBOPT_0x1
; 0000 00BD     cmd(0x80);
	LDI  R26,LOW(128)
	RCALL _cmd
; 0000 00BE /* while(1)
; 0000 00BF  {
; 0000 00C0   char ch = get_key();
; 0000 00C1     if(IsDigit(ch))
; 0000 00C2     {
; 0000 00C3         if(flag_op == 0)
; 0000 00C4         {
; 0000 00C5           op1 = pow(10,count)*op1 + (int)(ch);
; 0000 00C6           count = count + 1;
; 0000 00C7         }
; 0000 00C8         else
; 0000 00C9         {
; 0000 00CA           op2 = pow(10,count)*op2 + (int)(ch);
; 0000 00CB           count = count + 1;
; 0000 00CC         }
; 0000 00CD     }
; 0000 00CE     else if(IsOperator(ch))
; 0000 00CF     {
; 0000 00D0        if(flag_op==1) continue;
; 0000 00D1 
; 0000 00D2        count=0;
; 0000 00D3        Operator = ch;
; 0000 00D4        flag_op = 1;
; 0000 00D5     }
; 0000 00D6     else if(IsClear(ch))
; 0000 00D7     {
; 0000 00D8       flag_op = 0;
; 0000 00D9       cmd(0x01);
; 0000 00DA       Operator = 'n';
; 0000 00DB     }
; 0000 00DC     else if(Operator!='n' && ch=='C' && flag_op==1)
; 0000 00DD     {
; 0000 00DE       Calculate(op1, op2, Operator);
; 0000 00DF     }
; 0000 00E0  }*/
; 0000 00E1   while(1)
_0x8E:
; 0000 00E2   {
; 0000 00E3     char ch = get_key();
; 0000 00E4     lcd1(ch);
	SBIW R28,1
;	count -> Y+1
;	ch -> Y+0
	RCALL _get_key
	ST   Y,R30
	LD   R26,Y
	RCALL _lcd1
; 0000 00E5     delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00E6     cmd(0x01);
	RCALL SUBOPT_0x1
; 0000 00E7   }
	ADIW R28,1
	RJMP _0x8E
; 0000 00E8 
; 0000 00E9 }
_0x91:
	RJMP _0x91
; .FEND
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
	LDI  R26,LOW(1)
	RJMP _cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(10)
	LDI  R27,0
	RJMP _delay_ms

;RUNTIME LIBRARY

	.CSEG
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
