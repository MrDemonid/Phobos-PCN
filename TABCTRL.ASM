        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; pазpешаем локальные идентефикатоpы
        jumps           ; разрешаем оптимизацию переходов

        %noincl

;@unicode = 1
include         "windef.inc"
include         "kernel32.inc"
include         "gdi32.inc"
include         "user32.inc"
include         "shell32.inc"
include         "comctl32.inc"

include         "resource.inc"
include         "alarm.inc"
include         "tabctrl.inc"
include         "util.inc"
include         "auxport.inc"
include         "console.inc"
include         "owner.inc"

include         "logdlg.inc"

includelib      "imp32i.lib"



; идентификаторы окон
IDW_TABCTRL     = 4000
IDW_CHILD       = 5000

ID_MENUBTN      = ID_KEY_END+1 ; ID кнопки меню

; стиль tab контрола
WS_TABCTRL      = WS_CHILD+WS_VISIBLE+WS_CLIPCHILDREN+TCS_FOCUSNEVER


;г==========================================================================¬
;¦--------------------------------- ДАННЫЕ ---------------------------------¦
;L==========================================================================-
dataseg
  hTabCtrl      dd 0
  hImageList    dd 0


    align 4
  TEXT szChild, "AlarmDispClassApp"


udataseg
  lpCurTAB      dd ?            ; указатель на TAB текущей закладки
  lpOldProc     dd ?
  hMenuBtn      HWND ?          ; хэндл кнопки меню репорта


;г==========================================================================¬
;¦----------------------------------- КОД ----------------------------------¦
;L==========================================================================-

codeseg

proc tab_Patch, @@hWnd, @@uMsg, @@wParam, @@lParam
  local r: RECT
        mov     eax, [@@uMsg]
        cmp     eax, WM_ERASEBKGND
        je      @@backgr
        cmp     eax, WM_COMMAND
        je      @@wmcommand
    @@defwndproc:
        call    CallWindowProc, [lpOldProc], [@@hWnd], [@@uMsg], [@@wParam], [@@lParam]
        ret
    @@backgr:
        lea eax, [r]
        call    GetClientRect, [@@hWnd], eax
        lea eax, [r]
        call    SendMessage, [@@hWnd], TCM_ADJUSTRECT, 0, eax
        lea eax, [r]
        call    ExcludeClipRect, [@@wParam], [r.left], [r.top], [r.right], [r.bottom]
        call    CallWindowProc, [lpOldProc], [@@hWnd], [@@uMsg], [@@wParam], [@@lParam]
        ret
    @@wmcommand:
        mov     eax, [@@wParam]         ; eax - wparam
        mov     edx, eax
        shr     edx, 16
        cmp     edx, BN_CLICKED         ; событие от кнопки?
        jne     @@defwndproc            ; <- нет, уходим
        cmp     eax, ID_MENUBTN         ; меню?
        jne     @@defwndproc            ; <- нет, уходим

        call    GetModuleHandle, NULL
        call    DialogBoxParam, eax, DLG_LOGINFO, [@@hWnd], offset log_DlgProc, eax
        xor     eax, eax
        ret

endp





        align 4
; на выходе:
;       eax     - хэндл tab-контрола или NULL (при ошибке)
proc tab_Init uses ebx esi edi, @@paren: HWND
        xor     esi, esi
        mov     [lpCurTAB], esi
        call    GetModuleHandle, esi
        mov     ebx, eax
      ; создаем класс для child-окон вкладок
        push    esi             ; wc_hIconSm
        push    offset szChild  ; wc_lpszClassName
        push    esi             ; wc_lpszMenuName
        push    esi             ; wc_hbrBackground - не используем
        call    LoadCursor, NULL, IDC_ARROW
        push    eax             ; wc_hCursor
        push    esi             ; wc_hIcon
        push    ebx             ; wc_hInstance
        push    esi             ; wc_cbWndExtra
        push    esi             ; wc_cbClsExtra
        push    offset DispProc ; wc_lpfnWndProc
        push    CS_HREDRAW or CS_VREDRAW ; wc_style
        push    size WNDCLASSEX ; wc_cbSize
        ; pегистpиpуем класс создаваемого окна
        call    RegisterClassEx, esp
        add     esp, size WNDCLASSEX
        and     eax, 0ffffh
        jz      @@err1

        ; создаем tab control и поверхность для рисования
        invoke  CreateWindowEx, WS_EX_LEFT, "SysTabControl32", esi, WS_TABCTRL, esi, esi, esi, esi, [@@paren], IDW_TABCTRL, ebx, esi
        or      eax, eax
        jz      @@err2
        mov     [hTabCtrl], eax
        mov     edi, eax

        ; подгружаем дефолтные иконки для вкладышей
        call    ImageList_LoadImage, ebx, IDR_TABBMP, 16, esi, CLR_NONE, IMAGE_BITMAP, LR_DEFAULTCOLOR
        mov     [hImageList], eax
        call    SendMessage, edi, TCM_SETIMAGELIST, esi, eax

        ; создаем кисти и перья для отрисовки контролов
        call    own_Init

        ; патчим оконную функцию для избавления от мерцания и обработки кнопки
        call GetWindowLong, [hTabCtrl], GWL_WNDPROC
        mov  [lpOldProc], eax
        call SetWindowLong, [hTabCtrl], GWL_WNDPROC, offset tab_Patch

        ; создаем кнопку меню
        invoke  CreateWindowEx, NULL, "BUTTON", "Журнал", BS_FLAT or WS_CHILD or WS_VISIBLE, 0 ,0, 100, 100, [hTabCtrl], ID_MENUBTN, ebx, NULL
        mov     [hMenuBtn], eax

        mov     eax, edi
    @@exit:
        ret
    @@err1:
        invoke  err_ShowLastError, [@@paren], <"TABCTRL.ASM">, <"tab_Init.RegisterClassEx">
        ret
    @@err2:
        invoke  err_ShowLastError, [@@paren], <"TABCTRL.ASM">, <"tab_Init.CreateWindowEx">
        ret
