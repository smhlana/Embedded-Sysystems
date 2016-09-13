    __CONFIG  _CP_OFF & _CPD_OFF & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT & _MCLRE_OFF & _FCMEN_OFF & _IESO_OFF
                LIST        P = 16F690, r=dec
#include "P16F690.inc"
errorlevel -302                                ; suppress the bank sel check warnings

;**********REGISTERS LABEL EQUATES**********************************************
W		EQU 00h
FREQUENCY_L	EQU 20h
FREQUENCY_H	EQU 21h
T1SYNC		EQU 22h
CNT_1		EQU 23h	
CNT_2		EQU 24h
CNT_3		EQU 25h
DIGITLO		EQU 26h
DIGITHI		EQU 27h
;*******************************************************************************

;**********BEGIN****************************************************************
	ORG     0x00    ; Program Start address
	goto    Setup   ; Jump to program setup
;*******************************************************************************
	
;**********SETUP****************************************************************
Setup   ;bcf	STATUS, RP0
	;bcf	STATUS, RP1
	;clrf	PORTC	
	;bsf	STATUS, RP1
	;CLRF	ANSEL	
	;bsf	STATUS, RP0
	;bcf	STATUS, RP1
	;movlw	0Ch
	;movwf	TRISC
	bsf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 1
	bsf	TRISC, TRISC5	; RC5 input switch
	bsf	TRISA, TRISA0	; Set RA0 as input
	bsf	TRISA, TRISA5	; Set RA5 as output
	bcf	TRISB, TRISB7	; Set RB7 as output
	bcf	TRISC, TRISC7	; LED indicator
	movlw	b'01110000'	; Select ADC FRC clock
        movwf	ADCON1
	bcf	STATUS,RP0
	bsf	STATUS,RP1	; Select Bank 2
	bsf	ANSEL,0		; Enable analog input in RA0
	bcf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 0
	bsf	T1CON, TMR1CS	; Use external clock source - T1CKI pin on rising edge
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
	movlw   b'10000001'	; Enable ADC and Rigth justify
        movwf   ADCON0
	goto	MainLoop
;*******************************************************************************

;**********LOOP*****************************************************************
MainLoop
	bcf	PORTC, RC7
	btfss	PORTC, RC5
	goto	CalculateFrequency
	goto	MainLoop
;*******************************************************************************

;**********CALCULATE FREQUENCY**************************************************
CalculateFrequency
	bsf	PORTC, RC7
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
	bcf	PIR1,6	    ; A/D conversion has not started
	bcf	STATUS,6
        bsf     STATUS,5    ; Select bank 1
	bsf	PIE1,6	    ; Enable ADC interrupt
        bcf     STATUS,5    ; Select bank 0
	bsf	INTCON,6
	call    SampleTime
	bsf     ADCON0,GO   ; Start A/D conversion cycle
        btfsc   ADCON0,GO   ; Poll conversion
        goto    $-1
        movf    ADRESH,W
        movwf   DIGITHI
	bcf	STATUS,6
        bsf     STATUS,5    ; Select bank 1
        movf    ADRESL,0
        bcf     STATUS,5    ; Select bank 0
        movwf   DIGITLO
	bcf	PIR1,6
	goto	PCComms
;*******************************************************************************

;**********SEND INFO TO PC******************************************************
PCComms	bsf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 1
	bsf	TXSTA, TXEN	; Enable the transmission
	bcf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 0
	movf	FREQUENCY_L, 0
	movwf	TXREG
PollPIR1_1
	btfss	PIR1, TXIF	; Wait for transmit buffer to be empty
	goto	PollPIR1_1
	movf	FREQUENCY_H, 0
	movwf	TXREG
PollPIR1_2
	btfss	PIR1, TXIF	; Wait for transmit buffer to be empty
	goto	PollPIR1_2
	movf	DIGITLO, 0
	movwf	TXREG
PollPIR1_3
	btfss	PIR1, TXIF	; Wait for transmit buffer to be empty
	goto	PollPIR1_3
	movf	DIGITHI, 0
	movwf	TXREG
PollPIR1_4
	btfss	PIR1, TXIF	; Wait for transmit buffer to be empty
	goto	PollPIR1_4
	bsf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 1
	bcf	TXSTA, TXEN	; Disable the transmission
	bcf     STATUS, RP0	
        bcf     STATUS, RP1	; Select Bank 0
	bcf	PORTC, RC7
	goto	MainLoop
;*******************************************************************************

;**********A/D CONVERSION*******************************************************
;Sample	
;	return
;*******************************************************************************

;**********A/D SAMPLING TIME****************************************************
SampleTime
        nop
        nop
        nop
        nop
        nop
        nop
        return
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