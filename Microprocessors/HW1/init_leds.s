; Filename:     leds_init.s
; Author:       Kairat Satbekov 
; Description:  
	import hw1
	export init_leds
;******************************************************************************** 
; SRAM
;******************************************************************************** 
    AREA    SRAM, READWRITE
    align
        
;******************************************************************************** 
; Constant Variables (FLASH) Segment
;******************************************************************************** 
    AREA    FLASH, CODE, READONLY
    align
		
;******************************************************************************** 
;******************************************************************************** 
;******************************************************
; Initializes led_array_addr so that each LED
; has the following color codes:
;
; led_array_addr[0]= Green 50%, Red 0%, Blue 0%
; led_array_addr[1]= Green 0%, Red 50%, Blue 0%
; led_array_addr[2]= Green 0%, Red 0%, Blue 50%
; led_array_addr[3]= Green 50%, Red 25%, Blue 0%
; led_array_addr[4]= Green 0%, Red 50%, Blue 25%
; led_array_addr[5]= Green 25%, Red 0%, Blue 50%
; led_array_addr[6]= Green 25%, Red 25%, Blue 25%
; led_array_addr[7]= Green 75%, Red 0%, Blue 75%
;
; parameter 0	address of LED array
; parameter 1	address of UPDATE_LEDS variable
;
;******************************************************
	;; TODO -- Implement EABI compliant function init_leds

init_leds	PROC
	; save modified registers, in our case it's only R4 since R0-R3 are handled by caller
	PUSH	{R4}
	
	; initialize led_array_addr[0]
	MOV		R2, #0x7F
	MOV 	R3, #0x0
	MOV 	R4, #0x0
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1
	
	; initialize led_array_addr[1]	
	MOV		R2, #0x0
	MOV 	R3, #0x7F
	MOV 	R4, #0x0
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1
	
	; initialize led_array_addr[2]
	MOV		R2, #0x0
	MOV 	R3, #0x0
	MOV 	R4, #0x7F
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1
	
	; initialize led_array_addr[3]
	MOV		R2, #0x7F
	MOV 	R3, #0x3F
	MOV 	R4, #0x0
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1

	; initialize led_array_addr[4]
	MOV		R2, #0x0
	MOV 	R3, #0x7F
	MOV 	R4, #0x3F
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1

	; initialize led_array_addr[5]
	MOV		R2, #0x3F
	MOV 	R3, #0x0
	MOV 	R4, #0x7F
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1
	
	; initialize led_array_addr[6]
	MOV		R2, #0x3F
	MOV 	R3, #0x3F
	MOV 	R4, #0x3F
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1
	
	; initialize led_array_addr[7]
	MOV		R2, #0xBF
	MOV 	R3, #0x0
	MOV 	R4, #0xBF
	STRB	R2, [R0], #1
	STRB	R3, [R0], #1
	STRB	R4, [R0], #1
	
	; clear update_led_addr
	MOV		R4, #0x00000000
	STR		R4, [R1]
	
	; restore modified registers
	POP		{R4}
	
	; return from function
	BX 		LR
	
	ENDP
    END
        
        
