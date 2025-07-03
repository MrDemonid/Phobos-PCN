DLG_LOGINFO             equ 3000
IDC_LIST                equ 3009
IDC_OK                  equ 3011
IDC_REFRESH             equ 3012
IDC_REPORT              equ 3013
IDC_DATAFROM            equ 3005
IDC_DATATO              equ 3006
IDC_TIMEFROM            equ 3007
IDC_TIMETO              equ 3008
IDC_OBJECT              equ 3004
IDC_RTR                 equ 3014



procdesc log_Open       @@hWnd: HWND
procdesc log_Close

; на входе:
;    key        - номер объекта
;    cmd        - номер команды
;    param      - возможный параметр команды ТС
procdesc log_Insert     @@key: DWORD, @@cmd: DWORD, @@param: DWORD

procdesc log_DlgProc    @@hWnd: HWND, @@uMsg: DWORD, @@wParam: DWORD, @@lParam: DWORD


