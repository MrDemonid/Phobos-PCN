
; ᮮ�饭�� �� ��࠭����
WM_RECEIVE              = WM_USER+100   ; HI(wParam) - ��࠭����
                                        ; LO(wParam) - ����� ����
                                        ; HI(lParam) - LO(����� 諥��), HI(hoz)
                                        ; LO(lParam) - cmd

; ���� ����饭�� (TC) � WM_RECEIVE
TC_FIRST                = 1
TC_ACCIDENT             = 1     ; "�����"
TC_KEYCONNECT           = 2     ; "���ࠢ����� ������祭�"
TC_KEYDISCONNECT        = 3     ; "���ࠢ����� �⪫�祭�"
TC_KZ                   = 4     ; "���몠���"
TC_REPLACEMENT          = 5     ; "������� ��"
TC_TYPEUO               = 6     ; "��।������ ⨯ ��"
TC_ATTIRE               = 7     ; "����"
TC_NOTTAKEN             = 8     ; "�� ����"
TC_REMOVED              = 9     ; "����"
TC_TAKEN                = 10    ; "����"
TC_TEHNOLOGICAL         = 11    ; "��孮�����᪠�"
TC_ALERT                = 12    ; "�ॢ���"
TC_UOOPEN               = 13    ; "����⨥ ��"
TC_UOCLOSE              = 14    ; "����⠭������� ��"
TC_RTRFAILURE           = 15    ; "�⪠� ��࠭����"
TC_RTRRESTORE           = 16    ; "����⠭������� ��࠭����"
TC_REMOVEDSILENT        = 17    ; "����" (�� "����� �����")
TC_TAKENSILENT          = 18    ; "����" (�� "����� ������")
TC_MAX                  = 18

; ���� ������ ⥫��ࠢ����� (��)
TU_PICKUP               = 19    ; "����� �ࠧ�"
TU_REMOVE               = 20    ; "�����"
TU_TAKEAFTER            = 21    ; "����� ��᫥ ��室�"
TU_STATUSUO             = 22    ; "����� ��"
TU_REQUESTON            = 23    ; "����� ������"
TU_REQUESTOFF           = 24    ; "����� �����"
TU_CONNECT              = 25    ; "��������� ���ࠢ�����"
TU_DISCONNECT           = 26    ; "�⪫���� ���ࠢ�����"
TU_GETTYPEUO            = 27    ; "��।����� ⨯ ��"


;TC_FAULT                = 15    ; "����ࠢ�����"
;TC_RESET                = 16    ; "����"
;TC_ATTENTION            = 17    ; "��������"
;TC_FIRE                 = 18    ; "�����"
;TC_PROTECTION           = 19    ; "��࠭�"
;TC_SIGNALUO             = 20    ; "�஢��� ᨣ���� �� ��
;TC_RTROPEN              = 5     ; "���誠 ��࠭���� �����"
;TC_RTRCLOSE             = 6     ; "���誠 ��࠭���� ������"

                                        ; lParam     - ��� ��




procdesc aux_Open       @@nPort: byte
procdesc aux_Close


; �ନ��� � ����頥� �� � ��।�
; �� �室�
;   rtrNum      - ����� ��࠭���� [1..MAX_RTR]
;   keyNum      - ����� ���ࠢ����� (����) [0..119]
;   cmdTU       - ⨯ ������� ��
procdesc aux_SendTU     @@rtrNum: dword, @@keyNum: dword, @@cmdTU: dword

; �८�ࠧ�� ��� �� ��� �� � ��ப�
; �� �室�:
;    cmd        - ��� �� ��� ��
; �� ��室�:
;    eax        - ��ப� � ���ᠭ��� ����
procdesc aux_CodeToStr  @@cmd: dword

