;
;
; ��������� ������ � ������������ ���� ������ OWNERDRAW
;
;
        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; p��p����� ��������� ������������p�
        jumps           ; ��������� ����������� ���������

        %noincl

include         "windef.inc"
include         "kernel32.inc"
include         "user32.inc"
include         "gdi32.inc"

include         "owner.inc"
include         "util.inc"

; ������ ������ �� ��������� (��� ������ 640x480)
  LAB_FONT_SIZE = 16
  KEY_FONT_SIZE = 12
  MNU_FONT_SIZE = 16

; ����� ������������ ����
  COL_MNU_BACKGR    = 09F9F9Fh      ; ��� � ���������� ���������
  COL_MNU_SELBACKGR = 0DCBFBFh      ; ��� ����������� ������ ����
  COL_MNU_FRAME     = 03F3F3Fh      ; ���� ��������� ������ ���� � ���������� ���������
  COL_MNU_SELFRAME  = 0FFFFFFh      ; ���� ��������� ����������� ������ ����
  COL_MNU_TEXT      = 0000000h      ; ���� ������ � ���������� ���������
  COL_MNU_SELTEXT   = 00F0F0Fh      ; ���� ������ ����������� ����

; ����� ������
  COL_BTN_FRAME     = 000000h       ; ���� ������� ��������
  COL_BTN_SELFRAME  = 0FFFFFFh      ; ���� ������� ��� ������� �����
  COL_BTN_FOCUS     = 1F1F1Fh       ; ���� ������� ��� ������ �� ��������
  COL_BTN_NOPRESENT = 0C0C0C0h      ; ���� �������������� �����
  COL_BTN_REMOVED   = 08B6BFAh      ; ���� ������� � ������������ �����
  COL_BTN_TAKEN     = 0DC9E6Bh      ; ���� ����� �� ������������
  COL_BTN_BAD       = 0B6B6B6h      ; ���� ����������� �����

; ����� ��������
  COL_LAB_TEXT      = 0FFFFFFh      ; ���� ������
  COL_LAB_BACKGR    = 0A0AA82h      ; ���� ����




dataseg

udataseg
  ; ������ ��� ��������� ��������� ��������
  labBrush      HBRUSH ?        ; ����� ����
  labTextCol    dd ?            ; ���� ������
  labFont       HFONT ?         ; ����� �����
  ; ������ ��� ��������� ��������� ������
  keyFont       HFONT ?
  keyPenFrame   HPEN ?          ; ���� ������� ��������
  keyPenSel     HPEN ?          ; ���� ������� ��� ������� �����
  keyPenFocus   HPEN ?          ; ���� ������� ��� ������ �� ��������
  keyBrush      HBRUSH ?        ; �����������
                HBRUSH ?        ; ����
                HBRUSH ?        ; �����������
                HBRUSH ?        ; ����
                HBRUSH ?        ; �����������
                HBRUSH ?        ; �������� ��� �������
                HBRUSH ?        ; �����������
                HBRUSH ?        ; �������� ��� �������
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
                HBRUSH ?        ; ����������� ����
  ; ������ ��� ������������ ����
  mnuFont       HFONT ?         ; ����




codeseg


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|///////////////////////////// ������������� ///////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+
        align 4

proc own_Init
        ; ������� �����
        call    CreatePen, PS_SOLID, 1, COL_BTN_FRAME
        mov     [keyPenFrame], eax
        call    CreatePen, PS_SOLID, 1,COL_BTN_SELFRAME
        mov     [keyPenSel], eax
        call    CreatePen, PS_DOT, 1, COL_BTN_FOCUS
        mov     [keyPenFocus], eax
        mov     [labTextCol], COL_LAB_TEXT
        ; ������� �����
        call    CreateSolidBrush, COL_LAB_BACKGR
        mov     [labBrush], eax
        lea     edi, [keyBrush]
        call    CreateSolidBrush, COL_BTN_NOPRESENT     ; ���� �� ������������
        mov     [edi+0*4], eax
        mov     [edi+2*4], eax
        mov     [edi+4*4], eax
        mov     [edi+6*4], eax
        call    CreateSolidBrush, COL_BTN_REMOVED       ; ���� � ������������
        mov     [edi+1*4], eax
        mov     [edi+7*4], eax
        call    CreateSolidBrush, COL_BTN_TAKEN         ; �� ������������
        mov     [edi+3*4], eax
        mov     [edi+5*4], eax
        call    CreateSolidBrush, COL_BTN_BAD           ; ����������� ����
        lea     edi, [edi+8*4]
        mov     ecx, 8
        rep     stosd


        xor     eax, eax
        mov     [labFont], eax
        mov     [keyFont], eax
        mov     [mnuFont], eax
        call    GetSystemMetrics, SM_CYSCREEN
        call    own_ScaleFont, eax
        ret
