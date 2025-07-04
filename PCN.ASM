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

include         "pcn.inc"
include         "auxport.inc"
include         "tabctrl.inc"
include         "util.inc"
include         "queue.inc"

include         "console.inc"

struc LED
  tcCode        dd ?
  lpszText      dd ?
ends

  COL_RED       = 3060FFh
  COL_GREEN     = 60FF30h
  COL_BLUE      = 0FF9030h

; �������������� ���� � ���������
  ID_PCN        = 6000
  ID_DISP       = 6002  ; ������ ��������� �������
  ID_LED        = 6010  ; ������ ����������� ����������
  ID_HIST       = 6050  ; ���� ���������


; ������ ���������������
  WS_DISP       = WS_VISIBLE or SS_SUNKEN or SS_CENTERIMAGE or WS_CHILD or SS_CENTER
  WS_LED        = WS_CHILD or WS_VISIBLE or BS_OWNERDRAW
  WS_HIST       = WS_CHILD or WS_VISIBLE or LBS_NOSEL or LBS_NOINTEGRALHEIGHT or WS_CAPTION or LBS_OWNERDRAWFIXED or LBS_HASSTRINGS

; ������� (�� ����� 640x480)
  DISP_FONT_SIZE= 64
  LED_FONT_SIZE = 12
  HIST_FONT_SIZE= 11

; ���� GWL_USERDATA ������ "�����������"
  LED_COLMASK   = 00000011b     ; ����� ��������� ����� ����� ������
  LED_BLINK     = 00000100b     ; ��� "��������" ������
  LED_TIMERS    = 10000000b     ; ������ �� �������
  LED_SOUND     = 01000000b
  ; �������������� ����� ������
  LED_RS        = (0 or LED_SOUND) shl 8     ; ������� ������ �� ������
  LED_GS        = (1 or LED_SOUND) shl 8     ; ������� ������ �� ������
  LED_BS        = (2 or LED_SOUND) shl 8     ; ����� ������ �� ������
  LED_R         = 0 shl 8                    ; ������� ������ ��� ������
  LED_G         = 1 shl 8                    ; ������� ������ ��� ������
  LED_B         = 2 shl 8                    ; ����� ������ ��� ������


dataseg
  tmrIsRun      dd 0

  TEXT s1,  "������"
  TEXT s2,  "����. ���"
  TEXT s3,  "����. ����"
  TEXT s4,  "���������"
  TEXT s5,  "������� ��"
  TEXT s6,  "��� ��"
  TEXT s7,  "�����"
  TEXT s8,  "�� ����"
  TEXT s9,  "����"
  TEXT s10, "����"
  TEXT s11, "���������"
  TEXT s12, "�������"
  TEXT s13, "������ ��"
  TEXT s14, "����� ��"
  TEXT s15, "����� ����"
  TEXT s16, "����� ����"

  ledTbl        LED <TC_ALERT or LED_RS, s12>       ; "�������"
                LED <TC_ACCIDENT or LED_RS, s1>     ; "������"
                LED <TC_NOTTAKEN or LED_RS, s8>     ; "������"
                LED <TC_KZ or LED_RS, s4>           ; "���������"
                LED <TC_ATTIRE or LED_B, s7>        ; "�����"
                LED <TC_TYPEUO or LED_B, s6>        ; "��� ��"
                LED <TC_TAKEN or LED_G, s10>        ; "����"
                LED <TC_UOOPEN or LED_RS, s13>      ; "������ ��"
                LED <TC_REMOVED or LED_R, s9>       ; "����"
                LED <TC_UOCLOSE or LED_RS, s14>     ; "������ ��"
                LED <TC_KEYCONNECT or LED_G, s2>    ; "����. ���"
                LED <TC_REPLACEMENT or LED_RS, s5>  ; "������� ��"
                LED <TC_KEYDISCONNECT or LED_RS, s3>; "����. ����"
                LED <TC_RTRFAILURE or LED_RS, s15>  ; "����� ����."
                LED <TC_TEHNOLOGICAL or LED_B, s11> ; "���������"
                LED <TC_RTRRESTORE or LED_G, s16>   ; "�����. ����."
        ledCnt  = ($-ledTbl) / (size LED)

                LED <TC_REMOVEDSILENT, s9>
                LED <TC_TAKENSILENT, s10>
        ledMax  = ($-ledTbl) / (size LED)

