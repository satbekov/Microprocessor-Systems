; Filename:     leds_rotate.s
; Author:       Kairat Satbekov
; Description:  
	
	import hw1
	export rotate_leds
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
; Rotates the 24-bit color values of one LED to the next LED by rotating 3-bytes
;
; parameter 0	address of LED array
; parameter 1   array size
;
;********************************************************************************
rotate_leds   PROC
	
	PUSH	{R4-R10}
	
	LDRB	R2, [R0]			; save led_array[0] value to R2
	LDRB	R3, [R0,#1]			; save led_array[1] value to R3
	LDRB	R4, [R0,#2]			; save led_array[2] value to R4
	MOV		R9, R0				; save source index iterator to R9
	ADD		R9, R9, #3			; set it to point to led_array[3]
	MOV		R10, R0				; save destination index iterator to R10
	ADD		R5, R1, R1, LSL #1	; R5 holds the size of the array
    SUBS	R5, R5, #3			; save end index to R5

rotate_loop_start
	
	BEQ		rotate_loop_end
	; load led_array[i+3], led_array[i+4], led_array[i+5] from source
	; to R6, R7, R8
	LDRB	R6, [R9], #1
	LDRB	R7, [R9], #1
	LDRB	R8, [R9], #1
	; store R6, R7, R8 to array[i], led_array[i+1], led_array[i+2]
	; to destination(assuming after done, i += 3)
	STRB	R6, [R10], #1
	STRB	R7, [R10], #1
	STRB	R8, [R10], #1
	SUBS	R5, R5, #3
	B		rotate_loop_start

rotate_loop_end
    SUB		R9, R9, #3
	STRB	R2, [R9], #1		; led_array[21] = led_array[0]
	STRB	R3, [R9], #1		; led_array[22] = led_array[1]
	STRB	R4, [R9], #1		; led_array[23] = led_array[2]
    POP		{R4-R10}
    BX		LR
    ENDP
    
    
	END