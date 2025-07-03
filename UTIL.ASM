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
include         "gdi32.inc"

include         "util.inc"

includelib      "imp32i.lib"


;г==========================================================================¬
;¦------------------------------- КОНСТАНТЫ --------------------------------¦
;L==========================================================================-

;г==========================================================================¬
;¦--------------------------------- ДАННЫЕ ---------------------------------¦
;L==========================================================================-
dataseg
  hexTable      db "0123456789ABCDEF"

udataseg



;г==========================================================================¬
;¦----------------------------------- КОД ----------------------------------¦
;L==========================================================================-

codeseg

        align 4
; пpеобpазуем номеp объекта в стpоку
; на входе:
;       eax     - number
;       edi     - buffer
proc util_Int2Name uses edx ecx
        mov     ecx, 10
        add     edi, 2 * (size TCHAR)
        cmp     eax, 100
        jb      @@1
        add     edi, size TCHAR
    @@1:
        mov     [TCHAR edi + (size TCHAR)], 0
        xor     edx, edx
        or      eax, eax
        jz      @@2
        div     ecx
    @@2:
        add     edx, '0'
    ifdef @unicode
        mov     [edi], dx
    else
        mov     [edi], dl
    endif
        sub     edi, size TCHAR
        mov     edx, '-'
    ifdef @unicode
        mov     [edi], dx
    else
        mov     [edi], dl
    endif
        sub     edi, size TCHAR
        xor     edx, edx
        or      eax, eax
        jz      @@3
        div     ecx
    @@3:
        add     edx, '0'
    ifdef @unicode
        mov     [edi], dx
    else
        mov     [edi], dl
    endif
        xor     edx, edx
        or      eax, eax
        jz      @@exit
        sub     edi, size TCHAR
        div     ecx
        add     edx, '0'
    ifdef @unicode
        mov     [edi], dx
    else
        mov     [edi], dl
    endif
    @@exit:
        ret
endp

; пpеобpазуем число в стpоку
; на входе:
;       eax     - number
;       edi     - buffer
proc util_Int2Str uses edx ecx edi
        mov     ecx, 10
        xor     edx, edx
        div     ecx
        or      eax, eax
        jz      @@1
        or      eax, '0'
        stos    [large TCHAR edi]
    @@1:
        xchg    eax, edx
        or      eax, '0'
        stos    [large TCHAR edi]
    @@exit:
        xor     eax, eax
        stos    [large TCHAR edi]
        ret
endp


; перевод символа в hex-строку, вида 0xXX
; на входе:
;       al      - символ
;       edi     - буфер
; на выходе:
;       edi     - конец буфера
proc util_Byte2Hex
        mov     ah, al
        mov     al, '0'
        stosb
        mov     al, 'x'
        stosb
        mov     al, ah
        shr     al, 4
        add     al, 90h
        daa
        adc     al, 40h
        daa
        stosb
        mov     al, ah
        and     al, 0Fh
        add     al, 90h
        daa
        adc     al, 40h
        daa
        stosb
        ret
endp


; на входе:
;       eax     - номер объекта
;       edi     - буфер
proc util_ID2Name uses edx ecx ebx
        mov     ecx, 2
        mov     ebx, 10
    @@loop:
        xor     edx, edx
        div     ebx
        or      edx, '0'
    ifdef @unicode
        mov     [edi+ecx*2], dx
    else
        mov     [edi+ecx], dl
    endif
        dec     ecx
        jns     @@loop
        add     edi, (size TCHAR) * 3
        ret
endp

ifdef @unicode
; переводит номер объекта в ascii строку (независимо от юникода)
; на входе:
;       eax     - номер объекта
;       edi     - буфер
proc util_ID2Ascii uses ebx
        mov     ecx, 2
        mov     ebx, 10
    @@loop:
        xor     edx, edx
        div     ebx
        or      dl, '0'
        mov     [edi+ecx], dl
        dec     ecx
        jns     @@loop
        ret
endp
endif



proc util_RtlZeroMemory uses edi, @@lpBuff, @@nSize
        mov     edi, [@@lpBuff]
        mov     ecx, [@@nSize]
        xor     eax, eax
        cld
        mov     edx, ecx
        shr     ecx, 2
        and     edx, 11b
        rep     stosd
        mov     ecx, edx
        rep     stosb
        ret
endp


proc util_GetModulePath uses edi, @@lpszPath: LPTCHAR, @@len: DWORD
        mov     edi, [@@lpszPath]
        call    GetModuleFileName, NULL, edi, [@@len]
        or      eax, eax
        jz      @@defpath
        mov     ecx, eax
        std
        lea     edi, [edi+eax*size TCHAR - size TCHAR]
        mov     eax, '\'
        repne   scas [large TCHAR edi]
        cld
        mov     [TCHAR edi+2*(size TCHAR)],0
        ; проверяем не стал ли путь пустым
        mov     edi, [@@lpszPath]
        call    lstrlen, edi
        or      eax, eax
        jz      @@defpath
    @@exit:
        ret
    @@defpath:
        invoke  lstrcpy, edi, <".\">
        ret