endp

        align 4

proc own_Done
        SAFE_DELETE [keyPenFrame]
        SAFE_DELETE [keyPenSel]
        SAFE_DELETE [keyPenFocus]
        SAFE_DELETE [labBrush]
        SAFE_DELETE <[keyBrush]>
        SAFE_DELETE <[keyBrush+1*4]>
        SAFE_DELETE <[keyBrush+3*4]>
        SAFE_DELETE <[keyBrush+8*4]>
        SAFE_DELETE [labFont]
        SAFE_DELETE [keyFont]
        SAFE_DELETE [mnuFont]
        ret
endp


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|///////////////////////////////// ����� ///////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+

        align 4

proc own_ScaleFont uses ebx esi edi, @@scrHeight
  local lf: LOGFONT
        SAFE_DELETE [labFont]
        SAFE_DELETE [keyFont]
        SAFE_DELETE [mnuFont]
      ; �������������� ��������� LOGFONT
        lea     ebx, [lf]
        mov     edi, ebx
        mov     ecx, size LOGFONT
        xor     eax, eax
        rep     stosb
        mov     [(LOGFONT ebx).lfCharSet], OEM_CHARSET
        mov     [(LOGFONT ebx).lfQuality], PROOF_QUALITY
    ; ������� ���� ��� �������� ��������
        mov     eax, LAB_FONT_SIZE
        mul     [@@scrHeight]
        xor     edx, edx
        mov     ecx, 480
        div     ecx             ; height = (ScrHeight * FONT_SIZE) / 480
        neg     eax
        mov     [(LOGFONT ebx).lfHeight], eax
        mov     [(LOGFONT ebx).lfPitchAndFamily], VARIABLE_PITCH or FF_DONTCARE
        call    CreateFontIndirect, ebx
        mov     [labFont], eax

    ; ������� ���� ��� ������
        mov     eax, KEY_FONT_SIZE
        mul     [@@scrHeight]
        xor     edx, edx
        mov     ecx, 480
        div     ecx
        neg     eax
        mov     [(LOGFONT ebx).lfHeight], eax
        mov     [(LOGFONT ebx).lfPitchAndFamily], FIXED_PITCH or FF_MODERN
        call    CreateFontIndirect, ebx
        mov     [keyFont], eax

    ; ������� ���� ��� ����
        mov     eax, MNU_FONT_SIZE
        mul     [@@scrHeight]
        xor     edx, edx
        mov     ecx, 480
        div     ecx
        neg     eax
        mov     [(LOGFONT ebx).lfCharSet], RUSSIAN_CHARSET
        mov     [(LOGFONT ebx).lfHeight], eax
        mov     [(LOGFONT ebx).lfPitchAndFamily], VARIABLE_PITCH or FF_SWISS;FF_DONTCARE
        call    CreateFontIndirect, ebx
        mov     [mnuFont], eax
        ret
endp

proc own_GetLabFont
        mov     eax, [labFont]
        ret
endp
proc own_GetKeyFont
        mov     eax, [keyFont]
        ret
endp


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|//////////////////////////////// �������� /////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|//////////////////////////////// ������� //////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+

        align 4
; ���������� WM_CTLCOLORSTATIC
; �� ������:
;       ZF      - 0 - ��������� ����������
;                 1 - ��������� �� ���, ����������
proc stc_OnCtlColorStatic, @@hWnd, @@hDC
        call    GetWindowLong, [@@hWnd], GWL_ID
        cmp     eax, ID_LABEL_END
        ja      @@false
        cmp     eax, ID_LABEL
        jb      @@false
        call    SetBkMode, [@@hDC], TRANSPARENT
        call    SetTextColor, [@@hDC], [labTextCol]
        call    SelectObject, [@@hDC], [labFont]
        xor     eax, eax
        or      eax, [labBrush]
        ret
    @@false:
        xor     eax, eax
        ret
endp


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|///////////////////////////////// ������ //////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+

