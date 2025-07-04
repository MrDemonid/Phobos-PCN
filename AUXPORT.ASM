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
include         "winmm.inc"
include         "error.inc"

include         "alarm.inc"
include         "auxport.inc"
include         "util.inc"
include         "queue.inc"
include         "logdlg.inc"
include         "console.inc"
include         "tabctrl.inc"

includelib      "imp32i.lib"



macro ISZ var, lab:req
  ifnb <var>
        cmp     &var&, 0
        je      &lab
  else
        or      eax, eax
        jz      &lab
  endif
endm

macro ISNZ var, lab:req
  ifnb <var>
        cmp     &var&, 0
        jne     &lab
  else
        or      eax, eax
        jnz     &lab
  endif
endm



MAX_RCV_TIME    = 1500  ; ����� �� ������ ������ ������������� � ms


; ���� ������� ��������� ������ (���-7)
CH_STX          = 02h   ; ���. ������
CH_ETX          = 03h   ; ���. ������
CH_ACK          = 06h   ; ������������� ("��")
CH_NAK          = 15h   ; "���"
CH_INF          = 23h   ; ������� ��������� ���������������� (����� �� �������������)
CH_CMD          = 24h   ; ������� ������� �������������� (������ �� ������������)
CH_SPI          = 5Ch   ; ������� ��������� ��� �����

CH_XOZ          = 2Fh   ; ������� �������� ������ ���������
CH_SLF          = 21h   ; ������� �������� ������ ������

; ����� ��������� ������� ������ � ������ ����� (auxStatus)
INP_NAK         = 1     ; ��� ������ ������ "���" �� ���
INP_TC          = 2     ; ��� ������ ����� �� �� ���
INP_PROCEEDTC   = 4     ; ����� ��������� � ��������� ������ �� �� ���
OUT_WAIT        = 8     ; ��������� �������� ���������� ������ � ����

; ���������
MAX_QUEUE       = 32    ; ������� ������� ��������� �� ������ ������������
MAX_TC_LEN      = 28    ; ����. ����� ������ ��
MAX_LINES       = 4     ; ����. ������� �� �����

; ���� ������ �������������� (rtrFlags)
;RTR_ENABLE      = 1     ; ������������ ������������
RTR_BADSTATUS   = 4     ; ��� ����� ������������� (��� ������������� ������������)
RTR_OPROS       = 16    ; ��� ������ ������ "���" �������� ����������
RTR_ZAPROS      = 80h   ; �������� ������, � �� ������� ��

dataseg
  hComm         HANDLE 0        ; ����� �����
  hThread       HANDLE 0        ; ����� ������ ������
  auxMutex      HANDLE 0        ; ������� ������ ������

; ������� ������ ��
  tu1   db TU_PICKUP    , 10,02,24h,5Ch,"00",70h,"000",03     ; "����� �����"
  tu2   db TU_REMOVE    , 10,02,24h,5Ch,"00",6Eh,"000",03     ; "�����"
  tu3   db TU_TAKEAFTER , 10,02,24h,5Ch,"00",71h,"000",03     ; "����� ����� ������"
  tu4   db TU_STATUSUO  , 10,02,24h,5Ch,"00",7Ah,"000",03     ; "������ ��"
  tu5   db TU_REQUESTON , 07,02,24h,5Ch,"00",7Eh,03           ; "������ ������"
  tu6   db TU_REQUESTOFF, 08,02,24h,5Ch,"00",7Eh,'1',03       ; "������ ������"
  tu7   db TU_CONNECT   , 10,02,24h,5Ch,"00",7Ch,"000",03     ; "���������� �����������"
  tu8   db TU_DISCONNECT, 10,02,24h,5Ch,"00",7Bh,"000",03     ; "��������� �����������"
  tu9   db TU_GETTYPEUO , 10,02,24h,5Ch,"00",6Fh,"000",03     ; "���������� ��� ��"

  tuTable       dd tu1, tu2, tu3, tu4, tu5, tu6, tu7, tu8, tu9, 0



; ������� ������������� ��������� ��
  xlatTable     db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 1
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 2
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 3
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 4
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 5
                db 0, TC_ACCIDENT, 0, TC_KEYDISCONNECT, 0, TC_KEYCONNECT, TC_UOOPEN, TC_UOCLOSE, TC_KZ, TC_REPLACEMENT, TC_TYPEUO, 0, 0, TC_ATTIRE, TC_NOTTAKEN, 0 ; 6
                db 0, 0, 0, TC_REMOVED, 0, 0, 0, TC_TAKEN, TC_TEHNOLOGICAL, 0, 0, 0, 0, TC_ALERT, 0, 0 ; 7

