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
include         "odbc32.inc"
include         "comctl32.inc"

include         "alarm.inc"
include         "util.inc"
include         "odbcdrv.inc"
include         "logdlg.inc"

include "console.inc"


includelib      "imp32i.lib"


; цвета текста и фона вьюнера
  VIEW_TEXT         = 0000000h
  VIEW_BACKGR       = 0EADCDCh  ;0DCBFBFh

dataseg
  hLog              dd 0        ; хэндл идентификатора окружения базы

  ; файл базы данных
  TEXT szLogFile    "RES\LOG.MDB"

  ; SQL инструкции

  ; Вставка в базу данных об объекте и событии
  TEXT szSqlInsert  "INSERT INTO main (Data, Object, Code, Param) VALUES (Now(), ?, ?, ?)"
  ; выборка отдельных объектов в заданном интервале времени
  TEXT szSqlReport  "SELECT main.Data, main.Object, main.Code, main.Param FROM main WHERE ((main.Object",3eh,"=(?)) And (main.Object",3ch,"=(?)) And (main.Data",3eh,"=(?)) And (main.Data",3ch,"=(?))) ORDER BY main.Data"

  ; Создание новой базы данных
  TEXT szSqlTable   "CREATE TABLE main ([Key] COUNTER,[Data] DATETIME NOT NULL,[Object] INTEGER NOT NULL,[Code] INTEGER NOT NULL,[Param] INTEGER)"
  TEXT szSqlIndex   "CREATE INDEX NewIndex ON main (Object,Code,Data)"


  ; названия полей для ListView
  TEXT szDate       "Дата"
  TEXT szTime       "Время"
  TEXT szObject     "Ключ"
  TEXT szCode       "Событие"
  TEXT szPar1       "1"
  TEXT szPar2       "2"

  ; коды команд извещения ТС
  TEXT sz1          "Авария"
  TEXT sz2          "Направление подключено"
  TEXT sz3          "Направление отключено"
  TEXT sz4          "Замыкание"
  TEXT sz5          "Подмена УО"
  TEXT sz6          "Тип УО"
  TEXT sz7          "Наряд"
  TEXT sz8          "Не взят"
  TEXT sz9          "Снят"
  TEXT sz10         "Взят"
  TEXT sz11         "Технологическая"
  TEXT sz12         "Тревога"
  TEXT sz13         "Вскрытие УО"
  TEXT sz14         "Восстановление УО"
  TEXT sz15         "Отказ ретранслятора"
  TEXT sz16         "Восстановление ретранслятора"
  TEXT sz17         "Статус: снят"
  TEXT sz18         "Статус: взят"
  ; коды команд телеуправления (ТУ)
  TEXT sz19         "Взять сразу"
  TEXT sz20         "Снять"
  TEXT sz21         "Взять после выхода"
  TEXT sz22         "Запрос состояния УО"
  TEXT sz23         "Запрос взятых"
  TEXT sz24         "Запрос снятых"
  TEXT sz25         "Подключить направление"
  TEXT sz26         "Отключить направление"
  TEXT sz27         "Определить тип УО"
  TEXT szUnk        "--Unknown comand--"
  tblCodes          dd sz1,sz2,sz3,sz4,sz5,sz6,sz7,sz8,sz9,sz10,sz11,sz12,sz13,sz14,sz15,sz16,sz17,sz18,sz19
                    dd sz20,sz21,sz22,sz23,sz24,sz25,sz26,sz27
  numCodes = ($-tblCodes)/4




udataseg
        align 4

  ; хэндлы скомпилированных SQL-инструкций
  hSqlInsert        dd ?    ; INSERT INTO main (Object, Code, Param) VALUES (?, ?, ?)
    insObject       dd ?
    insObjectInd    dd ?
    insCode         dd ?
    insCodeInd      dd ?
    insParam        dd ?
    insParamInd     dd ?
  hSqlReport        dd ?    ; SELECT main.Data, main.Object, main.Code FROM main WHERE ( (main.Object=?) And (main.Data",3eh,"=(?)) And (main.Data",3ch,"=(?))) ORDER BY main.Data"
    inObjFrom       dd ?
    inObjFromInd    dd ?
    inObjTo         dd ?
    inObjToInd      dd ?
    inFromDate      TIMESTAMP_STRUCT <>
    inFromDateInd   dd ?
    inToDate        TIMESTAMP_STRUCT <>
    inToDateInd     dd ?
  ; данные для результатов
  ResDate           TIMESTAMP_STRUCT <>
  ResObject         dd ?
  ResCode           dd ?
  ResParam          dd ?
  ResLen            dd ?




