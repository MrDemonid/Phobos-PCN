DATE_DELIMITER  = '-'           ; ᨬ��� ࠧ����⥫� ��� ����
TIME_DELIMITER  = ':'           ; ᨬ��� ࠧ����⥫� ��� �६���


; �p���p��㥬 ����p ��ꥪ� � ��p���
; �� �室�:
;       eax     - number
;       edi     - buffer
procdesc util_Int2Name

; �� �室�:
;       eax     - ����� ��ꥪ�
;       edi     - ����
procdesc util_ID2Name

ifdef @unicode
; ��ॢ���� ����� ��ꥪ� � ascii ��ப� (������ᨬ� �� ����)
; �� �室�:
;       eax     - ����� ��ꥪ�
;       edi     - ����
procdesc util_ID2Ascii
endif

; �p���p��㥬 �᫮ � ��p���
; �� �室�:
;       eax     - number
;       edi     - buffer
procdesc util_Int2Str


; ��ॢ�� ᨬ���� � hex-��ப�, ���� 0xXX
; �� �室�:
;       al      - ᨬ���
;       edi     - ����
; �� ��室�:
;       edi     - ����� ����
procdesc util_Byte2Hex


procdesc util_RtlZeroMemory     @@lpBuff: dword, @@nSize: dword


; �८�ࠧ������ ���� � ᨬ����� �ଠ�
; �� �室�:
;       esi     - ��室��� ��ப�
;       edx     - ������� DATA_STRUCT
procdesc util_DateToStr

; �८�ࠧ������ �६��� � ᨬ����� �ଠ�
; �� �室�:
;       esi     - ��室��� ��ப�
;       edx     - ������� TIME_STRUCT
procdesc util_TimeToStr

; �� �室�:
;       edi     - ��室��� ��ப�
;       dl      - ���. ���� ����饭�� ��
; �� ��室�:
;       edi     - ��ப�
procdesc util_TCParam


procdesc util_GetModulePath     @@lpszPath: LPTCHAR, @@len: DWORD

procdesc err_ShowLastError      @@hWnd: dword, @@lpszModule: dword, @@lpszFunc: dword
procdesc err_ShowUserError      @@hWnd: dword, @@lpszModule: dword, @@lpszFunc: dword, @@lpszStr: dword




macro SAFE_DELETE obj:req
  local @@1
        xor     ecx, ecx
        xchg    ecx, &obj
        jecxz   @@1
        call    DeleteObject, ecx
    @@1:
endm

macro SAFE_CLOSE handl:req
  local @@1
        xor     ecx, ecx
        xchg    ecx, &handl
        jecxz   @@1
        call    CloseHandle, ecx
    @@1:
endm
