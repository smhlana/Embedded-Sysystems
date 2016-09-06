#include "P16F690.inc"

;**********REGISTERS LABEL EQUATES**********************************************
W		EQU 00h
FREQUENCY_L	EQU 20h
FREQUENCY_H	EQU 21h
T1SYNC		EQU 22h
CNT_1		EQU 23h	
CNT_2		EQU 24h
CNT_3		EQU 25h
;*******************************************************************************

;**********BEGIN****************************************************************
	ORG     0x00    ; Program Start address
	goto    Setup   ; Jump to program setup
;*******************************************************************************
	
;**********SETUP****************************************************************
Setup   bcf     STATUS,RP0	
        bcf     STATUS,RP1	; Select Bank 0
	bsf	T1CON, TMR1CS	; Use external clock source - T1CKI pin on rising edge
	;movlw	02h
	;movwf	T1SYNC
	bsf	T1CON, 02	; Do not synchronise the external clk input
	goto	CalculateFrequency
;*******************************************************************************

;**********CALCULATE FREQUENCY**************************************************
CalculateFrequency
	call	One_S_Delay
StartTimer1
	bcf     STATUS,RP1	; Select Bank 0
	bsf	T1CON, TMR1ON   ; Enable Timer 1
	; INSERT 1S DELAY
StopTTimer1
	bcf	T1CON, TMR1ON   ; Enable Timer 1
	movf	TMR1L, W
	movwf	FREQUENCY_L	; Store low byte if frequency
	movf	TMR1H, W
	movwf	FREQUENCY_H	; Store high byte of frequency
	goto	CalculateVoltage
;*******************************************************************************

;**********CALCULATE VOLTAGE****************************************************
CalculateVoltage
;*******************************************************************************
	
;**********1S DELAY*************************************************************
;One_S_Delay
;	movlw	00h	    ; Load 256
;	movwf	CNT_1
;	movlw	0DBh	    ; Load 219
;	movwf	CNT_2
;	movlw	06h	    ; Load 6
;	movwf	CNT_3
;Start_Delay
;	decfsz	CNT_1
;	goto	Start_Delay
;	movlw	00h
;	movwf	CNT_1
;	decfsz	CNT_2
;	movlw	0DBh
;	movfw	CNT_2
;	decfsz	CNT_3
;	goto	Start_Delay
;	return
;*******************************************************************************
One_S_Delay
	movlw	00h
Start_Delay
	decfsz	CNT_1
	goto	Start_Delay
	return
	end