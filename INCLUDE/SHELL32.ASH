struc NOTIFYICONDATA
  cbSize           dd ?
  hWnd             dd ?
  uID              dd ?
  uFlags           dd ?
  uCallbackMessage dd ?
  hIcon            dd ?
  szTip            TCHAR 64 dup (?)
ends

struc DLLVERSIONINFO
  cbSize                dd ?
  dwMajorVersion        dd ?
  dwMinorVersion        dd ?
  dwBuildNumber         dd ?
  dwPlatformID          dd ?
ends

struc SHFILEOPSTRUCT
  hWnd                  dd ?
  wFunc                 dd ?
  pFrom                 dd ?
  pTo                   dd ?
  fFlags                dd ?
  fAnyOperationsAborted dd ?
  hNameMappings         dd ?
  lpszProgressTitle     dd ?
ends

; Taskbar icon messages

NIM_ADD                 = 0
NIM_MODIFY              = 1
NIM_DELETE              = 2
NIM_SETFOCUS            = 3
NIM_SETVERSION          = 4

; Taskbar icon flags

NIF_MESSAGE             = 01h
NIF_ICON                = 02h
NIF_TIP                 = 04h
NIF_STATE               = 08h
NIF_INFO                = 10h
NIF_GUID                = 20h