codeseg




proc log_Open uses ebx, @@hWnd: HWND
  local @@path:TCHAR:MAX_PATH           ; путь к каталогу программы
        ; подключаемся к драйверу ODBC
        call    odbc_Open, [@@hWnd]
        jz      @@exit
        lea     ebx, [@@path]
        call    util_GetModulePath, ebx, MAX_PATH
        ; подключаемся к базе данных
        call    odbc_DoConnect, [@@hWnd], ebx, offset szLogFile, offset szSqlTable, offset szSqlIndex
        mov     [hLog], eax
        or      eax, eax
        jz      @@error
        ; компилируем SQL-инструкцию добавления данных
        call    sql_PrepareStmt, [hLog], offset szSqlInsert
        mov     [hSqlInsert], eax
        or      eax, eax
        jz      @@errins
        call    sql_BindInInteger, eax, 1, offset insObject, offset insObjectInd
        call    sql_BindInInteger, [hSqlInsert], 2, offset insCode, offset insCodeInd
        call    sql_BindInInteger, [hSqlInsert], 3, offset insParam, offset insParamInd

        ; компилируем SQL-инструкцию получение списка для одного объекта в интервале времени
        call    sql_PrepareStmt, [hLog], offset szSqlReport
        mov     [hSqlReport], eax
        or      eax, eax
        jz      @@errone
        call    sql_BindInInteger, eax, 1, offset inObjFrom, offset inObjFromInd
        call    sql_BindInInteger, [hSqlReport], 2, offset inObjTo, offset inObjToInd
        call    sql_BindInDate, [hSqlReport], 3, offset inFromDate, offset inFromDateInd
        call    sql_BindInDate, [hSqlReport], 4, offset inToDate, offset inToDateInd

    @@exit:
        ret
    @@error:
        move    edx, "Can not open database: [log.mdb]"
    @@errshow:
        invoke  MessageBox, [@@hWnd], edx, "LOG ERROR", MB_OK+MB_ICONERROR
        xor     eax, eax
        ret
    @@errins:
        move    edx, "Can not precompile INSERT instruction!"
        jmp     @@errshow
    @@errone:
        move    edx, "Can not precompile SELECT ONE instruction!"
        jmp     @@errshow
endp


proc log_Close
        mov     ecx, [hLog]
        jecxz   @@odbc
        ; уничтожаем все созданные SQL-запросы
        call    sql_CloseStmt, [hSqlInsert]
        call    sql_CloseStmt, [hSqlReport]
        ; отключаемся от базы
        call    obbc_Disconnect, [hLog]
    @@odbc:
        ; отключаемся от драйвера ODBC
        call    odbc_Close
        ret
endp


; на входе:
;    key        - номер объекта
;    cmd        - номер команды
;    param      - возможный параметр команды ТС
proc log_Insert, @@key: DWORD, @@cmd: DWORD, @@param: DWORD
        mov     eax, [@@key]
        mov     [insObject], eax
        mov     eax, [@@cmd]
        mov     [insCode], eax
        mov     eax, [@@param]
        mov     [insParam], eax
        call    sql_Execute, [hSqlInsert]
        ret
endp


procdesc ScaleColumns C         @@hList: HWND, @@nColumn: DWORD, @@width: DWORD:?
procdesc InsertColumns C        @@hList: HWND, @@nColumn: DWORD, @@lpszText: DWORD:?


; Масштабирует столбцы ListView
; на входе:
;    hList      - хэндл контрола
;    nColumn    - количество столбцов
;    width      - ширина столбца(в процентах), по количеству nColumns
proc ScaleColumns C uses ebx esi edi, @@hList: HWND, @@nColumn: DWORD, @@width: DWORD:?
  local @@r: RECT
        mov     ebx, [@@hList]
        lea     esi, [@@width]  ; массив размеров столбцов
        xor     edi, edi
        lea     eax, [@@r]
        call    GetClientRect, ebx, eax
    @@loop:
        lodsd                   ; eax = width (in percent)
        mul     [@@r.right]
        mov     ecx, 100
        div     ecx
        call    SendMessage, ebx, LVM_SETCOLUMNWIDTH, edi, eax
        inc     edi
        cmp     edi, [@@nColumn]
        jb      @@loop
        ret
