
procdesc pcn_Init       @@hParen: HWND
procdesc pcn_Done

procdesc pcn_GetMinWidth
procdesc pcn_BreakCmd

procdesc disp_ShowTxt   @@lpszTxt: dword
procdesc disp_Clear

; ��ࠡ��稪� ᮡ�⨩

; WM_SIZE �������� ����
procdesc pcn_OnSize     @@x: dword, @@y:dword, @@width: dword, @@height: dword

; WM_RECEIVE
procdesc pcn_OnReceive  @@wParam: dword, @@lParam: dword