; ���������� WM_DRAWITEM ��� BUTTON
; �� ������:
;       ZF      - 0 - ��������� ����������
;                 1 - ��������� �� ���, ����������
proc btn_OnDrawItem uses ebx esi edi, @@lpItem
  local szText: TCHAR:32
        mov     ebx, [@@lpItem]
        cmp     [(DRAWITEMSTRUCT ebx).CtlType], ODT_BUTTON
        jne     @@false
        mov     eax, [(DRAWITEMSTRUCT ebx).CtlID]
        cmp     eax, ID_KEY
        jb      @@false
        cmp     eax, ID_KEY_END
        ja      @@false
        ; �������� ���� ��������� ������
        call    GetWindowLong, [(DRAWITEMSTRUCT ebx).hwndItem], GWL_USERDATA
        mov     edi, eax                ; edi - flag

        test    edi, KEY_TWOLINE
        jnz     @@draw_two
        and     edi, KEY_PRESENT or KEY_ALARM or KEY_FLASH or KEY_BAD
        ; �������� ����� � ���� �������
        mov     eax, [keyPenFrame]
        test    [(DRAWITEMSTRUCT ebx).itemState], ODS_SELECTED
        jz      @@set_pen
        mov     eax, [keyPenSel]
    @@set_pen:
        call    SelectObject, [(DRAWITEMSTRUCT ebx).hDC], eax
        ; ������������� ����� ����
        mov     eax, [keyBrush+edi*4]
        call    SelectObject, [(DRAWITEMSTRUCT ebx).hDC], eax
        ; ������������ �������
        lea     eax, [(DRAWITEMSTRUCT ebx).rcItem]
        call    Rectangle, [(DRAWITEMSTRUCT ebx).hDC], [(RECT eax).left], [(RECT eax).top], [(RECT eax).right], [(RECT eax).bottom]
        ; ������� �������, ���� ��� �����
    @@draw_text:
        test    edi, KEY_PRESENT
        jz      @@done
        call    SelectObject, [(DRAWITEMSTRUCT ebx).hDC], [keyFont]
        push    eax
        lea     esi, [szText]
        call    GetWindowText, [(DRAWITEMSTRUCT ebx).hwndItem], esi, 16
        call    SetBkMode, [(DRAWITEMSTRUCT ebx).hDC], TRANSPARENT
        lea     eax, [(DRAWITEMSTRUCT ebx).rcItem]
        call    DrawText, [(DRAWITEMSTRUCT ebx).hDC], esi, -1, eax, DT_CENTER or DT_SINGLELINE or DT_VCENTER
        pop     eax
        call    SelectObject, [(DRAWITEMSTRUCT ebx).hDC], eax
    @@done:
        or      eax, -1
        ret

  ; �� ����� ��� ������
  ;   ebx       - DRAWITEMSTRUC
  ;   eax       - ID
  ;   edx       - lp TAB
  ;   edi       - flags
  @@draw_two:
        ; ���� ��������
        ; ������� �������, ���� ��� �����
        jmp     @@draw_text


    @@false:    ; ��������� �� ���, ����������
        xor     eax, eax
        ret
endp



;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|////////////////////////////////// ���� ///////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+

; ���������� WM_MEASUREITEM ��� MENU
; �� ������:
;       ZF      - 0 - ��������� ����������
;                 1 - ��������� �� ���, ����������
proc mnu_OnMeasureItem uses esi edi ebx, @@hWnd, @@lpItem
  local @@s: SIZEL
        mov     ebx, [@@lpItem]         ; ebx = (MEASUREITEMSTRUCT *)lParam
        cmp     [(MEASUREITEMSTRUCT ebx).CtlType], ODT_MENU
        jne     @@false
        call    GetDC, [@@hWnd]
        mov     esi, eax
        call    SelectObject, eax, [mnuFont]
        push    eax
        call    lstrlen, [(MEASUREITEMSTRUCT ebx).itemData]
        lea     edx, [@@s]
        call    GetTextExtentPoint32, esi, [(MEASUREITEMSTRUCT ebx).itemData], eax, edx
        pop     eax
        call    SelectObject, esi, eax
        call    ReleaseDC, [@@hWnd], esi
        mov     eax, [@@s.x]
        add     eax, 3*2
        mov     [(MEASUREITEMSTRUCT ebx).itemWidth], eax
        mov     eax, [@@s.y]
        mov     edx, eax
        shr     edx, 2
        add     eax, edx
        mov     [(MEASUREITEMSTRUCT ebx).itemHeight], eax
        or      eax, -1
        ret
    @@false:    ; ��� ��  ���, ����������
        xor     eax, eax
        ret