endp


; Создает столбцы ListView
; на входе:
;    hList      - хэндл контрола
;    nColumn    - количество столбцов
;    lpszText   - массив строк, для заголовков столбцов, по количеству nColumns
proc InsertColumns C uses ebx esi edi, @@hList: HWND, @@nColumn: DWORD, @@lpszText: DWORD:?
  local @@lv: LV_COLUMN
        mov     ebx, [@@hList]
        lea     esi, [@@lpszText]       ; массив строк
        xor     edi, edi
        ; настраиваем структуру
        mov     [@@lv.imask], LVCF_TEXT+LVCF_WIDTH
        mov     [@@lv.lx], 10
    @@loop:
        lodsd                           ; eax = строка с именем столбца
        mov     [@@lv.pszText], eax
        lea     eax, [@@lv]
        call    SendMessage, ebx, LVM_INSERTCOLUMN, edi, eax
        inc     edi
        cmp     edi, [@@nColumn]
        jb      @@loop
        ret
endp


; заполняет ListView данными
proc FillColumn uses ebx esi edi, @@hStmt, @@hList
  local @@lvi:LV_ITEM
  local @@row
  local @@szBuff: TCHAR:128
        lea     eax, [@@row]
        call    SQLNumResultCols, [@@hStmt], eax
        cmp     [@@row], 0
        je      @@done

        xor     ebx, ebx                ; ebx - index row
        lea     esi, [@@lvi]
    @@loop:
        call    SQLFetch, [@@hStmt]
        and     eax, 0FFFEh     ; eax = (eax & (~(SQL_SUCCESS|SQL_SUCCESS_WITH_INFO))) == 0
        jnz     @@done
        ; вставляем дату
        lea     edi, [@@szBuff]
        lea     edx, [ResDate]
        mov     [@@lvi.pszText], edi
        call    util_DateToStr
        mov     [@@lvi.imask], LVIF_TEXT+LVIF_PARAM
        mov     [@@lvi.iItem], ebx
        mov     [@@lvi.iSubItem], 0
        mov     [@@lvi.lParam], ebx
        call    SendMessage, [@@hList], LVM_INSERTITEM, 0, esi
        ; вставляем время
        mov     [@@lvi.imask], LVIF_TEXT
        inc     [@@lvi.iSubItem]
        lea     edi, [@@szBuff]
        lea     edx, [ResDate+6]
        mov     [@@lvi.pszText], edi
        call    util_TimeToStr
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi
        ; вставляем номер ключа
        inc     [@@lvi.iSubItem]
        lea     edi, [@@szBuff]
        mov     [@@lvi.pszText], edi
        mov     eax, [ResObject]
        call    util_Int2Name
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi
        ; вставляем описание действия
        inc     [@@lvi.iSubItem]
        mov     eax, [ResCode]
        lea     edx, [szUnk]
        dec     eax
        js      @@1
        cmp     eax, numCodes
        jae     @@1
        mov     edx, [tblCodes+eax*4]
     @@1:
        mov     [@@lvi.pszText], edx
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi
        ; вставляем возможный параметр ТС
        inc     [@@lvi.iSubItem]
        lea     edi, [@@szBuff]
        mov     [@@lvi.pszText], edi
        mov     edx, [ResParam]
        mov     dl, dh
        call    util_TCParam
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi
        inc     [@@lvi.iSubItem]
;        lea     edi, [@@szBuff]
;        mov     [@@lvi.pszText], edi
        mov     edx, [ResParam]
        call    util_TCParam
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi

        jmp     @@loop
    @@done:
        ret
endp