udataseg
  hPcn          HWND ?          ; ����� ���� ���
  hDisp         HWND ?          ; ����� "�������"
  hLed          HWND ledCnt dup(?)  ; ������ "�����������"
  hHist         HWND ?          ; ����� ���� ���������


  ; "�������"
  dispCol       dd ?            ; ���� ������
  dispBrush     HBRUSH ?        ; ����� ����
  dispFont      HFONT ?


  ; "����������"
  ledXlat       dd TC_MAX dup(?); ������� ������������� ����� �� � ������ ���

  ledCol        dd ?            ; ���� ������ ������
  ledPen        HPEN ?          ; ���� �����
  ledBrush      HBRUSH 8 dup(?) ; ����� ����: (���� GWL_USERDATA: 0-1 - ����� �����, 2 - �������������)
                                ;   - ����
                                ;   - ����
                                ;   - ����
                                ;   - ����
                                ;   - ��     (���. �������������)
                                ;   - ���    (���. �������������)
                                ;   - ���    (���. �������������)
  ledFont       HFONT ?

  ; ��������
  hisCols       dd TC_MAX dup(?); ����� ��� ���������
  hisBrush      HBRUSH ?
  hisFont       HFONT ?
  hisMaxItems   dd ?            ; ����. ���������� ������� ��������� � ������


  ; ������� ���������
  lpQueue       dd ?

  lenMsg        db ?
  curMsg        dd ?,?,?,?
  curLed        HWND ?

codeseg


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|///////////////////////////// ������������� ///////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+
        align 4

; �� �����:
;   hParen      - ����� �������� ����
proc pcn_Init uses ebx esi edi, @@hParen
        xor     esi, esi
        move    edi, "PCNEmulClass"
        mov     [hPcn], esi
        call    GetModuleHandle, esi
        mov     ebx, eax        ; ebx - hInstance
        push    esi             ; wc_hIconSm
        push    edi             ; wc_lpszClassName
        push    esi             ; wc_lpszMenuName
        call    GetStockObject, GRAY_BRUSH
        push    eax
        call    LoadCursor, NULL, IDC_ARROW
        push    eax             ; wc_hCursor
        push    esi             ; wc_hIcon
        push    ebx             ; wc_hInstance
        push    esi             ; wc_cbWndExtra
        push    esi             ; wc_cbClsExtra
        push    offset PcnProc  ; wc_lpfnWndProc
        push    CS_HREDRAW or CS_VREDRAW ; wc_style
        push    size WNDCLASSEX ; wc_cbSize
        ; p�����p�p��� ����� ������������ ����
        call    RegisterClassEx, esp
        add     esp, size WNDCLASSEX
        and     eax, 0ffffh
        jz      @@err
        ; ������� �����, �����, �����
        call    pcn_CreatePaints
        move    edx, "���"
        call    CreateWindowEx, WS_EX_TOOLWINDOW or WS_EX_CLIENTEDGE, edi, edx, \
                                WS_CAPTION or WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN, \
                                esi, esi, esi, esi, \
                                [@@hParen], ID_PCN, ebx, esi
        mov     [hPcn], eax
        or      eax, eax
        jz      @@err

        call    pcn_ScaleFont

        ; ������� ������� ��� ������� ���, �� 128 ����
        call    queue_Create, 128
        mov     [lpQueue], eax
        ret

    @@err:
        invoke  err_ShowLastError, [@@hParen], "PCN.ASM", "pcn_Init()"
        ret
endp

        align 4

proc pcn_Done
        call    queue_Destroy, [lpQueue]
        call    pcn_DestroyPaints
        ret
endp

; ���������� WM_SIZE �� �������� ����
proc pcn_OnSize uses ebx, @@x, @@y, @@width, @@height
  local @@r: RECT
        call    MoveWindow, [hPcn], [@@x], [@@y], [@@width], [@@height], 1
        lea     eax, [@@r]
        call    GetClientRect, [hPcn], eax
        ; ������������� "�������"
        call    disp_SetPos, [@@r.left], [@@r.top], [@@r.right]
        add     [@@r.top], eax
        ; "����������"
        call    led_SetPos, [@@r.left], [@@r.top], [@@r.right]
        add     eax, [@@r.top]
        ; � ���� ���������
        call    his_SetPos, [@@r.left], eax, [@@r.right]
        ret
endp


