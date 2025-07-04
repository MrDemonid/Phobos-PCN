; ⨯� ��࠭���஢
RTR_PHOBOS              = 1
RTR_PHOBOS3             = 3

; 䫠�� .fStatus
TAB_MODIFIED    = 1h            ; �뫨 ��������� � ������祭���/�⪫�祭��� ���祩


; ᢮��⢠ ���祩 (.lpKeyHandles)
; ����⠭�� KEY_XXXX � 䠩�� OWNER.INC


struc TAB
  hDisp         HWND ?          ; ����� ���� ⥪�饩 ��࠭���
  fStatus       dd ?            ; 䫠�� ���ﭨ� �������
  ; ��࠭����
  retID         dd ?            ; ����� ��࠭����
  retType       dd ?            ; ⨯ ��࠭���� (PHOBOS_XX)
  ; ����
  keyTotal      dd ?            ; ������⢮ ���祩
  keyFirst      dd ?            ; ����� ��ࢮ�� ����
  keyHor        dd ?            ; ������⢮ ���祩 �� �ਭ� ����
  keyVer        dd ?            ; ������⢮ ���祩 �� ���� ����
;  keyFlags      LPDWORD ?       ; ���ﭨ� � ��ࠬ���� ���祩
  lpKeyHandles  LPHANDLE ?      ; ������ ���祩
  ; ࠧ��⪠
  labVerFirst   dd ?            ; ��� ����� ���⨪��쭮� ࠧ��⪨ (��� 㤮��⢠)
  lpLabHandles  LPHANDLE ?      ; ������ ࠧ��⪨
ends

typedef LPTAB   ptr TAB

procdesc tab_Init         @@paren: HWND
procdesc tab_Done
procdesc tab_NewPage      @@lpszName: dword, @@retType: dword, @@keyHor: dword, @@keyVer: dword
procdesc tab_SetFlags     @@rtrID:dword, @@numKeys:dword, @@lpKeys: ptr byte, @@numBads:dword, @@lpBads: ptr byte

; �����㦠�� ������ �� ���譥�� 䠩��
; �� �室�:
;       nRTR    - ����� ��࠭���� (�������) [1..8]
;       Section - ��� ᥪ樨 � INI-䠩��, ��� �饬 ��� 䠩�� � ��⬠��� ������
procdesc tab_NewIcon      @@nRTR: byte, @@szSection: LPTCHAR



; �८�ࠧ㥬 ����� ��࠭���� � ���ࠢ����� � ��᮫��� ����� ���ࠢ�����
; �� �室�:
;       rtr     - ��࠭���� [1..8]
;       key     - ���ࠢ����� [0..119]
; �� ��室�:
;       eax     - ��᮫��� ����� ���ࠢ����� [0..959]
procdesc tab_RtrToAbs     @@rtrID: dword, @@key: dword

; ���⭮� �८�ࠧ������
; �� �室�:
;       key     - ��᮫��� ����� ���ࠢ����� [0..959]
; �� ��室�:
;       edx     - ��࠭���� [1..8]
;       eax     - ���ࠢ����� [0..119]
procdesc tab_AbsToRtr     @@key: dword


;
procdesc tab_OnSize       @@x: dword, @@y:dword, @@width: dword, @@height: dword
procdesc tab_OnNotify     @@hWnd: HWND, @@wParam: dword, @@lParam: dword
procdesc tab_OnDispChange @@hWnd: HWND, @@wParam: dword, @@lParam: dword
procdesc tab_OnReceive    @@wParam: dword, @@lParam: dword

