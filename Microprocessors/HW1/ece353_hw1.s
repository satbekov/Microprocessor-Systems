; Filename:     ece353_hw1
; Author:       Kairat Satbekov
; Description:  

    export hw1
	export WS2812B_BYTES
	export UPDATE_LEDS
	import init_leds
	import rotate_leds
	import write_leds
	
WORD		EQU		4
HALF_WORD	EQU		2
BYTE		EQU		1
	
;******************************************************************************** 
; SRAM
;******************************************************************************** 
    AREA    SRAM, READWRITE
		;; TODO -- allocate space for WS2812B_BYTES and for UPDATE_LEDS
WS2812B_BYTES		SPACE	24*BYTE
UPDATE_LEDS			SPACE	1*WORD
	
    align
		
;******************************************************************************** 
; Constant Variables (FLASH) Segment
;******************************************************************************** 
    AREA    FLASH, CODE, READONLY
    align
  
;******************************************************************************** 
;******************************************************************************** 
hw1   PROC
	;; TODO -- Setup argument to pass to init_leds
	;; TODO -- call init_leds routine
	
	LDR		R0, =(WS2812B_BYTES)
	LDR		R1, =(UPDATE_LEDS)
	
	PUSH	{R0-R1}
	BL		init_leds
	POP		{R0-R1}
	
infinite_loop
	;; TODO -- do stuff specified in HW1 problem statement
	;; If UPDATE_LEDS is zero branch back to infinite loop
	LDR		R4, [R1]
	CMP		R4, #0
	BEQ		infinite_loop
	;; Otherwise
	CPSID	I
	MOV32	R3, #0x00000000

	;; pass the right parameters to rotate_leds
	STR		R3, [R1]
	PUSH	{R0-R1}
	MOV		R1, #8
	BL		rotate_leds
	POP 	{R0-R1}
	PUSH	{R0-R2}
	MOV		R1, #8
	MOV32	R2, #0x400073FC
	BL		write_leds
	POP		{R0-R2}
	CPSIE	I
	B		infinite_loop
	
    ENDP
    align
        

    END
        
        
