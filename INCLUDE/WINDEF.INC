@unicode = 1


;========================================================================
;
;       BASIC TYPES
;
;========================================================================
NULL                    equ     0       ; null
TRUE                    equ     1       ; boolean true
FALSE                   equ     0       ; boolean false

typedef ACHAR           BYTE            ; ansi character
typedef WCHAR           WORD            ; unicode character

ifndef @unicode
        typedef TCHAR   ACHAR
    else
        typedef TCHAR   WCHAR
endif

typedef HWND            DWORD
typedef HDLG            DWORD
typedef HANDLE          DWORD
typedef HINSTANCE       DWORD
typedef HDC             DWORD
typedef HBRUSH          DWORD
typedef HPEN            DWORD
typedef HFONT           DWORD

typedef LPVOID          PTR BYTE
typedef LPDWORD         PTR DWORD
typedef LPCHAR          PTR BYTE        ; указатель на строку (ascii)
typedef LPTCHAR         PTR TCHAR       ; указатель на строку (unicode)
typedef LPBYTE          PTR BYTE
typedef LPHANDLE        PTR HANDLE
typedef LPHWND          PTR HWND


macro %ifdef cond, text:VARARG
ifdef cond
  irp @i, <text>
   @i
  endm
endif
endm


macro _TEXTA @name, text: rest
  @name equ <db &text&, 0>
endm

macro _TEXTW @name, text: vararg
    @@out equ <>
    irp @i, <text>
        @@pos instr <&@i>, <">
        if @@pos
            @@len SizeStr <&@i>
            ??str SubStr <&@i>, 2, @@len-2
%           irpc @c, <??str>
                @@pos instr <®АБ™™™ѓ£КМОН°ПјЅ¬√ƒ≈∆«»… ЋћЌќѕ–—“”‘’÷„ЎўЏџ№Ёёяабвгдежзийклмнопрстуфхцчшщъыьэю€®Є>, <&@c>
                if @@pos
                    @@pos = @@pos+401h
                    @@txt equ % @@pos
                else
                    @@txt equ '&@c&'
                endif
                @@out CatStr @@out, <,>, @@txt
            endm
        else
            @@txt equ % @i
            @@out CatStr @@out, <,>, @@txt
        endif
    endm
    @@out SubStr @@out, 2     ;; удал€ем зап€тую в начале строки
    @name CatStr <dw >, @@out, <,0>
endm

macro TEXTA name: req, string: rest
    _TEXTA <@txt>, string
  dataseg
%   name @txt
  codeseg
endm

macro TEXT name: req, string: rest
    ifdef @unicode
        _TEXTW <@txt>, string
    else
        _TEXTA <@txt>, string
    endif
  dataseg
%   name @txt
  codeseg
endm


macro STRING @@out, @@string: rest
  local @@str
    TEXT <@@str>, @@string
    @@out equ <offset @@str>
endm

macro PARAM @@out, @@arg: VARARG
    @@out equ <>
    irp @i, <&@@arg>
        @@pos instr <@i>, <">
        if @@pos eq 1
            STRING <@txt>, &@i
            @@out catstr @@out, <,>, @txt
        else
            @@out catstr @@out, <,>, <@i>
        endif
    endm
    @@out SubStr @@out, 2     ;; удал€ем зап€тую в начале строки
endm


macro invoke @@func: rest
        PARAM <@func>, <&@@func>
%       call    @func
endm

macro move @@param: rest
        PARAM <@par>, <&@@param>
%       mov     @par
endm




;=============================================================================
;
;                —ќ«ƒјЌ»≈ » ќЅ–јЅќ“ ј —ќќЅў≈Ќ»… ќ ќЌЌќ… ‘”Ќ ÷»»
;
;=============================================================================

struc MSGM
  msg   dd ?
  fn    dd ?
ends


macro BEGIN_MESSAGE_MAP             ; открываем таблицу сообщений
  local m
  dataseg
    label m MSGM
    ??MSGCNT = 0
  codeseg
        mov     eax, [@@uMsg]     ; @@uMsg
        lea     edx, [m]
endm

macro END_MESSAGE_MAP               ; собственно обработчик сообщений
  codeseg
        mov     ecx, ??MSGCNT
    @@loop:
        cmp     eax, [(MSGM edx).msg]
        je      @@found
        add     edx, size MSGM
        loop    @@loop
    @@defwndproc:
        leave
        lea     eax, [DefWindowProc]
        jmp     eax
    @@found:
        call    [(MSGM edx).fn], [@@hWnd], [@@lParam], [@@wParam]
        or      eax, eax
        jnz     @@defwndproc
        ret
endm


macro MESSAGE mess, func            ; объ€влеине функции св€занной с сообщением
  dataseg
        MSGM <&mess&, &func&>
        ??MSGCNT = ??MSGCNT + 1
  codeseg
endm

