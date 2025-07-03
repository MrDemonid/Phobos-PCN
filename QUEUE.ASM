        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; pазpешаем локальные идентефикатоpы
        jumps           ; разрешаем оптимизацию переходов

        %noincl

include         "windef.inc"
include         "kernel32.inc"
include         "queue.inc"

ELEM_SIZE       = 32    ; макс. размер блока
ELEM_SHIFT      = 5     ; умножение сдвигом

codeseg

    align 4
proc queue_Create uses ebx, @@numElem
        mov     ebx, [@@numElem]
        call    GetProcessHeap
        mov     ecx, eax
        mov     eax, ELEM_SIZE
        mul     ebx
        add     eax, size QUEUE
        call    HeapAlloc, ecx, HEAP_ZERO_MEMORY, eax
        or      eax, eax
        jz      @@exit
        lea     ecx, [eax+size QUEUE]
        mov     edx, [@@numElem]
        mov     [(QUEUE eax).lpElem], ecx
        mov     [(QUEUE eax).nElem], ebx
    @@exit:
        ret
endp


    align 4
proc queue_Destroy, @@lpQueue: ptr QUEUE
        call    GetProcessHeap
        call    HeapFree, eax, 0, [@@lpQueue]
        ret
endp


    align 4
proc queue_IsEmpty, @@lpQueue: ptr QUEUE
        mov     edx, [@@lpQueue]
        or      edx, edx
        jz      @@noempty
        mov     eax, [(QUEUE edx).nUsed]
        or      eax, eax
        jnz     @@noempty
        or      eax, -1
        ret
    @@noempty:
        xor     eax, eax
        ret
endp


    align 4
proc queue_Get uses esi edi, @@lpQueue: ptr QUEUE, @@lpElem: ptr byte
        mov     eax, [@@lpQueue]
        mov     edx, eax
        or      eax, eax
        jz      @@exit                          ; <- очередь пуста
        mov     eax, [(QUEUE edx).nUsed]
        or      eax, eax
        jz      @@exit                          ; <- очередь пуста
        mov     eax, [(QUEUE edx).nGet]
        mov     esi, eax
        mov     ecx, [(QUEUE edx).lpElem]
        shl     esi, ELEM_SHIFT
        mov     edi, [@@lpElem]                 ; edi - dest
        add     esi, ecx                        ; esi = queue[nPtr]
        inc     eax                             ; nGet++;
        ; копируем элемент
        movzx   ecx, [byte esi]                 ; ecx - len block
;        and     ecx, ELEM_SIZE-1                ; страховка
        inc ecx
        rep     movsb
        ; корректируем nGet
        cmp     eax, [(QUEUE edx).nElem]
        jb      @@setget
        xor     eax, eax
    @@setget:
        mov     [(QUEUE edx).nGet], eax
        dec     [(QUEUE edx).nUsed]
        or      eax, -1
    @@exit:
        ret
endp


    align 4
proc queue_Put uses ebx esi edi, @@lpQueue: ptr QUEUE, @@lpStr, @@nSize
        mov     eax, [@@lpQueue]
        mov     edx, eax
        or      eax, eax
        jz      @@exit
        mov     eax, [(QUEUE edx).nUsed]
        sub     eax, [(QUEUE edx).nElem]
        jz      @@exit                          ; <- нет места
        mov     ecx, [(QUEUE edx).nPut]
        mov     edi, [(QUEUE edx).lpElem]
        mov     ebx, ecx
        shl     ecx, ELEM_SHIFT                 ; ecx = nPut * sizeof(BLOCK)
        mov     esi, [@@lpStr]                  ; esi - dest
        add     edi, ecx                        ; edi = queue[nPut]
        inc     ebx                             ; nPut++
        ; копируем данные в очередь
        mov     ecx, [@@nSize]
;        and     ecx, ELEM_SIZE-1                ; страховка
        mov     eax, ecx
        stosb                           ; сохраняем длину блока
        rep     movsb                   ; и сами данные
        ; корректируем nPut
        cmp     ebx, [(QUEUE edx).nElem]
        jb      @@setput
        xor     ebx, ebx
    @@setput:
        mov     [(QUEUE edx).nPut], ebx
        inc     [(QUEUE edx).nUsed]
        or      eax, -1
    @@exit:
        ret
endp

end
