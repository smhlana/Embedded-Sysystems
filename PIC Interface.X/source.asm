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
Setup   bcf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 0
	bsf	T1CON, TMR1CS	; Use external clock source - T1CKI pin on rising edge
	;movlw	02h
	;movwf	T1SYNC
	bsf	T1CON, 02	; Do not synchronise the external clk input
	bsf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 1
	movlw	0CFh
	movwf	SPBRG		; Use BAUD Rate = 1.2kbps in high speed
	bsf	TXSTA, BRGH	; Select high speed
	bcf	TXSTA, SYNC	; Enable asynchronous serial port
	bcf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 0
	bsf	RCSTA, SPEN	; Enable asynchronous serial port
	goto	CalculateFrequency
;*******************************************************************************

;**********CALCULATE FREQUENCY**************************************************
CalculateFrequency
	call	One_S_Delay
StartTimer1
	bcf     STATUS,RP1	; Select Bank 0
	bsf	T1CON, TMR1ON   ; Enable Timer 1
	clrf	TMR1L
	clrf	TMR1H
	call	One_S_Delay
StopTimer1
	bcf	T1CON, TMR1ON   ; Disable Timer 1
	movf	TMR1L, W
	movwf	FREQUENCY_L	; Store low byte if frequency
	movf	TMR1H, W
	movwf	FREQUENCY_H	; Store high byte of frequency
	goto	CalculateVoltage
;*******************************************************************************

;**********CALCULATE VOLTAGE****************************************************
CalculateVoltage
	goto	PCComms
;*******************************************************************************

;**********SEND INFO TO PC******************************************************
PCComms	bsf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 1
	bsf	TXSTA, TXEN	; Enable the transmission
	bcf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 0
	movfw	FREQUENCY_L
	movwf	TXREG
PollPIR1
	btfss	PIR1, TXIF	; Wait for transmit buffer to be empty
	goto	PollPIR1
	movfw	FREQUENCY_H
	movwf	TXREG
	; Send voltage also
	bsf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 1
	bcf	TXSTA, TXEN	; Disable the transmission
	goto	CalculateFrequency
;*******************************************************************************
	
;**********1S DELAY*************************************************************
One_S_Delay
	; (((2+3(255))x10e-6)x216)x6 = 1.0000535s
	movlw	00h	    ; Load 256
	movwf	CNT_1
	movlw	0D8h	    ; Load 216
	movwf	CNT_2
	movlw	06h	    ; Load 6
	movwf	CNT_3
Start_Delay
	decfsz	CNT_1
	goto	Start_Delay
	movlw	00h
	movwf	CNT_1
	decfsz	CNT_2
	goto	Start_Delay
	movlw	0D8h
	movwf	CNT_2
	decfsz	CNT_3
	goto	Start_Delay
	return
;*******************************************************************************
	
	end