        ideal
        p586
        model   flat, stdcall, nt
        smart
        locals  @@      ; p��p����� ��������� ������������p�
        jumps           ; ��������� ����������� ���������

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


; ����� ������ � ���� �������
  VIEW_TEXT         = 0000000h
  VIEW_BACKGR       = 0EADCDCh  ;0DCBFBFh

dataseg
  hLog              dd 0        ; ����� �������������� ��������� ����

  ; ���� ���� ������
  TEXT szLogFile    "RES\USER.MDB"

  ; SQL ����������

  ; ������� � ���� ������ �� ������� � �������
  TEXT szSqlInsert  "INSERT INTO users (Surname, FirstName, LastName, HomePhone, JobPhone, MobPhone, Address) VALUES (?, ?, ?, ?, ?, ?, ?)"
  ; ������� ��� ���� ��� ��� ���� ������
  TEXT szSqlAllUser "SELECT users.Surname, users.FirstName, users.LastName FROM users ORDER BY users.Surname"
  ; ������ ������� ����������� ���� �� ��� �������
  TEXT szSqlUser    "SELECT users.Surname, users.FirstName, users.LastName, users.HomePhone, users.JobPhone, users.MobPhone, users.Address FROM users WHERE (users.Surname=(?)) ORDER BY users.Surname"


  ; �������� ����� ���� ������
  TEXT szSqlTable   "CREATE TABLE users ([Key] COUNTER,[Surname] CHAR NOT NULL,[FirstName] CHAR,[LastName] CHAR,[HomePhone] CHAR,[JobPhone] CHAR,[MobPhone] CHAR,[Address] CHAR)"
  TEXT szSqlIndex   "CREATE INDEX NewIndex ON users (Surname)"

�������
���
��������
���. �������
���. �������
���. �������
�����


  ; �������� ����� ��� ListView
  TEXT szDate       "����"
  TEXT szTime       "�����"
  TEXT szObject     "����"
  TEXT szCode       "�������"
  TEXT szPar1       "1"
  TEXT szPar2       "2"

  ; ���� ������ ��������� ��
  TEXT sz1          "������"
  TEXT sz2          "����������� ����������"
  TEXT sz3          "����������� ���������"
  TEXT sz4          "���������"
  TEXT sz5          "������� ��"
  TEXT sz6          "��� ��"
  TEXT sz7          "�����"
  TEXT sz8          "�� ����"
  TEXT sz9          "����"
  TEXT sz10         "����"
  TEXT sz11         "���������������"
  TEXT sz12         "�������"
  TEXT sz13         "�������� ��"
  TEXT sz14         "�������������� ��"
  TEXT sz15         "����� �������������"
  TEXT sz16         "�������������� �������������"
  TEXT sz17         "������: ����"
  TEXT sz18         "������: ����"
  ; ���� ������ �������������� (��)
  TEXT sz19         "����� �����"
  TEXT sz20         "�����"
  TEXT sz21         "����� ����� ������"
  TEXT sz22         "������ ��������� ��"
  TEXT sz23         "������ ������"
  TEXT sz24         "������ ������"
  TEXT sz25         "���������� �����������"
  TEXT sz26         "��������� �����������"
  TEXT sz27         "���������� ��� ��"
  TEXT szUnk        "--Unknown comand--"
  tblCodes          dd sz1,sz2,sz3,sz4,sz5,sz6,sz7,sz8,sz9,sz10,sz11,sz12,sz13,sz14,sz15,sz16,sz17,sz18,sz19
                    dd sz20,sz21,sz22,sz23,sz24,sz25,sz26,sz27
  numCodes = ($-tblCodes)/4




udataseg
        align 4

  ; ������ ���������������� SQL-����������
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
  ; ������ ��� �����������
  ResDate           TIMESTAMP_STRUCT <>
  ResObject         dd ?
  ResCode           dd ?
  ResParam          dd ?
  ResLen            dd ?




codeseg




