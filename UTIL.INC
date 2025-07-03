DATE_DELIMITER  = '-'           ; символ разделитель для даты
TIME_DELIMITER  = ':'           ; символ разделитель для времени


; пpеобpазуем номеp объекта в стpоку
; на входе:
;       eax     - number
;       edi     - buffer
procdesc util_Int2Name

; на входе:
;       eax     - номер объекта
;       edi     - буфер
procdesc util_ID2Name

ifdef @unicode
; переводит номер объекта в ascii строку (независимо от юникода)
; на входе:
;       eax     - номер объекта
;       edi     - буфер
procdesc util_ID2Ascii
endif

; пpеобpазуем число в стpоку
; на входе:
;       eax     - number
;       edi     - buffer
procdesc util_Int2Str


; перевод символа в hex-строку, вида 0xXX
; на входе:
;       al      - символ
;       edi     - буфер
; на выходе:
;       edi     - конец буфера
procdesc util_Byte2Hex


procdesc util_RtlZeroMemory     @@lpBuff: dword, @@nSize: dword


; преобразование даты в символьный формат
; на входе:
;       esi     - выходная строка
;       edx     - структура DATA_STRUCT
procdesc util_DateToStr

; преобразование времени в символьный формат
; на входе:
;       esi     - выходная строка
;       edx     - структура TIME_STRUCT
procdesc util_TimeToStr

; на входе:
;       edi     - выходная строка
;       dl      - доп. байт извещения ТС
; на выходе:
;       edi     - строка
procdesc util_TCParam


procdesc util_GetModulePath     @@lpszPath: LPTCHAR, @@len: DWORD

procdesc err_ShowLastError      @@hWnd: dword, @@lpszModule: dword, @@lpszFunc: dword
procdesc err_ShowUserError      @@hWnd: dword, @@lpszModule: dword, @@lpszFunc: dword, @@lpszStr: dword




macro SAFE_DELETE obj:req
  local @@1
        xor     ecx, ecx
        xchg    ecx, &obj
        jecxz   @@1
        call    DeleteObject, ecx
    @@1:
endm

macro SAFE_CLOSE handl:req
  local @@1
        xor     ecx, ecx
        xchg    ecx, &handl
        jecxz   @@1
        call    CloseHandle, ecx
    @@1:
endm
