; эмуляция приема пакета ТС
; вставляется в файл ALARM.ASM

dataseg
  c1            db 02,'#','\',"01",77h,"005",03  ; взят
  c2            db 02,'#','\',"01",77h,"008",03  ; взят
  c3            db 02,'#','\',"01",77h,"010",03  ; взят
  c4            db 02,'#','\',"01",77h,"011",03  ; взят
  c5            db 02,'#','\',"01",77h,"015",03  ; взят
  c6            db 02,'#','\',"01",77h,"021",03  ; взят
  t1            db 02,'#','\',"01",7Dh,"011",03  ; тревога
  t2            db 02,'#','\',"01",73h,"011",03  ; снят
  t3            db 02,'#','\',"01",61h,"010",03  ; авария
  t4            db 02,'#','\',"01",63h,"051",03  ; напр. подключено
  t5            db 02,'#','\',"01",66h,"000",03  ; УО вскрыт
  t6            db 02,'#','\',"01",69h,"101",03  ; подмена УО
  t7            db 02,'#','\',"01",6Dh,"108",03  ; наряд
  t8            db 02,'#','\',"01",6eh,"000",03  ; не взят

  sendTC        dd c1, c2, c3, c4, c5, c6, t1, t2, t3, t4, t5, t6, t7, t8, 0
  curTC         dd sendTC


codeseg

; таймер засылает цепочку пакетов ТС
proc app_Timer uses ebx esi edi, @@hWnd, @@uMsg, @@idEvent, @@dwTime
        mov     esi, [curTC]
        mov     esi, [esi]
        or      esi, esi
        jz      @@deltimer
        lea     edi, [tcBuf]
    @@copy:
        lodsb
        stosb
        cmp     al, 03
        jne     @@copy
        add     [curTC], 4
        call    aux_sendTC
        xor     eax, eax
        ret
    @@deltimer:
        mov     [curTC], offset sendTC
        call    KillTimer, [@@hWnd], [@@idEvent]
        xor     eax, eax
        ret
endp


;UnregisterHotKey
proc OnKeyDown uses ebx esi edi, @@hWnd, @@wParam, @@lParam
        ...
        ...
        cmp     ebx, VK_F1
        je      @@send1

        ...
        ...
        ...

    @@send1:    ; посылаем цепочку команд в ПЦН
        mov     eax, offset sendTC
        mov     [curTC], eax
        call    SetTimer, [hWndApp], 0, 1000, offset app_Timer
        xor     eax, eax
        ret

        ...
endp


