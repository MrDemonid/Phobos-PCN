        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; pазpешаем локальные идентефикатоpы
        jumps           ; разрешаем оптимизацию переходов

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



MAX_RCV_TIME    = 1500  ; время на чтение ответа ретранслятора в ms


; спец символы протокола обмена (КОИ-7)
CH_STX          = 02h   ; нач. текста
CH_ETX          = 03h   ; кон. текста
CH_ACK          = 06h   ; подтверждение ("ДА")
CH_NAK          = 15h   ; "НЕТ"
CH_INF          = 23h   ; признак извещения телесигнализации (ответ от ретранслятора)
CH_CMD          = 24h   ; признак команды телеуправления (запрос на ретранслятор)
CH_SPI          = 5Ch   ; признак сообщения СПИ Фобос

CH_XOZ          = 2Fh   ; признак передачи номера хозоргана
CH_SLF          = 21h   ; признак передачи номера шлейфа

; флаги состояния потоков чтения и записи порта (auxStatus)
INP_NAK         = 1     ; был принят символ "НЕТ" от РТР
INP_TC          = 2     ; был принят пакет ТС от РТР
INP_PROCEEDTC   = 4     ; поток находится в состоянии приема ТС от РТР
OUT_WAIT        = 8     ; требуется ожидание результата записи в порт

; константы
MAX_QUEUE       = 32    ; глубина очереди сообщений на каждый ретранслятор
MAX_TC_LEN      = 28    ; макс. длина пакета ТС
MAX_LINES       = 4     ; макс. шлейфов на ключе

; биты флагов ретрансляторов (rtrFlags)
;RTR_ENABLE      = 1     ; ретранслятор присутствует
RTR_BADSTATUS   = 4     ; был отказ ретранслятора (при восстановлнии сбрасывается)
RTR_OPROS       = 16    ; при первом ответе "НЕТ" сообщить приложению
RTR_ZAPROS      = 80h   ; посылаем запрос, а не команду ТУ

dataseg
  hComm         HANDLE 0        ; хэндл порта
  hThread       HANDLE 0        ; хэндл потока чтения
  auxMutex      HANDLE 0        ; мьютекс потока чтения

; таблица команд ТУ
  tu1   db TU_PICKUP    , 10,02,24h,5Ch,"00",70h,"000",03     ; "Взять сразу"
  tu2   db TU_REMOVE    , 10,02,24h,5Ch,"00",6Eh,"000",03     ; "Снять"
  tu3   db TU_TAKEAFTER , 10,02,24h,5Ch,"00",71h,"000",03     ; "Взять после выхода"
  tu4   db TU_STATUSUO  , 10,02,24h,5Ch,"00",7Ah,"000",03     ; "Запрос УО"
  tu5   db TU_REQUESTON , 07,02,24h,5Ch,"00",7Eh,03           ; "Запрос взятых"
  tu6   db TU_REQUESTOFF, 08,02,24h,5Ch,"00",7Eh,'1',03       ; "Запрос снятых"
  tu7   db TU_CONNECT   , 10,02,24h,5Ch,"00",7Ch,"000",03     ; "Подключить направление"
  tu8   db TU_DISCONNECT, 10,02,24h,5Ch,"00",7Bh,"000",03     ; "Отключить направление"
  tu9   db TU_GETTYPEUO , 10,02,24h,5Ch,"00",6Fh,"000",03     ; "Определить тип УО"

  tuTable       dd tu1, tu2, tu3, tu4, tu5, tu6, tu7, tu8, tu9, 0



; таблица перекодировки сообщений ТС
  xlatTable     db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 1
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 2
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 3
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 4
                db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 5
                db 0, TC_ACCIDENT, 0, TC_KEYDISCONNECT, 0, TC_KEYCONNECT, TC_UOOPEN, TC_UOCLOSE, TC_KZ, TC_REPLACEMENT, TC_TYPEUO, 0, 0, TC_ATTIRE, TC_NOTTAKEN, 0 ; 6
                db 0, 0, 0, TC_REMOVED, 0, 0, 0, TC_TAKEN, TC_TEHNOLOGICAL, 0, 0, 0, 0, TC_ALERT, 0, 0 ; 7

