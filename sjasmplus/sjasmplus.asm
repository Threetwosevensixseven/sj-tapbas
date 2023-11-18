 INCLUDE BasicLib.asm
 DEVICE ZXSPECTRUM48

 ORG 23755

Basic
	LINE : db clear:NUM Start-1             : LEND
	LINE : db poke:NUM 23610:db ',':NUM 255 : LEND    
	LINE : db load,'"pasmo.tap"',code       : LEND
	LINE : db rand,usr:NUM Start	        : LEND
BasEnd

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

 EMPTYTAP "sjasmplus.tap"
 SAVETAP  "sjasmplus.tap", BASIC, "loader",    Basic, BasEnd-Basic, 10
 SAVETAP  "sjasmplus.tap", CODE,  "pasmo.tap", Start, $-Start

 END Start