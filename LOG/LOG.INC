; инициализация
; на входе:
;       lpszName- имя файла (if == 0 then disable log)
;       isNew   - флаг создания нового файла
procdesc log_Init           @@lpszName: dword, @@isNew: byte

procdesc log_Add        CPP @@frmStr: dword, @@va_list: dword:?