; ����� �� "������ �������������"
    align 4
  cmdReq        db 02, 24h, 5Ch, "00", 7Ah, 03h
      lenReq    = $-cmdReq
    align 4
  cmdACK        db 06h          ; ������ "��", ��� ������������� ��������� ��

  ;--------------------------------
    align 4
  TEXT szCOM    "\\.\COM1"      ; �� ��������� COM1


; ������� �������������� ����� �� � �� � ��������� ���

  TEXT szt0     "-"
  TEXT szt1     "������"
  TEXT szt2     "����������� ����������"
  TEXT szt3     "����������� ���������"
  TEXT szt4     "���������"
  TEXT szt5     "������� ��"
  TEXT szt6     "������������ ��� ��"
  TEXT szt7     "�����"
  TEXT szt8     "������"
  TEXT szt9     "����"
  TEXT szt10    "����"
  TEXT szt11    "���������������"
  TEXT szt12    "�������"
  TEXT szt13    "�������� ��"
  TEXT szt14    "�������������� ��"
  TEXT szt15    "����� �������������"
  TEXT szt16    "�������������� �������������"
  TEXT szt17    "���: ����"
  TEXT szt18    "���: ����"
  TEXT szt19    "����� �����"
  TEXT szt20    "�����"
  TEXT szt21    "����� ����� ������"
  TEXT szt22    "������ ��������� ��"
  TEXT szt23    "������ ������"
  TEXT szt24    "������ ������"
  TEXT szt25    "���������� �����������"
  TEXT szt26    "��������� �����������"
  TEXT szt27    "���������� ��� ��"

        align 4
  lpszCodes     dd szt0, szt1, szt2, szt3, szt4, szt5, szt6, szt7, szt8, szt9, szt10
                dd szt11, szt12, szt13, szt14, szt15, szt16, szt17, szt18, szt19, szt20
                dd szt21, szt22, szt23, szt24, szt25, szt26, szt27
  numCodes      = ($-lpszCodes)/4



udataseg
  isStop        db ?            ; ���� ���������� ������ ������ ������/������ �����
  rtrCur        dd ?            ; ������� ������������ [0..MAX_RTR-1]

  rtrFlags      db MAX_RTR dup(?) ; ������ ��������������� � ������ ��������������
  rtrQueue      dd MAX_RTR dup(?) ; ������� ��������� ��� ������� �������������
  rtrMutex      dd MAX_RTR dup(?) ; �������� ��� ������� �������������

  tcBuf         db 128 dup(?)   ; ����� ��� �������� ������ TC
  tcPos         dd ?            ; ������� ������ � tcBuff

  auxBuff       db 128 dup(?)   ; ����� ������
;---------------


  tcSend        db 128 dup(?)



codeseg


; ��������� � �������� �� � �������
; �� �����
;   rtrNum      - ����� ������������� [1..MAX_RTR]
;   keyNum      - ����� ����������� (�����) [0..119]
;   cmdTU       - ��� ������� ��
proc aux_SendTU uses ebx esi edi, @@rtrNum, @@keyNum, @@cmdTU
  local @@size
        ; ���� ������� �� �������
        lea     esi, [tuTable]
        mov     edx, [@@cmdTU]
    @@find:
        lodsd
        or      eax, eax
        jz      @@exit          ; -> ��� ����� �������
        cmp     dl, [eax]
        jne     @@find
        ; �����
        xor     edx, edx
        mov     dl, [byte eax+1]     ; dl - ������ �������
        lea     esi, [eax+2]
        mov     [@@size], edx
        ; ������ ����� �������������
        mov     eax, [@@rtrNum]
        mov     ebx, eax
        cmp     al, [byte numRTR]
        ja      @@exit
        or      al, '0'
        mov     [esi+4], al
        ; � ����� �����, ���� �����
        cmp     dl, 10
        jb      @@done
        mov     eax, [@@keyNum]
        lea     edi, [esi+6]
    ifdef @unicode
        call    util_ID2Ascii
    else
        call    util_ID2Name
    endif
    @@done:
        dec     ebx
        js      @@exit
        call    WaitForSingleObject, [rtrMutex+ebx*4], INFINITE
        call    queue_Put, [rtrQueue+ebx*4], esi, [@@size]
        call    ReleaseMutex, [rtrMutex+ebx*4]
        ; ��������� ������� � ���� ������
        call    tab_RtrToAbs, [@@rtrNum], [@@keyNum]
        call    log_Insert, eax, [@@cmdTU], 0
    @@exit:
        ret
