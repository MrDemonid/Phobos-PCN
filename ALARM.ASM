; ��������� ��������� ������:
;   dc  - �������� ������� �������
;   df  - �������� ������ ������� � ����
;
        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; p��p����� ��������� ������������p�
        jumps           ; ��������� ����������� ���������

        %noincl

;@unicode = 1
include         "windef.inc"
include         "kernel32.inc"
include         "gdi32.inc"
include         "user32.inc"
include         "shell32.inc"
include         "comctl32.inc"

include         "alarm.inc"
include         "tabctrl.inc"
include         "util.inc"
include         "auxport.inc"
include         "pcn.inc"
include         "console.inc"

include         "odbcdrv.inc"
include         "logdlg.inc"

include         "resource.inc"

includelib      "imp32i.lib"


;+--------------------------------------------------------------------------+
;�=============================== ��������� ================================�
;+--------------------------------------------------------------------------+

;�==========================================================================�
;�--------------------------------- ������ ---------------------------------�
;L==========================================================================-
dataseg
  TEXT szVersion "Alarm ver 2.6.0 (c) Andrey Hlus"

  TEXT szSetupIni "ALARM.INI"

  inpNum        dd 0
  inpTxt        db 4 dup(?)


udataseg
  hInstApp      HINSTANCE ?
  hWndApp       HWND ?
  hHeap         HANDLE ?
  hPcn          HWND ?          ; ����� ���� ��������� ������ ���

  numRTR        dd ?            ; ���������� ������������ ��������������

  szSetupFile   TCHAR MAX_PATH dup(?)

;�==========================================================================�
;�----------------------------------- ��� ----------------------------------�
;L==========================================================================-

codeseg
    Start:
        call    app_Init
        jz      Exit            ; <- ����������� ������, ���������� ������ ����������
        call    app_Run
    Exit:
        jmp     app_Done




;�==========================================================================�
;�----------------------------- ������������� ------------------------------�
;L==========================================================================-

proc app_Init
        call    GetModuleHandle, 0
        mov     [hInstApp], eax
        ; �������������� ����
        call    GetProcessHeap
        mov     [hHeap], eax
        ; ������ ��������� ��������� ������
        call    app_ReadCommandLine
;        ; ��������� ���������� �������
;        call    con_Create
        ; �������������� ����������� ������ ComCtrl32
        call    app_InitCommonControls

        ; ������������ ����� � ������� ���� ����������
        call    app_CreateWindow
        invoke  con_printf, <"run programm",13,10>

        ; �������������� ���� ������
        call    log_Open, [hWndApp]     ; ���������� ���� ������� �����
        ; �������������� ����
        call    app_AuxInit
        ret
endp


proc app_AuxInit uses ebx esi
        lea     ebx, [szSetupFile]
        ; ������ �������� �����
        invoke  GetPrivateProfileInt, <"AUX">, <"Port">, 0, ebx
        ; ��������� ����
        mov     esi, eax
        call    aux_Open, eax
        or      eax, eax
        jz      @@error
        ret
    @@error:
        invoke  con_printf, <"AUX Open error! Port: %u, Path: %s",13,10>, esi, ebx
;        xor     eax, eax
        or      eax, -1
        ret
endp