proc pcn_CreatePaints uses edi
        ; ����� � ����� ��� "�������"
        mov     [dispCol], 022421bh
        call    CreateSolidBrush, 0bC9F9Fh
        mov     [dispBrush], eax

        ; ����� � ����� ��� "�����������"
        mov     [ledCol], 0FFEFEFh
        call    CreatePen, PS_SOLID, 1, 0F1F1F1h
        mov     [ledPen], eax

        lea     edi, [ledBrush]
        call    CreateSolidBrush, 0505050h
        mov     ecx, 4
        rep     stosd
        call    CreateSolidBrush, 03030F0h
        stosd
        call    CreateSolidBrush, 030F030h
        stosd
        call    CreateSolidBrush, 0F03030h
        stosd
        call    CreateSolidBrush, 0303030h
        stosd

        ; ��� ���� ��������
        mov     [hisCols+0*4], COL_RED         ; "������"
        mov     [hisCols+1*4], COL_GREEN       ; "����������� ����������"
        mov     [hisCols+2*4], COL_GREEN       ; "����������� ���������"
        mov     [hisCols+3*4], COL_RED         ; "���������"
        mov     [hisCols+4*4], COL_RED         ; "������� ��"
        mov     [hisCols+5*4], COL_GREEN       ; "������������ ��� ��"
        mov     [hisCols+6*4], COL_BLUE        ; "�����"
        mov     [hisCols+7*4], COL_RED         ; "�� ����"
        mov     [hisCols+8*4], COL_RED         ; "����"
        mov     [hisCols+9*4], COL_GREEN       ; "����"
        mov     [hisCols+10*4], COL_BLUE       ; "���������������"
        mov     [hisCols+11*4], COL_RED        ; "�������"
        mov     [hisCols+12*4], COL_RED        ; "�������� ��"
        mov     [hisCols+13*4], COL_GREEN      ; "�������������� ��"
        mov     [hisCols+14*4], COL_RED        ; "����� �������������"
        mov     [hisCols+15*4], COL_GREEN      ; "�������������� �������������"
        mov     [hisCols+16*4], COL_RED        ; "����" (��� �����)
        mov     [hisCols+17*4], COL_GREEN      ; "����" (��� �����)
        call    GetStockObject, BLACK_BRUSH
        mov     [hisBrush], eax
        ; �������������� �����
        xor     eax, eax
        mov     [dispFont], eax
        mov     [ledFont], eax
        mov     [hisFont], eax
        ret
endp

proc pcn_DestroyPaints
        SAFE_DELETE [ledPen]

        SAFE_DELETE [dispBrush]
        SAFE_DELETE [ledBrush]
        SAFE_DELETE [ledBrush+16]
        SAFE_DELETE [ledBrush+20]
        SAFE_DELETE [ledBrush+24]
        SAFE_DELETE [ledBrush+28]

        SAFE_DELETE [dispFont]
        SAFE_DELETE [ledFont]
        SAFE_DELETE [hisFont]
        ret
endp



proc pcn_ScaleFont uses ebx esi edi
  local @@h
  local lf: LOGFONT
        SAFE_DELETE [dispFont]
        SAFE_DELETE [hisFont]
        SAFE_DELETE [ledFont]
        call    GetSystemMetrics, SM_CYSCREEN
        mov     [@@h], eax
      ; �������������� ��������� LOGFONT
        lea     ebx, [lf]
        mov     edi, ebx
        mov     ecx, size LOGFONT
        xor     eax, eax
        rep     stosb
        mov     [(LOGFONT ebx).lfCharSet], RUSSIAN_CHARSET
        mov     [(LOGFONT ebx).lfQuality], PROOF_QUALITY
        ; ������� ���� ��� "�������"
        mov     eax, DISP_FONT_SIZE
        mul     [@@h]
        xor     edx, edx
        mov     ecx, 480
        div     ecx
        neg     eax
        mov     [(LOGFONT ebx).lfHeight], eax
        mov     [(LOGFONT ebx).lfPitchAndFamily], VARIABLE_PITCH or FF_DONTCARE
        call    CreateFontIndirect, ebx
        mov     [dispFont], eax
        call    SendMessage, [hDisp], WM_SETFONT, eax, 0
        ; ������� ���� ��� ���� ���������
        mov     eax, HIST_FONT_SIZE
        mul     [@@h]
        xor     edx, edx
        mov     ecx, 480
        div     ecx
        neg     eax
        mov     [(LOGFONT ebx).lfHeight], eax
        mov     [(LOGFONT ebx).lfPitchAndFamily], VARIABLE_PITCH or FF_SWISS;FF_DONTCARE
        call    CreateFontIndirect, ebx
        mov     [hisFont], eax
        call    SendMessage, [hHist], WM_SETFONT, eax, 0
        ; ������� ���� ��� "�����������"
        mov     eax, LED_FONT_SIZE
        mul     [@@h]
        xor     edx, edx
        mov     ecx, 480
        div     ecx
        neg     eax
        mov     [(LOGFONT ebx).lfHeight], eax
        mov     [(LOGFONT ebx).lfPitchAndFamily], VARIABLE_PITCH or FF_SWISS;FF_DONTCARE
        call    CreateFontIndirect, ebx
        mov     [ledFont], eax
        lea     esi, [hLed]
        mov     ebx, ledCnt
        mov     edi, eax
    @@setled:
        lodsd
        call    SendMessage, eax, WM_SETFONT, edi, 0
        dec     ebx
        jnz     @@setled

        ret