endp

        align 4

proc tab_Done uses ebx esi edi
  local ti: TC_ITEM
  local hHeap: HANDLE
        cmp     [hTabCtrl], 0
        je      @@exit
        call    GetProcessHeap
        mov     [hHeap], eax
        call    SendMessage, [hTabCtrl], TCM_GETITEMCOUNT, 0, 0
        or      eax, eax
        jz      @@del_tab
        mov     ebx, eax
        xor     edi, edi
        lea     esi, [ti]
    @@del_struc:
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, edi, esi
        call    HeapFree, [hHeap], 0, [ti.lParam]
        inc     edi
        dec     ebx
        jnz     @@del_struc
    @@del_tab:
        call    SendMessage, [hTabCtrl], TCM_DELETEALLITEMS, 0, 0
        call    SendMessage, [hTabCtrl], TCM_GETIMAGELIST, 0, 0
        call    ImageList_Destroy, eax
        call    own_Done
    @@exit:
        ret
endp


        align 4
; подгружаем иконку из внешнего файла
; на входе:
;       nRTR    - номер ретранслятора (вкладки) [1..8]
;       Section - имя секции в INI-файле, где ищем имя файла с битмапом иконки
proc tab_NewIcon uses esi edi ebx, @@nRTR: dword, @@szSection: LPTCHAR
  local @@buff: TCHAR:260=buflen

        lea     edi, [@@buff]
        invoke  GetPrivateProfileString, [@@szSection], <"Icon">,<"">, edi, MAX_PATH, offset szSetupFile
        call    lstrlen, edi
        or      eax, eax
        jz      @@done          ; <- не нашли имени файла
        ; загружаем файл
        call    GetModuleHandle, 0
        call    LoadImage, eax, edi, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE
        or      eax, eax
        jz      @@done
        mov     edx, [@@nRTR]
        dec     edx
        js      @@done
        cmp     edx, 7
        ja      @@done
        mov     edi, eax
        call    ImageList_Replace, [hImageList], edx, eax, 0
        call    DeleteObject, edi
    @@done:
        ret
endp


        align 4

proc tab_NewPage uses esi edi ebx, @@lpszName, @@retType, @@keyHor, @@keyVer
  local ti: TC_ITEM
  local rc: RECT
      ; создаем и инициализируем структуру
        mov     esi, [@@keyVer] ; esi - vert
        mov     ebx, [@@keyHor] ; ebx - hor
        call    GetProcessHeap
        push    eax
        mov     eax, esi
        mul     ebx
        lea     ecx, [esi+ebx]  ; ecx = keyRow+keyCol = 22
        mov     edi, eax        ; edi - num keys = 120
        lea     eax, [edi*4]    ; eax = numKeys*size(HANDLE)
        lea     eax, [eax+ecx*4]; eax = numKeys*size(HANDLE)+(keyRow+keyCol)*size(HANDLE)
        add     eax, size TAB   ; 732
        pop     edx
        call    HeapAlloc, edx, HEAP_ZERO_MEMORY, eax
        xchg    eax, esi        ; eax - vert
        or      esi, esi
        jz      @@err1
        mov     [(TAB esi).keyTotal], edi ; 120
        mov     [(TAB esi).keyVer], eax   ; 12
        mov     [(TAB esi).keyHor], ebx   ; 10
        lea     eax, [esi+size TAB]     ; eax - свободный участок памяти за структурой
        mov     [(TAB esi).lpKeyHandles], eax
        lea     eax, [eax+edi*4]
        mov     [(TAB esi).lpLabHandles], eax
        call    SendMessage, [hTabCtrl], TCM_GETITEMCOUNT, 0, 0
        mov     ebx, eax
        inc     eax
        mov     [(TAB esi).retID], eax  ; ID ретранслятора == tab+1
        mov     eax, edi
        xor     edi, edi                ; Zero (edi)
        mul     ebx
        mov     [(TAB esi).keyFirst], eax       ; keyFirst = (rtr-1)*numKeys
        xor     edx, edx
        div     [(TAB esi).keyHor]
        mov     [(TAB esi).labVerFirst], eax
        call    GetModuleHandle, edi
        mov     edx, WS_CHILD
        or      ebx, ebx
        jnz     @@make_child
        mov     [lpCurTAB], esi
        or      edx, WS_VISIBLE
    @@make_child:
        lea     ecx, [ebx+IDW_CHILD]
        call    CreateWindowEx, WS_EX_CLIENTEDGE, offset szChild, edi, \
                                edx, \;WS_CHILD, \; or WS_VISIBLE, \
                                edi, edi, edi, edi, \
                                [hTabCtrl], ecx, eax, edi
        or      eax, eax
        jz      @@err2
        ; заполняем структуру
        mov     [(TAB esi).hDisp], eax
        mov     edx, [@@retType]
        mov     [(TAB esi).retType], edx
        ; создаем вкладку
        mov     [ti.imask], TCIF_TEXT or TCIF_IMAGE or TCIF_PARAM
        mov     eax, [@@lpszName]
        mov     [ti.pszText], eax
        mov     [ti.iImage], ebx; iImage = retID-1
        mov     [ti.lParam], esi; lParam = lpTAB
        xor     eax, eax
        mov     [ti.lpReserved1], eax
        mov     [ti.lpReserved2], eax
        mov     [ti.cchTextMax], eax

        lea     eax, [ti]
        call    SendMessage, [hTabCtrl], TCM_INSERTITEM, ebx, eax
        cmp     eax, -1
        je      @@err3
        call    CreateKeys, esi, ID_KEY, ID_LABEL
        or      eax, -1
        ret

    @@err1:
        move    edi, <"tab_NewPage.HeapAlloc()">
        jmp     @@err
    @@err2:
        move    edi, <"tab_NewPage.CreateWindowEx()">
        jmp     @@err
    @@err3:
        move    edi, <"tab_NewPage.InsertItem()">
        jmp     @@err
    @@err:
        or      esi, esi
        jz      @@err9
        mov     ecx, [(TAB esi).hDisp]
        jecxz   @@1
        call    DestroyWindow, ecx
    @@1:
        call    GetProcessHeap
        call    HeapFree, eax, 0, esi
    @@err9:
        call    GetParent, [hTabCtrl]
        invoke  err_ShowLastError, eax, <"TABCTRL.ASM">, edi
        ret