; ������ ��������� ������:
;   dc          - �������� ������� �������
;   df          - �������� ������ ������� � ����
proc app_ReadCommandLine
        call    GetCommandLine
        xchg    esi, eax                ; esi - ��p�� ��������� ��p���
        ; ���������� ��� ��������
        push    '"'
        xor     eax, eax
        lods    [large TCHAR esi]
        pop     edx                     ; edx = '"'
        cmp     eax, edx
        je      @@skip_name
        dec     edx
        dec     edx                     ; edx = ' '
    @@skip_name:
        lods    [large TCHAR esi]       ; ���������� ��������� ������
        or      eax, eax
        jz      @@done                  ; -> ��� ����������
        cmp     eax, edx
        jne     @@skip_name
    @@while:
        ; ������ ��������� ��������
        call    @@skip_space
        jz      @@done
        cmp     eax, '/'                ; �������� ���������� � ������� '/'
        je      @@get_char
        cmp     eax, '-'                ; ��� '-'
        jne     @@while                 ; -> ���������� � ������ ���������
    @@get_char:
        ; �������� ��������
        call    @@read_char
        cmp     eax, 'D'
        jne     @@next
        call    @@read_char
        cmp     eax, 'C'
        je      @@con_debug
        cmp     eax, 'F'
        je      @@file_debug
    @@next:
        ; ��������� � ���������� ���������
        jmp     @@while
    @@done:
        or      eax, -1
        ret

    @@con_debug:
        ; ��������� ���������� �������
        call    dbg_Create, DEBUG_CONSOLE
        jmp     @@next
    @@file_debug:
        ; ���������� ���������� ���������� � ����
        call    dbg_Create, DEBUG_FILE
        jmp     @@next

  @@skip_space:
        lods    [large TCHAR esi]
        or      eax, eax
        jz      @@end_skip
        cmp     eax, ' '
        jbe     @@skip_space
    @@end_skip:
        retn
  @@read_char:
        ; ������ ��������� ������
        lods    [large TCHAR esi]
        ; � ��p������ ��� � ��p���� p�����p
        cmp     eax, 'a'
        jb      @@read_done
        cmp     eax, 'z'
        ja      @@read_done
        sub     eax, 'a'-'A'
    @@read_done:
        retn
endp




proc app_InitCommonControls
  local @@buf:TCHAR:MAX_PATH
        lea     edi, [@@buf]
        call    GetSystemDirectory, edi, MAX_PATH
        invoke  lstrcat, edi, "\comctl32.dll"
        call    LoadLibrary, edi
        or      eax, eax
        jz      @@error
        call    GetProcAddress, eax, offset szGetVersion
        or      eax, eax
        jz      @@error
        mov     esi, eax
        call    RtlZeroMemory, edi, size DLLVERSIONINFO
        mov     [(DLLVERSIONINFO edi).cbSize], size DLLVERSIONINFO
        call    esi, edi
        move    eax, "Sorry! This programm request COMCTL version 4.70 or later"
        cmp     [(DLLVERSIONINFO edi).dwMajorVersion], 4
        jb      @@error
        ja      @@done
        cmp     [(DLLVERSIONINFO edi).dwMinorVersion], 70
        jb      @@error
    @@done:
        mov     [(INITCOMMONCONTROLSEX edi).dwSize], size INITCOMMONCONTROLSEX
        mov     [(INITCOMMONCONTROLSEX edi).dwICC], ICC_DATE_CLASSES
        call    InitCommonControlsEx, edi
        ret
    @@exit:
        ret
    @@error:
        push    eax
        call    GetDesktopWindow
        pop     edx
        invoke  err_ShowLastError, eax, <"MAIN.ASM">, edx
        jmp     @@exit

  TEXTA szGetVersion, "DllGetVersion"
endp


proc app_CreateWindow
        xor     esi, esi
        mov     ebx, [hInstApp]
        ; ���������� ������� ��� ���� ���������� (�� ������� �� ���� �����)
        call    GetSystemMetrics, SM_CYSCREEN
        push    eax
        call    GetSystemMetrics, SM_CXSCREEN
        push    eax
        ; ��������� ��������� WNDCLASSEX
        move    edi, "AlarmClassApp"
        push    esi             ; wc_hIconSm
        push    edi             ; wc_lpszClassName
        push    esi             ; wc_lpszMenuName
        push    esi             ; wc_hbrBackground - �� ����������
        call    LoadCursor, NULL, IDC_ARROW
        push    eax             ; wc_hCursor
        call    LoadIcon, ebx, IDI_APPICO
        push    eax             ; wc_hIcon
        push    ebx             ; wc_hInstance
        push    esi             ; wc_cbWndExtra
        push    esi             ; wc_cbClsExtra
        push    offset WndProc  ; wc_lpfnWndProc
        push    CS_HREDRAW or CS_VREDRAW ; wc_style
        push    size WNDCLASSEX ; wc_cbSize
        ; p�����p�p��� ����� ������������ ����
        call    RegisterClassEx, esp


        add     esp, size WNDCLASSEX
        and     eax, 0ffffh
        pop     edx             ; width
        pop     ecx             ; height
        jz      @@error
        ; ������� ����
;        call    LoadMenu, ebx, IDR_MENU ; ���������� ����
        WS_MAINSTYLE = WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN ;+WS_CLIPSIBLINGS
        invoke  CreateWindowEx, esi, edi, "������������ ��� �������", WS_MAINSTYLE, esi, esi, edx, ecx, esi, esi, ebx, esi
        mov     [hWndApp], eax
        or      eax, eax
        jz      @@error
        ; ������������� ����
        push    eax
        call    ShowWindow, eax, SW_SHOWNORMAL
        call    UpdateWindow

;        ; ���������� ������� ������� ������
;        call    LoadAccelerators, ebx, IDR_ACCEL
;        mov     [hAccelApp], eax

        or      eax, -1
        ret

    @@error:
        call    GetDesktopWindow
        invoke  err_ShowLastError, eax, <"MAIN.ASM">, <"app_CreateWindow">
        xor     eax, eax
        ret
endp



;�==========================================================================�
;�------------------------------ ���������� --------------------------------�
;L==========================================================================-

proc app_Run
  local @@msg:MSG
        xor     esi, esi
        lea     edi, [@@msg]
        ; ������ � ���� ��������� ���������
    @@msgloop:
        call    GetMessage, edi, esi, esi, esi
        or      eax, eax
        jz      @@endmsg
;        call    TranslateAccelerator, [hWndApp], [hAccelApp], edi
;        or      eax, eax
;        jnz     @@msgloop
        call    TranslateMessage, edi
        call    DispatchMessage, edi
        jmp     @@msgloop
    @@endmsg:
        ret
endp



;�==========================================================================�
;�---------------------------- ������� ������� -----------------------------�
;L==========================================================================-
        align   4
proc WndProc, @@hWnd, @@uMsg, @@lParam, @@wParam
    BEGIN_MESSAGE_MAP
;        MESSAGE WM_HOTKEY, OnHotKey
        MESSAGE WM_RECEIVE, OnReceive
        MESSAGE WM_SIZE,    OnSize
        MESSAGE WM_NOTIFY,  OnNotify
        MESSAGE WM_DISPLAYCHANGE, OnDispChange
        MESSAGE WM_KEYDOWN, OnKeyDown
        MESSAGE WM_CREATE,  OnCreate
        MESSAGE WM_DESTROY, OnDestroy
    END_MESSAGE_MAP
endp


proc OnKeyWatch uses ebx esi edi, @@hWnd, @@uMsg, @@idEvent, @@dwTime
        call    disp_Clear
        mov     [inpNum], 0
        call    KillTimer, [hWndApp], 1
        ret
endp