endp

; esi - TC
; edi - len
proc putdebug uses esi edi ebx ecx edx eax
        mov     al, [esi+4]
        cmp     al, '2'
        jne     @@other
        invoke  con_printf, <"rtr 2: ",0>
        invoke  con_printa, esi, edi
    @@done:
        ret
    @@other:
        cmp     al, '1'
        je      @@done
        invoke  con_printf, <"unknown: ",0>
        invoke  con_printa, esi, edi
        jmp     @@done
endp

; ������ �� � �������� ����������� ����������
; �� �����:
;   edi - end TC
proc aux_sendTC uses edi
  local @@rtr
  local @@key
  local @@hoz: BYTE:4
  local @@lin: BYTE:4
  local @@cmd
  local @@dst
        xor     eax, eax
        mov     [@@lin], al
        mov     [@@hoz], al

        lea     esi, [tcBuf]    ; esi - ptr to TC
        sub     edi, esi        ; edi - len

        call    putdebug
        ; ���������
        cmp     edi, 10
        jb      @@false         ; <- ����� ������� 10 ��������
        lodsd
        cmp     eax, 305c2302h  ; <#02,'#','\',"0">
        jne     @@false
        ; ��������� ������ �� ������
        xor     eax, eax
        lodsb                   ; �������� ����� �������������
        sub     al, '0'
        js      @@false
        cmp     al, 9
        ja      @@false
        mov     [@@rtr], eax
        dec     al              ; ����� ������������� � [0..MAX_RTR-1]
        js      @@false
        mov     [@@dst], eax
        lodsb
        cmp     al, '/'
        jne     @@get_cmd
        ; ����, ����, ������, ���������, ��� ��
        ; ��������� ����� ��������� ��� ���� �� ��� ����. ���������
        lodsb
        mov     [@@hoz], al
        lodsb
        ; ��������� ��� �� � ������������ � ����� ������� ���
    @@get_cmd:
        mov     al, [xlatTable+eax]
        or      eax, eax
        jz      @@false
        mov     [@@cmd], eax
        ; ��������� ����� ����������� (�����)
        xor     eax, eax
        mov     ecx, 100
        lodsb
        sub     eax, '0'
        mul     ecx
        mov     [@@key], eax
        xor     eax, eax
        mov     ecx, 10
        lodsb
        sub     eax, '0'
        mul     ecx
        add     [@@key], eax
        xor     eax, eax
        lodsb
        sub     eax, '0'
        add     [@@key], eax
        cmp     [@@key], 120
        jae     @@false         ; <- �������� ����
        xor     eax, eax
        lodsb
        cmp     al, '!'
        jne     @@done
        ; ��������� ����� ������
        lodsb
        sub     al, '0'
        js      @@false
        cmp     al, MAX_LINES
        jae     @@false
        mov     [@@lin], al
        lodsb
    @@done:
        cmp     al, CH_ETX
        jne     @@false
        ; �������� �������� ����������
; HI(lParam) - LO(����� ������), HI(hoz)
; LO(lParam) - cmd
        mov     eax, [@@dst]
        mov     esi, [@@cmd]
        test    [rtrFlags+eax], RTR_OPROS
        jz      @@send
        cmp     esi, TC_TAKEN
        jne     @@isrm
        mov     esi, TC_TAKENSILENT
        jmp     @@send
    @@isrm:
        cmp     esi, TC_REMOVED
        jne     @@send
        mov     esi, TC_REMOVEDSILENT
    @@send:
        xor     ecx, ecx
        mov     cl, [@@lin]
        mov     ch, [@@hoz]
        shl     ecx, 16
        or      ecx, esi        ; ecx - lParam

        mov     eax, [@@rtr]
        mov     edx, [@@key]
        shl     eax, 16
        or      eax, edx        ; eax - wParam
        call    PostMessage, [hWndApp], WM_RECEIVE, eax, ecx
        ; ��������� ������� � ���� ������
        call    tab_RtrToAbs, [@@rtr], [@@key]
        xor     edx, edx
        mov     dl, [@@lin]
        mov     dh, [@@hoz]
        call    log_Insert, eax, esi, edx

        or      eax, -1
        ret
    @@false:
        xor     eax, eax
        ret
