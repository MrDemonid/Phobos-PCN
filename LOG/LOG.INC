; ���樠������
; �� �室�:
;       lpszName- ��� 䠩�� (if == 0 then disable log)
;       isNew   - 䫠� ᮧ����� ������ 䠩��
procdesc log_Init           @@lpszName: dword, @@isNew: byte

procdesc log_Add        CPP @@frmStr: dword, @@va_list: dword:?
