; ������� ��।� "���� ��襫 - ���� �襫"
; �������� �࠭���� � ���� ��᪠�� ��ப


struc QUEUE
  lpElem        dd ?    ; 㪠��⥫� �� ���ᨢ ������⮢
  nElem         dd ?    ; ࠧ��� ��।�
  nUsed         dd ?    ; ������⢮ ��. � ��।�
  nGet          dd ?    ; ����� ������� ��� �����祭��
  nPut          dd ?    ; ����� ������� ��� ����������
ends


; ᮧ���� � ���樠������� �������� ��।�
; �� ��室�:
;   eax - ���� ��।� ��� NULL �� �訡��
procdesc queue_Create   @@numElem: dword

; 㭨�⮦��� ��।�
procdesc queue_Destroy  @@lpQueue: ptr QUEUE

; �஢�ઠ ��।� �� ������⢨� ������⮢
; �� ��室�:
;   eax - 䫠� (>0 - ��।� ����, 0 - ��-� ����)
procdesc queue_IsEmpty  @@lpQueue: ptr QUEUE


; �⥭�� ������� �� ��।�
; �� ��室�:
; eax   - �ਧ��� �ᯥ� (>0 - ��⠫�, 0 - ��।� ����)
procdesc queue_Get      @@lpQueue: ptr QUEUE, @@lpElem: ptr byte


; ���������� ������� � ��।�
; �� ��室�:
; eax   - �ਧ��� �ᯥ� (>0 - ��������, 0 - ��।� ��९������)
procdesc queue_Put      @@lpQueue: ptr QUEUE, @@lpStr: dword, @@nSize: dword
;@@lpElem: ptr ELEM