endp

        align 4
proc CreateKeys uses esi, @@lpTab: ptr TAB, @@keyID, @@labID
  local @@paren
  local @@style
  local @@class
  local @@hInst
  local @@szName: TCHAR: 128
        call    GetModuleHandle, 0
        mov     [@@hInst], eax
        mov     edx, [@@lpTab]
        mov     eax, [(TAB edx).hDisp]
        mov     [@@paren], eax
        lea     edi, [@@szName] ; esi - control name
    ; создаем горизонтальную разметку
        mov     esi, [(TAB edx).lpLabHandles]
        mov     ecx, [(TAB edx).keyHor]
        mov     [@@style], WS_VISIBLE or SS_SUNKEN or SS_CENTERIMAGE or WS_CHILD or SS_CENTER
        move    <[@@class]>, <"STATIC">
        xor     ebx, ebx
    @@make_hor_lab:
        mov     eax, ebx
        call    util_Int2Str
        mov     eax, [@@labID]
        call    @@create_child
        inc     ebx
        inc     [@@labID]
        loop    @@make_hor_lab
    ; создаем вертикальную разметку
        mov     ebx, [(TAB edx).labVerFirst]
        mov     ecx, [(TAB edx).keyVer]
    @@make_ver_lab:
        lea     eax, [ebx+ecx-1]
        call    util_Int2Str
        mov     eax, [@@labID]
        call    @@create_child
        inc     [@@labID]
        loop    @@make_ver_lab
    ; создаем ключи
        mov     esi, [(TAB edx).lpKeyHandles]
        mov     [@@style], WS_VISIBLE or WS_CHILD or BS_OWNERDRAW ;or BS_PUSHBUTTON or BS_FLAT ;
        move    <[@@class]>, <"BUTTON">
        mov     ebx, [(TAB edx).keyFirst]
        mov     ecx, [(TAB edx).keyTotal]
    @@make_key:
        mov     eax, ebx
        call    util_Int2Name
        mov     eax, [@@keyID]
        call    @@create_child
        inc     ebx
        inc     [@@keyID]
        loop    @@make_key
        ret
  ; на входе:
  ;   esi       - адрес для хэндла нового контрола
  ;   edi       - имя контрола
  ;   eax       - ID контрола
        align 4
  @@create_child:
        push    ecx edx
        call    CreateWindowEx, 0, [@@class], edi, [@@style], \
                                0 ,0, 100, 100, \
                                [@@paren], eax, [@@hInst], 0
        mov     [esi], eax
        add     esi, 4
        pop     edx ecx
        retn
endp


        align 4
; задает флаги ключей заданной вкладки
; на входе:
;       rtr     - ретранслятор [1..8]
;       numKeys - длина массива ключей
;       lpKeys  - массив ключей (каждый байт задает номер активированного ключа)
;       numBads - длина массива неисправных ключей
;       lpBads  - массив неисправных ключей
proc tab_SetFlags uses ebx esi edi, @@rtrID:dword, @@numKeys:dword, @@lpKeys: ptr byte, @@numBads:dword, @@lpBads: ptr byte
  local @@keys: BYTE:128=keysize
  local ti: TC_ITEM
  local @@hWnd
        ; готовим массив подключенных ключей
        lea     edi, [@@keys]
        call    util_RtlZeroMemory, edi, keysize
        mov     ecx, [@@numKeys]
        mov     esi, [@@lpKeys]
        jecxz   @@setkeys
        cmp     ecx, 120
        jbe     @@fill
        mov     ecx, 120
    @@fill:
        xor     eax, eax
        lodsb
        or      [BYTE edi+eax], KEY_PRESENT
        loop    @@fill
        ; теперь вносим неисправные ключи
        mov     ecx, [@@numBads]
        mov     esi, [@@lpBads]
        jecxz   @@setkeys
        cmp     ecx, 120
        jbe     @@corr
        mov     ecx, 120
    @@corr:
        xor     eax, eax
        lodsb
        mov     [BYTE edi+eax], KEY_BAD
        loop    @@corr

        ; заносим значения в структуру ключей
    @@setkeys:
        dec     [@@rtrID]
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, [@@rtrID], edx
        mov     ecx, [ti.lParam]
        mov     edi, [(TAB ecx).lpKeyHandles]
        mov     ebx, [(TAB ecx).keyTotal]
        lea     esi, [@@keys]
    @@loop:
        xor     eax, eax
        lodsb
        call    SetWindowLong, [dword edi], GWL_USERDATA, eax
        add     edi, 4
        dec     ebx
        jnz     @@loop
        ret
endp


; на входе:
;       rtr     - ретранслятор [1..8]
;       key     - направление [0..119]
; на выходе:
;       eax     - абсолютный номер направления [0..959]
proc tab_RtrToAbs, @@rtrID, @@key
  local ti: TC_ITEM
        dec     [@@rtrID]
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, [@@rtrID], edx
        mov     ecx, [ti.lParam]
        mov     eax, [(TAB ecx).keyFirst]
        add     eax, [@@key]
        ret
endp