endp

; ��������� ������ ������ �������� ������
; �� ������:
;       eax     - ������ ������ � ��������
;       edx     - ������ ������ � ��������
proc pcn_GetSize uses ebx, @@lpszText, @@hFnt
  local @@s: SIZEL
        call    GetDC, [hPcn]
        mov     ebx, eax
        call    SelectObject, ebx, [@@hFnt]
        push    eax
        call    lstrlen, [@@lpszText]
        lea     edx, [@@s]
        call    GetTextExtentPoint32, ebx, [@@lpszText], eax, edx
        pop     eax
        call    SelectObject, ebx, eax
        call    ReleaseDC, [hPcn], ebx
        mov     eax, [@@s.x]
        mov     edx, [@@s.y]
        ret
endp


; ���������� ���������� ����������� ������
proc pcn_GetMinWidth
        invoke  pcn_GetSize, "������� ��", [ledFont]
        add     eax, 4
        shl     eax, 1
        add     eax, 16
        push    eax
        invoke  pcn_GetSize, "00:00:00  000 - ������� ��", [hisFont]
        add     eax, 16
        ; �������� �� ���� ���������
        pop     edx
        cmp     eax, edx
        jae     @@exit
        xchg    eax, edx
    @@exit:
        ret
endp


; �������� � ������� ��� ��������� �� �� �������������
; �� �����:
;   HI(wParam)  - ������������
;   LO(wParam)  - ����� �����
;   HI(lParam)  - LO(����� ������), HI(hoz)
;   LO(lParam)  - cmd
proc pcn_OnReceive, @@wParam, @@lParam
  local @@msg: dword: 4
        ; ����������� ����� ����������� � ����������
        mov     eax, [@@wParam]
        mov     edx, eax
        shr     eax, 16                 ; eax - rtr [1..8]
        and     edx, 0FFFFh             ; edx - key [0..119]
        call    tab_RtrToAbs, eax, edx
        mov     ecx, [@@lParam]
        mov     edx, ecx
        shr     edx, 16                 ; edx - lobyte(line), hibyte(hoz)
        and     ecx, 0FFFFh             ; ecx - cmd
        ; ������ ��� ��� � �������
        mov     [@@msg], eax
        mov     [@@msg+4], ecx
        mov     [@@msg+8], edx
        ; ���������� � ���� ���������
        call    his_Insert, eax, ecx
        ; ���������, ����� �� ��� ������ ���������������
        mov     ecx, [@@msg+4]
        cmp     ecx, TC_REMOVEDSILENT
        je      @@noalarm
        cmp     ecx, TC_TAKENSILENT
        jne     @@alarm
    @@noalarm:
        ret     ; ������ ����� �� ���������

    @@alarm:
        lea     eax, [@@msg]
        call    queue_Put, [lpQueue], eax, 4*3

        cmp     [tmrIsRun], 0
        jne     @@exit
        call    SetTimer, [hPcn], 0, 250, NULL
    @@exit:
        ret
endp


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|///////////////////////////////// ������� /////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+
; ������ ��������� � ������ ����
; �� ������:
;   eax         - ������ ����
proc disp_SetPos uses ebx, @@x, @@y, @@width
  local @@s: SIZEL
        invoke  pcn_GetSize, "0", [dispFont]
        push    edx
        call    MoveWindow, [hDisp], [@@x], [@@y], [@@width], edx, 1
        pop     eax
        ret
endp

; ���������� WM_CTLCOLORSTATIC
proc disp_OnCtlColorStatic, @@hWnd, @@hDC
        call    GetWindowLong, [@@hWnd], GWL_ID
        cmp     eax, ID_DISP
        jne     @@false
        call    SetBkMode, [@@hDC], TRANSPARENT
        call    SetTextColor, [@@hDC], [dispCol]
        xor     eax, eax
        or      eax, [dispBrush]
        ret
    @@false:
        xor     eax, eax
        ret
endp

proc disp_ShowNum uses edi, @@num
  local @@t: TCHAR: 8
        mov     eax, [@@num]
        lea     edi, [@@t]
        call    util_ID2Name
        xor     eax, eax
        stos    [large TCHAR edi]
        lea     eax, [@@t]
        call    SetWindowText, [hDisp], eax
        ret
endp

proc disp_Clear
        invoke  SetWindowText, [hDisp], ""
        ret
