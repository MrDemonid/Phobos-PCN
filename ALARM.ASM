; параметры командной строки:
;   dc  - включить консоль отладки
;   df  - включить запись отладки в файл
;
        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; pазpешаем локальные идентефикатоpы
        jumps           ; разрешаем оптимизацию переходов

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
;¦=============================== КОНСТАНТЫ ================================¦
;+--------------------------------------------------------------------------+

;г==========================================================================¬
;¦--------------------------------- ДАННЫЕ ---------------------------------¦
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
  hPcn          HWND ?          ; хэндл окна эмулятора пульта ПЦН

  numRTR        dd ?            ; количество подключенных ретрансляторов

  szSetupFile   TCHAR MAX_PATH dup(?)

;г==========================================================================¬
;¦----------------------------------- КОД ----------------------------------¦
;L==========================================================================-

codeseg
    Start:
        call    app_Init
        jz      Exit            ; <- критическая ошибка, дальнейшая работа невозможна
        call    app_Run
    Exit:
        jmp     app_Done




;г==========================================================================¬
;¦----------------------------- ИНИЦИАЛИЗАЦИЯ ------------------------------¦
;L==========================================================================-

proc app_Init
        call    GetModuleHandle, 0
        mov     [hInstApp], eax
        ; инициализируем кучу
        call    GetProcessHeap
        mov     [hHeap], eax
        ; читаем параметры командной строки
        call    app_ReadCommandLine
;        ; открываем отладочную консоль
;        call    con_Create
        ; инициализируем расширенную версию ComCtrl32
        call    app_InitCommonControls

        ; регистрируем класс и создаем окно приложения
        call    app_CreateWindow
        invoke  con_printf, <"run programm",13,10>

        ; инициализируем базу данных
        call    log_Open, [hWndApp]     ; подключаем базу ведения логов
        ; инициализируем порт
        call    app_AuxInit
        ret
endp


proc app_AuxInit uses ebx esi
        lea     ebx, [szSetupFile]
        ; читаем значение порта
        invoke  GetPrivateProfileInt, <"AUX">, <"Port">, 0, ebx
        ; открываем порт
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






; разбор командной строки:
;   dc          - включить консоль отладки
;   df          - включить запись отладки в файл
proc app_ReadCommandLine
        call    GetCommandLine
        xchg    esi, eax                ; esi - адpес командной стpоки
        ; пропускаем имя програмы
        push    '"'
        xor     eax, eax
        lods    [large TCHAR esi]
        pop     edx                     ; edx = '"'
        cmp     eax, edx
        je      @@skip_name
        dec     edx
        dec     edx                     ; edx = ' '
    @@skip_name:
        lods    [large TCHAR esi]       ; подгружаем очередной символ
        or      eax, eax
        jz      @@done                  ; -> нет параметров
        cmp     eax, edx
        jne     @@skip_name
    @@while:
        ; читаем очередной параметр
        call    @@skip_space
        jz      @@done
        cmp     eax, '/'                ; параметр начинается с символа '/'
        je      @@get_char
        cmp     eax, '-'                ; или '-'
        jne     @@while                 ; -> пропускаем и читаем следующий
    @@get_char:
        ; уточняем параметр
        call    @@read_char
        cmp     eax, 'D'
        jne     @@next
        call    @@read_char
        cmp     eax, 'C'
        je      @@con_debug
        cmp     eax, 'F'
        je      @@file_debug
    @@next:
        ; переходим к следующему параметру
        jmp     @@while
    @@done:
        or      eax, -1
        ret

    @@con_debug:
        ; открываем отладочную консоль
        call    dbg_Create, DEBUG_CONSOLE
        jmp     @@next
    @@file_debug:
        ; записываем отладочную информацию в файл
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
        ; читаем очередной символ
        lods    [large TCHAR esi]
        ; и пеpеводим его в веpхний pегистp
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
        ; определяем размеры для окна приложения (по дефолту на весь экран)
        call    GetSystemMetrics, SM_CYSCREEN
        push    eax
        call    GetSystemMetrics, SM_CXSCREEN
        push    eax
        ; заполняем структуру WNDCLASSEX
        move    edi, "AlarmClassApp"
        push    esi             ; wc_hIconSm
        push    edi             ; wc_lpszClassName
        push    esi             ; wc_lpszMenuName
        push    esi             ; wc_hbrBackground - не используем
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
        ; pегистpиpуем класс создаваемого окна
        call    RegisterClassEx, esp


        add     esp, size WNDCLASSEX
        and     eax, 0ffffh
        pop     edx             ; width
        pop     ecx             ; height
        jz      @@error
        ; создаем окно
;        call    LoadMenu, ebx, IDR_MENU ; подгружаем меню
        WS_MAINSTYLE = WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN ;+WS_CLIPSIBLINGS
        invoke  CreateWindowEx, esi, edi, "Сигнализация ПАО Пензмаш", WS_MAINSTYLE, esi, esi, edx, ecx, esi, esi, ebx, esi
        mov     [hWndApp], eax
        or      eax, eax
        jz      @@error
        ; прорисовываем окно
        push    eax
        call    ShowWindow, eax, SW_SHOWNORMAL
        call    UpdateWindow

