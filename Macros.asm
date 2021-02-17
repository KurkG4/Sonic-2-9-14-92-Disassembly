; ---------------------------------------------------------------------------
; Align and pad
; input: length to align to, value to use as padding (default is 0)
; ---------------------------------------------------------------------------

align:	macro
	if (narg=1)
	dcb.b \1-(*%\1),0
	else
	dcb.b \1-(*%\1),\2
	endc
	endm

; ---------------------------------------------------------------------------
; stop the Z80
; ---------------------------------------------------------------------------

stopZ80:	macro
		move.w	#$100,(Z80_Bus_Request).l
	.wait:	btst	#0,(Z80_Bus_Request).l
		bne.s	.wait
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

resetZ80:	macro
		move.w	#$100,(Z80_Reset).l
		endm

resetZ80a:	macro
		move.w	#0,(Z80_Reset).l
		endm

; ---------------------------------------------------------------------------
; start the Z80
; ---------------------------------------------------------------------------

startZ80:	macro
		move.w	#0,(Z80_Bus_Request).l
		endm

; ---------------------------------------------------------------------------
; disable interrupts
; ---------------------------------------------------------------------------

disable_ints:	macro
		move	#$2700,sr
		endm

; ---------------------------------------------------------------------------
; enable interrupts
; ---------------------------------------------------------------------------

enable_ints:	macro
		move	#$2300,sr
		endm

; ---------------------------------------------------------------------------
; VDP Stuff
; ---------------------------------------------------------------------------

SetGfxMode:	macro mode
	   	move.w  #VDPREG_MODE4|(mode), (VDP_Control_Port)
    		endm
    		
   		; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length
	lea	(VDP_control_port).l,a5
	move.w	#VDPREG_INCR+1,(a5) ; VRAM pointer increment: $0001
	move.l	#((VDPREG_DMALEN_H|((((length)-1)&$FF00)>>8))<<16)|(VDPREG_DMALEN_L|(((length)-1)&$FF)),(a5) ; DMA length ...
	move.w	#VDPREG_DMASRC_H+$80,(a5) ; VRAM fill
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&VRAM_Plane_A_Name_Table)>>14),(a5) ; Start at ...
	move.w	#(byte)<<8,(VDP_data_port).l ; Fill with byte
.loop:	move.w	(a5),d1
	btst	#1,d1
	bne.s	.loop ; busy loop until the VDP is finished filling...
	move.w	#VDPREG_INCR+2,(a5) ; VRAM pointer increment: $0002
    endm