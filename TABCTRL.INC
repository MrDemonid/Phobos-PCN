; типы ретрансляторов
RTR_PHOBOS              = 1
RTR_PHOBOS3             = 3

; флаги .fStatus
TAB_MODIFIED    = 1h            ; были изменения с подключением/отключением ключей


; свойства ключей (.lpKeyHandles)
; константы KEY_XXXX в файле OWNER.INC


struc TAB
  hDisp         HWND ?          ; хэндл окна текущей страницы
  fStatus       dd ?            ; флаги состояния вкладки
  ; ретранслятор
  retID         dd ?            ; номер ретранслятора
  retType       dd ?            ; тип ретранслятора (PHOBOS_XX)
  ; ключи
  keyTotal      dd ?            ; количество ключей
  keyFirst      dd ?            ; номер первого ключа
  keyHor        dd ?            ; количество ключей по ширине окна
  keyVer        dd ?            ; количество ключей по высоте окна
;  keyFlags      LPDWORD ?       ; состояние и параметры ключей
  lpKeyHandles  LPHANDLE ?      ; хэндлы ключей
  ; разметка
  labVerFirst   dd ?            ; нач номер вертикальной разметки (для удобства)
  lpLabHandles  LPHANDLE ?      ; хэндлы разметки
ends

typedef LPTAB   ptr TAB

procdesc tab_Init         @@paren: HWND
procdesc tab_Done
procdesc tab_NewPage      @@lpszName: dword, @@retType: dword, @@keyHor: dword, @@keyVer: dword
procdesc tab_SetFlags     @@rtrID:dword, @@numKeys:dword, @@lpKeys: ptr byte, @@numBads:dword, @@lpBads: ptr byte

; подгружаем иконку из внешнего файла
; на входе:
;       nRTR    - номер ретранслятора (вкладки) [1..8]
;       Section - имя секции в INI-файле, где ищем имя файла с битмапом иконки
procdesc tab_NewIcon      @@nRTR: byte, @@szSection: LPTCHAR



; преобразуем номер ретранслятора и направления в абсолютный номер направления
; на входе:
;       rtr     - ретранслятор [1..8]
;       key     - направление [0..119]
; на выходе:
;       eax     - абсолютный номер направления [0..959]
procdesc tab_RtrToAbs     @@rtrID: dword, @@key: dword

; обратное преобразование
; на входе:
;       key     - абсолютный номер направления [0..959]
; на выходе:
;       edx     - ретранслятор [1..8]
;       eax     - направление [0..119]
procdesc tab_AbsToRtr     @@key: dword


;
procdesc tab_OnSize       @@x: dword, @@y:dword, @@width: dword, @@height: dword
procdesc tab_OnNotify     @@hWnd: HWND, @@wParam: dword, @@lParam: dword
procdesc tab_OnDispChange @@hWnd: HWND, @@wParam: dword, @@lParam: dword
procdesc tab_OnReceive    @@wParam: dword, @@lParam: dword