;UnregisterHotKey
proc OnKeyDown uses ebx esi edi, @@hWnd, @@wParam, @@lParam
        mov     ebx, [@@wParam]
        mov     edi, [inpNum]
        cmp     ebx, VK_ADD
        je      @@take
        cmp     ebx, VK_SUBTRACT
        je      @@takeoff
        cmp     ebx, VK_MULTIPLY
        je      @@takeafter
        cmp     ebx, VK_RETURN
        je      @@flash
        cmp     ebx, VK_NUMPAD0
        jb      @@exit
        cmp     ebx, VK_NUMPAD9
        ja      @@exit
        sub     ebx, VK_NUMPAD0
        ; �������� ����� ������
        call    Beep, 7000, 30
        or      edi, edi
        jnz     @@next
        ; ��� ������ ������ ������
        mov     [dword inpTxt], edi
        call    SetTimer, [hWndApp], 1, 10000, offset OnKeyWatch
    @@next:
        cmp     edi, 3
        je      @@done
        or      bl, '0'
        mov     [inpTxt+edi], bl
        inc     [inpNum]
        ; ���������� �� "�������"
        call    disp_ShowTxt, offset inpTxt
        jmp     @@done


    @@take:     ; ������� "����� �����"
        mov     esi, TU_PICKUP
        jmp     @@do_cmd
    @@takeoff:  ; ������� "�����"
        mov     esi, TU_REMOVE
        jmp     @@do_cmd
    @@takeafter:; ������� "����� ����� ������"
        mov     esi, TU_TAKEAFTER
        jmp     @@do_cmd
    @@do_cmd:
        call    Beep, 7000, 30
        call    KillTimer, [hWndApp], 1
        call    disp_Clear
        cmp     [inpNum], 3
        jne     @@noinput
        ; ����������� ����� ����������� � �������� ���
        movzx   eax, [byte inpTxt]
        mov     edx, 100
        sub     eax, '0'
        mul     edx
        mov     ecx, eax
        movzx   eax, [byte inpTxt+1]
        mov     edx, 10
        sub     eax, '0'
        mul     edx
        add     ecx, eax
        movzx   eax, [byte inpTxt+2]
        sub     eax, '0'
        add     ecx, eax
        call    tab_AbsToRtr, ecx
        mov     ecx, eax
        or      ecx, edx
        jz      @@noinput
        call    aux_SendTU, edx, eax, esi

    @@noinput:
        mov     [inpNum], 0
        jmp     @@done


    @@done:
        xor     eax, eax
        ret

    @@exit:
        or      eax, -1
        ret
    @@flash:
        call    pcn_BreakCmd
        mov     [inpNum], 0
        xor     eax, eax
        ret
endp



proc OnCreate uses ebx esi edi, @@hWnd, @@wParam, @@lParam
  local @@buff: TCHAR:128=buflen
  local @@keys: BYTE:128
  local @@bads: BYTE:128
  local @@nkey, @@nbad
  local @@rtr: TCHAR:8
        ; �������� ��� � ���� ����� ��������
        call    lstrlen, offset szSetupIni
        mov     edx, MAX_PATH-1
        sub     edx, eax
        lea     ebx, [szSetupFile]
        call    util_GetModulePath, ebx, edx
        call    lstrcat, ebx, offset szSetupIni
        ; ������� ���� �������
        call    tab_Init, [@@hWnd]
        or      eax, eax
        jz      @@err1
        ; ������ ��������� � ��������� �� ������� �� ������ ������������
        mov     [numRTR], 0
        lea     esi, [@@rtr]
        invoke  lstrcpy, esi, <"RTR1">

    @@newpage:
        ; ������ ��� �������������
        invoke  GetPrivateProfileInt, esi, <"Type">, 0, ebx
        cmp     eax, RTR_PHOBOS
        je      @@found
        cmp     eax, RTR_PHOBOS3
        jne     @@next_rtr
    @@found:
        push    eax
        inc     [numRTR]
        ; ������ �������� ��� ������� �������������
        lea     edi, [@@buff]
        invoke  GetPrivateProfileString, esi, <"Name">,<"�����">, edi, buflen, ebx
        ; ��������� ������� ��� �������� �������������
        pop     ecx
        invoke  tab_NewPage, edi, ecx, 10, 12
        or      eax, eax
        jz      @@errtab
        ; ���������� �� ������, ���� ��� ����
        call    tab_NewIcon, [numRTR], esi

        ; ������ ��������� �� ��������������� ������
        lea     edi, [@@keys]
        invoke  GetPrivateProfileInt, esi, <"NumKeys">, 0, ebx
        cmp     eax, 120
        jbe     @@01
        mov     eax, 120
    @@01:
        mov     [@@nkey], eax
        invoke  GetPrivateProfileStruct, esi, <"Keys">, edi, eax, ebx
        or      eax, eax
        jnz     @@get_bads
        ; �� ������ ��������� ���������, ������� ��� ��� ����� ��������������
        mov     [@@nkey], 0

    @@get_bads:
        ; ������ ��������� �� ����������� ������
        lea     edi, [@@bads]
        invoke  GetPrivateProfileInt, esi, <"NumBads">, 0, ebx
        cmp     eax, 120
        jbe     @@02
        mov     eax, 120
    @@02:
        mov     [@@nbad], eax
        invoke  GetPrivateProfileStruct, esi, <"Bads">, edi, eax, ebx
        or      eax, eax
        jnz     @@setflags
        ; �� ������ ��������� ���������, ������� ��� ��� ����� ��������������
        mov     [@@nbad], 0
    @@setflags:
        lea     edx, [@@keys]
        call    tab_SetFlags, [numRTR], [@@nkey], edx, [@@nbad], edi

    @@next_rtr:
        ; ��������� � ���������� ���������� ��� ���������� �������������
        lea     edi, [esi+3*size TCHAR]
        movzx   eax, [TCHAR edi]
        inc     eax
        stos    [large TCHAR edi]
        cmp     eax, '0'+MAX_RTR
        jbe     @@newpage

        ; ������� ���� ���
        call    pcn_Init, [@@hWnd]
        mov     [hPcn], eax