; на входе:
;       key     - абсолютный номер направления [0..959]
; на выходе:
;       edx     - ретранслятор [1..8]
;       eax     - направление [0..119]
proc tab_AbsToRtr uses ebx esi, @@key
  local ti: TC_ITEM
        call    SendMessage, [hTabCtrl], TCM_GETITEMCOUNT, 0, 0
        mov     ebx, eax
    @@while:
        dec     ebx             ; ebx = rtr-1
        js      @@false
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, ebx, edx
        cmp     eax, -1
        je      @@false
        mov     eax, [@@key]
        mov     ecx, [ti.lParam]
;        inc     ebx             ; ebx - номер текущего ртр и номер след. вкладки
        sub     eax, [(TAB ecx).keyFirst]
        js      @@while
        cmp     eax, [(TAB ecx).keyTotal]
        jae     @@while
        ; нашли
        inc     ebx
        mov     edx, ebx        ; edx - ретранслятор
        ret                     ; eax - направление[0..119]
    @@false:
        xor     eax, eax
        xor     edx, edx
        ret
endp



        align 4
; производит масштабирование окна
; на входе:
;       width   - ширина клиентской области
;       height  - высота клиентской области
proc ScaleWindow near uses ebx esi edi, @@lpTab: ptr TAB, @@width, @@height
  local ws, wb, hs, hb
  local numobj
  local @@r: RECT
  local @@rp: RECT
  local @@rc: RECT
        mov     ecx, [@@lpTab]
        mov     eax, [@@height]
        cdq
        mov     ebx, [(TAB ecx).keyVer]
        inc     ebx
        div     ebx             ; eax - высота кнопок
        add     edx, eax        ; edx - высота разметки
        mov     [hb], eax
        mov     [hs], edx
        mov     eax, [@@width]
        cdq
        mov     ebx, [(TAB ecx).keyHor]
        inc     ebx
        div     ebx             ; eax - ширина кнопок
        add     edx, eax        ; edx - ширина разметки
        mov     [wb], eax
        mov     [ws], edx
    ; позиционируем горизонтальную разметку
        mov     esi, [(TAB ecx).lpLabHandles];        offset hLabels
        dec     ebx             ; ebx = num hor labels
        mov     edi, [ws]       ; edi - начальная позиция разметки по X
    @@horlabel:
        lodsd
        call    MoveWindow, eax, edi, 0, [wb], [hs], TRUE; FALSE
        add     edi, [wb]
        dec     ebx
        jnz     @@horlabel
    ; позиционируем вертикальную разметку
        mov     ecx, [@@lpTab]
        mov     edi, [hs]       ; edi - начальная позиция разметки по Y
        mov     ebx, [(TAB ecx).keyVer]
    @@verlabel:
        lodsd
        call    MoveWindow, eax, 0, edi, [ws], [hb], TRUE; FALSE
        add     edi, [hb]
        dec     ebx
        jnz     @@verlabel
        ; теперь позиционируем сами кнопки объектов
        mov     ecx, [@@lpTab]
        mov     eax, [(TAB ecx).keyVer]
        mul     [(TAB ecx).keyHor]
        mov     [numobj], eax
        mov     [@@height], edi ; height - позиция кнопок по Y
        xor     esi, esi        ; esi - номер кнопки
        mov     edx, [(TAB ecx).lpKeyHandles]
    @@hloop:
        mov     eax, [hb]       ; eax - высота кнопки ключа
        sub     [@@height], eax
        mov     edi, [ws]       ; edi - начальная позиция по X
        mov     ecx, [@@lpTab]
        mov     ebx, [(TAB ecx).keyHor]
    @@wloop:
        push    edx
        mov     eax, [edx+esi*4]
        call    MoveWindow, eax, edi, [@@height], [wb], [hb], TRUE; FALSE
        pop     edx
        add     edi, [wb]
        inc     esi
        dec     ebx
        jnz     @@wloop
        cmp     esi, [numobj]
        jb      @@hloop

    ; позиционируем кнопку меню
        lea     eax, [@@r]
        mov     ecx, [@@lpTab]
        call    GetClientRect, [(TAB ecx).hDisp], eax
        lea     esi, [@@rp]
        lea     edi, [@@rc]
        call    GetWindowRect, [hTabCtrl], esi
        mov     ecx, [@@lpTab]
        call    GetWindowRect, [(TAB ecx).hDisp], edi

        mov     ecx, [@@rc.right]
        sub     ecx, [@@rc.left]
        sub     ecx, [@@r.right]
        shr     ecx, 1                   ; ecx - ширина бордюра
        mov     ebx, [@@rc.bottom]
        sub     ebx, [@@rc.top]
        sub     ebx, [@@r.bottom]
        shr     ebx, 1                   ; ebx - высота бордюра

        mov     eax, [@@rc.left]
        sub     eax, [@@rp.left]
        mov     edx, [@@rc.top]
        sub     edx, [@@rp.top]
        add     eax, ecx
        add     edx, ebx
        call    MoveWindow, [hMenuBtn], eax, edx, [ws], [hs], TRUE; FALSE

        ret
endp


        align 4
; уведомление о изменении размера главного окна программы
; меняем размер tab контрола
proc tab_OnSize, @@x, @@y, @@width, @@height
  local @@r: RECT
  local ti: TC_ITEM
        call    MoveWindow, [hTabCtrl], [@@x], [@@y], [@@width], [@@height], 0;1
        lea     esi, [@@r]
        call    GetClientRect, [hTabCtrl], esi
        call    SendMessage, [hTabCtrl], TCM_ADJUSTRECT, 0, esi
        mov     eax, [lpCurTAB]
        mov     ecx, [(TAB eax).hDisp]
        mov     eax, [@@r.right]
        mov     edx, [@@r.bottom]
        sub     eax, [@@r.left]
        sub     edx, [@@r.top]
        call    MoveWindow, ecx, [@@r.left], [@@r.top], eax, edx, 1
        xor     eax, eax
        ret
