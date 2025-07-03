        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; pазpешаем локальные идентефикатоpы
        nojumps         ; запpещаем TASM'у подставлять NOP'ы

        %noincl

include "windef.inc"
include "kernel32.inc"
include "log.inc"

ifndef @unicode
        procdesc vsprintf CPP buff:dword, fstr:dword, args:dword:?
        _vsprintf       equ <vsprintf>
    else
        procdesc vswprintf CPP buff:dword, fstr:dword, args:dword:?
        _vsprintf       equ <vswprintf>
endif



dataseg
  lpszName      dd 0    ; имя лога (по умолчанию лог отключен)

codeseg

proc log_Init uses ebx, @@lpszName, @@isNew: byte
        mov     ecx, [@@lpszName]
        mov     [lpszName], ecx
        jecxz   @@exit
        cmp     [@@isNew], 0
        je      @@exit
        call    CreateFile, ecx, GENERIC_WRITE, FILE_SHARE_WRITE, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
        cmp     eax, INVALID_HANDLE_VALUE
        jne     @@close
        mov     [lpszName], 0
        jmp     @@exit
    @@close:
        call    CloseHandle, eax
    @@exit:
        ret
endp


proc log_Add CPP uses eax ebx ecx edx esi edi, @@frmStr, @@va_list: dword:?
  local @@buff:TCHAR:1024
  local @@tmp
        mov     ecx, [lpszName]
        jcxz    @@exit
        call    CreateFile, ecx, GENERIC_WRITE, FILE_SHARE_WRITE, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
        mov     ebx, eax
        cmp     eax, INVALID_HANDLE_VALUE
        je      @@exit
        call    SetFilePointer, ebx, 0, 0, FILE_END
        lea     esi, [@@buff]
        lea     edx, [@@va_list]
        call    _vsprintf, esi, [@@frmStr], edx
        call    lstrlen, esi
        lea     edx, [@@tmp]
        call    WriteFile, ebx, esi, eax, edx, 0
        call    CloseHandle, ebx
    @@exit:
        ret
endp

end