proc log_Open uses ebx, @@hWnd: HWND
  local @@path:TCHAR:MAX_PATH           ; ���� � �������� ���������
        ; ������������ � �������� ODBC
        call    odbc_Open, [@@hWnd]
        jz      @@exit
        lea     ebx, [@@path]
        call    util_GetModulePath, ebx, MAX_PATH
        ; ������������ � ���� ������
        call    odbc_DoConnect, [@@hWnd], ebx, offset szLogFile, offset szSqlTable, offset szSqlIndex
        mov     [hLog], eax
        or      eax, eax
        jz      @@error
        ; ����������� SQL-���������� ���������� ������
        call    sql_PrepareStmt, [hLog], offset szSqlInsert
        mov     [hSqlInsert], eax
        or      eax, eax
        jz      @@errins
        call    sql_BindInInteger, eax, 1, offset insObject, offset insObjectInd
        call    sql_BindInInteger, [hSqlInsert], 2, offset insCode, offset insCodeInd
        call    sql_BindInInteger, [hSqlInsert], 3, offset insParam, offset insParamInd

        ; ����������� SQL-���������� ��������� ������ ��� ������ ������� � ��������� �������
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
        ; ���������� ��� ��������� SQL-�������
        call    sql_CloseStmt, [hSqlInsert]
        call    sql_CloseStmt, [hSqlReport]
        ; ����������� �� ����
        call    obbc_Disconnect, [hLog]
    @@odbc:
        ; ����������� �� �������� ODBC
        call    odbc_Close
        ret
endp


; �� �����:
;    key        - ����� �������
;    cmd        - ����� �������
;    param      - ��������� �������� ������� ��
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


; ������������ ������� ListView
; �� �����:
;    hList      - ����� ��������
;    nColumn    - ���������� ��������
;    width      - ������ �������(� ���������), �� ���������� nColumns
proc ScaleColumns C uses ebx esi edi, @@hList: HWND, @@nColumn: DWORD, @@width: DWORD:?
  local @@r: RECT
        mov     ebx, [@@hList]
        lea     esi, [@@width]  ; ������ �������� ��������
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


; ������� ������� ListView
; �� �����:
;    hList      - ����� ��������
;    nColumn    - ���������� ��������
;    lpszText   - ������ �����, ��� ���������� ��������, �� ���������� nColumns
proc InsertColumns C uses ebx esi edi, @@hList: HWND, @@nColumn: DWORD, @@lpszText: DWORD:?
  local @@lv: LV_COLUMN
        mov     ebx, [@@hList]
        lea     esi, [@@lpszText]       ; ������ �����
        xor     edi, edi
        ; ����������� ���������
        mov     [@@lv.imask], LVCF_TEXT+LVCF_WIDTH
        mov     [@@lv.lx], 10
    @@loop:
        lodsd                           ; eax = ������ � ������ �������
        mov     [@@lv.pszText], eax
        lea     eax, [@@lv]
        call    SendMessage, ebx, LVM_INSERTCOLUMN, edi, eax
        inc     edi
        cmp     edi, [@@nColumn]
        jb      @@loop
        ret
endp


; ��������� ListView �������
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
        ; ��������� ����
        lea     edi, [@@szBuff]
        lea     edx, [ResDate]
        mov     [@@lvi.pszText], edi
        call    util_DateToStr
        mov     [@@lvi.imask], LVIF_TEXT+LVIF_PARAM
        mov     [@@lvi.iItem], ebx
        mov     [@@lvi.iSubItem], 0
        mov     [@@lvi.lParam], ebx
        call    SendMessage, [@@hList], LVM_INSERTITEM, 0, esi
        ; ��������� �����
        mov     [@@lvi.imask], LVIF_TEXT
        inc     [@@lvi.iSubItem]
        lea     edi, [@@szBuff]
        lea     edx, [ResDate+6]
        mov     [@@lvi.pszText], edi
        call    util_TimeToStr
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi
        ; ��������� ����� �����
        inc     [@@lvi.iSubItem]
        lea     edi, [@@szBuff]
        mov     [@@lvi.pszText], edi
        mov     eax, [ResObject]
        call    util_Int2Name
        call    SendMessage, [@@hList], LVM_SETITEM, 0, esi
        ; ��������� �������� ��������
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
        ; ��������� ��������� �������� ��
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
        cmp     edx, BN_CLICKED         ; ������� �� ������?
        jne     @@default               ; <- ���, ������
        cmp     eax, IDC_OK
        je      @@idc_ok
        cmp     eax, IDC_REFRESH
        je      @@idc_refresh
        cmp     eax, IDC_REPORT
        je      @@idc_report
        jmp     @@default
    @@setkeys:
        ; ��������� ������ ������
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
        ; ����� ��������� ��������
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
        ; ����� ������ �������
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
        ; ������������� ��������� �������
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