endp


        align 4
; уведомление о переключении закладок
proc tab_OnNotify, @@hWnd, @@wParam, @@lParam
  local rc: RECT
  local ti: TC_ITEM
        cmp     [word low @@wParam], IDW_TABCTRL
        jne     @@exit
        mov     eax, [@@lParam]
        cmp     [(NMHDR eax).code], TCN_SELCHANGING
        jne     @@isnewpage
        mov     eax, [lpCurTAB]
        mov     ecx, [(TAB eax).hDisp]
        call    ShowWindow, ecx, SW_HIDE
        jmp     @@done

    @@isnewpage:
        cmp     [(NMHDR eax).code], TCN_SELCHANGE
        jne     @@exit
        call    SendMessage, [hTabCtrl], TCM_GETCURSEL, 0, 0
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, eax, edx
        mov     ecx, [ti.lParam]
        mov     [lpCurTAB], ecx

        lea     edx, [rc]
        call    GetClientRect, [hTabCtrl], edx
        lea     edx, [rc]
        call    SendMessage, [hTabCtrl], TCM_ADJUSTRECT, 0, edx
        mov     eax, [rc.right]
        mov     edx, [rc.bottom]
        sub     eax, [rc.left]
        sub     edx, [rc.top]

        mov     ecx, [ti.lParam]
        mov     ecx, [(TAB ecx).hDisp]
        call    MoveWindow, ecx, [rc.left], [rc.top], eax, edx, -1
        mov     ecx, [ti.lParam]
        mov     ecx, [(TAB ecx).hDisp]
        call    ShowWindow, ecx, SW_RESTORE
    @@done:
        xor     eax, eax
        ret
    @@exit:
        or      eax, -1
        ret
endp

        align 4
; уведомление о смене разрешения экрана
; на входе:
;   LO(lParam)  - screen width
;   HI(lParam)  - screen height
;   wParam      - bits per pixel
proc tab_OnDispChange uses ebx esi edi, @@hWnd, @@wParam, @@lParam
  local ti: TC_ITEM
        call    SendMessage, [hTabCtrl], TCM_GETITEMCOUNT, 0, 0
        or      eax, eax
        jz      @@exit
        mov     ebx, eax
        xor     edi, edi
      @@disp_loop:
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, edi, edx
        inc     edi
        mov     edx, [@@lParam]
        shr     edx, 16
        call    own_ScaleFont, edx
        dec     ebx
        jnz     @@disp_loop
    @@exit:
        ret
endp



;+===========================================================================+
;|///////////////////////////////////////////////////////////////////////////|
;|//////////////////// ОБРАБОТКА СОБЫТИЙ РЕТРАНСЛЯТОРА //////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+===========================================================================+

proc tab_OnReceive uses esi, @@wParam, @@lParam
        mov     eax, [@@wParam]
        mov     edx, eax
        shr     eax, 16                 ; eax - rtr
        and     edx, 0FFFFh             ; edx - key
        mov     ecx, [@@lParam]
        mov     esi, ecx
        shr     esi, 16                 ; esi - lobyte(line), hibyte(hoz)
        and     ecx, 0FFFFh             ; ecx - cmd
        cmp     ecx, TC_MAX
        ja      @@exit
        dec     eax             ; переводим номер ретранслятора в номер tab-закладки
        js      @@exit
;        ret
        call    [dword @@cmdTable+ecx*4], eax, edx, esi
  @@exit:
        ret

  @@cmdTable:
    dd  tc_doNull
    dd  tc_doAccident           ; "Авария"
    dd  tc_doKeyConnect         ; "Направление подключено"
    dd  tc_doKeyDisconnect      ; "Направление отключено"
    dd  tc_doKZ                 ; "Замыкание"
    dd  tc_doReplaceUO          ; "Подмена УО"
    dd  tc_doTypeUO             ; "Тип УО"
    dd  tc_doAttire             ; "Наряд"
    dd  tc_doNotTaken           ; "Не взят"
    dd  tc_doRemoved            ; "Снят"
    dd  tc_doTaken              ; "Взят"
    dd  tc_doSystem             ; "Технологическая"
    dd  tc_doAlert              ; "Тревога"
    dd  tc_doNull               ; "УО выключен"
    dd  tc_doNull               ; "УО включен"
    dd  tc_doNull               ; "Отказ ретранслятора"
    dd  tc_doNull               ; "Восстановление ретранслятора"
    dd  tc_doRemoved            ; "Снят" (по "Запрос снятых")
    dd  tc_doTaken              ; "Взят" (по "Запрос взятых")
endp

proc tc_doNull, @@rtr, @@key, @@line
        ret
endp

; "Авария"
proc tc_doAccident, @@rtr, @@key, @@line
        ; помечаем снятым
        call    tc_doRemoved, [@@rtr], [@@key], [@@line]
        ; сигнализируем оператору

        ret
endp

; "Направление подключено"
proc tc_doKeyConnect uses esi ebx, @@rtr, @@key, @@line
  local ti: TC_ITEM
  local @@r: RECT
        mov     ebx, KEY_PRESENT
  tc_switchConnect:
        and     ebx, KEY_PRESENT
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, [@@rtr], edx
        ; меняем флаг
        mov     ecx, [ti.lParam]
        mov     eax, [@@key]
        mov     esi, [(TAB ecx).lpKeyHandles]
        mov     esi, [esi+eax*4]
        call    GetWindowLong, esi, GWL_USERDATA
        and     eax, not KEY_PRESENT
        or      eax, ebx
        call    SetWindowLong, esi, GWL_USERDATA, eax
        ; перерисовываем этот ключ
        lea     ebx, [@@r]
        call    GetClientRect, esi, ebx
        call    InvalidateRect, esi, ebx, FALSE
        ret