endp
    ; HI(wParam) - ������������
    ; LO(wParam) - ����� �����
    ; HI(lParam) - LO(����� ������), HI(hoz)
    ; LO(lParam) - cmd




proc aux_Open uses ebx esi edi, @@nPort: byte
  local @@dcb: DCB
  local @@time: COMMTIMEOUTS
        ; ����������� ������� ��������� ��
        xor     esi, esi
    @@make_queue:
        cmp     esi, [numRTR]
        jae     @@setup_port
        call    queue_Create, MAX_QUEUE
        mov     [rtrQueue+esi*4], eax
        mov     [rtrFlags+esi], 0
        ; ������� ������� ��� ������ �������
        call    CreateMutex, NULL, FALSE, NULL
        mov     [rtrMutex+esi*4], eax
        inc     esi
        jmp     @@make_queue

    @@setup_port:
; ��� ��, ������
;or      eax, -1
;ret

        ; ����������� ����
        lea     ebx, [@@dcb]
        call    util_RtlZeroMemory, ebx, size DCB
        mov     [(DCB ebx).DCBlength], size DCB
        invoke  BuildCommDCB, <"baud=200 parity=E data=7 stop=2">, ebx
        ISZ,    @@error
        movzx   eax, [@@nPort]
        cmp     eax, 9
        jbe     @@1
        mov     eax, 1
    @@1:
        or      eax, "0"
        lea     edi, [szCOM+(7*size TCHAR)]
        stos    [large TCHAR edi]
        call    CreateFile, offset szCOM, GENERIC_READ or GENERIC_WRITE, 0, 0, OPEN_EXISTING, 0, 0
        cmp     eax, INVALID_HANDLE_VALUE
        je      @@error
        mov     [hComm], eax
        mov     esi, eax
    ; ������� ������� ������ ������
        call    CreateMutex, NULL, TRUE, NULL
        mov     [auxMutex], eax
    ; �������� ������
        call    SetCommMask, esi, 0
        ISZ,    @@error
    ; ���������� ����
        call    PurgeComm, esi, PURGE_TXABORT+PURGE_RXABORT+PURGE_TXCLEAR+PURGE_RXCLEAR
        ISZ,    @@error
    ; ������ ����p���� ��p��
        call    SetCommState, esi, ebx
        ISZ,    @@error
; ����������� ������� ��������� ��������� ��� 200 ��� � ��� (11 ��� �� ������)
; ����� �� ����� ������ �������:
;     RD_READ = 11 bit / 200 bod = 55 �����������
; ����. �������� ����� �������� ���� ��������:
;     RD_WAIT = RD_READ / 2 = 27 ����
; ����� ����. ����� �� ����� ������ �������:
;     RD_TIME = RD_READ+RD_WAIT
; ���������� ����� �� �����, �� �������������� ��������������:
;     RD_ADD = 150 �����������
; ����� ����� ������ ������������� �� �������:
;     (NumOfChar * ReadTotalTimeoutMultiplier) + ReadTotalTimeoutConstant
; �.�.:
;     (NumOfChar * RD_TIME) + RD_ADD

AUX_READ_CHAR = (11 * 1000) / 200  ; 55 ms; (+ 10 �� ������ ������)
AUX_WAIT_CHAR = 5                 ; 3 ms  (+ 5 �� ������ ������)
AUX_TOTAL_TIME = AUX_READ_CHAR + AUX_WAIT_CHAR
AUX_TOTAL_ADD  = 100

        xor     ebx, ebx
        lea     edx, [@@time]
        mov     [@@time.ReadIntervalTimeout], AUX_WAIT_CHAR           ; ����. �������� ����� �������� ���� ��������
        mov     [@@time.ReadTotalTimeoutMultiplier], AUX_TOTAL_TIME ; ����� ������ ������ ������� + �������� �� ������ ������ ���������� �������
        mov     [@@time.ReadTotalTimeoutConstant], AUX_TOTAL_ADD       ; ���������, �� ������ �������������� �������� � ������
        mov     [@@time.WriteTotalTimeoutMultiplier], AUX_TOTAL_TIME
        mov     [@@time.WriteTotalTimeoutConstant], ebx
        call    SetCommTimeouts, esi, edx
        ISZ,    @@error
    ; ������ ����� �� ��������� ������
        call    SetCommMask, esi, EV_RXCHAR
        ISZ,    @@error
    ; ��������� �p��, ��� ��p������ ������� ��p��
        call    CreateThread, ebx, ebx, offset aux_Thread, ebx, ebx, ebx
        mov     [hThread], eax
        ISZ,    @@error
    ; ������ Real-Time ���������
        call    SetThreadPriority, eax, 15

    ; ��� ��, ������
        or      eax, -1
        ret
    @@error:
        invoke  err_ShowLastError, [hWndApp], <"AUXPORT.ASM">, <"aux_Open">
        call    aux_Close
        xor     eax, eax
        ret
