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
include         "console.inc"
include         "util.inc"




dataseg
  dbgType       db 0
  hCon          HANDLE 0


codeseg


proc dbg_Create, @@dev: byte
        mov     al, [@@dev]
        cmp     al, DEBUG_CONSOLE
        je      @@con
        cmp     al, DEBUG_FILE
        je      @@file
        xor     al, al
    @@exit:
        mov     [dbgType], al
        ret
    @@file:     ; отладка в файл
        jmp     @@exit
    @@con:      ; отладка в консоль
        call    con_Create
        jmp     @@exit

endp



proc con_Create uses eax
        call    AllocConsole
        invoke  CreateFile, "CONOUT$", GENERIC_READ+GENERIC_WRITE, FILE_SHARE_READ+FILE_SHARE_WRITE,0,OPEN_EXISTING,0,0
        mov     [hCon], eax
        ret
endp


; добавляет в лог (консоль или в файл) строку (в ANSI-формате)
proc con_AddString, @@lpString
  local @@t
        mov     al, [dbgType]
        cmp     al, DEBUG_FILE
        jne     @@chkcon
        ; вывод в файл
        invoke  CreateFile, "alarm.log", GENERIC_WRITE, FILE_SHARE_WRITE or FILE_SHARE_READ, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
        mov     ebx, eax
        cmp     eax, INVALID_HANDLE_VALUE
        je      @@exit
        call    SetFilePointer, ebx, 0, 0, FILE_END
        call    @@save
        call    CloseHandle, ebx
        jmp     @@exit
    @@chkcon:
        cmp     al, DEBUG_CONSOLE
        jne     @@exit
        mov     ebx, [hCon]
        or      ebx, ebx
        jz      @@exit
        call    @@save
    @@exit:
        ret

  @@save:
        mov     esi, [@@lpString]
        call    lstrlenA, esi
        lea     edx, [@@t]
        call    WriteFile, ebx, esi, eax, edx, 0
        lea     edx, [@@t]
        retn
endp


proc con_printf CPP uses eax ebx ecx edx esi edi, @@frmStr, @@va_list: dword:?
  local @@buf:TCHAR:2048
  local @@ansi: byte:1024
        ; формируем дату и время записи
        lea     edx, [@@buf]
        call    con_PutDate, edx
        mov     esi, eax
        ; форматируем в буфер параметры
        lea     edx, [@@va_list]
        call    wvsprintf, esi, [@@frmStr], edx
        lea     esi, [@@buf]
        ifdef @unicode
            ; переводим юникод в ANSI
            lea     edi, [@@ansi]
            xchg    esi, edi
            call    UnicodeToANSI, esi, edi
        endif
        call    con_AddString, esi
        ret
endp


proc con_printa CPP uses eax ebx ecx edx esi edi, @@lpArray, @@nSize
  local @@buf:BYTE:2048
        mov     ecx, [@@nSize]
        jecxz   @@exit
        mov     esi, [@@lpArray]
        lea     edi, [@@buf]

    @@loop:
        lodsb
        cmp     al, ' '
        jb      @@hex
        mov     ah, "'"
        xchg    al, ah
        stosb
        xchg    al, ah
        stosb
        xchg    al, ah
        stosb
    @@next:
        dec     ecx
        jz      @@done
        mov     al, ','
        stosb
        jmp     @@loop

    @@done:
        xor     eax, eax
        stosb
        lea     edx, [@@buf]
        call    con_AddString, edx
        invoke  con_AddString, <"",13,10>

    @@exit:
        ret

    @@hex:
        ; переводим символ в hex-строку
        call    util_Byte2Hex
        jmp     @@next
endp





ifdef @unicode

; конвертирует BSTR строку в ANSI
; возвращает указатель на сформированную строку
proc UnicodeToANSI uses edx, @@lpAnsiStr, @@lpBStr
  local @@len
        call    lstrlenW, [@@lpBStr]
        inc     eax                     ; резервируем место для завершающего нуля
        mov     [@@len], eax
        xor     edx, edx
        call    WideCharToMultiByte, edx, edx, [@@lpBStr], -1, [@@lpAnsiStr], [@@len], edx, edx
    @@done:
        ret
endp

endif   ; @unicode


;
; формирует в буфер @@lpBuff текущую дату и время
; на выходе:
;    eax - адрес за последним символом
;
proc con_PutDate uses edi, @@lpBuff
  local @@time: SYSTEMTIME
        mov     edi, [@@lpBuff]
        ; формируем дату
        mov     eax, '['
        stos    [large TCHAR edi]
        lea     eax, [@@time]
        call    GetLocalTime, eax
        mov     ax, [@@time.wDay]
        mov     [@@time.wDayOfWeek], ax
        lea     edx, [@@time.wYear]
        call    util_DateToStr
        mov     eax, ' '
        stos    [large TCHAR edi]
        ; формируем время
        lea     edx, [@@time.wHour]
        call    util_TimeToStr
        mov     eax, ']'
        stos    [large TCHAR edi]
        mov     eax, ' '
        stos    [large TCHAR edi]
        mov     eax, edi
        ret
endp



end