endp

; "Направление отключено"
proc tc_doKeyDisconnect uses esi ebx, @@rtr, @@key, @@line
  local ti: TC_ITEM
  local @@r: RECT
        xor     ebx, ebx
        jmp     tc_switchConnect
endp
;-----------------

; "Замыкание"
proc tc_doKZ, @@rtr, @@key, @@line
        ; помечаем снятым
        call    tc_doRemoved, [@@rtr], [@@key], [@@line]
        ; сигнализируем оператору

        ret
endp
; "Подмена УО"
proc tc_doReplaceUO, @@rtr, @@key, @@line
        ; помечаем снятым
        call    tc_doRemoved, [@@rtr], [@@key], [@@line]
        ; сигнализируем оператору

        ret
endp
; "Тип УО"
proc tc_doTypeUO, @@rtr, @@key, @@line


        ret
endp

; "Наряд"
proc tc_doAttire, @@rtr, @@key, @@line
        ; запрашиваем УО о текущем состоянии объекта

        ; сигнализируем оператору
        ret
endp

; "Не взят"
proc tc_doNotTaken, @@rtr, @@key, @@line
        ; помечаем снятым
        call    tc_doRemoved, [@@rtr], [@@key], [@@line]
        ; сигнализируем оператору

        ret
endp

;---------------------
; "Снят"
proc tc_doRemoved uses ebx esi edi, @@rtr, @@key, @@line
  local ti: TC_ITEM
  local @@r: RECT
        xor     ebx, ebx
        jmp     tc_switchTaken
endp

; "Взят"
proc tc_doTaken uses ebx esi edi, @@rtr, @@key, @@line
  local ti: TC_ITEM
        mov     ebx, KEY_ALARM
  tc_switchTaken:
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, [@@rtr], edx
        mov     ecx, [ti.lParam]
        mov     edi, [(TAB ecx).lpKeyHandles]
        mov     edx, [@@key]
        mov     edi, [edi+edx*4]        ; edi - hBtn
        ; изменяем флаг состояния ключа
        call    GetWindowLong, edi, GWL_USERDATA
        mov     ecx, [ti.lParam]
        mov     esi, eax                ; esi - flag
        and     esi, not KEY_ALARM
        or      esi, ebx                ; подправляем статус ключа
        test    esi, KEY_WARNING
        jz      @@redraw
        ; была сработка, а значит нужно уничтожить таймер
        mov     eax, [@@rtr]
        shl     eax, 16
        or      eax, [@@key]
        call    KillTimer, [(TAB ecx).hDisp], eax
        and     esi, not (KEY_WARNING+KEY_FLASH)
        ; перерисовываем кнопку
    @@redraw:
        call    SetWindowLong, edi, GWL_USERDATA, esi
        call    InvalidateRect, edi, 0, FALSE
        ret
endp
;-------------------

; "Технологическая"
proc tc_doSystem, @@rtr, @@key, @@line
        ret
endp

; "Тревога"
proc tc_doAlert uses ebx esi, @@rtr, @@key, @@line
  local ti: TC_ITEM
        lea     edx, [ti]
        mov     [ti.imask], TCIF_PARAM
        call    SendMessage, [hTabCtrl], TCM_GETITEM, [@@rtr], edx
        mov     ecx, [ti.lParam]
        mov     esi, [(TAB ecx).lpKeyHandles]
        mov     eax, [@@key]
        mov     esi, [esi+eax*4]        ; esi - hBtn
        call    GetWindowLong, esi, GWL_USERDATA
        mov     ebx, eax
        test    ebx, KEY_WARNING
        jnz     @@exit
        mov     ecx, [ti.lParam]
        or      ebx, KEY_WARNING
        mov     edx, [@@rtr]
        shl     edx, 16
        or      edx, [@@key]
        call    SetTimer, [(TAB ecx).hDisp], edx, 300, NULL
    @@exit:
        call    SetWindowLong, esi, GWL_USERDATA, ebx

        ; снимаем объект с сигнализации
        dec     [@@rtr]
        call    aux_SendTU, [@@rtr], [@@key], TU_REMOVE
        ret
endp



;+===========================================================================+
;|///////////////////////////////////////////////////////////////////////////|
;|/////////////////////////////// ОКНО CHILD ////////////////////////////////|
;|///////////////////////////////////////////////////////////////////////////|
;+===========================================================================+

        align 4
proc DispProc, @@hWnd, @@uMsg, @@wParam, @@lParam
  local @@p: PAINTSTRUCT
  local rc: RECT
  local ti: TC_ITEM
        mov     eax, [@@uMsg]
        cmp     eax, WM_DRAWITEM
        je      @@wmdrawitem
        cmp     eax, WM_MEASUREITEM
        je      @@wmmeasureitem
        cmp     eax, WM_CTLCOLORSTATIC
        je      @@ctlcolorstatic
        cmp     eax, WM_TIMER
        je      @@wmtimer
        cmp     eax, WM_CONTEXTMENU
        je      @@wmcontextmenu
        cmp     eax, WM_SIZE
        je      @@wmsize
        cmp     eax, WM_COMMAND
        je      @@wmcommand
    @@defwindowproc:
        leave
        lea     eax, [DefWindowProc]
        jmp     eax

    ; обработчик прорисовки контролов ключей
    @@wmdrawitem:
        call    btn_OnDrawItem, [@@lParam]
        jnz     @@rettrue
        call    mnu_OnDrawItem, [@@lParam]
        jz      @@defwindowproc
    @@rettrue:
        or      eax, -1
        ret

    @@wmmeasureitem:
        call    mnu_OnMeasureItem, [@@hWnd], [@@lParam]
        jz      @@defwindowproc
        jmp     @@rettrue


    ; обработчик прорисовки контролов разметки
    @@ctlcolorstatic:
        call    stc_OnCtlColorStatic, [@@lParam], [@@wParam]
        jz      @@defwindowproc
        ret

    @@wmtimer:
        call    OnTimer, [@@wParam]
        jmp     @@retnull

    @@wmsize:
        call    OnSize, [@@wParam], [@@lParam]
        jz      @@defwindowproc
    @@retnull:
        xor     eax, eax
        ret

    ; обработчик нажатия правой кнопкой на контрол
    @@wmcontextmenu:
        movzx   ecx, [word @@lParam]    ; pos X
        movzx   edx, [word @@lParam+2]  ; pos Y
        call    btn_OnContextMenu, [@@hWnd], ecx, edx
        jz      @@defwindowproc
        jmp     @@retnull

    @@wmcommand:
        mov     eax, [@@wParam]         ; eax - wparam
        shr     eax, 16
        cmp     eax, BN_DBLCLK         ; событие от кнопки?
        jne     @@defwindowproc         ; <- нет, уходим
        ; было двойное нажатие левой кнопки мыши на контрол
        call    btn_OnDblClk, [@@hWnd], [@@lParam]
        jz      @@defwindowproc
        jmp     @@retnull