endp

proc disp_ShowTxt, @@lpszTxt
        call    SetWindowText, [hDisp], [@@lpszTxt]
        ret
endp

;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|//////////////////////////////// ���������� ///////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+
; ������ ��������� � ������ ����
; �� ������:
;   eax         - ������ ����
proc led_SetPos uses ebx esi edi, @@x, @@y, @@width
  local @@h, @@w
  local @@x2, @@oy
        mov     eax, [@@y]
        mov     [@@oy], eax
        invoke  pcn_GetSize, "0", [ledFont]
        mov     eax, edx
        shr     eax, 2
        add     edx, eax
        mov     [@@h], edx      ; ������ = ������ + (������ / 4)
        mov     ecx, [@@width]
        shr     ecx, 1
        mov     [@@w], ecx      ; ������ ������ ��������
        sub     [@@width], ecx  ; ������ ������� ��������
        add     ecx, [@@x]
        mov     [@@x2], ecx
        mov     ebx, ledCnt
        lea     esi, [hLed]
    @@loop:
        ; ������� �����
        lodsd
        call    MoveWindow, eax, [@@x], [@@y], [@@w], [@@h], 1
        dec     ebx
        jz      @@exit          ; <- ���� ��������, �� ����� ���������� �� ������� � �������� ����.
        ; ������ ������
        lodsd
        call    MoveWindow, eax, [@@x2], [@@y], [@@width], [@@h], 1
        mov     eax, [@@h]
        add     [@@y], eax
        dec     ebx
        jnz     @@loop
    @@exit:
        mov     eax, [@@y]      ; ���������� ������ ��������
        sub     eax, [@@oy]
        ret
endp


; ���������� WM_DRAWITEM

proc led_OnDrawItem uses ebx esi edi, @@lpItem: ptr DRAWITEMSTRUCT
  local szText: TCHAR:16
        ; ���������, ��� �� ���������
        mov     ebx, [@@lpItem]
        cmp     [(DRAWITEMSTRUCT ebx).CtlType], ODT_BUTTON
        jne     @@false
        mov     eax, [(DRAWITEMSTRUCT ebx).CtlID]
        cmp     eax, ID_LED
        jb      @@false
        ; �������� ������� ������ ������
        call    GetWindowLong, [(DRAWITEMSTRUCT ebx).hwndItem], GWL_USERDATA
        mov     edi, eax                ; edi - flag
        and     edi, LED_COLMASK or LED_BLINK          ; ��� ���������� ��� ��������
        ; �������� ���� ��� �����
        mov     eax, [ledPen]
        call    SelectObject, [(DRAWITEMSTRUCT ebx).hDC], eax
        ; ������������� ����� ����
        mov     eax, [ledBrush+edi*4]
        call    SelectObject, [(DRAWITEMSTRUCT ebx).hDC], eax
        ; ������������ �������
        lea     eax, [(DRAWITEMSTRUCT ebx).rcItem]
        call    Rectangle, [(DRAWITEMSTRUCT ebx).hDC], [(RECT eax).left], [(RECT eax).top], [(RECT eax).right], [(RECT eax).bottom]
        ; ������� �������
        lea     esi, [szText]
        call    GetWindowText, [(DRAWITEMSTRUCT ebx).hwndItem], esi, 16
        call    SetBkMode, [(DRAWITEMSTRUCT ebx).hDC], TRANSPARENT
        call    SetTextColor, [(DRAWITEMSTRUCT ebx).hDC], [ledCol]
        lea     eax, [(DRAWITEMSTRUCT ebx).rcItem]
        call    DrawText, [(DRAWITEMSTRUCT ebx).hDC], esi, -1, eax, DT_CENTER or DT_SINGLELINE or DT_VCENTER
        or      eax, -1
        ret

    @@false:
        xor     eax, eax
        ret
endp



;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|///////////////////////////////// �������� ////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+
; ������ ��������� � ������ ����
; �� �����:
;    x          - ����� ���������� (������������ ���� PCN)
;    y          - ������� ���������� (������������ ���� PCN)
; �� ������:
proc his_SetPos uses ebx, @@x, @@y, @@width
  local @@r: RECT
        lea     eax, [@@r]
        call    GetClientRect, [hPcn], eax
        mov     eax, [@@y]
        sub     [@@r.bottom], eax
        call    MoveWindow, [hHist], [@@x], eax, [@@width], [@@r.bottom], 1
        ; ����������� ����. ���������� ������� � ���� ���������
        call    SendMessage, [hHist], LB_GETITEMHEIGHT, 0, 0
        mov     ebx, eax
        call    GetSystemMetrics, SM_CYSCREEN
        sub     eax, [@@y]      ; eax = ScrHeight - Height(DISP+LED)
        xor     edx, edx
        div     ebx
        inc     eax
        mov     [hisMaxItems], eax
        ret