endp

proc aux_Close uses ebx
;jmp @@del_queue
        ; ������������� ����� ������
        invoke  con_printf, <"close aux thread",13,10>
        call    ReleaseMutex, [auxMutex]
        call    WaitForSingleObject, [hThread], 10000

        invoke  con_printf, <"free COM-port",13,10>
        ; ����������� ����
        mov     ebx, [hComm]
        or      ebx, ebx
        jz      @@del_queue
        call    SetCommMask, ebx, NULL   ; �������� ������
        call    PurgeComm, ebx, PURGE_TXABORT+PURGE_RXABORT+PURGE_TXCLEAR+PURGE_RXCLEAR
        SAFE_CLOSE ebx

        ; ������� ������� ��������� ��   (ebx ������ ���� ����� ����)
    @@del_queue:
        cmp     ebx, [numRTR]
        jae     @@exit
        ; ������� �������
        mov     ecx, [rtrMutex+ebx*4]
        jecxz   @@1
        call    CloseHandle, ecx
      @@1:
        ; ������� ������� ���������
        call    queue_Destroy, [rtrQueue+ebx*4]
        inc     ebx
        jmp     @@del_queue
    @@exit:
        ret
endp




proc aux_Thread,   @@lpParametr: dword
  local @@tu: BYTE:32
  local @@com: COMSTAT
  local @@cnt
  local @@msk
  local @@time

        ; �������� ����������
        invoke  con_printf, <"Start aux thread.",13,10>
        xor     eax, eax
        mov     [rtrCur], eax

    @@while:
        call    @@get_tu                ; �������� �� ��� �������� �������������
        lea     edx, [@@cnt]
        call    WriteFile, [hComm], esi, eax, edx, 0
        or      eax, eax
        jz      @@wr_error

    ; �������� ������ ������ �� �������������
        call    timeGetTime
        mov     [@@time], eax
        lea     esi, [auxBuff]
        lea     edi, [tcBuf]
    @@read:
        call    timeGetTime
        sub     eax, [@@time]
        cmp     eax, MAX_RCV_TIME
        ja      @@next_rtr
        lea     eax, [@@cnt]
        call    ReadFile, [hComm], esi, 16, eax, 0
        or      eax, eax
        jz      @@rd_error
    @@do_parse:
        cmp     [@@cnt], 0
        je      @@read
        cmp     [byte esi], CH_NAK
        je      @@NAK           ; <- ����� "���", ������ �� ��������� ������������

        ; ��������� ����� �� ������ ����� ������
    @@scan:     ; while (cnt)
        cmp     [@@cnt], 0
        je      @@read
        dec     [@@cnt]
        lodsb
        stosb
        cmp     al, CH_ETX
        jne     @@scan
        ; ��� ����� ������ ��, ���������� ������������� ������������� � ��������� ��
        call    TransmitCommChar, [hComm], CH_ACK
        ; � ���������� ��������� �� ����������
        call    aux_sendTC                        ; � ���������� ����� � ������� ����������
        ; ��������� �� ������
        cmp     [@@cnt], 0
        jne     @@rd_toolong
    @@done_read:
        call    timeGetTime
        sub     eax, [@@time]
        cmp     eax, MAX_RCV_TIME-10
        jae     @@next_rtr
        ; ��� �������� ����� �������
        mov     ecx, MAX_RCV_TIME
        sub     ecx, eax
        call    Sleep, ecx

        ; ������� � ���������� �������������
  @@next_rtr:
        mov     eax, [rtrCur]
        inc     eax
        cmp     eax, [numRTR]
        jb      @@next_done
        xor     eax, eax
    @@next_done:
        mov     [rtrCur], eax
        ; ��������� �� ���� �� ����������� ������
        call    WaitForSingleObject, [auxMutex], 5
        cmp     eax, WAIT_TIMEOUT
        je      @@while
    @@exit:
        ret

    @@wr_error:
        ; ������ ������ � ����
        call    GetLastError
        invoke  con_printf, <"AUX: write error with code: %i",13,10>, eax
        jmp     @@flash
    @@rd_error:
        ; ������ ������ �� �����
        call    GetLastError
        invoke  con_printf, <"AUX: read error with code: %i",13,10>, eax
        lea     esi, [@@com]
        call    util_RtlZeroMemory, esi, size COMSTAT
        lea     ecx, [@@msk]
        call    ClearCommError, [hComm], ecx, esi
        jmp     @@flash

    @@rd_toolong:
        ; ������-�� � ������ ��� �������� �������
        invoke  con_printf, <"AUX: packet TC is too long!\n",13,10>
        jmp     @@flash

    ; ������ ����� "���" �� ������
    @@NAK:
        mov     eax, [rtrCur]
        test    [rtrFlags+eax], RTR_OPROS
        jz      @@end_nak
        test    [rtrFlags+eax], RTR_ZAPROS
        jz      @@end_nak
        ; ����� ������
        and     [rtrFlags+eax], not RTR_OPROS
      @@end_nak:
        jmp     @@done_read     ; <- ����������� ����� ������

    ; ���� ������� � ���������� ������ � ��� ������� �������� �����
    @@flash:
        call    Sleep, 1000
        lea     esi, [auxBuff]
        lea     eax, [@@cnt]
        call    ReadFile, [hComm], esi, 20, eax, 0
        call    PurgeComm, [hComm], PURGE_TXABORT+PURGE_RXABORT+PURGE_TXCLEAR+PURGE_RXCLEAR
        jmp     @@next_rtr      ; <- ��������� � ���������� �������������




  ; ���������� �� ��� �������� �������������
  ; �� ������:
  ;   eax       - len
  ;   esi       - ������ ��
  @@get_tu:
        mov     edi, [rtrCur]
        call    WaitForSingleObject, [rtrMutex+edi*4], INFINITE
        lea     esi, [@@tu]
        and     [rtrFlags+edi], not RTR_ZAPROS
        call    queue_Get, [rtrQueue+edi*4], esi
        or      eax, eax
        jz      @@new_tu
        xor     eax, eax
        lodsb
        cmp     [byte esi+5], '~'
        jne     @@tu_ret
        or      [rtrFlags+edi], RTR_OPROS
      @@tu_ret:
        push    eax
        call    ReleaseMutex, [rtrMutex+edi*4]
        pop     eax
        retn
        ; ������� �����, ��������� ������
    @@new_tu:
        or      [rtrFlags+edi], RTR_ZAPROS
        mov     eax, edi
        inc     eax
        lea     esi, [cmdReq]
        or      al, '0'
        mov     [esi+4], al
        mov     eax, lenReq
        jmp     @@tu_ret