endp


; на входе:
;  HI(wParam)   - ретранслятор [0..MAX_RTR-1]
;  LO(wParam)   - ID контрола [0..119]
proc OnTimer uses ebx, @@wParam
  local ti: TC_ITEM
        mov     [ti.imask], TCIF_PARAM
        movzx   edx, [word @@wParam+2]
        lea     eax, [ti]
        call    SendMessage, [hTabCtrl], TCM_GETITEM, edx, eax
        mov     ecx, [ti.lParam]
        movzx   eax, [word @@wParam]
        mov     edx, [(TAB ecx).lpKeyHandles]
        mov     ebx, [edx+eax*4]        ; ebx - hBtn
        call    GetWindowLong, ebx, GWL_USERDATA
        xor     eax, KEY_FLASH
        call    SetWindowLong, ebx, GWL_USERDATA, eax
        ; перерисовываем
        call    InvalidateRect, ebx, 0, FALSE
    @@exit:
        ret
endp

proc OnSize, @@opCode, @@ptSize
        mov     eax, [@@opCode]
        cmp     eax, SIZE_MINIMIZED
        je      @@false
        cmp     eax, SIZE_MAXHIDE
        je      @@false
        mov     eax, [@@ptSize]
        mov     edx, eax
        and     eax, 0ffffh
        shr     edx, 16
        call    ScaleWindow, [lpCurTAB], eax, edx
        or      eax, -1
        ret
    @@false:
        xor     eax, eax
        ret
endp


proc btn_OnContextMenu uses ebx esi, @@hWnd, @@scrX, @@scrY
  local @@p: POINT
  local @@key
  local @@hKey
        ; проверяем над какими контролами произошло событие
        mov     eax, [@@scrX]
        mov     edx, [@@scrY]
        mov     [@@p.x], eax
        mov     [@@p.y], edx
        lea     ecx, [@@p]
        call    ScreenToClient, [@@hWnd], ecx
        call    ChildWindowFromPoint, [@@hWnd], [@@p.x], [@@p.y]
        or      eax, eax
        jz      @@false
        xchg    esi, eax
        call    GetWindowLong, esi, GWL_ID
        cmp     eax, ID_KEY
        jb      @@false                 ; <- это не контролы ключей
        cmp     eax, ID_KEY_END
        ja      @@false                 ; <- это не контролы ключей
        sub     eax, ID_KEY
        mov     [@@key], eax
        ; все в порядке, это к нам
        call    CreatePopupMenu
        mov     ebx, eax
        call    GetWindowLong, esi, GWL_USERDATA
        and     eax, KEY_PRESENT
        jz      @@do_menu
        ; добавляем пункты команд в меню
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_PICKUP, "Взять сразу"
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_REMOVE, "Снять"
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_TAKEAFTER, "Взять после выхода"
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_STATUSUO, "Запрос УО"
        ; добавляем пункты для Фобос-3
        mov     eax, [lpCurTAB]
        cmp     [(TAB eax).retType], RTR_PHOBOS3
        jb      @@do_menu
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_CONNECT, "Подключить направление"
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_DISCONNECT, "Отключить направление"
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_GETTYPEUO, "Определить тип УО"
    @@do_menu:
        ; эти пункты меню присутствуют всегда
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_REQUESTON, "Запрос взятых"
        invoke  AppendMenu, ebx, MF_OWNERDRAW, TU_REQUESTOFF, "Запрос снятых"
        ; запускаем выполнение меню
        call    TrackPopupMenu, ebx, TPM_LEFTALIGN+TPM_TOPALIGN+TPM_LEFTBUTTON+TPM_RETURNCMD+TPM_NONOTIFY, \
                                [@@scrX], [@@scrY], 0, [@@hWnd], 0
        xchg    eax, ebx
        call    DestroyMenu, eax
        or      ebx, ebx
        jz      @@false
        mov     ecx, [lpCurTAB]
        call    aux_SendTU, [(TAB ecx).retID], [@@key], ebx
        or      eax, -1
        ret
    @@false:
        xor     eax, eax
        ret
endp