; ����������� ������� ��� ���������
proc init_controls near @@hDlg
  local @@buf: TCHAR:16
        xor     edi, edi
        ; ListView
        call    GetDlgItem, [@@hDlg], IDC_LIST
        mov     ebx, eax
        call    ShowWindow, ebx, SW_HIDE
        call    SendMessage, ebx, LVM_SETEXTENDEDLISTVIEWSTYLE, edi, 21h
        call    InsertColumns, ebx, 6, offset szDate, offset szTime, offset szObject, offset szCode, offset szPar1, offset szPar2
        ; ������ ����� ����� ������� ���������
        call    SendMessage, ebx, LVM_SETTEXTCOLOR, edi, VIEW_TEXT
        call    SendMessage, ebx, LVM_SETBKCOLOR, edi, VIEW_BACKGR
        call    SendMessage, ebx, LVM_SETTEXTBKCOLOR, edi, VIEW_BACKGR
        ; ���������� ����
        call    ShowWindow, ebx, SW_SHOW
        ; ����������� ������ ��������������
        call    GetDlgItem, [@@hDlg], IDC_RTR
        mov     ebx, eax
        lea     esi, [@@buf]
        mov     [dword esi], '*'        ; ����� ������ ���� �������������� �����
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
        ; ����������� ������ ��������
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
        ; ������ ����� ������������� ����������
        call    GetDlgItem, [@@hDlg], IDC_RTR
        mov     edi, eax
        call    SendMessage, edi, LB_GETCURSEL, esi, esi
        call    SendMessage, edi, LB_GETITEMDATA, eax, esi
        or      eax, eax
        jz      @@1
        dec     eax
        mov     ebx, 120        ; ebx - ���������� ������
        mul     ebx
    @@1:
        mov     [@@idx], eax    ; ���. ����� ������
        call    GetDlgItem, [@@hDlg], IDC_OBJECT
        mov     [@@handle], eax
        ; ������� ������
        call    SendMessage, [@@handle], LB_RESETCONTENT, esi, esi
        lea     edi, [@@buf]
        ; ������� �����
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
        ; �����
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
  local @@buf:TCHAR:2048                ; ����� ��� ����� �� ListView
  local @@count                         ; ���������� �����
  local @@curItem

        call    SendMessage, [@@hList], LVM_GETITEMCOUNT, 0, 0
        mov     [@@count], eax
        or      eax, eax
        jz      @@exit                  ; -> ������ ����, ������
        ;
        ; ��������� ���������� �������� � ���� � ��� ������ �������
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

        ; �� � �������, �������������� ������ (������� � 6 ���������)
        invoke  [prn_Begin] C, <"Report">, 6, 18, 16, 10, 40, 8, 8
        or      eax, eax
        jz      @@freelib
        ; ��������� � ���������
        invoke  [prn_Insert] C, 6, "����", "�����", "������", "�������", "P1", "P2"


        ; ������ ���������� �� ������ � ���������� �� ������
        lea     edi, [@@buf]
        call    util_RtlZeroMemory, edi, size LV_ITEM

        mov     [@@curItem], 0
    @@row_loop:
        ; ������� ��������� ������
        mov     ebx, [@@curItem]
        lea     edi, [@@buf]
        xor     esi, esi

        call    @@get_item       ; ��������� ����
        call    @@get_next_item  ; ��������� �����
        call    @@get_next_item  ; ��������� ����� �������
        call    @@get_next_item  ; ��������� �������� �������
        call    @@get_next_item  ; ��������� ���. ���������
        call    @@get_next_item

        ; �������� �� ������
        lea     eax, [@@buf]
        lea     ebx, [@@buf + 256*size TCHAR]
        lea     ecx, [@@buf + 512*size TCHAR]
        lea     edx, [@@buf + 768*size TCHAR]
        lea     esi, [@@buf + 1024*size TCHAR]
        call    [prn_Insert] C, 6, eax, ebx, ecx, edx, esi, edi

    @@next_row:
        ; ��������� � ������ ���������� �������
        inc     [@@curItem]
        dec     [@@count]
        jnz     @@row_loop

    @@done:
        ; ����������� ������
        invoke  [prn_End] C

    @@freelib:
        ; ������� ������ �� DLL
        call    FreeLibrary, [@@hModule]
    @@exit:
        ret


    @@get_next_item:
        ; ��������� � ���������� �������
        inc     esi
        add     edi, 256 * size TCHAR
    @@get_item:
        ; ������ ������ �� ������� ������ � �������
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