proc log_DlgProc uses ebx esi edi, @@hWnd: HWND, @@uMsg: DWORD, @@wParam: DWORD, @@lParam: DWORD
  local @@hList
        mov     eax, [@@uMsg]
        cmp     eax, WM_SIZE
        je      @@size
        cmp     eax, WM_COMMAND
        je      @@wmcommand
        cmp     eax, WM_INITDIALOG
        je      @@initdialog
        cmp     eax, WM_CLOSE
        je      @@close
    @@default:
        xor     eax, eax
        ret
    @@size:
        mov     eax, [@@wParam]           ; wparam
        cmp     eax, SIZE_MINIMIZED
        je      @@default
        cmp     eax, SIZE_MAXHIDE
        je      @@default
        call    GetDlgItem, [@@hWnd], IDC_LIST
        mov     [@@hList], eax
        call    ShowWindow, eax, SW_HIDE
        call    @@scale_list
        jmp     @@return

    @@wmcommand:
        mov     eax, [@@wParam]         ; eax - wparam
        mov     edx, eax
        shr     edx, 16
        cmp     edx, LBN_SELCHANGE
        je      @@setkeys
        cmp     edx, BN_CLICKED         ; событие от кнопки?
        jne     @@default               ; <- нет, уходим
        cmp     eax, IDC_OK
        je      @@idc_ok
        cmp     eax, IDC_REFRESH
        je      @@idc_refresh
        cmp     eax, IDC_REPORT
        je      @@idc_report
        jmp     @@default
    @@setkeys:
        ; обновляем список ключей
        call    SetupKeysList, [@@hWnd]
        jmp     @@return

    @@idc_refresh:
        xor     edi, edi
        call    GetDlgItem, [@@hWnd], IDC_LIST
        mov     [@@hList], eax
        call    SendMessage, eax, LVM_DELETEALLITEMS, edi, edi
        call    ShowWindow, [@@hList], SW_SHOW
        call    PrepareData, [@@hWnd]
        call    GetDlgItem, [@@hWnd], IDC_OBJECT
        mov     ebx, eax
        call    SendMessage, ebx, LB_GETCURSEL, edi, edi
        or      eax, eax
        jnz     @@selone
        ; выбор диапазона объектов
        inc     eax
        call    SendMessage, ebx, LB_GETITEMDATA, eax, edi
        mov     [inObjFrom], eax
        call    SendMessage, ebx, LB_GETCOUNT, edi, edi
        dec     eax
        js      @@default
        call    SendMessage, ebx, LB_GETITEMDATA, eax, edi
        mov     [inObjTo], eax
        jmp     @@show
    @@selone:
        ; выбор одного объекта
        call    SendMessage, ebx, LB_GETITEMDATA, eax, edi
        mov     [inObjFrom], eax
        mov     [inObjTo], eax
    @@show:
        mov     ebx, [hSqlReport]
        call    sql_Execute, ebx
        call    SQLBindCol, ebx, 1, SQL_C_TIMESTAMP, offset ResDate, edi, offset ResLen
        call    SQLBindCol, ebx, 2, SQL_C_ULONG, offset ResObject,  edi, offset ResLen
        call    SQLBindCol, ebx, 3, SQL_C_ULONG, offset ResCode, edi, offset ResLen
        call    SQLBindCol, ebx, 4, SQL_C_ULONG, offset ResParam, edi, offset ResLen
        call    FillColumn, ebx, [@@hList]
        call    SQLCloseCursor, ebx
        call    @@scale_list
        call    SetFocus, [@@hList]
        jmp     @@default
    @@idc_ok:
        jmp     @@close


    @@idc_report:
        ; распечатываем выбранные события
        call    GetDlgItem, [@@hWnd], IDC_LIST
        mov     [@@hList], eax
        call    PrintReport, [@@hList]
        jmp     @@default


    @@initdialog:
        call    init_controls, [@@hWnd]

        jmp     @@return
    @@close:
        call    EndDialog, [@@hWnd], 0
    @@return:
        ret

    @@scale_list:
;        call    GetDlgItem, [@@hWnd], IDC_LIST
;        mov     [@@hList], eax
        call    ScaleColumns, [@@hList], 6, 18, 16, 10, 40, 8, 8
        call    ShowWindow, [@@hList], SW_SHOW
        retn

endp


