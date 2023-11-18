;-----------------------------------------------------------
;
; Basic Int System
;
;-----------------------------------------------------------
 ORG $8000
;-----------------------------------------------------------
Start:
 ; Disable interrupts while we sort it out
 di 
 ; Set the jump table
 ld hl, IM2Table
 ld de, IM2Table + 1
 ld bc, 256
 ; Set the I register
 ld a, h
 ld i, a
 ; Set the first entry to copy
 ld a, $81
 ld (hl), a
 ; Fill the table
 ldir
 ; Set the IM mode
 im 2
 ei
 ret
;-----------------------------------------------------------
 ORG $8181
 push af
 push bc
 push de
 push hl
 push ix             
 push iy
 ld a, (Test)
 out (254), a
 inc a
 and 7
 ld (Test), a
 pop iy
 pop ix              
 pop hl
 pop de
 pop bc
 pop af              
 jp $38
;-----------------------------------------------------------
 ORG $8200
IM2Table: ds 257
;-----------------------------------------------------------
Test: db 0
;-----------------------------------------------------------
 END Start

;  10 CLEAR 32767
;  20 POKE 23610,255
;  30 LOAD ""CODE 
;  40 RANDOMIZE USR 32768