;        ; подгружаем таблицу горячих клавиш
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



;г==========================================================================¬
;¦------------------------------ ВЫПОЛНЕНИЕ --------------------------------¦
;L==========================================================================-

proc app_Run
  local @@msg:MSG
        xor     esi, esi
        lea     edi, [@@msg]
        ; входим в цикл обработки сообщений
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



;г==========================================================================¬
;¦---------------------------- ОКОННАЯ ФУНКЦИЯ -----------------------------¦
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
        ; начинаем набор номера
        call    Beep, 7000, 30
        or      edi, edi
        jnz     @@next
        ; это первый символ набора
        mov     [dword inpTxt], edi
        call    SetTimer, [hWndApp], 1, 10000, offset OnKeyWatch
    @@next:
        cmp     edi, 3
        je      @@done
        or      bl, '0'
        mov     [inpTxt+edi], bl
        inc     [inpNum]
        ; отображаем на "дисплей"
        call    disp_ShowTxt, offset inpTxt
        jmp     @@done


    @@take:     ; команда "взять сразу"
        mov     esi, TU_PICKUP
        jmp     @@do_cmd
    @@takeoff:  ; команда "снять"
        mov     esi, TU_REMOVE
        jmp     @@do_cmd
    @@takeafter:; команда "взять после выхода"
        mov     esi, TU_TAKEAFTER
        jmp     @@do_cmd
    @@do_cmd:
        call    Beep, 7000, 30
        call    KillTimer, [hWndApp], 1
        call    disp_Clear
        cmp     [inpNum], 3
        jne     @@noinput
        ; преобразуем номер направления в числовой вид
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
        ; получаем имя и путь файла настроек
        call    lstrlen, offset szSetupIni
        mov     edx, MAX_PATH-1
        sub     edx, eax
        lea     ebx, [szSetupFile]
        call    util_GetModulePath, ebx, edx
        call    lstrcat, ebx, offset szSetupIni
        ; создаем окно вкладок
        call    tab_Init, [@@hWnd]
        or      eax, eax
        jz      @@err1
        ; читаем настройки и добавляем по вкладке на каждый ретранслятор
        mov     [numRTR], 0
        lea     esi, [@@rtr]
        invoke  lstrcpy, esi, <"RTR1">

    @@newpage:
        ; читаем тип ретранслятора
        invoke  GetPrivateProfileInt, esi, <"Type">, 0, ebx
        cmp     eax, RTR_PHOBOS
        je      @@found
        cmp     eax, RTR_PHOBOS3
        jne     @@next_rtr
    @@found:
        push    eax
        inc     [numRTR]
        ; читаем название для вкладки ретранслятора
        lea     edi, [@@buff]
        invoke  GetPrivateProfileString, esi, <"Name">,<"Фобос">, edi, buflen, ebx
        ; добавляем вкладку для текущего ретранслятора
        pop     ecx
        invoke  tab_NewPage, edi, ecx, 10, 12
        or      eax, eax
        jz      @@errtab
        ; подгружаем ей иконку, если она есть
        call    tab_NewIcon, [numRTR], esi

        ; читаем настройки по задействованным ключам
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
        ; не смогли прочитать настройки, считаем что все ключи деактивированы
        mov     [@@nkey], 0

    @@get_bads:
        ; читаем настройки по неисправным ключам
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
        ; не смогли прочитать настройки, считаем что все ключи деактивированы
        mov     [@@nbad], 0
    @@setflags:
        lea     edx, [@@keys]
        call    tab_SetFlags, [numRTR], [@@nkey], edx, [@@nbad], edi

    @@next_rtr:
        ; переходим к считыванию параметров для следующего ретранслятора
        lea     edi, [esi+3*size TCHAR]
        movzx   eax, [TCHAR edi]
        inc     eax
        stos    [large TCHAR edi]
        cmp     eax, '0'+MAX_RTR
        jbe     @@newpage

        ; создаем окно ПЦН
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
        ; уничтожаем tab control
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

; сообщения от ретранслятора
; HI(wParam) - ретранслятор
; LO(wParam) - номер ключа
; HI(lParam) - LO(номер шлейфа), HI(hoz)
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
 ;       and     ecx, 0FFh     ; ecx - номер шлейфа
;        shr     edx, 8        ; edx - хозорган
;        and     edx, 0FFh

;        invoke  con_printf, <"rcv[%u], shleif: %u, hozorgan: 0x%X, cmd: 0x%X",13,10>, eax, ecx, edx, ebx
;        pop     ebx

;  @@1:
        call    tab_OnReceive, [@@wParam], [@@lParam]
        call    pcn_OnReceive, [@@wParam], [@@lParam]
        xor     eax, eax
        ret
endp

;г==========================================================================¬
;¦--------------------------- ЗАВЕРШЕНИЕ РАБОТЫ ----------------------------¦
;L==========================================================================-

proc app_Done
        ; закрываем базы данных
        call    log_Close               ; закрываем базу ведения логов
        ; закрываем COM-порт
        call    aux_Close
        ; уходим
        call    ExitProcess, 0
endp



end Start