; пакет ТУ "запрос ретранслятора"
    align 4
  cmdReq        db 02, 24h, 5Ch, "00", 7Ah, 03h
      lenReq    = $-cmdReq
    align 4
  cmdACK        db 06h          ; символ "ДА", для подтверждения получения ТС

  ;--------------------------------
    align 4
  TEXT szCOM    "\\.\COM1"      ; по умолчания COM1


; таблица преобразования кодов ТС и ТУ в текстовый вид

  TEXT szt0     "-"
  TEXT szt1     "Авария"
  TEXT szt2     "Направление подключено"
  TEXT szt3     "Направление отключено"
  TEXT szt4     "Замыкание"
  TEXT szt5     "Подмена УО"
  TEXT szt6     "Определенный тип УО"
  TEXT szt7     "Наряд"
  TEXT szt8     "Невзят"
  TEXT szt9     "Снят"
  TEXT szt10    "Взят"
  TEXT szt11    "Технологическая"
  TEXT szt12    "Тревога"
  TEXT szt13    "Вскрытие УО"
  TEXT szt14    "Восстановление УО"
  TEXT szt15    "Отказ ретранслятора"
  TEXT szt16    "Восстановление ретранслятора"
  TEXT szt17    "РТР: Снят"
  TEXT szt18    "РТР: Взят"
  TEXT szt19    "Взять сразу"
  TEXT szt20    "Снять"
  TEXT szt21    "Взять после выхода"
  TEXT szt22    "Запрос состояния УО"
  TEXT szt23    "Запрос взятых"
  TEXT szt24    "Запрос снятых"
  TEXT szt25    "Подключить направление"
  TEXT szt26    "Отключить направление"
  TEXT szt27    "Определить тип УО"

        align 4
  lpszCodes     dd szt0, szt1, szt2, szt3, szt4, szt5, szt6, szt7, szt8, szt9, szt10
                dd szt11, szt12, szt13, szt14, szt15, szt16, szt17, szt18, szt19, szt20
                dd szt21, szt22, szt23, szt24, szt25, szt26, szt27
  numCodes      = ($-lpszCodes)/4



udataseg
  isStop        db ?            ; флаг завершения работы потока чтения/записи порта
  rtrCur        dd ?            ; текущий ретранслятор [0..MAX_RTR-1]

  rtrFlags      db MAX_RTR dup(?) ; список задействованных в опросе ретрансляторов
  rtrQueue      dd MAX_RTR dup(?) ; очередь сообщений для каждого ретранслятора
  rtrMutex      dd MAX_RTR dup(?) ; мьютексы для каждого ретранслятора

  tcBuf         db 128 dup(?)   ; буфер для принятых команд TC
  tcPos         dd ?            ; текущая позици в tcBuff

  auxBuff       db 128 dup(?)   ; буфер приема
;---------------


  tcSend        db 128 dup(?)



codeseg


; формирует и помещает ТУ в очередь
; на входе
;   rtrNum      - номер ретранслятора [1..MAX_RTR]
;   keyNum      - номер направления (ключа) [0..119]
;   cmdTU       - тип команды ТУ
proc aux_SendTU uses ebx esi edi, @@rtrNum, @@keyNum, @@cmdTU
  local @@size
        ; ищем команду по таблице
        lea     esi, [tuTable]
        mov     edx, [@@cmdTU]
    @@find:
        lodsd
        or      eax, eax
        jz      @@exit          ; -> нет такой команды
        cmp     dl, [eax]
        jne     @@find
        ; нашли
        xor     edx, edx
        mov     dl, [byte eax+1]     ; dl - размер посылки
        lea     esi, [eax+2]
        mov     [@@size], edx
        ; ставим номер ретранслятора
        mov     eax, [@@rtrNum]
        mov     ebx, eax
        cmp     al, [byte numRTR]
        ja      @@exit
        or      al, '0'
        mov     [esi+4], al
        ; и номер ключа, если нужен
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
        ; добавляем команду в базу данных
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

