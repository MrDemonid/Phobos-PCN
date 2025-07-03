
; сообщения от ретранслятора
WM_RECEIVE              = WM_USER+100   ; HI(wParam) - ретранслятор
                                        ; LO(wParam) - номер ключа
                                        ; HI(lParam) - LO(номер шлейфа), HI(hoz)
                                        ; LO(lParam) - cmd

; коды извещения (TC) в WM_RECEIVE
TC_FIRST                = 1
TC_ACCIDENT             = 1     ; "Авария"
TC_KEYCONNECT           = 2     ; "Направление подключено"
TC_KEYDISCONNECT        = 3     ; "Направление отключено"
TC_KZ                   = 4     ; "Замыкание"
TC_REPLACEMENT          = 5     ; "Подмена УО"
TC_TYPEUO               = 6     ; "Определенный тип УО"
TC_ATTIRE               = 7     ; "Наряд"
TC_NOTTAKEN             = 8     ; "Не взят"
TC_REMOVED              = 9     ; "Снят"
TC_TAKEN                = 10    ; "Взят"
TC_TEHNOLOGICAL         = 11    ; "Технологическая"
TC_ALERT                = 12    ; "Тревога"
TC_UOOPEN               = 13    ; "Вскрытие УО"
TC_UOCLOSE              = 14    ; "Восстановление УО"
TC_RTRFAILURE           = 15    ; "Отказ ретранслятора"
TC_RTRRESTORE           = 16    ; "Восстановление ретранслятора"
TC_REMOVEDSILENT        = 17    ; "Снят" (по "Запрос снятых")
TC_TAKENSILENT          = 18    ; "Взят" (по "Запрос взятых")
TC_MAX                  = 18

; коды команд телеуправления (ТУ)
TU_PICKUP               = 19    ; "Взять сразу"
TU_REMOVE               = 20    ; "Снять"
TU_TAKEAFTER            = 21    ; "Взять после выхода"
TU_STATUSUO             = 22    ; "Запрос УО"
TU_REQUESTON            = 23    ; "Запрос взятых"
TU_REQUESTOFF           = 24    ; "Запрос снятых"
TU_CONNECT              = 25    ; "Подключить направление"
TU_DISCONNECT           = 26    ; "Отключить направление"
TU_GETTYPEUO            = 27    ; "Определить тип УО"


;TC_FAULT                = 15    ; "Неисправность"
;TC_RESET                = 16    ; "Сброс"
;TC_ATTENTION            = 17    ; "Внимание"
;TC_FIRE                 = 18    ; "Пожар"
;TC_PROTECTION           = 19    ; "Охрана"
;TC_SIGNALUO             = 20    ; "Уровень сигнала от УО
;TC_RTROPEN              = 5     ; "Крышка ретранслятора открыта"
;TC_RTRCLOSE             = 6     ; "Крышка ретранслятора закрыта"

                                        ; lParam     - код ТС




procdesc aux_Open       @@nPort: byte
procdesc aux_Close


; формирует и помещает ТУ в очередь
; на входе
;   rtrNum      - номер ретранслятора [1..MAX_RTR]
;   keyNum      - номер направления (ключа) [0..119]
;   cmdTU       - тип команды ТУ
procdesc aux_SendTU     @@rtrNum: dword, @@keyNum: dword, @@cmdTU: dword

; преобразует код ТС или ТУ в строку
; на входе:
;    cmd        - код ТС или ТУ
; на выходе:
;    eax        - строка с описанием кода
procdesc aux_CodeToStr  @@cmd: dword