endp




proc err_ShowLastError, @@hWnd: dword, @@lpszModule: dword, @@lpszFunc: dword
  local @@lpBuffer: dword
  local @@frmBuff: TCHAR:1024
        pusha
        call    GetLastError
        mov     edi, eax                ; edi - code last error
        lea     esi, [@@lpBuffer]       ; esi - &lpBuffer
        lea     ebx, [@@frmBuff]        ; ebx - буффер под формируемую строку ошибки
        xor     edx, edx
        call    FormatMessage, FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS,\
                                edx, \  ; игнорируется
                                edi, \  ; error code
                                edx, \  ; lang id
                                esi, \  ; & lpBuffer
                                edx, \  ; минимальное число TCHARs, назначаемое для буфера
                                edx
        or      eax, eax        ; сколько символов в полученной строке?
        move    eax, "Unknown error"
        jz      @@1
        call    LocalLock, [@@lpBuffer]
    @@1:
        invoke  wsprintf, ebx, <"%s in module %s failed with error %X: %s">,[@@lpszFunc], [@@lpszModule], edi, eax
        invoke  MessageBox, [@@hWnd], ebx, <"ERROR">, MB_OK or MB_ICONERROR
        call    LocalFree, [@@lpBuffer]
        popa
        xor     eax, eax
        ret
endp


proc err_ShowUserError, @@hWnd, @@lpszModule, @@lpszFunc, @@lpszStr
  local @@frmBuff: TCHAR:1024
        pusha
        lea     ebx, [@@frmBuff]
        invoke  wsprintf, ebx, <"%s in module %s failed with error: %s">, [@@lpszFunc], [@@lpszModule], [@@lpszStr]
        invoke  MessageBox, [@@hWnd], ebx, <"ERROR">, MB_OK or MB_ICONERROR
        popa
        xor     eax, eax
        ret
endp



;+---------------------------------------------------------------------------+
;|///////////////////////////////////////////////////////////////////////////|
;|////////////////////// Преобразование Даты и Времени //////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+---------------------------------------------------------------------------+

struc DATE_STRUCT
  year          dw ?
  month         dw ?
  day           dw ?
ends


struc TIME_STRUCT
  hour          dw ?
  minute        dw ?
  second        dw ?
ends


; преобразование даты в символьный формат
; на входе:
;       edi     - выходная строка
;       edx     - структура DATA_STRUCT
proc util_DateToStr uses ebx
        mov     ebx, edx
        mov     ecx, 10
        movzx   eax, [(DATE_STRUCT ebx).day]
        xor     edx, edx
        div     ecx
        or      eax, '0'
        or      edx, '0'
        stos    [large TCHAR edi]
        xchg    eax, edx
        stos    [large TCHAR edi]
        mov     eax, DATE_DELIMITER
        stos    [large TCHAR edi]

        movzx   eax, [(DATE_STRUCT ebx).month]
        xor     edx, edx
        div     ecx
        or      eax, '0'
        or      edx, '0'
        stos    [large TCHAR edi]
        xchg    eax, edx
        stos    [large TCHAR edi]
        mov     eax, DATE_DELIMITER
        stos    [large TCHAR edi]

        mov     eax, '2'
        stos    [large TCHAR edi]
        mov     eax, '0'
        stos    [large TCHAR edi]
        movzx   eax, [(DATE_STRUCT ebx).year]
        sub     eax, 2000
        xor     edx, edx
        div     ecx
        or      eax, '0'
        or      edx, '0'
        stos    [large TCHAR edi]
        xchg    eax, edx
        stos    [large TCHAR edi]
        mov     [large TCHAR edi], 0
        ret
endp


; преобразование времени в символьный формат
; на входе:
;       edi     - выходная строка
;       edx     - структура TIME_STRUCT
proc util_TimeToStr uses ebx
        mov     ebx, edx
        mov     ecx, 10
        movzx   eax, [(TIME_STRUCT ebx).hour]
        xor     edx, edx
        div     ecx
        or      eax, '0'
        or      edx, '0'
        stos    [large TCHAR edi]
        xchg    eax, edx
        stos    [large TCHAR edi]
        mov     eax, TIME_DELIMITER
        stos    [large TCHAR edi]

        movzx   eax, [(TIME_STRUCT ebx).minute]
        xor     edx, edx
        div     ecx
        or      eax, '0'
        or      edx, '0'
        stos    [large TCHAR edi]
        xchg    eax, edx
        stos    [large TCHAR edi]
        mov     eax, TIME_DELIMITER
        stos    [large TCHAR edi]

        movzx   eax, [(TIME_STRUCT ebx).second]
        xor     edx, edx
        div     ecx
        or      eax, '0'
        or      edx, '0'
        stos    [large TCHAR edi]
        xchg    eax, edx
        stos    [large TCHAR edi]
        mov     [large TCHAR edi], 0
        ret