endp


; ���������� WM_CTLCOLORSLISTBOX
proc his_OnCtlColorListbox, @@hWnd, @@hDC
        call    GetWindowLong, [@@hWnd], GWL_ID
        cmp     eax, ID_HIST
        jne     @@false
        call    GetStockObject, BLACK_BRUSH
        xor     edx, edx
        or      eax, edx
        ret
    @@false:
        xor     eax, eax
        ret
endp

; �������������� ��� UNICODE
proc his_Insert uses ebx esi edi, @@key, @@cmd
  local @@text: TCHAR: 32
  local @@t: SYSTEMTIME
        ; ��������� �����
        lea     eax, [@@t]
        call    GetLocalTime, eax
        lea     edi, [@@text]
        lea     edx, [@@t.wHour]
        call    util_TimeToStr
        mov     eax, ' '
        stos    [large TCHAR edi]
        stos    [large TCHAR edi]
        ; ��������� ����
        mov     eax, [@@key]
        call    util_ID2Name
        mov     eax, ' '
        stos    [large TCHAR edi]
        mov     eax, '-'
        stos    [large TCHAR edi]
        mov     eax, ' '
        stos    [large TCHAR edi]
        mov     eax, [@@cmd]
        sub     eax, TC_FIRST
        js      @@exit
        mov     ebx, [hisCols+eax*4]
        mov     edx, [ledXlat+eax*4]
        mov     esi, [dword ledTbl+edx*8+4]
        call    lstrlen, esi
        mov     ecx, eax
        rep     movs [large TCHAR esi], [large TCHAR edi]
        xor     eax, eax
        stos    [large TCHAR edi]
        lea     esi, [@@text]
        call    SendMessage, [hHist], LB_INSERTSTRING, 0, esi
        call    SendMessage, [hHist], LB_SETITEMDATA, eax, ebx
        ; ���� �����, ������� �������� �� ������� ��������� �������
    @@delloop:
        call    SendMessage, [hHist], LB_GETCOUNT, 0, 0
        cmp     eax, [hisMaxItems]
        jbe     @@exit
        dec     eax
        js      @@exit
        call    SendMessage, [hHist], LB_DELETESTRING, eax, 0
        jmp     @@delloop

    @@exit:
        ret
endp

proc his_OnMeasureItem uses esi edi ebx, @@hWnd, @@lpItem
  local @@s: SIZEL
  local @@t: TCHAR:8
        mov     ebx, [@@lpItem]         ; ebx = (MEASUREITEMSTRUCT *)lParam
        cmp     [(MEASUREITEMSTRUCT ebx).CtlType], ODT_LISTBOX
        jne     @@false
        call    GetDC, [@@hWnd]
        mov     esi, eax
        call    SelectObject, eax, [hisFont]
        push    eax
        mov     [@@t], '0'
        mov     [@@t+size TCHAR], 0
        lea     eax, [@@t]
        lea     edx, [@@s]
        call    GetTextExtentPoint32, esi, eax, 1, edx
        pop     eax
        call    SelectObject, esi, eax
        call    ReleaseDC, [@@hWnd], esi
        mov     eax, [@@s.x]
        mov     [(MEASUREITEMSTRUCT ebx).itemWidth], eax
        mov     eax, [@@s.y]
        add     eax, 4          ; ��������� �� 2 ������� ������ � �����
        mov     [(MEASUREITEMSTRUCT ebx).itemHeight], eax
        or      eax, -1
        ret

    @@false:    ; ��� ��  ���, ����������
        xor     eax, eax
        ret
endp

