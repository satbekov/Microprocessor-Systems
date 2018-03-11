	export bubble_sort
	import __main
        
    AREA    FLASH, CODE, READONLY
    ALIGN
        

;******************************************************************************
; Description
;     Given the address in R7, it will read the unsigned byte at R7 and R7 + 1.
;     If [R7] > [R7 + 1], swap the values
;
;     Modify only registers R8 or greater.
;
; Parameters
;   R7 - Array Address
;
; Returns
;   Nothing
;******************************************************************************
swap_values PROC
     ;---------------------------------------
     ; START ADD CODE
     ;---------------------------------------
	 
	 ; Load the first value in the array
	 LDRB	R8, [R7, #0]
	 
	 ; Load the next value to R9
     LDRB	R9, [R7, #1]
	 
	 ; Copy the i+1 value; temporary
	 MOV	R10, R9
	 CMP	R8, R9
	 BLS    exit
	 ; Swap the values if i > i+1
	 STRB 	R8, [R7, #1]
	 STRB	R10, [R7, #0]
	 
	 ; Return from the function
exit
	 BX		LR
     
     ;---------------------------------------
     ; END ADD CODE
     ;---------------------------------------
    ENDP


    
;******************************************************************************
; Description
;   Uses Bubble Sort to sort an array of unsigned 8-bit numbers.
;
;   Modify only registers R0-R7
;
; Parameters
;   R0 - Array Address
;   R1 - Array Size
;
; Returns
;   Nothing
;******************************************************************************
bubble_sort PROC

    ; Save registers
     PUSH   {R0-R12, LR}
     
     ;---------------------------------------
     ; START ADD CODE
     ;---------------------------------------
     
	 SUB	R1, R1, #1
	
while_outer_start
	 CMP	R1, #0
	 BEQ	while_outer_end
	 
	 ; R2 saves the current index
	 MOV	R2, #0
	 
	 ; # counter for first check
	 MOV	R7, R0
while_inner_start
	 CMP	R2, R1
	 BHI	while_inner_end	
	 BL		swap_values
	 ADD	R7, R7, #1
	 ADD	R2, R2, #1 
	 B		while_inner_start
	 
while_inner_end
	 SUB	R1, R1, #1
	 B		while_outer_start
	 
while_outer_end
	 
     ; NOTE: The return from the function is already
     ; provided below
     
     ;---------------------------------------
     ; END ADD CODE
     ;---------------------------------------
     
    
    ; Restore Registers
    POP     {R0-R12, LR}
    
    ; Return from the function
    BX      LR
    
    ENDP
         
    END     