endp


; на входе:
;       edi     - выходная строка
;       dl      - доп. байт извещения ТС
; на выходе:
;       edi     - строка
proc util_TCParam uses edi
        or      dl, dl
        jz      @@exit
        xor     eax, eax
        mov     al, dl
        shr     eax, 4
        mov     al, [hexTable+eax]
        stos    [large TCHAR edi]

        mov     al, dl
        and     eax, 0Fh
        mov     al, [hexTable+eax]
        stos    [large TCHAR edi]

    @@exit:
        xor     eax, eax
        stos    [large TCHAR edi]
        ret
endp


end






; на входе:
;       esi     - выходная строка
;       al      - доп. байт извещения ТС
proc util_TCParam
        or      al, al
        jz      @@exit
        mov     ah, al
        shr     al, 4
        add     al, 90h
        daa
        adc     al, 40h
        daa
        mov     [esi], al
        inc     esi
        mov     al, ah
        and     al, 0Fh
        add     al, 90h
        daa
        adc     al, 40h
        daa
        mov     [esi], al
        inc     esi
    @@exit:
        xor     al, al
        mov     [esi], al
        ret
endp




; пpеобpазуем номеp объекта в стpоку
; на входе:
;       eax     - number
;       esi     - buffer
proc util_Int2Name uses edx
        cmp     eax, 100
        jae     @@great
        aam
        movzx   edx, al
        shl     edx, 16
        or      edx, '0-0'
        shr     eax, 8
        or      eax, edx
        mov     [esi], eax
        ret
  @@great:
        sub     eax, 100
        cmp     eax, 100
        jae     @@200
        aam
        movzx   edx, al
        shl     edx, 24
        or      edx, '0-01'
        and     eax, 0ff00h
        or      eax, edx
        mov     [esi], eax
        mov     [byte esi+4], 0
        ret
  @@200:
        sub     eax, 100
        aam
        movzx   edx, al
        shl     edx, 24
        or      edx, '0-02'
        and     eax, 0ff00h
        or      eax, edx
        mov     [esi], eax
        mov     [byte esi+4], 0
        ret
endp


; преобразование времени в символьный формат
; на входе:
;       esi     - выходная строка
;       edx     - структура TIME_STRUCT
proc util_TimeToStr
        movzx   eax, [(TIME_STRUCT edx).hour]
        aam
        shl     eax, 16
        or      eax, '00: '
        bswap   eax
        mov     [esi], eax
        movzx   eax, [(TIME_STRUCT edx).minute]
        aam
        shl     eax, 16
        or      eax, '00: '
        bswap   eax
        mov     [esi+3], eax
        movzx   eax, [(TIME_STRUCT edx).second]
        aam
        shl     eax, 16
        or      eax, '00' shl 16
        bswap   eax
        mov     [esi+6], eax
        ret
endp




#include <windows.h>
#include <strsafe.h>

void ErrorExit(LPTSTR lpszFunction)
{
    // Retrieve the system error message for the last-error code

    LPVOID lpMsgBuf;
    LPVOID lpDisplayBuf;
    DWORD dw = GetLastError();

    FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER |
        FORMAT_MESSAGE_FROM_SYSTEM |
        FORMAT_MESSAGE_IGNORE_INSERTS,
        NULL,
        dw,
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
        (LPTSTR) &lpMsgBuf,
        0, NULL );

    // Display the error message and exit the process

    lpDisplayBuf = (LPVOID)LocalAlloc(LMEM_ZEROINIT,
        (lstrlen((LPCTSTR)lpMsgBuf) + lstrlen((LPCTSTR)lpszFunction) + 40) * sizeof(TCHAR));
    StringCchPrintf((LPTSTR)lpDisplayBuf,
        LocalSize(lpDisplayBuf) / sizeof(TCHAR),
        TEXT("%s failed with error %d: %s"),
        lpszFunction, dw, lpMsgBuf);
    MessageBox(NULL, (LPCTSTR)lpDisplayBuf, TEXT("Error"), MB_OK);

    LocalFree(lpMsgBuf);
    LocalFree(lpDisplayBuf);
    ExitProcess(dw);
}

void main()
{
    // Generate an error

    if(!GetProcessId(NULL))
        ErrorExit(TEXT("GetProcessId"));
}