proc his_OnDrawItem uses esi edi ebx, @@lpItem
  local @@oldFnt
  local @@txt: TCHAR:32
        mov     edi, [@@lpItem]         ; edi - (DRAWITEMSTRUCT *)lParam
        cmp     [(DRAWITEMSTRUCT edi).CtlType], ODT_LISTBOX
        jne     @@false
        cmp     [(DRAWITEMSTRUCT edi).itemID], -1
        je      @@false
        call    SelectObject, [(DRAWITEMSTRUCT edi).hDC], [hisFont]
        mov     [@@oldFnt], eax
        mov     ebx, [(DRAWITEMSTRUCT edi).itemData]

        lea     ebx, [@@txt]
        call    SendMessage, [(DRAWITEMSTRUCT edi).hwndItem], LB_GETTEXT, [(DRAWITEMSTRUCT edi).itemID], ebx
        cmp     eax, LB_ERR
        je      @@1
        lea     esi, [(DRAWITEMSTRUCT edi).rcItem]
        call    FillRect, [(DRAWITEMSTRUCT edi).hDC], esi, [hisBrush]
        call    SetBkMode, [(DRAWITEMSTRUCT edi).hDC], TRANSPARENT
        call    SetTextAlign, [(DRAWITEMSTRUCT edi).hDC], TA_UPDATECP or TA_LEFT or TA_TOP
        ; ������� ����� ���������
        call    SetTextColor, [(DRAWITEMSTRUCT edi).hDC], 0F0F0C0h
        call    MoveToEx, [(DRAWITEMSTRUCT edi).hDC], [(DRAWITEMSTRUCT edi).rcItem.left], [(DRAWITEMSTRUCT edi).rcItem.top], NULL
        call    DrawText, [(DRAWITEMSTRUCT edi).hDC], ebx, 10, esi, DT_SINGLELINE or DT_LEFT or DT_VCENTER
        add     ebx, 10 * (size TCHAR)
        ; ������� ����� �������
        ; ������� �������
        call    SendMessage, [(DRAWITEMSTRUCT edi).hwndItem], LB_GETITEMDATA, [(DRAWITEMSTRUCT edi).itemID], 0
        call    SetTextColor, [(DRAWITEMSTRUCT edi).hDC], eax
        call    DrawText, [(DRAWITEMSTRUCT edi).hDC], ebx, -1, esi, DT_SINGLELINE or DT_LEFT or DT_VCENTER

      @@1:
        call    SelectObject, [(DRAWITEMSTRUCT edi).hDC], [@@oldFnt]
        or      eax, -1
        ret
    @@false:    ; ��� �� ���, ����������
        xor     eax, eax
        ret
endp


;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|/////////////////////////// ������� ������� ��� ///////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+


proc PcnProc, @@hWnd, @@uMsg, @@wParam, @@lParam
local szTxt: TCHAR:256
        mov     eax, [@@uMsg]
        cmp     eax, WM_DRAWITEM
        je      @@wmdrawitem
        cmp     eax, WM_MEASUREITEM
        je      @@measureitem
        cmp     eax, WM_CTLCOLORLISTBOX
        je      @@wmctlcolorlistbox
        cmp     eax, WM_CTLCOLORSTATIC
        je      @@ctlcolorstatic
        cmp     eax, WM_TIMER
        je      @@wmtimer
        cmp     eax, WM_COMMAND
        je      @@wmcommand
        cmp     eax, WM_ERASEBKGND
        je      @@rettrue
        cmp     eax, WM_NCHITTEST
        je      @@nomove
        cmp     eax, WM_CREATE
        je      @@wmcreate
    @@defwindowproc:
        leave
        lea     eax, [DefWindowProc]
        jmp     eax

    @@wmcreate:
        call    OnCreate, [@@hWnd]

    @@retnull:
        xor     eax, eax
        ret

    @@wmcommand:
        call    GetParent, [@@hWnd]
        call    SetFocus, eax
        movzx   eax, [word @@wParam+2]
        movzx   edx, [word @@wParam]
        cmp     eax, BN_CLICKED
        jne     @@defwindowproc
        call    OnCommand, edx, [@@lParam]
        jz      @@defwindowproc
        jmp     @@retnull

    @@wmtimer:
        call    OnTimer, [@@wParam]
        jmp     @@retnull

    ; ������ �� �������������� ������ ������
    @@nomove:
        mov     eax, HTCLIENT
        ret

    @@measureitem:
        call    his_OnMeasureItem, [@@hWnd], [@@lParam]
        xor eax, eax
        jz      @@defwindowproc
        jmp     @@rettrue

    @@wmdrawitem:
        call    led_OnDrawItem, [@@lParam]
        jnz     @@rettrue
        call    his_OnDrawItem, [@@lParam]
        jz      @@defwindowproc
    @@rettrue:
        or      eax, -1
        ret

    @@ctlcolorstatic:
        call    disp_OnCtlColorStatic, [@@lParam], [@@wParam]
        jz      @@defwindowproc
        ret
    @@wmctlcolorlistbox:
        call    his_OnCtlColorListbox, [@@lParam], [@@wParam]
        jz      @@defwindowproc
        ret


endp

proc OnCommand, @@id, @@hBtn
        mov     eax, [@@id]
        cmp     eax, ID_LED
        jb      @@false
        cmp     eax, ID_LED+ledCnt
        ja      @@false
        ; �� ��� �����
        call    GetWindowLong, [@@hBtn], GWL_USERDATA
        test    eax, LED_TIMERS
        jz      @@false
        mov     [tmrIsRun], 0
        or      eax, -1
        ret
    @@false:
        xor     eax, eax
        ret