endp


; ����������� ��� �� ��� �� � ������
; �� �����:
;    cmd        - ��� �� ��� ��
; �� ������:
;    eax        - ������ � ��������� ����
proc aux_CodeToStr, @@cmd
        mov     eax, [@@cmd]
        cmp     eax, numCodes
        jb      @@1
        xor     eax, eax
    @@1:
        mov     eax, [lpszCodes+eax*4]
        ret
endp




end


�����           #02,'#','\',"00", 'm' ,"000",#03
������          #02,'#','\',"00", 'a' ,"000",#03
������� ��      #02,'#','\',"00", 'i' ,"000",#03
����.���������� #02,'#','\',"00", 'e' ,"000",#03
����.���������  #02,'#','\',"00", 'c' ,"000",#03
�������         #02,'#','\',"00", '}' ,"000","!","7",#03
                                              ^   ^
                                              |   |
                                              |   +-����� ������
                                              +-������� �������� ������ ������

����            #02,'#','\',"00",'/',"6",'w',"000",#03
����            #02,'#','\',"00",'/',"6",'s',"000",#03
������          #02,'#','\',"00",'/',"6",'n',"000","!","7",#03
                                  ^   ^             ^   ^
                                  |   |             |   +-����� ������
                                  |   |             +-������� �������� ������ ������
                                  |   +-����� ��������� (3Bh ��� ����������)
                                  +-������� ��� �������
  ������������
  ������
  ��������
  ����� ������



���������       #02,'#','\',"00",'/',"9",'x',"000",#03
                                      ^
                                      |
                                      +-����� ���������� ���������

��� ��          #02,'#','\',"00",'/',"8",'j',"000",#03
                                  ^   ^
                                  |   |
                                  |   +-��� ��
                                  +-������� ��� �������

1: ��� �� / ���. ����. ��������� / ���. ����� (��� 3B) / ����� ������
2: ����� ������

