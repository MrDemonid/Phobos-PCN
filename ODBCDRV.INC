procdesc odbc_Open          @@hWnd: HWND

procdesc odbc_Close

;procdesc odbc_Connect       @@hWnd: HWND, @@szPath: LPTCHAR, @@szNameDB: LPTCHAR
procdesc odbc_DoConnect     @@hWnd: HWND, @@szPath: LPTCHAR, @@szNameDB: LPTCHAR, @@szTable: LPTCHAR, @@szIndex: LPTCHAR
procdesc obbc_Disconnect    @@hConn: HANDLE

procdesc sql_PrepareStmt    @@hConn: HANDLE, @@szSQLstr: LPTCHAR
procdesc sql_BindInInteger  @@hStmp: HANDLE, @@nParam: DWORD, @@lpParam: LPVOID, @@lpInd: LPVOID
procdesc sql_BindInDate     @@hStmp: HANDLE, @@nParam: DWORD, @@lpParam: LPVOID, @@lpInd: LPVOID
procdesc sql_Execute        @@hStmt: HANDLE
procdesc sql_CloseStmt      @@hStmt: HANDLE

