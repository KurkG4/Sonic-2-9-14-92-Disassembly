;===============================================================================
; Objeto 0x6C - Plataformas na Metropolis
; ->>>
;===============================================================================  
; Offset_0x022A28:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x022A50(PC, D0), D1
                jsr     Offset_0x022A50(PC, D1)
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x022A4C
                bra     Jmp_0E_To_DisplaySprite                ; Offset_0x022D7C
Offset_0x022A4C:
                bra     Jmp_11_To_DeleteObject                 ; Offset_0x022D82     
;-------------------------------------------------------------------------------   
Offset_0x022A50:
                dc.w    Offset_0x022A54-Offset_0x022A50
                dc.w    Offset_0x022B5C-Offset_0x022A50
;-------------------------------------------------------------------------------  
Offset_0x022A54:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bmi     Offset_0x022B06
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Mz_Moving_Platforms_Mappings, Obj_Map(A0) ; Offset_0x022D66, $0004
                move.w  #$63F9, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                bsr     Jmp_1B_To_ModifySpriteAttr_2P          ; Offset_0x022D8E
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.w  D0, D1
                lsr.w   #$03, D0
                andi.w  #$001E, D0
                lea     Mz_Moving_Platforms_Move_Data(PC), A2  ; Offset_0x022C46
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, Obj_Control_Var_0C(A0)                    ; $0038
                move.l  A2, Obj_Control_Var_10(A0)                       ; $003C
                andi.w  #$000F, D1
                lsl.w   #$02, D1
                move.b  D1, Obj_Control_Var_0C(A0)                       ; $0038
                move.b  #$04, Obj_Control_Var_0E(A0)                     ; $003A
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x022AE6
                neg.b   Obj_Control_Var_0E(A0)                           ; $003A
                moveq   #$00, D1
                move.b  Obj_Control_Var_0C(A0), D1                       ; $0038
                add.b   Obj_Control_Var_0E(A0), D1                       ; $003A
                cmp.b   Obj_Control_Var_0D(A0), D1                       ; $0039
                bcs.s   Offset_0x022AE2
                move.b  D1, D0
                moveq   #$00, D1
                tst.b   D0
                bpl.s   Offset_0x022AE2
                move.b  Obj_Control_Var_0D(A0), D1                       ; $0039
                subq.b  #$04, D1
Offset_0x022AE2:
                move.b  D1, Obj_Control_Var_0C(A0)                       ; $0038
Offset_0x022AE6:
                move.w  $00(A2, D1), D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034
                move.w  $02(A2, D1), D0
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_Control_Var_0A(A0)                       ; $0036
                bsr     Offset_0x022BCE
                bra     Offset_0x022B5C
Offset_0x022B06:
                andi.w  #$007F, D0
                add.w   D0, D0
                lea     (Mz_Moving_Platforms_Move_Data_01), A2 ; Offset_0x022CCA
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D1
                move.l  A0, A1
                move.w  Obj_X(A0), D2                                    ; $0008
                move.w  Obj_Y(A0), D3                                    ; $000C
                bra.s   Offset_0x022B2A
;-------------------------------------------------------------------------------
Offset_0x022B24:
                bsr     Jmp_05_To_SingleObjectLoad             ; Offset_0x022D88
                bne.s   Offset_0x022B54
Offset_0x022B2A:
                move.b  #$6C, Obj_Id(A1)                                 ; $0000
                move.w  (A2)+, D0
                add.w   D2, D0
                move.w  D0, Obj_X(A1)                                    ; $0008
                move.w  (A2)+, D0
                add.w   D3, D0
                move.w  D0, Obj_Y(A1)                                    ; $000C
                move.w  D2, Obj_Control_Var_04(A1)                       ; $0030
                move.w  D3, Obj_Control_Var_06(A1)                       ; $0032
                move.w  (A2)+, D0
                move.b  D0, Obj_Subtype(A1)                              ; $0028
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
Offset_0x022B54:
                dbra    D1, Offset_0x022B24
                addq.l  #$04, A7
                rts
Offset_0x022B5C:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x022B72
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                moveq   #$08, D3
                move.w  (A7)+, D4
                bra     Jmp_00_To_Platform_Object              ; Offset_0x022D94
Offset_0x022B72:
                move.w  Obj_X(A0), D0                                    ; $0008
                cmp.w   Obj_Control_Var_08(A0), D0                       ; $0034
                bne.s   Offset_0x022BC8
                move.w  Obj_Y(A0), D0                                    ; $000C
                cmp.w   Obj_Control_Var_0A(A0), D0                       ; $0036
                bne.s   Offset_0x022BC8
                moveq   #$00, D1
                move.b  Obj_Control_Var_0C(A0), D1                       ; $0038
                add.b   Obj_Control_Var_0E(A0), D1                       ; $003A
                cmp.b   Obj_Control_Var_0D(A0), D1                       ; $0039
                bcs.s   Offset_0x022BA4
                move.b  D1, D0
                moveq   #$00, D1
                tst.b   D0
                bpl.s   Offset_0x022BA4
                move.b  Obj_Control_Var_0D(A0), D1                       ; $0039
                subq.b  #$04, D1
Offset_0x022BA4:
                move.b  D1, Obj_Control_Var_0C(A0)                       ; $0038
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                move.w  $00(A1, D1), D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034
                move.w  $02(A1, D1), D0
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_Control_Var_0A(A0)                       ; $0036
                bsr     Offset_0x022BCE