; настраиваем внешний вид контролов
proc init_controls near @@hDlg
  local @@buf: TCHAR:16
        xor     edi, edi
        ; ListView
        call    GetDlgItem, [@@hDlg], IDC_LIST
        mov     ebx, eax
        call    ShowWindow, ebx, SW_HIDE
        call    SendMessage, ebx, LVM_SETEXTENDEDLISTVIEWSTYLE, edi, 21h
        call    InsertColumns, ebx, 6, offset szDate, offset szTime, offset szObject, offset szCode, offset szPar1, offset szPar2
        ; задаем цвета полей таблицы просмотра
        call    SendMessage, ebx, LVM_SETTEXTCOLOR, edi, VIEW_TEXT
        call    SendMessage, ebx, LVM_SETBKCOLOR, edi, VIEW_BACKGR
        call    SendMessage, ebx, LVM_SETTEXTBKCOLOR, edi, VIEW_BACKGR
        ; показываем окно
        call    ShowWindow, ebx, SW_SHOW
        ; настраиваем список ретрансляторов
        call    GetDlgItem, [@@hDlg], IDC_RTR
        mov     ebx, eax
        lea     esi, [@@buf]
        mov     [dword esi], '*'        ; пункт выбора всех ретрансляторов сразу
    @@loopRTR:
        call    SendMessage, ebx, LB_ADDSTRING, 0, esi
        call    SendMessage, ebx, LB_SETITEMDATA, edi, edi
        inc     edi
        mov     eax, edi
        or      al, '0'
        mov     [esi], eax
        cmp     edi, [numRTR]
        jbe     @@loopRTR
        call    SendMessage, ebx, LB_SETCURSEL, 0, 0
        ; настраиваем список объектов
        call    SetupKeysList, [@@hDlg]
        ret
endp


proc SetupKeysList, @@hDlg
  local @@handle
  local @@buf: TCHAR:16
  local @@idx
        mov     ecx, [numRTR]
        mov     eax, 120
        mul     ecx
        mov     ebx, eax                ; ebx - max keys

        xor     esi, esi
        ; узнаем какие ретрансляторы отображать
        call    GetDlgItem, [@@hDlg], IDC_RTR
        mov     edi, eax
        call    SendMessage, edi, LB_GETCURSEL, esi, esi
        call    SendMessage, edi, LB_GETITEMDATA, eax, esi
        or      eax, eax
        jz      @@1
        dec     eax
        mov     ebx, 120        ; ebx - количество ключей
        mul     ebx
    @@1:
        mov     [@@idx], eax    ; нач. адрес ключей
        call    GetDlgItem, [@@hDlg], IDC_OBJECT
        mov     [@@handle], eax
        ; очищаем список
        call    SendMessage, [@@handle], LB_RESETCONTENT, esi, esi
        lea     edi, [@@buf]
        ; создаем новый
        mov     [dword edi], '*'
        call    SendMessage, [@@handle], LB_ADDSTRING, esi, edi
        call    SendMessage, [@@handle], LB_SETITEMDATA, esi, esi
        inc     esi
    @@fill:
        mov     eax, [@@idx]
        call    util_Int2Name
        call    SendMessage, [@@handle], LB_ADDSTRING, 0, edi
        call    SendMessage, [@@handle], LB_SETITEMDATA, esi, [@@idx]
        inc     [@@idx]
        inc     esi
        dec     ebx
        jnz     @@fill
        call    SendMessage, [@@handle], LB_SETCURSEL, ebx, ebx

        ret
endp



proc PrepareData, @@hDlg
  local @@t:SYSTEMTIME
        xor     ebx, ebx
        call    GetDlgItem, [@@hDlg], IDC_DATAFROM
        call    SendMessage, eax, DTM_GETSYSTEMTIME, ebx, offset inFromDate
        mov     ax, [inFromDate.hour]
        mov     [inFromDate.day], ax
        call    GetDlgItem, [@@hDlg], IDC_DATATO
        call    SendMessage, eax, DTM_GETSYSTEMTIME, ebx, offset inToDate
        mov     ax, [inToDate.hour]
        mov     [inToDate.day], ax
        ; время
        call    GetDlgItem, [@@hDlg], IDC_TIMEFROM
        lea     edx, [@@t]
        call    SendMessage, eax, DTM_GETSYSTEMTIME, ebx, edx
        mov     ax, [@@t.wHour]
        mov     dx, [@@t.wMinute]
        mov     [inFromDate.hour], ax
        mov     [inFromDate.minute], dx
        mov     [inFromDate.second], bx
        mov     [inFromDate.fraction], ebx

        call    GetDlgItem, [@@hDlg], IDC_TIMETO
        lea     edx, [@@t]
        call    SendMessage, eax, DTM_GETSYSTEMTIME, ebx, edx
        mov     ax, [@@t.wHour]
        mov     dx, [@@t.wMinute]
        mov     [inToDate.hour], ax
        mov     [inToDate.minute], dx
        mov     [inToDate.second], bx
        mov     [inToDate.fraction], ebx
        ret
