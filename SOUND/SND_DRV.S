;--------------------------------------------------------------------
; Id's SNES sound driver - decoded from 'driver.s' provided by Id in
; an 'encoded' state (simply and each character with $7F to get in
; ASCII range - for some reason this was the ONLY file provided by
; Id that was encoded...).  It includes 'SPC700.MACS' which was not
; provided by Id but it appears to be only a macro file so the SNES
; sound chip code could be compiled by their regular 65816 assembler!
;--------------------------------------------------------------------


		LST	OFF
		TR	ON
		USE	SPC700.MACS	;Write this in SPC700
		REL

Defaults	=	$700

* Sample data starts at $900



Channel		DS	1	;Current channel being mangled
HardChannel	DS	1	;Channel value #16
SoundNum	DS	1	;Which sound effect?
Pointer		DS	2	;Temp pointer
DownAddr	DS	2	;Download pointer
channelsample	DS	8	;Sample to play for note on

Port1		ds	1
Port2		ds	1
Port3		ds	1

DSPRegAdr	=	$F2
DSPData		=	$F3
HPort0		=	$F4
HPort1		=	$F5
HPort2		=	$F6
HPort3		=	$F7
Timer0		=	$FA
Counter0	=	$FD

		LDXI	#$FF		;Reset stack ($1FF)
		XTXS

		XTAX			;Clear index
]A		STA[XI] 		;Clear out my direct page
		CPXI	#$F0		;All done?
		BNE	]A		;Loop

		LDXI	#DSPInitRegAdr-DSPInitRegVal-1
]A		LDA16X	DSPInitRegAdr	;Get Register
		XTAY
		LDA16X	DSPInitRegVal	;Set it to this value
		CALL	SetDSPYA	;Write the value
		DECX			;Count down
		BPL	]A		;Loop

		XTAY
		STYA	HPort0
		STYA	HPort2


MainLoop	LDA8	HPort3
		CMP8	HPort3		;Check if the port is stable
		BNE	MainLoop	;Not stable, loop (needed?)
		CMP8	Port3		;Is the command new?
		BEQ	MainLoop	;No

		STYA	Port0
		LDYA	HPort2
		STYA	Port2
		XTYA			;Port3 value in A
		STA8	HPort3 		;Tell SNES command is fetched

		ASLA
		XTAX
		XJMP[16X] CMDTABLE

		DA	CMD_Assign,CMD_Bend,CMD_NoteOn,MainLoop
		DA	MainLoop,MainLoop,MainLoop,MainLoop
		DA	MainLoop,MainLoop,MainLoop,MainLoop


* 6C (flg) was 2F
* 0D (efb) was 60
* 6D (esa) was >SoundList
* 7D (edl) was 2
* HEX FF081724241708FF ;Filter for echo sounds
DSPInitRegVal	HEX	7F7F000000002000000000
		DB	>SoundList,0,0
*		HEX	FF081724241708FF	;Filter for echo sounds
		HEX	7F00000000000000	;Filter for normal sounds

		HEX	5D6D7D
		HEX	0F1F2F3F4F5F6F7F

		STA8	DSPData		;Save value
		RET			;Exit

		STA8	DSPData		;Save value
		RET			;Exit

CMD_Assign	LDX8	Port0		;Channel
		LDA8	Port1		;Sample for channel
		STA8X	channelsample
		XJMP	MainLoop

CMD_NoteOff
*
		LDX8	Port0		;Ch
		LDA16X	Bitty		;Get voice to shut down
		LDYI	#$5C		;Key off register
		CALL	SetDSPYA	;Shut down old voice

]A		DECY
		BNE	]A
		XJMP	MainLoop

CMD_Bend	LDA8	Port0		;Channel number
		ASLA
		ASLA
		ASLA
		ASLA
		XTAX
		INCX
		INCX
		LDA8	Port1		;Pitch low
		CALL	SetDSPXA	;Pitch low
		INCX
		LDA8	Port2		;Pitch high
		CALL	SetDSPXA	;Pitch high ($562 is 11k)
		XJMP	MainLoop

CMD_NoteOn
*
		LDA8	Port3		;Bits 4-7 are chanel number
		ANDI	#$70
		LSRA
		LSRA
		LSRA
		LSRA
		STA8	Channel
		XTAX

		STA8	SoundNum 	;Save sound #

		LDYI	#$5C 		;Key off register
		CALL	SetDSPYA	;Shut down old voice

		LDYI	#OFFCOUNT
]A		DECY
		BNE	]A

		ASLA			;Mul by 16
		ASLA
		ASLA
		ASLA
		STA8	HardChannel	;Save channel (HardWare)
		XTAX			;Use index to DSP

*
		ANDI	#3		;Command 0 is stereo volume, 5 is mono
		BEQ	stereo
		LDA8	Port2		;Full 7 bit volume
		CALL	SetDSPXA	;Left volume
		INCX
		CALL	SetDSPXA	;Right volume
		INCX
		XJMP	pitch

stereo		LDA8	Port2		;Command volume
		LSRA
		ANDI	#$78
		CALL	SetDSPXA	;Left volume
		INCX
		LDA8	Port2		;Command volume
		ASLA
		ASLA
		ASLA
		ANDI	#$78
		CALL	SetDSPXA	;Right volume
		INCX

pitch		LDA8	Port0		;Pitch low
		CALL	SetDSPXA	;Pitch low
		INCX
		LDA8	Port1		;Pitch high
		CALL	SetDSPXA	;Pitch high ($562 is 11k)
		INCX
		LDA8	SoundNum
		CALL	SetDSPXA	;Sample number
		INCX
		LDAI	#$FE
		CALL	SetDSPXA	;ADSR 1
		INCX
		LDAI	#$E9
		CALL	SetDSPXA	;ADSR 2
		INCX
		LDAI	#$0
		CALL	SetDSPXA	;Gain

*
		LDYI	#$5C		;Key off register
		CALL	SetDSPYA	;Finish shutting down old voice

*
		LDA16X	Bitty		;Get voice to start up
		LDYI	#$4C		;Key on register
		CALL	SetDSPYA	;Set and exit
		XJMP	MainLoop


CMD_SetAddr	LDA8	Port0
		STA8	DownAddr
		LDA8	Port1
		STA8	DownAddr+1
		XJMP	MainLoop

CMD_Download	LDYI	#0
		LDA8	Port0
		STA[8]Y DownAddr
		INCY
		LDA8	Port1
		STA[8]Y DownAddr
		INCY
		LDA8	Port2
		STA[8]Y DownAddr

		XCLC
		ADCI	#3
		STA8	DownAddr
		LDA8	DownAddr+1
		ADCI	#0
		STA8	DownAddr+1
		XJMP	MainLoop



;End
