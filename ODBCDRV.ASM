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
include         "odbcdrv.inc"

include         "console.inc"


includelib      "imp32i.lib"
includelib      "odbc32.lib"
includelib      "odbccp32.lib"


; формирует переход если выполнение пред команды odbc возвратило
; ошибку (в регистре EAX)
macro SQLERR lab
        and     eax, 0FFFEh     ;; eax = (eax & (~(SQL_SUCCESS|SQL_SUCCESS_WITH_INFO))) == 0
        jnz     &lab&
endm



dataseg
  hEnv                  dd 0    ; идентификатор окружения ODBC


codeseg


proc odbc_Open, @@hWnd: HWND
        ; получаем идентификатор окружения
        call    SQLAllocHandle, SQL_HANDLE_ENV, SQL_NULL_HANDLE, offset hEnv
        SQLERR  @@errenv
        ; выбираем версию ODBC, подойдет и третья
        call    SQLSetEnvAttr, [hEnv], SQL_ATTR_ODBC_VERSION, SQL_OV_ODBC3, 0
        SQLERR  @@errattr
        or      eax, -1
        ret
    @@errattr:
        call    odbc_Close
    @@errenv:
        invoke  MessageBox, [@@hWnd], "Can not open ODBC dirver!", "ODBC ERROR", MB_OK+MB_ICONERROR
        xor     eax, eax
        mov     [hEnv], eax
        ret
endp


proc odbc_Close
        mov     ecx, [hEnv]
        jecxz   @@exit
        call    SQLFreeHandle, SQL_HANDLE_ENV, ecx
        xor     eax, eax
        mov     [hEnv], eax
    @@exit:
        ret
endp



proc odbc_Connect uses esi, @@hWnd: HWND, @@szFullName: LPTCHAR
  local @@hConn
  local @@LenOutConn
  local @@szInConn :TCHAR:1024
  local @@szOutConn:TCHAR:1024

        mov     ecx, [hEnv]
        jecxz   @@done
        ; выделяем память идентификатору окружения
        lea     edx, [@@hConn]
        call    SQLAllocHandle, SQL_HANDLE_DBC, ecx, edx
        SQLERR  @@errret
        ; формируем строку подключения к базе
        lea     esi, [@@szInConn]
        invoke  lstrcpy, esi, <"DRIVER={Microsoft Access Driver (*.mdb)}",59,"DBQ=">
        call    lstrcat, esi, [@@szFullName]
        ; теперь попытаемся подключиться непосредственно к источнику данных
        lea     eax, [@@szOutConn]
        lea     edx, [@@LenOutConn]
        call    SQLDriverConnect, [@@hConn], \
                                  [@@hWnd], \
                                  esi, \
                                  size TCHAR*1024,\
                                  eax, \
                                  size TCHAR*1024, \
                                  edx, \
                                  SQL_DRIVER_COMPLETE
        SQLERR  @@errcon
        mov     eax, [@@hConn]
    @@done:
        ret

    @@errcon:
        call    obbc_Disconnect, [@@hConn]
    @@errret:
        xor     eax, eax
        jmp     @@done
endp


proc odbc_DoConnect uses ebx esi edi, @@hWnd: HWND, @@szPath: LPTCHAR, @@szNameDB: LPTCHAR, @@szTable: LPTCHAR, @@szIndex: LPTCHAR
  local @@hStmt
  local @@szInConn :TCHAR:2048
        mov     ecx, [hEnv]
        jecxz   @@error
        ; формируем строку подключения и полного пути к источнику данных
        lea     edi, [@@szInConn]
        invoke  lstrcpy, edi, <"CREATE_DB=">
        call    lstrcat, edi, [@@szPath]
        call    lstrcat, edi, [@@szNameDB]
        ; проверяем наличие файла источника данных
        lea     esi, [@@szInConn+(10 * size TCHAR)]
        call    CreateFile, esi, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
        inc     eax             ; cmp     eax, INVALID_HANDLE_VALUE
        jz      @@create        ; -> файла не существует
        dec     eax
        call    CloseHandle, eax

        ; -----------------------------------------------------
        ; источник данных уже присутствует, пробуем его открыть
        ; -----------------------------------------------------
        call    odbc_Connect, [@@hWnd], esi
        ret

        ; -----------------------------------------------------
        ; создаём новый источник данных
        ; -----------------------------------------------------
    @@create:
        ; создаем источник данных
        invoke  SQLConfigDataSource, 0, ODBC_ADD_DSN, <"Microsoft Access Driver (*.mdb)">, edi
        or      eax, eax
        jz       @@error        ; -> не получилось создать новый источник данных
        ; открываем новую базу данных
        call    odbc_Connect, [@@hWnd], esi
        or      eax, eax
        jz      @@error         ; -> не удалось открыть новый источник данных
        xchg    edi, eax
        ; источник данных успешно создан и открыт, добавляем таблицу
        lea     eax, [@@hStmt]
        call    SQLAllocHandle, SQL_HANDLE_STMT, edi, eax
        SQLERR  @@errdisconnect
        call    SQLExecDirect, [@@hStmt], [@@szTable], SQL_NTS
        ;<"CREATE TABLE main ([Key] COUNTER,[Data] DATETIME NOT NULL,[Object] INTEGER NOT NULL,[Code] INTEGER NOT NULL,[Param] INTEGER)">
        SQLERR  @@errdisconnect
        invoke  SQLExecDirect, [@@hStmt], [@@szIndex], SQL_NTS
        ; <"CREATE INDEX NewIndex ON main (Object,Code,Data)">
        SQLERR  @@errdisconnect
        ; всё хорошо, возвращаем хэндл коннекта
        xchg    eax, edi
        ret
    @@errdisconnect:
        call    obbc_Disconnect, edi
    @@error:
        xor     eax, eax
        ret
endp





proc obbc_Disconnect, @@hConn: HANDLE
        mov     ecx, [@@hConn]
        jecxz   @@exit
        ; разъединяемся с источником данных
        push    ecx
        push    SQL_HANDLE_DBC
        call    SQLDisconnect, ecx
        ; и освобождаем его хэндл
        call    SQLFreeHandle
        xor     eax, eax
    @@exit:
        ret
endp



proc sql_PrepareStmt, @@hConn: HANDLE, @@szSQLstr: LPTCHAR
  local @@hStmt
        ; выделяем память для оперативного идентификатора
        mov     ecx, [@@hConn]
        jecxz   @@errret
        lea     edx, [@@hStmt]
        call    SQLAllocHandle, SQL_HANDLE_STMT, ecx, edx
        SQLERR  @@errret
        ; компилируем инструкцию
        call    SQLPrepare, [@@hStmt], [@@szSQLstr], SQL_NTS
        SQLERR  @@errpre
        mov     eax, [@@hStmt]
        ret

    @@errpre:
        call    sql_CloseStmt, [@@hStmt]
    @@errret:
        xor     eax, eax
        ret
endp


proc sql_BindInInteger, @@hStmp: HANDLE, @@nParam: DWORD, @@lpParam: LPVOID, @@lpInd: LPVOID
        mov     ecx, [@@hStmp]
        jecxz   @@done
        mov     edx, [@@lpInd]
        mov     [dword edx], 0
        call    SQLBindParameter, ecx, [@@nParam], SQL_PARAM_INPUT, \
                                  SQL_C_ULONG, SQL_INTEGER, \
                                  10, 0, \ ; ширина поля и число знаков после запятой
                                  [@@lpParam], 0, edx
    @@done:
        ret
endp

proc sql_BindInDate, @@hStmp: HANDLE, @@nParam: DWORD, @@lpParam: LPVOID, @@lpInd: LPVOID
        mov     ecx, [@@hStmp]
        jecxz   @@done
        mov     edx, [@@lpInd]
        mov     [dword edx], 0
        call    SQLBindParameter, ecx, [@@nParam], SQL_PARAM_INPUT, \
                                  SQL_C_TIMESTAMP, SQL_TIMESTAMP, \
                                  40, 0, \ ; ширина поля и число знаков после запятой
                                  [@@lpParam], 0, edx
    @@done:
        ret
endp


proc sql_Execute, @@hStmt: HANDLE
        mov     ecx, [@@hStmt]
        jecxz   @@done
        call    SQLExecute, ecx
    @@done:
        ret
endp

proc sql_CloseStmt, @@hStmt: HANDLE
        mov     ecx, [@@hStmt]
        jecxz   @@done
        call    SQLFreeHandle, SQL_HANDLE_STMT, ecx
        xor     eax, eax
    @@done:
        ret
endp


end