; обработка двойного нажатия левой кнопки на ключ
proc btn_OnDblClk uses ebx esi edi, @@hWnd, @@hBtn
  local @@vk: BYTE: 256
  local @@p: POINT
  local @@key
        lea     eax, [@@p]
        call    GetCursorPos, eax

        call    GetWindowLong, [@@hBtn], GWL_ID
        cmp     eax, ID_KEY
        jb      @@false                 ; <- это не контролы ключей
        cmp     eax, ID_KEY_END
        ja      @@false                 ; <- это не контролы ключей
        sub     eax, ID_KEY
        mov     [@@key], eax
        ; все в порядке, это к нам
        ; проверяем нажатие клавиш CTLR+SHIFT
        lea     eax, [@@vk]
        call    GetKeyboardState, eax
        or      eax, eax
        jz      @@false
        mov     al, [@@vk+VK_CONTROL]
        mov     ah, [@@vk+VK_SHIFT]
        and     al, 80h
        jz      @@false
        and     ah, 80h
        jz      @@false
        ; создаем меню
        call    CreatePopupMenu
        mov     ebx, eax
        ; добавляем пункты команд в меню
        call    GetWindowLong, [@@hBtn], GWL_USERDATA
        mov     edi, eax

        test    edi, KEY_BAD
        jnz     @@keybad

        test    edi, KEY_PRESENT
        jnz     @@1
        invoke  AppendMenu, ebx, MF_OWNERDRAW, 1, "Подключить"
        jmp     @@keybad
    @@1:
        invoke  AppendMenu, ebx, MF_OWNERDRAW, 2, "Отключить"
    @@keybad:
        test    edi, KEY_BAD
        jz      @@2
        ; ключ неисправен
        invoke  AppendMenu, ebx, MF_OWNERDRAW, 3, "Исправен"
        jmp     @@savemnu
    @@2:
        invoke  AppendMenu, ebx, MF_OWNERDRAW, 4, "Неисправен"

    @@savemnu:
        mov     esi, [lpCurTAB]
        test    [(TAB esi).fStatus], TAB_MODIFIED
        jz      @@do_menu
        invoke  AppendMenu, ebx, MF_OWNERDRAW, 5, "Сохранить"
    @@do_menu:
        ; и запускаем обработку меню
        call    TrackPopupMenu, ebx, TPM_LEFTALIGN+TPM_TOPALIGN+TPM_LEFTBUTTON+TPM_RETURNCMD+TPM_NONOTIFY, \
                                [@@p.x], [@@p.y], 0, [@@hWnd], 0
        xchg    eax, ebx
        call    DestroyMenu, eax
        ; @@key - номер контрола [0..119]
        ; ebx   - номер выбранного меню
        dec     ebx
        js      @@false
        cmp     ebx, 4
        ja      @@false
        jmp     [@@menu_func+ebx*4]
    @@key_off:

        and     edi, not KEY_PRESENT
        jmp     @@key_modify
    @@key_on:
        or      edi, KEY_PRESENT
        jmp     @@key_modify
    @@key_job:
        and     edi, not KEY_BAD
        jmp     @@key_modify
    @@key_bad:
        mov     edi, KEY_BAD
    @@key_modify:
        call    SetWindowLong, [@@hBtn], GWL_USERDATA, edi
        call    InvalidateRect, [@@hBtn], 0, -1
        or      [(TAB esi).fStatus], TAB_MODIFIED
        jmp     @@done


    @@key_save:
        call    tab_SaveFlags
        and     [(TAB esi).fStatus], not TAB_MODIFIED

    @@done:
        or      eax, -1
        ret

    @@false:
        xor     eax, eax
        ret

  @@menu_func   dd @@key_on, @@key_off, @@key_job, @@key_bad, @@key_save

endp


proc tab_SaveFlags uses edi ebx
  local @@rtr: TCHAR:8
        ; формируем имя секции в INI-файле
        lea     ebx, [@@rtr]
        invoke  lstrcpy, ebx, <"RTR0">
        mov     edx, [lpCurTAB]
        mov     eax, [(TAB edx).retID]
        or      al, '0'
        lea     edi, [@@rtr+3*size TCHAR]
        stos    [large TCHAR edi]
        ; сохраняем в файл настроек
        invoke  key_Saves, KEY_PRESENT, ebx, <"Keys">, <"NumKeys">
        invoke  key_Saves, KEY_BAD, ebx, <"Bads">, <"NumBads">

        ret

endp

; формирует список ключей с заданным флагом (KEY_XXXX) и сохраняет его в файл настроек
; на входе:
;   flag        - константа флага KEY_XXXX
;   szSection   - имя секции в файле настроек
;   szKey       - имя параметра в файле настроек, где хранится список ключей
;   szNumKey    - имя параметра в файле настроек, где хранится количество ключей
proc key_Saves uses ebx esi edi, @@flag, @@szSection: LPTCHAR, @@szKey: LPTCHAR, @@szNumKey: LPTCHAR
  local @@keys: BYTE:128=keysize
  local @@skey: TCHAR:8
  local @@nkey
        ; создаем массив с ключами
        lea     edi, [@@keys]
        call    util_RtlZeroMemory, edi, keysize
        mov     ebx, [lpCurTAB]
        mov     esi, [(TAB ebx).lpKeyHandles]
        mov     ebx, [(TAB ebx).keyTotal]
        mov     [@@nkey], 0
    @@make:
        call    GetWindowLong, [dword esi], GWL_USERDATA
        and     eax, [@@flag]
        jz      @@next
        ; добавляем существующий ключ
        call    GetWindowLong, [dword esi], GWL_ID
        sub     eax, ID_KEY
        stosb
        inc     [@@nkey]
    @@next:
        add     esi, 4
        dec     ebx
        jnz     @@make

        ; получаем имя и путь файла настроек
        lea     ebx, [szSetupFile]
        ; записываем количество подключенных ключей
        mov     esi, [@@szSection]
        lea     edi, [@@skey]
        invoke  wsprintf, edi, <"%u">, [@@nkey]
        or      eax, eax
        jz      @@exit
        call    WritePrivateProfileString, esi, [@@szNumKey], edi, ebx
        ; записываем массив подключенных ключей
        lea     ecx, [@@keys]
        call    WritePrivateProfileStruct, esi, [@@szKey], ecx, [@@nkey], ebx

    @@exit:
        ret
endp




end


;        call    BeginDeferWindowPos, 2