endp




TEXTA szPrnBegin,  "_prn_Begin"
TEXTA szPrnEnd,    "_prn_End"
TEXTA szPrnInsert, "_prn_Insert"


proc PrintReport, @@hList: HWND

  local prn_Begin
  local prn_End
  local prn_Insert
  local @@hModule
  local @@lvi:LV_ITEM
  local @@buf:TCHAR:2048                ; буфер для строк из ListView
  local @@count                         ; количество строк
  local @@curItem

        call    SendMessage, [@@hList], LVM_GETITEMCOUNT, 0, 0
        mov     [@@count], eax
        or      eax, eax
        jz      @@exit                  ; -> список пуст, уходим
        ;
        ; открываем библиотеку принтера и ищем в ней нужные функции
        ;
        invoke  LoadLibrary, "PRINTTBL.DLL"
        or      eax, eax
        jz      @@exit
        mov     [@@hModule], eax
        mov     ebx, eax
        call    GetProcAddress, ebx, offset szPrnBegin
        or      eax, eax
        jz      @@freelib
        mov     [prn_Begin], eax
        call    GetProcAddress, ebx, offset szPrnEnd
        or      eax, eax
        jz      @@freelib
        mov     [prn_End], eax
        call    GetProcAddress, ebx, offset szPrnInsert
        or      eax, eax
        jz      @@freelib
        mov     [prn_Insert], eax

        ; всё в порядке, инициализируем печать (таблица с 6 столбцами)
        invoke  [prn_Begin] C, <"Report">, 6, 18, 16, 10, 40, 8, 8
        or      eax, eax
        jz      @@freelib
        ; добавляем в заголовок
        invoke  [prn_Insert] C, 6, "Дата", "Время", "Объект", "Событие", "P1", "P2"


        ; теперь проходимся по списку и отправляем на печать
        lea     edi, [@@buf]
        call    util_RtlZeroMemory, edi, size LV_ITEM

        mov     [@@curItem], 0
    @@row_loop:
        ; выводим очередную строку
        mov     ebx, [@@curItem]
        lea     edi, [@@buf]
        xor     esi, esi

        call    @@get_item       ; извлекаем дату
        call    @@get_next_item  ; извлекаем время
        call    @@get_next_item  ; извлекаем номер объекта
        call    @@get_next_item  ; извлекаем описание события
        call    @@get_next_item  ; извлекаем доп. параметры
        call    @@get_next_item

        ; отсылаем на печать
        lea     eax, [@@buf]
        lea     ebx, [@@buf + 256*size TCHAR]
        lea     ecx, [@@buf + 512*size TCHAR]
        lea     edx, [@@buf + 768*size TCHAR]
        lea     esi, [@@buf + 1024*size TCHAR]
        call    [prn_Insert] C, 6, eax, ebx, ecx, edx, esi, edi

    @@next_row:
        ; переходим к печати следующего столбца
        inc     [@@curItem]
        dec     [@@count]
        jnz     @@row_loop

    @@done:
        ; заканчиваем печать
        invoke  [prn_End] C

    @@freelib:
        ; удаляем ссылку на DLL
        call    FreeLibrary, [@@hModule]
    @@exit:
        ret


    @@get_next_item:
        ; переходим к следующему столбцу
        inc     esi
        add     edi, 256 * size TCHAR
    @@get_item:
        ; читаем строку из текущих строки и столбца
        mov     [@@lvi.imask], LVIF_TEXT
        mov     [@@lvi.pszText], edi
        mov     [@@lvi.cchTextMax], 256
        mov     [@@lvi.iItem], ebx
        mov     [@@lvi.iSubItem], esi
        lea     eax, [@@lvi]
        call    SendMessage, [@@hList], LVM_GETITEM, 0, eax
        pop     edx
        or      eax, eax
        jz      @@next_row
        jmp     edx

endp


end