Offset_0x022BC8:
                bsr     Jmp_0D_To_SpeedToPos                   ; Offset_0x022D9A
                rts
Offset_0x022BCE:
                moveq   #$00, D0
                move.w  #$FF00, D2
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_Control_Var_08(A0), D0                       ; $0034
                bcc.s   Offset_0x022BE2
                neg.w   D0
                neg.w   D2
Offset_0x022BE2:
                moveq   #$00, D1
                move.w  #$FF00, D3
                move.w  Obj_Y(A0), D1                                    ; $000C
                sub.w   Obj_Control_Var_0A(A0), D1                       ; $0036
                bcc.s   Offset_0x022BF6
                neg.w   D1
                neg.w   D3
Offset_0x022BF6:
                cmp.w   D0, D1
                bcs.s   Offset_0x022C20
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_Control_Var_08(A0), D0                       ; $0034
                beq.s   Offset_0x022C0C
                ext.l   D0
                asl.l   #$08, D0
                divs.w  D1, D0
                neg.w   D0
Offset_0x022C0C:
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D3, Obj_Speed_Y(A0)                              ; $0012
                swap.w  D0
                move.w  D0, Obj_Sub_Y(A0)                                ; $000A
                clr.w   $000E(A0)
                rts
Offset_0x022C20:
                move.w  Obj_Y(A0), D1                                    ; $000C
                sub.w   Obj_Control_Var_0A(A0), D1                       ; $0036
                beq.s   Offset_0x022C32
                ext.l   D1
                asl.l   #$08, D1
                divs.w  D0, D1
                neg.w   D1
Offset_0x022C32:
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
                move.w  D2, Obj_Speed(A0)                                ; $0010
                swap.w  D1
                move.w  D1, $000E(A0)
                clr.w   Obj_Sub_Y(A0)                                    ; $000A
                rts       
;-------------------------------------------------------------------------------  
Mz_Moving_Platforms_Move_Data:                                 ; Offset_0x022C46
                dc.w    Offset_0x022C4C-Mz_Moving_Platforms_Move_Data
                dc.w    Offset_0x022C76-Mz_Moving_Platforms_Move_Data
                dc.w    Offset_0x022CA0-Mz_Moving_Platforms_Move_Data
Offset_0x022C4C:
                dc.w    $0028
                dc.w    $0000, $0000, $FFEA, $000A
                dc.w    $FFE0, $0020, $FFE0, $00E0
                dc.w    $FFEA, $00F6, $0000, $0100
                dc.w    $0016, $00F6, $0020, $00E0
                dc.w    $0020, $0020, $0016, $000A
Offset_0x022C76:
                dc.w    $0028
                dc.w    $0000, $0000, $FFEA, $000A
                dc.w    $FFE0, $0020, $FFE0, $0160
                dc.w    $FFEA, $0176, $0000, $0180
                dc.w    $0016, $0176, $0020, $0160
                dc.w    $0020, $0020, $0016, $000A
Offset_0x022CA0:
                dc.w    $0028
                dc.w    $0000, $0000, $FFEA, $000A
                dc.w    $FFE0, $0020, $FFE0, $01E0
                dc.w    $FFEA, $01F6, $0000, $0200
                dc.w    $0016, $01F6, $0020, $01E0
                dc.w    $0020, $0020, $0016, $000A
;-------------------------------------------------------------------------------
Mz_Moving_Platforms_Move_Data_01:                              ; Offset_0x022CCA
                dc.w    Offset_0x022CD0-Mz_Moving_Platforms_Move_Data_01
                dc.w    Offset_0x022D02-Mz_Moving_Platforms_Move_Data_01
                dc.w    Offset_0x022D34-Mz_Moving_Platforms_Move_Data_01
Offset_0x022CD0:
                dc.w    $0007
                dc.w    $0000, $0000, $0001
                dc.w    $FFE0, $003A, $0003
                dc.w    $FFE0, $0080, $0003
                dc.w    $FFE0, $00C6, $0003
                dc.w    $0000, $0100, $0006
                dc.w    $0020, $00C6, $0008
                dc.w    $0020, $0080, $0008
                dc.w    $0020, $003A, $0008
Offset_0x022D02:
                dc.w    $0007
                dc.w    $0000, $0000, $0011
                dc.w    $FFE0, $005A, $0013
                dc.w    $FFE0, $00C0, $0013
                dc.w    $FFE0, $0126, $0013
                dc.w    $0000, $0180, $0016
                dc.w    $0020, $0126, $0018
                dc.w    $0020, $00C0, $0018
                dc.w    $0020, $005A, $0018
Offset_0x022D34:
                dc.w    $0007
                dc.w    $0000, $0000, $0021
                dc.w    $FFE0, $007A, $0023
                dc.w    $FFE0, $0100, $0023
                dc.w    $FFE0, $0186, $0023
                dc.w    $0000, $0200, $0026
                dc.w    $0020, $0186, $0028
                dc.w    $0020, $0100, $0028    
                dc.w    $0020, $007A, $0028
;-------------------------------------------------------------------------------
Mz_Moving_Platforms_Mappings:                                  ; Offset_0x022D66
                dc.w    Offset_0x022D68-Mz_Moving_Platforms_Mappings
Offset_0x022D68:
                dc.w    $0002
                dc.l    $F8050000, $0000FFF0
                dc.l    $F8050800, $08000000                                                                                                                                                       
;===============================================================================   
; Objeto 0x6C - Plataformas na Metropolis
; <<<-
;===============================================================================