; парсит ТС и отсылает уведомление приложению
; на входе:
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
        ; проверяем
        cmp     edi, 10
        jb      @@false         ; <- пакет минимум 10 символов
        lodsd
        cmp     eax, 305c2302h  ; <#02,'#','\',"0">
        jne     @@false
        ; извлекаем данные из пакета
        xor     eax, eax
        lodsb                   ; получаем номер ретранслятора
        sub     al, '0'
        js      @@false
        cmp     al, 9
        ja      @@false
        mov     [@@rtr], eax
        dec     al              ; номер ретранслятора в [0..MAX_RTR-1]
        js      @@false
        mov     [@@dst], eax
        lodsb
        cmp     al, '/'
        jne     @@get_cmd
        ; ВЗЯТ, СНЯТ, НЕВЗЯТ, СЛУЖЕБНОЕ, ТИП УО
        ; считываем номер хозоргана или типа УО или служ. сообщения
        lodsb
        mov     [@@hoz], al
        lodsb
        ; извлекаем код ТС и перекодируем в более удобный вид
    @@get_cmd:
        mov     al, [xlatTable+eax]
        or      eax, eax
        jz      @@false
        mov     [@@cmd], eax
        ; извлекаем номер направления (ключа)
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
        jae     @@false         ; <- странный ключ
        xor     eax, eax
        lodsb
        cmp     al, '!'
        jne     @@done
        ; извлекаем номер шлейфа
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
        ; посылаем сообщене приложению
; HI(lParam) - LO(номер шлейфа), HI(hoz)
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
        ; добавляем команду в базу данных
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
    ; HI(wParam) - ретранслятор
    ; LO(wParam) - номер ключа
    ; HI(lParam) - LO(номер шлейфа), HI(hoz)
    ; LO(lParam) - cmd




proc aux_Open uses ebx esi edi, @@nPort: byte
  local @@dcb: DCB
  local @@time: COMMTIMEOUTS
        ; настраиваем очередь сообщений ТУ
        xor     esi, esi
    @@make_queue:
        cmp     esi, [numRTR]
        jae     @@setup_port
        call    queue_Create, MAX_QUEUE
        mov     [rtrQueue+esi*4], eax
        mov     [rtrFlags+esi], 0
        ; создаем мьютекс для данной очереди
        call    CreateMutex, NULL, FALSE, NULL
        mov     [rtrMutex+esi*4], eax
        inc     esi
        jmp     @@make_queue

    @@setup_port:
; все ОК, уходим
;or      eax, -1
;ret

        ; настраиваем порт
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
    ; создаем мьютекс потока чтения
        call    CreateMutex, NULL, TRUE, NULL
        mov     [auxMutex], eax
    ; обнуляем евенты
        call    SetCommMask, esi, 0
        ISZ,    @@error
    ; сбрасываем порт
        call    PurgeComm, esi, PURGE_TXABORT+PURGE_RXABORT+PURGE_TXCLEAR+PURGE_RXCLEAR
        ISZ,    @@error
    ; задаем настpойки поpта
        call    SetCommState, esi, ebx
        ISZ,    @@error
; настраиваем текущие параметры таймаутов под 200 бит в сек (11 бит на символ)
; время на прием одного символа:
;     RD_READ = 11 bit / 200 bod = 55 миллисекунд
; макс. задержка между приемами двух символов:
;     RD_WAIT = RD_READ / 2 = 27 мсек
; общее макс. время на прием одного символа:
;     RD_TIME = RD_READ+RD_WAIT
; добавочное время на пакет, на непредвиденные обстоятельства:
;     RD_ADD = 150 миллесекунд
; общее время пакета расчитывается по формуле:
;     (NumOfChar * ReadTotalTimeoutMultiplier) + ReadTotalTimeoutConstant
; т.е.:
;     (NumOfChar * RD_TIME) + RD_ADD