;        call    RegisterHotKey, [@@hWnd], 1, 0, VK_NUMPAD0)

        xor     eax, eax
        ret
  @@err1:
        invoke  err_ShowLastError, [@@hWnd], <"MAIN.ASM">, <"OnCreate.tab_Init">
        jmp     @@error
  @@errtab:
        invoke  err_ShowLastError, [@@hWnd], <"MAIN.ASM">, <"OnCreate.tab_NewPage">
  @@error:
        or      eax, -1
        ret
endp


proc OnDestroy, @@hWnd, @@wParam, @@lParam
        ; ���������� tab control
        call    pcn_Done
        call    tab_Done

        call    PostQuitMessage, 0
        xor     eax, eax
        ret
endp

proc OnSize uses edi esi ebx, @@hWnd, @@wParam, @@lParam
        mov     eax, [@@wParam]
        cmp     eax, SIZE_MINIMIZED
        je      @@skip
        cmp     eax, SIZE_MAXHIDE
        je      @@skip
        movzx   ebx, [word @@lParam]    ; ebx - width
        movzx   esi, [word @@lParam+2]  ; esi - height
        xor     edi, edi                ; edi - x
        call    pcn_GetMinWidth
        sub     ebx, eax
        call    pcn_OnSize, ebx, 0, eax, esi
        call    tab_OnSize, 0, 0, ebx, esi
        xor     eax, eax
        ret
    @@skip:
        or      eax, -1
        ret
endp

proc OnNotify, @@hWnd, @@wParam, @@lParam
        call    tab_OnNotify, [@@hWnd], [@@wParam], [@@lParam]
        ret
endp

proc OnDispChange, @@hWnd, @@wParam, @@lParam
        call    tab_OnDispChange, [@@hWnd], [@@wParam], [@@lParam]
        xor     eax, eax
        ret
endp

; ��������� �� �������������
; HI(wParam) - ������������
; LO(wParam) - ����� �����
; HI(lParam) - LO(����� ������), HI(hoz)
; LO(lParam) - cmd
proc OnReceive, @@hWnd, @@wParam, @@lParam
;        mov     eax, [@@wParam]
;        shr     eax, 16
;        cmp     al, 2
;        jne     @@1
;        push    ebx
;        mov     eax, [@@wParam]
;        and     eax, 0FFFFh
;        mov     ecx, [@@lParam]
;        mov     ebx, ecx
;        shr     ecx, 16
;        mov     edx, ecx
;;        and     ebx, 0FFFFh   ; ebx - cmd
 ;       and     ecx, 0FFh     ; ecx - ����� ������
;        shr     edx, 8        ; edx - ��������
;        and     edx, 0FFh

;        invoke  con_printf, <"rcv[%u], shleif: %u, hozorgan: 0x%X, cmd: 0x%X",13,10>, eax, ecx, edx, ebx
;        pop     ebx

;  @@1:
        call    tab_OnReceive, [@@wParam], [@@lParam]
        call    pcn_OnReceive, [@@wParam], [@@lParam]
        xor     eax, eax
        ret
endp

;�==========================================================================�
;�--------------------------- ���������� ������ ----------------------------�
;L==========================================================================-

proc app_Done
        ; ��������� ���� ������
        call    log_Close               ; ��������� ���� ������� �����
        ; ��������� COM-����
        call    aux_Close
        ; ������
        call    ExitProcess, 0
endp



end Start