endp

proc OnCreate uses ebx esi edi, @@hWnd
  local @@hInst
  local @@cnt
  local @@text: TCHAR:32
        xor     ebx, ebx
        call    GetModuleHandle, ebx
        mov     [@@hInst], eax
    ; ������� ��������

        ; "�������"
        invoke  CreateWindowEx, ebx, "STATIC", "", WS_DISP, ebx, ebx, ebx, ebx, [@@hWnd], ID_DISP, [@@hInst], ebx
        mov     [hDisp], eax

        ; "����������"
        lea     esi, [ledTbl]
        xor     edi, edi
        mov     [@@cnt], ledCnt
    @@ledloop:
        mov     eax, [(LED esi).tcCode]
        mov     edx, [(LED esi).lpszText]
        and     eax, 0FFh
        dec     eax
        mov     [ledXlat+eax*4], edi
        add     eax, ID_LED
        invoke  CreateWindowEx, ebx, "BUTTON", edx, WS_LED, ebx, ebx, ebx, ebx, [@@hWnd], eax, [@@hInst], ebx
        mov     [hLed+edi*4], eax
        mov     edx, [(LED esi).tcCode]
        shr     edx, 8
        inc     edi
        call    SetWindowLong, eax, GWL_USERDATA, edx
        add     esi, size LED
        dec     [@@cnt]
        jnz     @@ledloop
        ; ��������� ������� ������������� �� �����
        mov     [@@cnt], ledMax-ledCnt
    @@ledfill:
        mov     eax, [(LED esi).tcCode]
        and     eax, 0FFh
        dec     eax
        mov     [ledXlat+eax*4], edi
        inc     edi
        add     esi, size LED
        dec     [@@cnt]
        jnz     @@ledfill

        ; ���� ���������
        invoke  CreateWindowEx, WS_EX_TOOLWINDOW, "LISTBOX", "��������", WS_HIST, ebx, ebx, ebx, ebx, [@@hWnd], ID_HIST, [@@hInst], ebx
        mov     [hHist], eax

        mov     [tmrIsRun], 0
        ret
endp

proc pcn_BreakCmd
        mov     [tmrIsRun], 0
        call    disp_Clear
        ret
endp

proc OnTimer uses ebx, @@wParam
  local @@msg: BYTE:16
        mov     ebx, [@@wParam]
        cmp     ebx, 0
        je      @@newtimer
        cmp     [tmrIsRun], 0
        jle     @@nexttimer
        ; ���������� ������ "�����������"
        call    GetWindowLong, ebx, GWL_USERDATA
        xor     eax, LED_BLINK
        push    eax
        call    SetWindowLong, ebx, GWL_USERDATA, eax
        call    InvalidateRect, ebx, 0, -1
        pop     eax
        test    eax, LED_SOUND
        jz      @@done
        call    Beep, 4000, 100
    @@done:
        dec     [tmrIsRun]
        ret

    @@nexttimer:
        ; ��������������� ���������� ��������� ������
        call    GetWindowLong, ebx, GWL_USERDATA
        and     eax, not (LED_BLINK or LED_TIMERS)
        call    SetWindowLong, ebx, GWL_USERDATA, eax
        call    InvalidateRect, ebx, 0, -1
        call    disp_Clear
    @@newtimer:
        ; ���������� ������� ������
        call    KillTimer, [hPcn], [@@wParam]
        mov     [tmrIsRun], 0
        ; ��������� �����
        lea     ebx, [@@msg]
        call    queue_Get, [lpQueue], ebx
        or      eax, eax
        jz      @@exit
        ; ���-�� ����, ������� ����� ������
        mov     [tmrIsRun], 60
        mov     eax, [ebx+1]
        call    disp_ShowNum, eax
        mov     eax, [ebx+5]           ; cmd
        dec     eax
        mov     eax, [ledXlat+eax*4]
        mov     ebx, [hLed+eax*4]      ; ebx - ����� ������ ������
        call    GetWindowLong, ebx, GWL_USERDATA
        or      eax, LED_BLINK or LED_TIMERS
        call    SetWindowLong, ebx, GWL_USERDATA, eax
        call    SetTimer, [hPcn], ebx, 250, NULL
    @@exit:
        ret
endp



end



   ����
  "�������"        "������"
  "������"         "���������"
  "�����"          "��� ��"
  "����"           "������ ��"
  "����"           "������ ��"
  "����. ���"      "����� ����."
  "����. ����"     "�����. ����."
  "������� ��"     "���������"