AUX_READ_CHAR = (11 * 1000) / 200  ; 55 ms; (+ 10 на всякий случай)
AUX_WAIT_CHAR = 5                 ; 3 ms  (+ 5 на всякий случай)
AUX_TOTAL_TIME = AUX_READ_CHAR + AUX_WAIT_CHAR
AUX_TOTAL_ADD  = 100

        xor     ebx, ebx
        lea     edx, [@@time]
        mov     [@@time.ReadIntervalTimeout], AUX_WAIT_CHAR           ; макс. интервал между чтениями двух символов
        mov     [@@time.ReadTotalTimeoutMultiplier], AUX_TOTAL_TIME ; время приема одного символа + интервал до начала чтения следующего символа
        mov     [@@time.ReadTotalTimeoutConstant], AUX_TOTAL_ADD       ; константа, на всякие непредвиденные задержки в приеме
        mov     [@@time.WriteTotalTimeoutMultiplier], AUX_TOTAL_TIME
        mov     [@@time.WriteTotalTimeoutConstant], ebx
        call    SetCommTimeouts, esi, edx
        ISZ,    @@error
    ; ставим евент на пришедшие данные
        call    SetCommMask, esi, EV_RXCHAR
        ISZ,    @@error
    ; запускаем тpед, для обpаботки эвентов поpта
        call    CreateThread, ebx, ebx, offset aux_Thread, ebx, ebx, ebx
        mov     [hThread], eax
        ISZ,    @@error
    ; задаем Real-Time приоритет
        call    SetThreadPriority, eax, 15

    ; все ОК, уходим
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
        ; останавливаем поток чтения
        invoke  con_printf, <"close aux thread",13,10>
        call    ReleaseMutex, [auxMutex]
        call    WaitForSingleObject, [hThread], 10000

        invoke  con_printf, <"free COM-port",13,10>
        ; освобождаем порт
        mov     ebx, [hComm]
        or      ebx, ebx
        jz      @@del_queue
        call    SetCommMask, ebx, NULL   ; обнуляем евенты
        call    PurgeComm, ebx, PURGE_TXABORT+PURGE_RXABORT+PURGE_TXCLEAR+PURGE_RXCLEAR
        SAFE_CLOSE ebx

        ; удаляем очередь сообщений ТУ   (ebx должен быть равен нулю)
    @@del_queue:
        cmp     ebx, [numRTR]
        jae     @@exit
        ; удаляем мьютекс
        mov     ecx, [rtrMutex+ebx*4]
        jecxz   @@1
        call    CloseHandle, ecx
      @@1:
        ; удаляем очередь сообщений
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

        ; обнуляем переменные
        invoke  con_printf, <"Start aux thread.",13,10>
        xor     eax, eax
        mov     [rtrCur], eax

    @@while:
        call    @@get_tu                ; получаем ТУ для текущего ретранслятора
        lea     edx, [@@cnt]
        call    WriteFile, [hComm], esi, eax, edx, 0
        or      eax, eax
        jz      @@wr_error

    ; начинаем чтение ответа от ретранслятора
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
        je      @@NAK           ; <- ответ "НЕТ", уходим на следующий ретранслятор

        ; сканируем буфер на символ конца пакета
    @@scan:     ; while (cnt)
        cmp     [@@cnt], 0
        je      @@read
        dec     [@@cnt]
        lodsb
        stosb
        cmp     al, CH_ETX
        jne     @@scan
        ; это конец пакета ТС, отправляем ретранслятору подтверждение о получении ТС
        call    TransmitCommChar, [hComm], CH_ACK
        ; и отправляем пришедший ТС приложению
        call    aux_sendTC                        ; и отправляем пакет в очередь приложения
        ; проверяем на ошибки
        cmp     [@@cnt], 0
        jne     @@rd_toolong
    @@done_read:
        call    timeGetTime
        sub     eax, [@@time]
        cmp     eax, MAX_RCV_TIME-10
        jae     @@next_rtr
        ; еще осталось время поспать
        mov     ecx, MAX_RCV_TIME
        sub     ecx, eax
        call    Sleep, ecx

        ; переход к следующему ретранслятору
  @@next_rtr:
        mov     eax, [rtrCur]
        inc     eax
        cmp     eax, [numRTR]
        jb      @@next_done
        xor     eax, eax
    @@next_done:
        mov     [rtrCur], eax
        ; проверяем не пора ли заканчивать работу
        call    WaitForSingleObject, [auxMutex], 5
        cmp     eax, WAIT_TIMEOUT
        je      @@while
    @@exit:
        ret

    @@wr_error:
        ; ошибка записи в порт
        call    GetLastError
        invoke  con_printf, <"AUX: write error with code: %i",13,10>, eax
        jmp     @@flash
    @@rd_error:
        ; ошибка чтения из порта
        call    GetLastError
        invoke  con_printf, <"AUX: read error with code: %i",13,10>, eax
        lea     esi, [@@com]
        call    util_RtlZeroMemory, esi, size COMSTAT
        lea     ecx, [@@msk]
        call    ClearCommError, [hComm], ecx, esi
        jmp     @@flash

    @@rd_toolong:
        ; почему-то в буфере еще остались символы
        invoke  con_printf, <"AUX: packet TC is too long!\n",13,10>
        jmp     @@flash

    ; пришел ответ "НЕТ" на запрос
    @@NAK:
        mov     eax, [rtrCur]
        test    [rtrFlags+eax], RTR_OPROS
        jz      @@end_nak
        test    [rtrFlags+eax], RTR_ZAPROS
        jz      @@end_nak
        ; конец опроса
        and     [rtrFlags+eax], not RTR_OPROS
      @@end_nak:
        jmp     @@done_read     ; <- заканчиваем прием данных

    ; ждет секунду и сбрасывает буфера и все текущие операции порта
    @@flash:
        call    Sleep, 1000
        lea     esi, [auxBuff]
        lea     eax, [@@cnt]
        call    ReadFile, [hComm], esi, 20, eax, 0
        call    PurgeComm, [hComm], PURGE_TXABORT+PURGE_RXABORT+PURGE_TXCLEAR+PURGE_RXCLEAR
        jmp     @@next_rtr      ; <- переходим к следующему ретранслятору




  ; возвращает ТУ для текущего ретранслятора
  ; на выходе:
  ;   eax       - len
  ;   esi       - строка ТУ
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
        ; очередь пуста, формируем запрос
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


