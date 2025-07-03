DEBUG_CONSOLE   = 1
DEBUG_FILE      = 2

procdesc dbg_Create   CPP @@dev: byte

procdesc con_printf   CPP @@frmStr: dword, @@va_list: dword:?
procdesc con_printa   CPP @@lpArray: dword, @@nSize: dword