endp


; ���������� WM_DRAWITEM ��� MENU
; �� ������:
;       ZF      - 0 - ��������� ����������
;                 1 - ��������� �� ���, ����������
proc mnu_OnDrawItem uses esi edi ebx, @@lpItem
  local @@oldFnt
        mov     edi, [@@lpItem]         ; edi - (DRAWITEMSTRUCT *)lParam
        cmp     [(DRAWITEMSTRUCT edi).CtlType], ODT_MENU
        jne     @@false
        call    SelectObject, [(DRAWITEMSTRUCT edi).hDC], [mnuFont]
        mov     [@@oldFnt], eax
        mov     ebx, [(DRAWITEMSTRUCT edi).itemData]
        lea     esi, [(DRAWITEMSTRUCT edi).rcItem]
        cmp     [(DRAWITEMSTRUCT edi).itemAction], ODA_SELECT ; ���� ��������� ��������� ���������?
        je      @@select
        cmp     [(DRAWITEMSTRUCT edi).itemAction], ODA_DRAWENTIRE
        jne     @@exit
    ; ������ ������� ����
    @@draw_normal:
        call    draw_Rect, [(DRAWITEMSTRUCT edi).hDC], esi, COL_MNU_BACKGR
        call    draw_Frame, [(DRAWITEMSTRUCT edi).hDC], esi, COL_MNU_FRAME
        call    draw_Text, ebx, [(DRAWITEMSTRUCT edi).hDC], esi, COL_MNU_TEXT
    @@exit:
        call    SelectObject, [(DRAWITEMSTRUCT edi).hDC], [@@oldFnt]
        or      eax, -1
        ret
    ; ������ ������� � ���������� ���������� ���������
    @@select:
        test    [(DRAWITEMSTRUCT edi).itemState], ODS_SELECTED
        jz      @@draw_normal
        call    draw_Rect, [(DRAWITEMSTRUCT edi).hDC], esi, COL_MNU_SELBACKGR
        call    draw_Frame, [(DRAWITEMSTRUCT edi).hDC], esi, COL_MNU_SELFRAME
        call    draw_Text, ebx, [(DRAWITEMSTRUCT edi).hDC], esi, COL_MNU_SELTEXT
        jmp     @@exit

    @@false:    ; ��� �� ���, ����������
        xor     eax, eax
        ret
endp


proc draw_Rect, @@hDC, @@lpRect, @@col
        call    CreateSolidBrush, [@@col]
        mov     [@@col], eax
        mov     edx, [@@lpRect]
        dec     [(RECT edx).right]
        dec     [(RECT edx).bottom]
        call    FillRect, [@@hDC], edx, [@@col]
        mov     edx, [@@lpRect]
        inc     [(RECT edx).right]
        inc     [(RECT edx).bottom]
        call    DeleteObject, [@@col]
        ret
endp

proc draw_Frame uses ebx esi edi, @@hDC, @@lpRect, @@col
        call    CreatePen, PS_SOLID, 0, [@@col]
        call    SelectObject, [@@hDC], eax
        push    eax
        mov     ebx, [@@lpRect]
        call    MoveToEx, [@@hDC], [(RECT ebx).left], [(RECT ebx).top], NULL
        mov     esi, [(RECT ebx).right]
        dec     esi
        mov     edi, [(RECT ebx).bottom]
        dec     edi
        call    LineTo, [@@hDC], esi, [(RECT ebx).top]
        call    LineTo, [@@hDC], esi, edi
        call    LineTo, [@@hDC], [(RECT ebx).left], edi
        call    LineTo, [@@hDC], [(RECT ebx).left], [(RECT ebx).top]
        pop     eax
        call    SelectObject, [@@hDC], eax
        call    DeleteObject, eax
        ret
endp

proc draw_Text uses ebx esi edi, @@lpszText, @@hDC, @@lpRect, @@col
;        call    SelectObject, [@@hDC], [hFont]
        call    SetTextColor, [@@hDC], [@@col]
        call    SetBkMode, [@@hDC], TRANSPARENT
        call    DrawText, [@@hDC], [@@lpszText], -1, [@@lpRect], DT_SINGLELINE or DT_CENTER or DT_VCENTER
        ret
endp



end