; преобразует код ТС или ТУ в строку
; на входе:
;    cmd        - код ТС или ТУ
; на выходе:
;    eax        - строка с описанием кода
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


НАРЯД           #02,'#','\',"00", 'm' ,"000",#03
АВАРИЯ          #02,'#','\',"00", 'a' ,"000",#03
ПОДМЕНА УО      #02,'#','\',"00", 'i' ,"000",#03
НАПР.ПОДКЛЮЧЕНО #02,'#','\',"00", 'e' ,"000",#03
НАПР.ОТКЛЮЧЕНО  #02,'#','\',"00", 'c' ,"000",#03
ТРЕВОГА         #02,'#','\',"00", '}' ,"000","!","7",#03
                                              ^   ^
                                              |   |
                                              |   +-номер шлейфа
                                              +-признак передачи номера шлейфа

ВЗЯТ            #02,'#','\',"00",'/',"6",'w',"000",#03
СНЯТ            #02,'#','\',"00",'/',"6",'s',"000",#03
НЕВЗЯТ          #02,'#','\',"00",'/',"6",'n',"000","!","7",#03
                                  ^   ^             ^   ^
                                  |   |             |   +-номер шлейфа
                                  |   |             +-признак передачи номера шлейфа
                                  |   +-номер хозоргана (3Bh при отсутствии)
                                  +-признак доп символа
  Ретранслятор
  Объект
  Хозорган
  Номер шлейфа



СЛУЖЕБНОЕ       #02,'#','\',"00",'/',"9",'x',"000",#03
                                      ^
                                      |
                                      +-номер служебного сообщения

ТИП УО          #02,'#','\',"00",'/',"8",'j',"000",#03
                                  ^   ^
                                  |   |
                                  |   +-тип УО
                                  +-признак доп символа

1: тип УО / ном. служ. сообщения / хоз. орган (или 3B) / номер шлейфа
2: номер шлейфа

