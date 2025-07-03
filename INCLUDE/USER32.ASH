; USER32.DLL structures and constants

typedef LPPOINT                 ptr     POINT
typedef LPRECT                  ptr     RECT
typedef LPWNDCLASS              ptr     WNDCLASS
typedef LPWNDCLASSEX            ptr     WNDCLASSEX
typedef LPCREATESTRUCT          ptr     CREATESTRUCT
typedef LPCLIENTCREATESTRUCT    ptr     CLIENTCREATESTRUCT
typedef LPMDICREATESTRUCT       ptr     MDICREATESTRUCT
typedef LPSCROLLINFO            ptr     SCROLLINFO
typedef LPMSG                   ptr     MSG
typedef LPMINMAXINFO            ptr     MINMAXINFO
typedef LPWINDOWPLACEMENT       ptr     WINDOWPLACEMENT
typedef LPWINDOWPOS             ptr     WINDOWPOS
typedef LPNMHDR                 ptr     NMHDR
typedef LPCOPYDATASTRUCT        ptr     COPYDATASTRUCT
typedef LPACCEL                 ptr     ACCEL
typedef LPPAINTSTRUCT           ptr     PAINTSTRUCT
typedef LPDRAWTEXTPARAMS        ptr     DRAWTEXTPARAMS
typedef LPDRAWITEMSTRUCT        ptr     DRAWITEMSTRUCT
typedef LPMENUITEMINFO          ptr     MENUITEMINFO
typedef LPMEASUREITEMSTRUCT     ptr     MEASUREITEMSTRUCT
typedef LPMSGBOXPARAMS          ptr     MSGBOXPARAMS


struc POINT
  x             dd ?
  y             dd ?
ends

struc RECT
  left          dd ?
  top           dd ?
  right         dd ?
  bottom        dd ?
ends

struc WNDCLASS
  cbSize        dd ?
  style         dd ?
  lpfnWndProc   dd ?
  cbClsExtra    dd ?
  cbWndExtra    dd ?
  hInstance     dd ?
  hIcon         dd ?
  hCursor       dd ?
  hbrBackground dd ?
  lpszMenuName  dd ?
  lpszClassName dd ?
ends

struc WNDCLASSEX
  cbSize        dd ?
  style         dd ?
  lpfnWndProc   dd ?
  cbClsExtra    dd ?
  cbWndExtra    dd ?
  hInstance     dd ?
  hIcon         dd ?
  hCursor       dd ?
  hbrBackground dd ?
  lpszMenuName  dd ?
  lpszClassName dd ?
  hIconSm       dd ?
ends

struc CREATESTRUCT
  lpCreateParams dd ?
  hInstance      dd ?
  hMenu          dd ?
  hwndParent     dd ?
  cy             dd ?
  cx             dd ?
  y              dd ?
  x              dd ?
  style          dd ?
  lpszName       dd ?
  lpszClass      dd ?
  dwExStyle      dd ?
ends

struc CLIENTCREATESTRUCT
  hWindowMenu   dd ?
  idFirstChild  dd ?
ends

struc MDICREATESTRUCT
  szClass       dd ?
  szTitle       dd ?
  hOwner        dd ?
  x             dd ?
  y             dd ?
  cx            dd ?
  cy            dd ?
  style         dd ?
  lParam        dd ?
ends

struc SCROLLINFO
  cbSize        dd ?
  fMask         dd ?
  nMin          dd ?
  nMax          dd ?
  nPage         dd ?
  nPos          dd ?
  nTrackPos     dd ?
ends

struc MSG
  hwnd          dd ?
  message       dd ?
  wParam        dd ?
  lParam        dd ?
  time          dd ?
  pt            POINT <>
ends

struc MINMAXINFO
  ptReserved     POINT <>
  ptMaxSize      POINT <>
  ptMaxPosition  POINT <>
  ptMinTrackSize POINT <>
  ptMaxTrackSize POINT <>
ends

struc WINDOWPLACEMENT
  length           dd ?
  flags            dd ?
  showCmd          dd ?
;  ptMinPosition    POINT <>
;  ptMaxPosition    POINT <>
;  rcNormalPosition RECT <>
ends

struc WINDOWPOS
  hwnd            dd ?
  hwndInsertAfter dd ?
  x               dd ?
  y               dd ?
  cx              dd ?
  cy              dd ?
  flags           dd ?
ends

struc NMHDR
  hwndFrom      dd ?
  idFrom        dd ?
  code          dd ?
ends

struc COPYDATASTRUCT
  dwData        dd ?
  cbData        dd ?
  lpData        dd ?
ends

struc ACCEL
  fVirt         dw ?
  key           dw ?
  cmd           dw ?
ends

struc PAINTSTRUCT
  hdc           dd ?
  fErase        dd ?
  rcPaint       RECT <>
  fRestore      dd ?
  fIncUpdate    dd ?
  rgbReserved   db 32 dup (?)
ends

struc DRAWTEXTPARAMS
  cbSize        dd ?
  iTabLength    dd ?
  iLeftMargin   dd ?
  iRightMargin  dd ?
  uiLengthDrawn dd ?
ends

struc DRAWITEMSTRUCT
  CtlType       dd ?
  CtlID         dd ?
  itemID        dd ?
  itemAction    dd ?
  itemState     dd ?
  hwndItem      dd ?
  hDC           dd ?
  rcItem        RECT <>
  itemData      dd ?
ends

struc MENUITEMINFO
  cbSize        dd ?
  fMask         dd ?
  fType         dd ?
  fState        dd ?
  wID           dd ?
  hSubMenu      dd ?
  hbmpChecked   dd ?
  hbmpUnchecked dd ?
  dwItemData    dd ?
  dwTypeData    dd ?
  cch           dd ?
ends

struc MEASUREITEMSTRUCT
  CtlType       dd ?
  CtlID         dd ?
  itemID        dd ?
  itemWidth     dd ?
  itemHeight    dd ?
  itemData      dd ?
ends

struc MSGBOXPARAMS
  cbSize             dd ?
  hwndOwner          dd ?
  hInstance          dd ?
  lpszText           dd ?
  lpszCaption        dd ?
  dwStyle            dd ?
  lpszIcon           dd ?
  dwContextHelpId    dd ?
  lpfnMsgBoxCallback dd ?
  dwLanguageId       dd ?
ends

; MessageBox type flags

MB_OK                   equ 000000h
MB_OKCANCEL             equ 000001h
MB_ABORTRETRYIGNORE     equ 000002h
MB_YESNOCANCEL          equ 000003h
MB_YESNO                equ 000004h
MB_RETRYCANCEL          equ 000005h
MB_ICONHAND             equ 000010h
MB_ICONQUESTION         equ 000020h
MB_ICONEXCLAMATION      equ 000030h
MB_ICONASTERISK         equ 000040h
MB_USERICON             equ 000080h
MB_ICONWARNING          equ <MB_ICONEXCLAMATION>
MB_ICONERROR            equ <MB_ICONHAND>
MB_ICONINFORMATION      equ <MB_ICONASTERISK>
MB_ICONSTOP             equ <MB_ICONHAND>
MB_DEFBUTTON1           equ 000000h
MB_DEFBUTTON2           equ 000100h
MB_DEFBUTTON3           equ 000200h
MB_DEFBUTTON4           equ 000300h
MB_APPLMODAL            equ 000000h
MB_SYSTEMMODAL          equ 001000h
MB_TASKMODAL            equ 002000h
MB_HELP                 equ 004000h
MB_NOFOCUS              equ 008000h
MB_SETFOREGROUND        equ 010000h
MB_DEFAULT_DESKTOP_ONLY equ 020000h
MB_TOPMOST              equ 040000h
MB_RIGHT                equ 080000h
MB_RTLREADING           equ 100000h
MB_SERVICE_NOTIFICATION equ 200000h

; Conventional dialog box and message box command IDs

IDOK                    equ 1
IDCANCEL                equ 2
IDABORT                 equ 3
IDRETRY                 equ 4
IDIGNORE                equ 5
IDYES                   equ 6
IDNO                    equ 7
IDCLOSE                 equ 8
IDHELP                  equ 9

; Class styles

CS_VREDRAW              equ 00001h
CS_HREDRAW              equ 00002h
CS_KEYCVTWINDOW         equ 00004h
CS_DBLCLKS              equ 00008h
CS_OWNDC                equ 00020h
CS_CLASSDC              equ 00040h
CS_PARENTDC             equ 00080h
CS_NOKEYCVT             equ 00100h
CS_SAVEBITS             equ 00800h
CS_NOCLOSE              equ 00200h
CS_BYTEALIGNCLIENT      equ 01000h
CS_BYTEALIGNWINDOW      equ 02000h
CS_PUBLICCLASS          equ 04000h
CS_GLOBALCLASS          equ CS_PUBLICCLASS
CS_IME                  equ 10000h

; Windows styles

WS_OVERLAPPED           equ 000000000h
WS_ICONICPOPUP          equ 0C0000000h
WS_POPUP                equ 080000000h
WS_CHILD                equ 040000000h
WS_MINIMIZE             equ 020000000h
WS_VISIBLE              equ 010000000h
WS_DISABLED             equ 008000000h
WS_CLIPSIBLINGS         equ 004000000h
WS_CLIPCHILDREN         equ 002000000h
WS_MAXIMIZE             equ 001000000h
WS_CAPTION              equ 000C00000h
WS_BORDER               equ 000800000h
WS_DLGFRAME             equ 000400000h
WS_VSCROLL              equ 000200000h
WS_HSCROLL              equ 000100000h
WS_SYSMENU              equ 000080000h
WS_THICKFRAME           equ 000040000h
WS_HREDRAW              equ 000020000h
WS_VREDRAW              equ 000010000h
WS_GROUP                equ 000020000h
WS_TABSTOP              equ 000010000h
WS_MINIMIZEBOX          equ 000020000h
WS_MAXIMIZEBOX          equ 000010000h

; Common Window Styles

WS_OVERLAPPEDWINDOW     equ WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX or WS_MAXIMIZEBOX
WS_POPUPWINDOW          equ WS_POPUP or WS_BORDER or WS_SYSMENU
WS_CHILDWINDOW          equ WS_CHILD
WS_TILEDWINDOW          equ WS_OVERLAPPEDWINDOW
WS_TILED                equ WS_OVERLAPPED
WS_ICONIC               equ WS_MINIMIZE
WS_SIZEBOX              equ WS_THICKFRAME

; Extended Window Styles

WS_EX_DLGMODALFRAME     equ 00001h
WS_EX_DRAGOBJECT        equ 00002h
WS_EX_NOPARENTNOTIFY    equ 00004h
WS_EX_TOPMOST           equ 00008h
WS_EX_ACCEPTFILES       equ 00010h
WS_EX_TRANSPARENT       equ 00020h
WS_EX_MDICHILD          equ 00040h
WS_EX_TOOLWINDOW        equ 00080h
WS_EX_WINDOWEDGE        equ 00100h
WS_EX_CLIENTEDGE        equ 00200h
WS_EX_CONTEXTHELP       equ 00400h
WS_EX_RIGHT             equ 01000h
WS_EX_LEFT              equ 00000h
WS_EX_RTLREADING        equ 02000h
WS_EX_LTRREADING        equ 00000h
WS_EX_LEFTSCROLLBAR     equ 04000h
WS_EX_RIGHTSCROLLBAR    equ 00000h
WS_EX_CONTROLPARENT     equ 10000h
WS_EX_STATICEDGE        equ 20000h
WS_EX_APPWINDOW         equ 40000h
WS_EX_LAYERED           equ 80000h
WS_EX_OVERLAPPEDWINDOW  equ WS_EX_WINDOWEDGE or WS_EX_CLIENTEDGE
WS_EX_PALETTEWINDOW     equ WS_EX_WINDOWEDGE or WS_EX_TOOLWINDOW or WS_EX_TOPMOST

WS_EX_LAYERED           equ 00080000h
WS_EX_NOINHERITLAYOUT   equ 00100000h ; Disable inheritence of mirroring by children
WS_EX_LAYOUTRTL         equ 00400000h ; Right to left mirroring
WS_EX_COMPOSITED        equ 02000000h
WS_EX_NOACTIVATE        equ 08000000h

; MDI client style bits

MDIS_ALLCHILDSTYLES     equ 1

; Special CreateWindow position value

CW_USEDEFAULT           equ 8000h

; Predefined window handle

HWND_DESKTOP            equ 0

; ShowWindow commands

SW_HIDE                 equ 0
SW_SHOWNORMAL           equ 1
SW_NORMAL               equ 1
SW_SHOWMINIMIZED        equ 2
SW_SHOWMAXIMIZED        equ 3
SW_MAXIMIZE             equ 3
SW_SHOWNOACTIVATE       equ 4
SW_SHOW                 equ 5
SW_MINIMIZE             equ 6
SW_SHOWMINNOACTIVE      equ 7
SW_SHOWNA               equ 8
SW_RESTORE              equ 9
SW_SHOWDEFAULT          equ 10

; SetWindowPos flags

SWP_NOSIZE              equ 0001h
SWP_NOMOVE              equ 0002h
SWP_NOZORDER            equ 0004h
SWP_NOREDRAW            equ 0008h
SWP_NOACTIVATE          equ 0010h
SWP_DRAWFRAME           equ 0020h
SWP_SHOWWINDOW          equ 0040h
SWP_HIDEWINDOW          equ 0080h
SWP_NOCOPYBITS          equ 0100h
SWP_NOREPOSITION        equ 0200h
SWP_DEFERERASE          equ 2000h
SWP_ASYNCWINDOWPOS      equ 4000h

; SetWindowPos special handle values

HWND_TOP                equ 0
HWND_BOTTOM             equ 1
HWND_TOPMOST            equ -1
HWND_NOTOPMOST          equ -2

; GetWindow flags

GW_HWNDFIRST            equ 0
GW_HWNDLAST             equ 1
GW_HWNDNEXT             equ 2
GW_HWNDPREV             equ 3
GW_OWNER                equ 4
GW_CHILD                equ 5

; RedrawWindow flags

RDW_INVALIDATE          equ 0001h
RDW_INTERNALPAINT       equ 0002h
RDW_ERASE               equ 0004h
RDW_VALIDATE            equ 0008h
RDW_NOINTERNALPAINT     equ 0010h
RDW_NOERASE             equ 0020h
RDW_NOCHILDREN          equ 0040h
RDW_ALLCHILDREN         equ 0080h
RDW_UPDATENOW           equ 0100h
RDW_ERASENOW            equ 0200h
RDW_FRAME               equ 0400h
RDW_NOFRAME             equ 0800h

; PeekMessage Options

PM_NOREMOVE             equ 0000h
PM_REMOVE               equ 0001h
PM_NOYIELD              equ 0002h

; Window state messages

WM_STATE                equ 0000h
WM_NULL                 equ 0000h
WM_CREATE               equ 0001h
WM_DESTROY              equ 0002h
WM_MOVE                 equ 0003h
WM_SIZE                 equ 0005h
WM_ACTIVATE             equ 0006h
WM_SETFOCUS             equ 0007h
WM_KILLFOCUS            equ 0008h
WM_ENABLE               equ 000Ah
WM_SETREDRAW            equ 000Bh
WM_SETTEXT              equ 000Ch
WM_GETTEXT              equ 000Dh
WM_GETTEXTLENGTH        equ 000Eh
WM_PAINT                equ 000Fh
WM_CLOSE                equ 0010h
WM_QUERYENDSESSION      equ 0011h
WM_QUIT                 equ 0012h
WM_QUERYOPEN            equ 0013h
WM_ERASEBKGND           equ 0014h
WM_SYSCOLORCHANGE       equ 0015h
WM_ENDSESSION           equ 0016h
WM_SYSTEMERROR          equ 0017h
WM_SHOWWINDOW           equ 0018h
WM_CTLCOLOR             equ 0019h
WM_WININICHANGE         equ 001Ah
WM_DEVMODECHANGE        equ 001Bh
WM_ACTIVATEAPP          equ 001Ch
WM_FONTCHANGE           equ 001Dh
WM_TIMECHANGE           equ 001Eh
WM_CANCELMODE           equ 001Fh
WM_SETCURSOR            equ 0020h
WM_MOUSEACTIVATE        equ 0021h
WM_CHILDACTIVATE        equ 0022h
WM_QUEUESYNC            equ 0023h
WM_GETMINMAXINFO        equ 0024h
WM_PAINTICON            equ 0026h
WM_ICONERASEBKGND       equ 0027h
WM_NEXTDLGCTL           equ 0028h
WM_SPOOLERSTATUS        equ 002Ah
WM_DRAWITEM             equ 002Bh
WM_MEASUREITEM          equ 002Ch
WM_DELETEITEM           equ 002Dh
WM_VKEYTOITEM           equ 002Eh
WM_CHARTOITEM           equ 002Fh
WM_SETFONT              equ 0030h
WM_GETFONT              equ 0031h
WM_SETHOTKEY            equ 0032h
WM_QUERYDRAGICON        equ 0037h
WM_COMPAREITEM          equ 0039h
WM_COMPACTING           equ 0041h
WM_COMMNOTIFY           equ 0044h
WM_WINDOWPOSCHANGING    equ 0046h
WM_WINDOWPOSCHANGED     equ 0047h
WM_POWER                equ 0048h
WM_COPYDATA             equ 004Ah
WM_CANCELJOURNAL        equ 004Bh
WM_NOTIFY               equ 004Eh
WM_INPUTLANGCHANGEREQUEST equ 0050h
WM_INPUTLANGCHANGE      equ 0051h
WM_TCARD                equ 0052h
WM_HELP                 equ 0053h
WM_USERCHANGED          equ 0054h
WM_NOTIFYFORMAT         equ 0055h
WM_CONTEXTMENU          equ 007Bh
WM_STYLECHANGING        equ 007Ch
WM_STYLECHANGED         equ 007Dh
WM_DISPLAYCHANGE        equ 007Eh
WM_GETICON              equ 007Fh
WM_SETICON              equ 0080h
WM_NCCREATE             equ 0081h
WM_NCDESTROY            equ 0082h
WM_NCCALCSIZE           equ 0083h
WM_NCHITTEST            equ 0084h
WM_NCPAINT              equ 0085h
WM_NCACTIVATE           equ 0086h
WM_GETDLGCODE           equ 0087h
WM_NCMOUSEMOVE          equ 00A0h
WM_NCLBUTTONDOWN        equ 00A1h
WM_NCLBUTTONUP          equ 00A2h
WM_NCLBUTTONDBLCLK      equ 00A3h
WM_NCRBUTTONDOWN        equ 00A4h
WM_NCRBUTTONUP          equ 00A5h
WM_NCRBUTTONDBLCLK      equ 00A6h
WM_NCMBUTTONDOWN        equ 00A7h
WM_NCMBUTTONUP          equ 00A8h
WM_NCMBUTTONDBLCLK      equ 00A9h
WM_KEYFIRST             equ 0100h
WM_KEYDOWN              equ 0100h
WM_KEYUP                equ 0101h
WM_CHAR                 equ 0102h
WM_DEADCHAR             equ 0103h
WM_SYSKEYDOWN           equ 0104h
WM_SYSKEYUP             equ 0105h
WM_SYSCHAR              equ 0106h
WM_SYSDEADCHAR          equ 0107h
WM_KEYLAST              equ 0108h
WM_INITDIALOG           equ 0110h
WM_COMMAND              equ 0111h
WM_SYSCOMMAND           equ 0112h
WM_TIMER                equ 0113h
WM_HSCROLL              equ 0114h
WM_VSCROLL              equ 0115h
WM_INITMENU             equ 0116h
WM_INITMENUPOPUP        equ 0117h
WM_MENUSELECT           equ 011Fh
WM_MENUCHAR             equ 0120h
WM_ENTERIDLE            equ 0121h
WM_MENURBUTTONUP        equ 0122h
WM_MENUDRAG             equ 0123h
WM_MENUGETOBJECT        equ 0124h
WM_UNINITMENUPOPUP      equ 0125h
WM_MENUCOMMAND          equ 0126h
WM_CTLCOLORMSGBOX       equ 0132h
WM_CTLCOLOREDIT         equ 0133h
WM_CTLCOLORLISTBOX      equ 0134h
WM_CTLCOLORBTN          equ 0135h
WM_CTLCOLORDLG          equ 0136h
WM_CTLCOLORSCROLLBAR    equ 0137h
WM_CTLCOLORSTATIC       equ 0138h
WM_MOUSEFIRST           equ 0200h
WM_MOUSEMOVE            equ 0200h
WM_LBUTTONDOWN          equ 0201h
WM_LBUTTONUP            equ 0202h
WM_LBUTTONDBLCLK        equ 0203h
WM_RBUTTONDOWN          equ 0204h
WM_RBUTTONUP            equ 0205h
WM_RBUTTONDBLCLK        equ 0206h
WM_MBUTTONDOWN          equ 0207h
WM_MBUTTONUP            equ 0208h
WM_MBUTTONDBLCLK        equ 0209h
WM_MOUSEWHEEL           equ 020Ah
WM_MOUSELAST            equ 020Ah
WM_PARENTNOTIFY         equ 0210h
WM_ENTERMENULOOP        equ 0211h
WM_EXITMENULOOP         equ 0212h
WM_NEXTMENU             equ 0213h
WM_SIZING               equ 0214h
WM_CAPTURECHANGED       equ 0215h
WM_MOVING               equ 0216h
WM_POWERBROADCAST       equ 0218h
WM_DEVICECHANGE         equ 0219h
WM_MDICREATE            equ 0220h
WM_MDIDESTROY           equ 0221h
WM_MDIACTIVATE          equ 0222h
WM_MDIRESTORE           equ 0223h
WM_MDINEXT              equ 0224h
WM_MDIMAXIMIZE          equ 0225h
WM_MDITILE              equ 0226h
WM_MDICASCADE           equ 0227h
WM_MDIICONARRANGE       equ 0228h
WM_MDIGETACTIVE         equ 0229h
WM_MDISETMENU           equ 0230h
WM_ENTERSIZEMOVE        equ 0231h
WM_EXITSIZEMOVE         equ 0232h
WM_DROPFILES            equ 0233h
WM_MDIREFRESHMENU       equ 0234h
WM_IME_SETCONTEXT       equ 0281h
WM_IME_NOTIFY           equ 0282h
WM_IME_CONTROL          equ 0283h
WM_IME_COMPOSITIONFULL  equ 0284h
WM_IME_SELECT           equ 0285h
WM_IME_CHAR             equ 0286h
WM_IME_KEYDOWN          equ 0290h
WM_IME_KEYUP            equ 0291h
WM_MOUSEHOVER           equ 02A1h
WM_MOUSELEAVE           equ 02A3h
WM_CUT                  equ 0300h
WM_COPY                 equ 0301h
WM_PASTE                equ 0302h
WM_CLEAR                equ 0303h
WM_UNDO                 equ 0304h
WM_RENDERFORMAT         equ 0305h
WM_RENDERALLFORMATS     equ 0306h
WM_DESTROYCLIPBOARD     equ 0307h
WM_DRAWCLIPBOARD        equ 0308h
WM_PAINTCLIPBOARD       equ 0309h
WM_VSCROLLCLIPBOARD     equ 030Ah
WM_SIZECLIPBOARD        equ 030Bh
WM_ASKCBFORMATNAME      equ 030Ch
WM_CHANGECBCHAIN        equ 030Dh
WM_HSCROLLCLIPBOARD     equ 030Eh
WM_QUERYNEWPALETTE      equ 030Fh
WM_PALETTEISCHANGING    equ 0310h
WM_PALETTECHANGED       equ 0311h
WM_HOTKEY               equ 0312h
WM_PRINT                equ 0317h
WM_PRINTCLIENT          equ 0318h
WM_HANDHELDFIRST        equ 0358h
WM_HANDHELDLAST         equ 035Fh
WM_AFXFIRST             equ 0360h
WM_AFXLAST              equ 037Fh
WM_PENWINFIRST          equ 0380h
WM_PENWINLAST           equ 038Fh
WM_COALESCE_FIRST       equ 0390h
WM_COALESCE_LAST        equ 039Fh
WM_USER                 equ 0400h

; WM_SIZE commands

SIZE_RESTORED           equ 0
SIZE_MINIMIZED          equ 1
SIZE_MAXIMIZED          equ 2
SIZE_MAXSHOW            equ 3
SIZE_MAXHIDE            equ 4

; WM_ACTIVATE states

WA_INACTIVE             equ 0
WA_ACTIVE               equ 1
WA_CLICKACTIVE          equ 2

; WM_SHOWWINDOW identifiers

SW_PARENTCLOSING        equ 1
SW_OTHERZOOM            equ 2
SW_PARENTOPENING        equ 3
SW_OTHERUNZOOM          equ 4

; WM_MOUSEACTIVATE return codes

MA_ACTIVATE             equ 1
MA_ACTIVATEANDEAT       equ 2
MA_NOACTIVATE           equ 3
MA_NOACTIVATEANDEAT     equ 4

; WM_MDITILE flags

MDITILE_VERTICAL        equ 0
MDITILE_HORIZONTAL      equ 1
MDITILE_SKIPDISABLED    equ 2

; WM_NOTIFY codes

NM_OUTOFMEMORY          equ -1
NM_CLICK                equ -2
NM_DBLCLICK             equ -3
NM_RETURN               equ -4
NM_RCLICK               equ -5
NM_RDBLCLK              equ -6
NM_SETFOCUS             equ -7
NM_KILLFOCUS            equ -8


; WM_SETICON types

ICON_SMALL              equ 0
ICON_BIG                equ 1

; WM_HOTKEY commands

HOTKEYF_SHIFT           equ 01h
HOTKEYF_CONTROL         equ 02h
HOTKEYF_ALT             equ 04h
HOTKEYF_EXT             equ 08h


; WM_NCHITTEST notification
HTERROR                 equ -2
HTTRANSPARENT           equ -1
HTNOWHERE               equ 0
HTCLIENT                equ 1
HTCAPTION               equ 2
HTSYSMENU               equ 3
HTGROWBOX               equ 4
HTSIZE                  equ HTGROWBOX
HTMENU                  equ 5
HTHSCROLL               equ 6
HTVSCROLL               equ 7
HTMINBUTTON             equ 8
HTMAXBUTTON             equ 9
HTLEFT                  equ 10
HTRIGHT                 equ 11
HTTOP                   equ 12
HTTOPLEFT               equ 13
HTTOPRIGHT              equ 14
HTBOTTOM                equ 15
HTBOTTOMLEFT            equ 16
HTBOTTOMRIGHT           equ 17
HTBORDER                equ 18
HTREDUCE                equ HTMINBUTTON
HTZOOM                  equ HTMAXBUTTON
HTSIZEFIRST             equ HTLEFT
HTSIZELAST              equ HTBOTTOMRIGHT
HTOBJECT                equ 19
HTCLOSE                 equ 20
HTHELP                  equ 21


; Keystroke flags

KF_EXTENDED             equ 0100h
KF_DLGMODE              equ 0800h
KF_MENUMODE             equ 1000h
KF_ALTDOWN              equ 2000h
KF_REPEAT               equ 4000h
KF_UP                   equ 8000h

; Key state masks for mouse messages

MK_LBUTTON              equ 01h
MK_RBUTTON              equ 02h
MK_SHIFT                equ 04h
MK_CONTROL              equ 08h
MK_MBUTTON              equ 10h

; WM_SIZING codes

WMSZ_LEFT               equ 1
WMSZ_RIGHT              equ 2
WMSZ_TOP                equ 3
WMSZ_TOPLEFT            equ 4
WMSZ_TOPRIGHT           equ 5
WMSZ_BOTTOM             equ 6
WMSZ_BOTTOMLEFT         equ 7
WMSZ_BOTTOMRIGHT        equ 8

; WM_HOTKEY modifiers

MOD_ALT                 equ 1
MOD_CONTROL             equ 2
MOD_SHIFT               equ 4
MOD_WIN                 equ 8

; WM_PRINT flags

PRF_CHECKVISIBLE        equ 01h
PRF_NONCLIENT           equ 02h
PRF_CLIENT              equ 04h
PRF_ERASEBKGND          equ 08h
PRF_CHILDREN            equ 10h
PRF_OWNED               equ 20h

; Virtual key codes

VK_LBUTTON              equ 001h
VK_CANCEL               equ 003h
VK_RBUTTON              equ 002h
VK_MBUTTON              equ 004h
VK_BACK                 equ 008h
VK_TAB                  equ 009h
VK_CLEAR                equ 00Ch
VK_RETURN               equ 00Dh
VK_SHIFT                equ 010h
VK_CONTROL              equ 011h
VK_MENU                 equ 012h
VK_PAUSE                equ 013h
VK_CAPITAL              equ 014h
VK_ESCAPE               equ 01Bh
VK_SPACE                equ 020h
VK_PRIOR                equ 021h
VK_PGUP                 equ 021h
VK_PGDN                 equ 022h
VK_NEXT                 equ 022h
VK_END                  equ 023h
VK_HOME                 equ 024h
VK_LEFT                 equ 025h
VK_UP                   equ 026h
VK_RIGHT                equ 027h
VK_DOWN                 equ 028h
VK_SELECT               equ 029h
VK_PRINT                equ 02Ah
VK_EXECUTE              equ 02Bh
VK_SNAPSHOT             equ 02Ch
VK_INSERT               equ 02Dh
VK_DELETE               equ 02Eh
VK_HELP                 equ 02Fh
VK_LWIN                 equ 05Bh
VK_RWIN                 equ 05Ch
VK_APPS                 equ 05Dh
VK_NUMPAD0              equ 060h
VK_NUMPAD1              equ 061h
VK_NUMPAD2              equ 062h
VK_NUMPAD3              equ 063h
VK_NUMPAD4              equ 064h
VK_NUMPAD5              equ 065h
VK_NUMPAD6              equ 066h
VK_NUMPAD7              equ 067h
VK_NUMPAD8              equ 068h
VK_NUMPAD9              equ 069h
VK_MULTIPLY             equ 06Ah
VK_ADD                  equ 06Bh
VK_SEPARATOR            equ 06Ch
VK_SUBTRACT             equ 06Dh
VK_DECIMAL              equ 06Eh
VK_DIVIDE               equ 06Fh
VK_F1                   equ 070h
VK_F2                   equ 071h
VK_F3                   equ 072h
VK_F4                   equ 073h
VK_F5                   equ 074h
VK_F6                   equ 075h
VK_F7                   equ 076h
VK_F8                   equ 077h
VK_F9                   equ 078h
VK_F10                  equ 079h
VK_F11                  equ 07Ah
VK_F12                  equ 07Bh
VK_F13                  equ 07Ch
VK_F14                  equ 07Dh
VK_F15                  equ 07Eh
VK_F16                  equ 07Fh
VK_F17                  equ 080h
VK_F18                  equ 081h
VK_F19                  equ 082h
VK_F20                  equ 083h
VK_F21                  equ 084h
VK_F22                  equ 085h
VK_F23                  equ 086h
VK_F24                  equ 087h
VK_NUMLOCK              equ 090h
VK_SCROLL               equ 091h
VK_LSHIFT               equ 0A0h
VK_RSHIFT               equ 0A1h
VK_LCONTROL             equ 0A2h
VK_RCONTROL             equ 0A3h
VK_LMENU                equ 0A4h
VK_RMENU                equ 0A5h
VK_ATTN                 equ 0F6h
VK_CRSEL                equ 0F7h
VK_EXSEL                equ 0F8h
VK_EREOF                equ 0F9h
VK_PLAY                 equ 0FAh
VK_ZOOM                 equ 0FBh
VK_NONAME               equ 0FCh
VK_PA1                  equ 0FDh
VK_OEM_CLEAR            equ 0FEh

; Accelerator flags

FVIRTKEY                equ 01h
FNOINVERT               equ 02h
FSHIFT                  equ 04h
FCONTROL                equ 08h
FALT                    equ 10h

; GetClassLong offsets

GCL_MENUNAME            equ -8
GCL_HBRBACKGROUND       equ -10
GCL_HCURSOR             equ -12
GCL_HICON               equ -14
GCL_HMODULE             equ -16
GCL_CBWNDEXTRA          equ -18
GCL_CBCLSEXTRA          equ -20
GCL_WNDPROC             equ -24
GCL_STYLE               equ -26
GCW_ATOM                equ -32
GCL_HICONSM             equ -34

; WNDCLASS parameters

DLGWINDOWEXTRA          equ 30

; GetWindowLong offsets

GWL_WNDPROC             equ -4
GWL_HINSTANCE           equ -6
GWL_HWNDPARENT          equ -8
GWL_STYLE               equ -16
GWL_EXSTYLE             equ -20
GWL_USERDATA            equ -21
GWL_ID                  equ -12
DWL_MSGRESULT           equ 0
DWL_DLGPROC             equ 4
DWL_USER                equ 8

; GetSystemMetrics codes

SM_CXSCREEN             equ 0
SM_CYSCREEN             equ 1
SM_CXVSCROLL            equ 2
SM_CYHSCROLL            equ 3
SM_CYCAPTION            equ 4
SM_CXBORDER             equ 5
SM_CYBORDER             equ 6
SM_CXDLGFRAME           equ 7
SM_CYDLGFRAME           equ 8
SM_CYVTHUMB             equ 9
SM_CXHTHUMB             equ 10
SM_CXICON               equ 11
SM_CYICON               equ 12
SM_CXCURSOR             equ 13
SM_CYCURSOR             equ 14
SM_CYMENU               equ 15
SM_CXFULLSCREEN         equ 16
SM_CYFULLSCREEN         equ 17
SM_CYKANJIWINDOW        equ 18
SM_MOUSEPRESENT         equ 19
SM_CYVSCROLL            equ 20
SM_CXHSCROLL            equ 21
SM_DEBUG                equ 22
SM_SWAPBUTTON           equ 23
SM_RESERVED1            equ 24
SM_RESERVED2            equ 25
SM_RESERVED3            equ 26
SM_RESERVED4            equ 27
SM_CXMIN                equ 28
SM_CYMIN                equ 29
SM_CXSIZE               equ 30
SM_CYSIZE               equ 31
SM_CXFRAME              equ 32
SM_CYFRAME              equ 33
SM_CXMINTRACK           equ 34
SM_CYMINTRACK           equ 35
SM_CXDOUBLECLK          equ 36
SM_CYDOUBLECLK          equ 37
SM_CXICONSPACING        equ 38
SM_CYICONSPACING        equ 39
SM_MENUDROPALIGNMENT    equ 40
SM_PENWINDOWS           equ 41
SM_DBCSENABLED          equ 42
SM_CMOUSEBUTTONS        equ 43
SM_CXFIXEDFRAME         equ SM_CXDLGFRAME
SM_CYFIXEDFRAME         equ SM_CYDLGFRAME
SM_CXSIZEFRAME          equ SM_CXFRAME
SM_CYSIZEFRAME          equ SM_CYFRAME
SM_SECURE               equ 44
SM_CXEDGE               equ 45
SM_CYEDGE               equ 46
SM_CXMINSPACING         equ 47
SM_CYMINSPACING         equ 48
SM_CXSMICON             equ 49
SM_CYSMICON             equ 50
SM_CYSMCAPTION          equ 51
SM_CXSMSIZE             equ 52
SM_CYSMSIZE             equ 53
SM_CXMENUSIZE           equ 54
SM_CYMENUSIZE           equ 55
SM_ARRANGE              equ 56
SM_CXMINIMIZED          equ 57
SM_CYMINIMIZED          equ 58
SM_CXMAXTRACK           equ 59
SM_CYMAXTRACK           equ 60
SM_CXMAXIMIZED          equ 61
SM_CYMAXIMIZED          equ 62
SM_NETWORK              equ 63
SM_CLEANBOOT            equ 67
SM_CXDRAG               equ 68
SM_CYDRAG               equ 69
SM_SHOWSOUNDS           equ 70
SM_CXMENUCHECK          equ 71
SM_CYMENUCHECK          equ 72
SM_SLOWMACHINE          equ 73
SM_MIDEASTENABLED       equ 74
SM_MOUSEWHEELPRESENT    equ 75
SM_CMETRICS             equ 76

; Predefined cursor identifiers

IDC_ARROW               equ 32512
IDC_IBEAM               equ 32513
IDC_WAIT                equ 32514
IDC_CROSS               equ 32515
IDC_UPARROW             equ 32516
IDC_SIZE                equ 32640
IDC_ICON                equ 32641
IDC_SIZENWSE            equ 32642
IDC_SIZENESW            equ 32643
IDC_SIZEWE              equ 32644
IDC_SIZENS              equ 32645
IDC_NO                  equ 32648
IDC_HAND                equ 32649
IDC_APPSTARTING         equ 32650
IDC_HELP                equ 32651

; Predefined icon identifiers

IDI_APPLICATION         equ 32512
IDI_HAND                equ 32513
IDI_QUESTION            equ 32514
IDI_EXCLAMATION         equ 32515
IDI_ASTERISK            equ 32516
IDI_WINLOGO             equ 32517

; for LoadImage
IMAGE_BITMAP            equ 0
IMAGE_ICON              equ 1
IMAGE_CURSOR            equ 2

LR_DEFAULTCOLOR         equ 0000h
LR_MONOCHROME           equ 0001h
LR_COLOR                equ 0002h
LR_COPYRETURNORG        equ 0004h
LR_COPYDELETEORG        equ 0008h
LR_LOADFROMFILE         equ 0010h
LR_LOADTRANSPARENT      equ 0020h
LR_DEFAULTSIZE          equ 0040h
LR_VGACOLOR             equ 0080h
LR_LOADMAP3DCOLORS      equ 1000h
LR_CREATEDIBSECTION     equ 2000h
LR_COPYFROMRESOURCE     equ 4000h
LR_SHARED               equ 8000h


; System colors

COLOR_SCROLLBAR         equ 0
COLOR_BACKGROUND        equ 1
COLOR_ACTIVECAPTION     equ 2
COLOR_INACTIVECAPTION   equ 3
COLOR_MENU              equ 4
COLOR_WINDOW            equ 5
COLOR_WINDOWFRAME       equ 6
COLOR_MENUTEXT          equ 7
COLOR_WINDOWTEXT        equ 8
COLOR_CAPTIONTEXT       equ 9
COLOR_ACTIVEBORDER      equ 10
COLOR_INACTIVEBORDER    equ 11
COLOR_APPWORKSPACE      equ 12
COLOR_HIGHLIGHT         equ 13
COLOR_HIGHLIGHTTEXT     equ 14
COLOR_BTNFACE           equ 15
COLOR_BTNSHADOW         equ 16
COLOR_GRAYTEXT          equ 17
COLOR_BTNTEXT           equ 18
COLOR_INACTIVECAPTIONTEXT     equ 19
COLOR_BTNHIGHLIGHT      equ 20
COLOR_3DDKSHADOW        equ 21
COLOR_3DLIGHT           equ 22
COLOR_INFOTEXT          equ 23
COLOR_INFOBK            equ 24
COLOR_HOTLIGHT          equ 26
COLOR_GRADIENTACTIVECAPTION   equ 27
COLOR_GRADIENTINACTIVECAPTION equ 28

; Button messages

BM_GETCHECK             equ 00F0h
BM_SETCHECK             equ 00F1h
BM_GETSTATE             equ 00F2h
BM_SETSTATE             equ 00F3h
BM_SETSTYLE             equ 00F4h
BM_CLICK                equ 00F5h
BM_GETIMAGE             equ 00F6h
BM_SETIMAGE             equ 00F7h

; Button notifications

BN_CLICKED              equ 0
BN_PAINT                equ 1
BN_HILITE               equ 2
BN_UNHILITE             equ 3
BN_DISABLE              equ 4
BN_DOUBLECLICKED        equ 5
BN_SETFOCUS             equ 6
BN_KILLFOCUS            equ 7
BN_PUSHED               equ BN_HILITE
BN_UNPUSHED             equ BN_UNHILITE
BN_DBLCLK               equ BN_DOUBLECLICKED

; Button styles

BS_PUSHBUTTON           equ 0000h
BS_DEFPUSHBUTTON        equ 0001h
BS_CHECKBOX             equ 0002h
BS_AUTOCHECKBOX         equ 0003h
BS_RADIOBUTTON          equ 0004h
BS_3STATE               equ 0005h
BS_AUTO3STATE           equ 0006h
BS_GROUPBOX             equ 0007h
BS_USERBUTTON           equ 0008h
BS_AUTORADIOBUTTON      equ 0009h
BS_OWNERDRAW            equ 000Bh
BS_TEXT                 equ 0000h
BS_LEFTTEXT             equ 0020h
BS_RIGHTBUTTON          equ BS_LEFTTEXT
BS_ICON                 equ 0040h
BS_BITMAP               equ 0080h
BS_LEFT                 equ 0100h
BS_RIGHT                equ 0200h
BS_CENTER               equ 0300h
BS_TOP                  equ 0400h
BS_BOTTOM               equ 0800h
BS_VCENTER              equ 0C00h
BS_PUSHLIKE             equ 1000h
BS_MULTILINE            equ 2000h
BS_NOTIFY               equ 4000h
BS_FLAT                 equ 8000h

; Button states

BST_UNCHECKED           equ 0
BST_CHECKED             equ 1
BST_INDETERMINATE       equ 2
BST_PUSHED              equ 4
BST_FOCUS               equ 8

; List box messages

LB_ADDSTRING            equ 0180h
LB_INSERTSTRING         equ 0181h
LB_DELETESTRING         equ 0182h
LB_SELITEMRANGEEX       equ 0183h
LB_RESETCONTENT         equ 0184h
LB_SETSEL               equ 0185h
LB_SETCURSEL            equ 0186h
LB_GETSEL               equ 0187h
LB_GETCURSEL            equ 0188h
LB_GETTEXT              equ 0189h
LB_GETTEXTLEN           equ 018Ah
LB_GETCOUNT             equ 018Bh
LB_SELECTSTRING         equ 018Ch
LB_DIR                  equ 018Dh
LB_GETTOPINDEX          equ 018Eh
LB_FINDSTRING           equ 018Fh
LB_GETSELCOUNT          equ 0190h
LB_GETSELITEMS          equ 0191h
LB_SETTABSTOPS          equ 0192h
LB_GETHORIZONTALEXTENT  equ 0193h
LB_SETHORIZONTALEXTENT  equ 0194h
LB_SETCOLUMNWIDTH       equ 0195h
LB_ADDFILE              equ 0196h
LB_SETTOPINDEX          equ 0197h
LB_GETITEMRECT          equ 0198h
LB_GETITEMDATA          equ 0199h
LB_SETITEMDATA          equ 019Ah
LB_SELITEMRANGE         equ 019Bh
LB_SETANCHORINDEX       equ 019Ch
LB_GETANCHORINDEX       equ 019Dh
LB_SETCARETINDEX        equ 019Eh
LB_GETCARETINDEX        equ 019Fh
LB_SETITEMHEIGHT        equ 01A0h
LB_GETITEMHEIGHT        equ 01A1h
LB_FINDSTRINGEXACT      equ 01A2h
LB_SETLOCALE            equ 01A5h
LB_GETLOCALE            equ 01A6h
LB_SETCOUNT             equ 01A7h
LB_INITSTORAGE          equ 01A8h
LB_ITEMFROMPOINT        equ 01A9h

; List box notifications

LBN_ERRSPACE            equ -2
LBN_SELCHANGE           equ 1
LBN_DBLCLK              equ 2
LBN_SELCANCEL           equ 3
LBN_SETFOCUS            equ 4
LBN_KILLFOCUS           equ 5

; List box styles

LBS_NOTIFY              equ 0001h
LBS_SORT                equ 0002h
LBS_NOREDRAW            equ 0004h
LBS_MULTIPLESEL         equ 0008h
LBS_OWNERDRAWFIXED      equ 0010h
LBS_OWNERDRAWVARIABLE   equ 0020h
LBS_HASSTRINGS          equ 0040h
LBS_USETABSTOPS         equ 0080h
LBS_NOINTEGRALHEIGHT    equ 0100h
LBS_MULTICOLUMN         equ 0200h
LBS_WANTKEYBOARDINPUT   equ 0400h
LBS_EXTENDEDSEL         equ 0800h
LBS_DISABLENOSCROLL     equ 1000h
LBS_NODATA              equ 2000h
LBS_NOSEL               equ 4000h
LBS_STANDARD            equ LBS_NOTIFY or LBS_SORT or WS_VSCROLL or WS_BORDER

; List box return values

LB_OKAY                 equ 0
LB_ERR                  equ -1
LB_ERRSPACE             equ -2

; Combo box messages

CB_GETEDITSEL           equ 0140h
CB_LIMITTEXT            equ 0141h
CB_SETEDITSEL           equ 0142h
CB_ADDSTRING            equ 0143h
CB_DELETESTRING         equ 0144h
CB_DIR                  equ 0145h
CB_GETCOUNT             equ 0146h
CB_GETCURSEL            equ 0147h
CB_GETLBTEXT            equ 0148h
CB_GETLBTEXTLEN         equ 0149h
CB_INSERTSTRING         equ 014Ah
CB_RESETCONTENT         equ 014Bh
CB_FINDSTRING           equ 014Ch
CB_SELECTSTRING         equ 014Dh
CB_SETCURSEL            equ 014Eh
CB_SHOWDROPDOWN         equ 014Fh
CB_GETITEMDATA          equ 0150h
CB_SETITEMDATA          equ 0151h
CB_GETDROPPEDCONTROLRECT equ 0152h
CB_SETITEMHEIGHT        equ 0153h
CB_GETITEMHEIGHT        equ 0154h
CB_SETEXTENDEDUI        equ 0155h
CB_GETEXTENDEDUI        equ 0156h
CB_GETDROPPEDSTATE      equ 0157h
CB_FINDSTRINGEXACT      equ 0158h
CB_SETLOCALE            equ 0159h
CB_GETLOCALE            equ 015Ah
CB_GETTOPINDEX          equ 015Bh
CB_SETTOPINDEX          equ 015Ch
CB_GETHORIZONTALEXTENT  equ 015Dh
CB_SETHORIZONTALEXTENT  equ 015Eh
CB_GETDROPPEDWIDTH      equ 015Fh
CB_SETDROPPEDWIDTH      equ 0160h
CB_INITSTORAGE          equ 0161h

; Combo box notifications

CBN_ERRSPACE            equ -1
CBN_SELCHANGE           equ 1
CBN_DBLCLK              equ 2
CBN_SETFOCUS            equ 3
CBN_KILLFOCUS           equ 4
CBN_EDITCHANGE          equ 5
CBN_EDITUPDATE          equ 6
CBN_DROPDOWN            equ 7
CBN_CLOSEUP             equ 8
CBN_SELENDOK            equ 9
CBN_SELENDCANCEL        equ 10

; Combo box styles

CBS_SIMPLE              equ 0001h
CBS_DROPDOWN            equ 0002h
CBS_DROPDOWNLIST        equ 0003h
CBS_OWNERDRAWFIXED      equ 0010h
CBS_OWNERDRAWVARIABLE   equ 0020h
CBS_AUTOHSCROLL         equ 0040h
CBS_OEMCONVERT          equ 0080h
CBS_SORT                equ 0100h
CBS_HASSTRINGS          equ 0200h
CBS_NOINTEGRALHEIGHT    equ 0400h
CBS_DISABLENOSCROLL     equ 0800h
CBS_UPPERCASE           equ 2000h
CBS_LOWERCASE           equ 4000h

; Combo box return values

CB_OKAY                 equ 0
CB_ERR                  equ -1
CB_ERRSPACE             equ -2

; Edit control messages

EM_GETSEL               equ 00B0h
EM_SETSEL               equ 00B1h
EM_GETRECT              equ 00B2h
EM_SETRECT              equ 00B3h
EM_SETRECTNP            equ 00B4h
EM_SCROLL               equ 00B5h
EM_LINESCROLL           equ 00B6h
EM_SCROLLCARET          equ 00B7h
EM_GETMODIFY            equ 00B8h
EM_SETMODIFY            equ 00B9h
EM_GETLINECOUNT         equ 00BAh
EM_LINEINDEX            equ 00BBh
EM_SETHANDLE            equ 00BCh
EM_GETHANDLE            equ 00BDh
EM_GETTHUMB             equ 00BEh
EM_LINELENGTH           equ 00C1h
EM_REPLACESEL           equ 00C2h
EM_GETLINE              equ 00C4h
EM_LIMITTEXT            equ 00C5h
EM_CANUNDO              equ 00C6h
EM_UNDO                 equ 00C7h
EM_FMTLINES             equ 00C8h
EM_LINEFROMCHAR         equ 00C9h
EM_SETTABSTOPS          equ 00CBh
EM_SETPASSWORDCHAR      equ 00CCh
EM_EMPTYUNDOBUFFER      equ 00CDh
EM_GETFIRSTVISIBLELINE  equ 00CEh
EM_SETREADONLY          equ 00CFh
EM_SETWORDBREAKPROC     equ 00D0h
EM_GETWORDBREAKPROC     equ 00D1h
EM_GETPASSWORDCHAR      equ 00D2h
EM_SETMARGINS           equ 00D3h
EM_GETMARGINS           equ 00D4h
EM_SETLIMITTEXT         equ EM_LIMITTEXT
EM_GETLIMITTEXT         equ 00D5h
EM_POSFROMCHAR          equ 00D6h
EM_CHARFROMPOS          equ 00D7h

; Edit control EM_SETMARGIN parameters

EC_LEFTMARGIN           equ 1
EC_RIGHTMARGIN          equ 2
EC_USEFONTINFO          equ 0FFFFh

; Edit control notifications

EN_SETFOCUS             equ 0100h
EN_KILLFOCUS            equ 0200h
EN_CHANGE               equ 0300h
EN_UPDATE               equ 0400h
EN_ERRSPACE             equ 0500h
EN_MAXTEXT              equ 0501h
EN_HSCROLL              equ 0601h
EN_VSCROLL              equ 0602h

; Edit control styles

ES_LEFT                 equ 0000h
ES_CENTER               equ 0001h
ES_RIGHT                equ 0002h
ES_MULTILINE            equ 0004h
ES_UPPERCASE            equ 0008h
ES_LOWERCASE            equ 0010h
ES_PASSWORD             equ 0020h
ES_AUTOVSCROLL          equ 0040h
ES_AUTOHSCROLL          equ 0080h
ES_NOHIDESEL            equ 0100h
ES_OEMCONVERT           equ 0400h
ES_READONLY             equ 0800h
ES_WANTRETURN           equ 1000h
ES_NUMBER               equ 2000h

; Static window messages

STM_SETICON             equ 0170h
STM_GETICON             equ 0171h
STM_SETIMAGE            equ 0172h
STM_GETIMAGE            equ 0173h

; Static window notifications

STN_CLICKED             equ 0
STN_DBLCLK              equ 1
STN_ENABLE              equ 2
STN_DISABLE             equ 3

; Static window styles

SS_LEFT                 equ 0000h
SS_CENTER               equ 0001h
SS_RIGHT                equ 0002h
SS_ICON                 equ 0003h
SS_BLACKRECT            equ 0004h
SS_GRAYRECT             equ 0005h
SS_WHITERECT            equ 0006h
SS_BLACKFRAME           equ 0007h
SS_GRAYFRAME            equ 0008h
SS_WHITEFRAME           equ 0009h
SS_USERITEM             equ 000Ah
SS_SIMPLE               equ 000Bh
SS_LEFTNOWORDWRAP       equ 000Ch
SS_BITMAP               equ 000Eh
SS_OWNERDRAW            equ 000Dh
SS_ENHMETAFILE          equ 000Fh
SS_ETCHEDHORZ           equ 0010h
SS_ETCHEDVERT           equ 0011h
SS_ETCHEDFRAME          equ 0012h
SS_TYPEMASK             equ 001Fh
SS_NOPREFIX             equ 0080h
SS_NOTIFY               equ 0100h
SS_CENTERIMAGE          equ 0200h
SS_RIGHTJUST            equ 0400h
SS_REALSIZEIMAGE        equ 0800h
SS_SUNKEN               equ 1000h

; Scroll bar constants

SB_HORZ                 equ 0
SB_VERT                 equ 1
SB_CTL                  equ 2
SB_BOTH                 equ 3

; Scroll bar messages

SBM_SETPOS              equ 00E0h
SBM_GETPOS              equ 00E1h
SBM_SETRANGE            equ 00E2h
SBM_SETRANGEREDRAW      equ 00E6h
SBM_GETRANGE            equ 00E3h
SBM_ENABLE_ARROWS       equ 00E4h
SBM_SETSCROLLINFO       equ 00E9h
SBM_GETSCROLLINFO       equ 00EAh

; Scroll bar commands

SB_LINEUP               equ 0
SB_LINELEFT             equ 0
SB_LINEDOWN             equ 1
SB_LINERIGHT            equ 1
SB_PAGEUP               equ 2
SB_PAGELEFT             equ 2
SB_PAGEDOWN             equ 3
SB_PAGERIGHT            equ 3
SB_THUMBPOSITION        equ 4
SB_THUMBTRACK           equ 5
SB_TOP                  equ 6
SB_LEFT                 equ 6
SB_BOTTOM               equ 7
SB_RIGHT                equ 7
SB_ENDSCROLL            equ 8

; Scroll bar styles

SBS_HORZ                equ 0000h
SBS_VERT                equ 0001h
SBS_TOPALIGN            equ 0002h
SBS_LEFTALIGN           equ 0002h
SBS_BOTTOMALIGN         equ 0004h
SBS_RIGHTALIGN          equ 0004h
SBS_SIZEBOXTOPLEFTALIGN equ 0002h
SBS_SIZEBOXBOTTOMRIGHTALIGN equ 0004h
SBS_SIZEBOX             equ 0008h
SBS_SIZEGRIP            equ 0010h

; Scroll bar info flags

SIF_RANGE               equ 0001h
SIF_PAGE                equ 0002h
SIF_POS                 equ 0004h
SIF_DISABLENOSCROLL     equ 0008h
SIF_TRACKPOS            equ 0010h
SIF_ALL                 equ SIF_RANGE or SIF_PAGE or SIF_POS or SIF_TRACKPOS

; Dialog styles

DS_ABSALIGN             equ 0001h
DS_SYSMODAL             equ 0002h
DS_3DLOOK               equ 0004h
DS_FIXEDSYS             equ 0008h
DS_NOFAILCREATE         equ 0010h
DS_LOCALEDIT            equ 0020h
DS_SETFONT              equ 0040h
DS_MODALFRAME           equ 0080h
DS_NOIDLEMSG            equ 0100h
DS_SETFOREGROUND        equ 0200h
DS_CONTROL              equ 0400h
DS_CENTER               equ 0800h
DS_CENTERMOUSE          equ 1000h
DS_CONTEXTHELP          equ 2000h

; Dialog codes

DLGC_WANTARROWS         equ 0001h
DLGC_WANTTAB            equ 0002h
DLGC_WANTALLKEYS        equ 0004h
DLGC_WANTMESSAGE        equ 0004h
DLGC_HASSETSEL          equ 0008h
DLGC_DEFPUSHBUTTON      equ 0010h
DLGC_UNDEFPUSHBUTTON    equ 0020h
DLGC_RADIOBUTTON        equ 0040h
DLGC_WANTCHARS          equ 0080h
DLGC_STATIC             equ 0100h
DLGC_BUTTON             equ 2000h

; Menu flags

MF_INSERT               equ 0000h
MF_CHANGE               equ 0080h
MF_APPEND               equ 0100h
MF_DELETE               equ 0200h
MF_REMOVE               equ 1000h
MF_BYCOMMAND            equ 0000h
MF_BYPOSITION           equ 0400h
MF_SEPARATOR            equ 0800h
MF_UNCHECKED            equ 0000h
MF_ENABLED              equ 0000h
MF_GRAYED               equ 0001h
MF_DISABLED             equ 0002h
MF_CHECKED              equ 0008h
MF_USECHECKBITMAPS      equ 0200h
MF_STRING               equ 0000h
MF_BITMAP               equ 0004h
MF_OWNERDRAW            equ 0100h
MF_POPUP                equ 0010h
MF_MENUBARBREAK         equ 0020h
MF_MENUBREAK            equ 0040h
MF_UNHILITE             equ 0000h
MF_HILITE               equ 0080h
MF_DEFAULT              equ 1000h
MF_SYSMENU              equ 2000h
MF_HELP                 equ 4000h
MF_RIGHTJUSTIFY         equ 4000h
MF_MOUSESELECT          equ 8000h
MF_END                  equ 0080h
MFT_STRING              equ MF_STRING
MFT_BITMAP              equ MF_BITMAP
MFT_MENUBARBREAK        equ MF_MENUBARBREAK
MFT_MENUBREAK           equ MF_MENUBREAK
MFT_OWNERDRAW           equ MF_OWNERDRAW
MFT_RADIOCHECK          equ 0200h
MFT_SEPARATOR           equ MF_SEPARATOR
MFT_RIGHTORDER          equ 2000h
MFT_RIGHTJUSTIFY        equ MF_RIGHTJUSTIFY
MFS_GRAYED              equ 0003h
MFS_DISABLED            equ MFS_GRAYED
MFS_CHECKED             equ MF_CHECKED
MFS_HILITE              equ MF_HILITE
MFS_ENABLED             equ MF_ENABLED
MFS_UNCHECKED           equ MF_UNCHECKED
MFS_UNHILITE            equ MF_UNHILITE
MFS_DEFAULT             equ MF_DEFAULT
MFR_POPUP               equ 0001h
MFR_END                 equ MF_END

; System menu command values

SC_SIZE                 equ 61440
SC_MOVE                 equ 61456
SC_MINIMIZE             equ 61472
SC_MAXIMIZE             equ 61488
SC_NEXTWINDOW           equ 61504
SC_PREVWINDOW           equ 61520
SC_CLOSE                equ 61536
SC_VSCROLL              equ 61552
SC_HSCROLL              equ 61568
SC_MOUSEMENU            equ 61584
SC_KEYMENU              equ 61696
SC_ARRANGE              equ 61712
SC_RESTORE              equ 61728
SC_TASKLIST             equ 61744
SC_SCREENSAVE           equ 61760
SC_HOTKEY               equ 61776
SC_DEFAULT              equ 61792
SC_MONITORPOWER         equ 61808
SC_CONTEXTHELP          equ 61824
SC_SEPARATOR            equ 61455

; Border types

BDR_RAISEDOUTER         equ 01h
BDR_SUNKENOUTER         equ 02h
BDR_RAISEDINNER         equ 04h
BDR_SUNKENINNER         equ 08h
BDR_OUTER               equ 03h
BDR_INNER               equ 0Ch
BDR_RAISED              equ 05h
BDR_SUNKEN              equ 0Ah
EDGE_RAISED             equ BDR_RAISEDOUTER or BDR_RAISEDINNER
EDGE_SUNKEN             equ BDR_SUNKENOUTER or BDR_SUNKENINNER
EDGE_ETCHED             equ BDR_SUNKENOUTER or BDR_RAISEDINNER
EDGE_BUMP               equ BDR_RAISEDOUTER or BDR_SUNKENINNER

; Border flags

BF_LEFT                 equ 0001h
BF_TOP                  equ 0002h
BF_RIGHT                equ 0004h
BF_BOTTOM               equ 0008h
BF_TOPLEFT              equ BF_TOP or BF_LEFT
BF_TOPRIGHT             equ BF_TOP or BF_RIGHT
BF_BOTTOMLEFT           equ BF_BOTTOM or BF_LEFT
BF_BOTTOMRIGHT          equ BF_BOTTOM or BF_RIGHT
BF_RECT                 equ BF_LEFT or BF_TOP or BF_RIGHT or BF_BOTTOM
BF_DIAGONAL             equ 0010h
BF_DIAGONAL_ENDTOPRIGHT equ BF_DIAGONAL or BF_TOP or BF_RIGHT
BF_DIAGONAL_ENDTOPLEFT  equ BF_DIAGONAL or BF_TOP or BF_LEFT
BF_DIAGONAL_ENDBOTTOMLEFT  equ BF_DIAGONAL or BF_BOTTOM or BF_LEFT
BF_DIAGONAL_ENDBOTTOMRIGHT equ BF_DIAGONAL or BF_BOTTOM or BF_RIGHT
BF_MIDDLE               equ 0800h
BF_SOFT                 equ 1000h
BF_ADJUST               equ 2000h
BF_FLAT                 equ 4000h
BF_MONO                 equ 8000h

; Frame control types

DFC_CAPTION             equ 1
DFC_MENU                equ 2
DFC_SCROLL              equ 3
DFC_BUTTON              equ 4
DFC_POPUPMENU           equ 5

; Frame control states

DFCS_CAPTIONCLOSE       equ 0000h
DFCS_CAPTIONMIN         equ 0001h
DFCS_CAPTIONMAX         equ 0002h
DFCS_CAPTIONRESTORE     equ 0003h
DFCS_CAPTIONHELP        equ 0004h
DFCS_MENUARROW          equ 0000h
DFCS_MENUCHECK          equ 0001h
DFCS_MENUBULLET         equ 0002h
DFCS_MENUARROWRIGHT     equ 0004h
DFCS_SCROLLUP           equ 0000h
DFCS_SCROLLDOWN         equ 0001h
DFCS_SCROLLLEFT         equ 0002h
DFCS_SCROLLRIGHT        equ 0003h
DFCS_SCROLLCOMBOBOX     equ 0005h
DFCS_SCROLLSIZEGRIP     equ 0008h
DFCS_SCROLLSIZEGRIPRIGHT equ 0010h
DFCS_BUTTONCHECK        equ 0000h
DFCS_BUTTONRADIOIMAGE   equ 0001h
DFCS_BUTTONRADIOMASK    equ 0002h
DFCS_BUTTONRADIO        equ 0004h
DFCS_BUTTON3STATE       equ 0008h
DFCS_BUTTONPUSH         equ 0010h
DFCS_INACTIVE           equ 0100h
DFCS_PUSHED             equ 0200h
DFCS_CHECKED            equ 0400h
DFCS_TRANSPARENT        equ 0800h
DFCS_HOT                equ 1000h
DFCS_ADJUSTRECT         equ 2000h
DFCS_FLAT               equ 4000h
DFCS_MONO               equ 8000h

; DrawCaption flags

DC_ACTIVE               equ 01h
DC_SMALLCAP             equ 02h
DC_ICON                 equ 04h
DC_TEXT                 equ 08h
DC_INBUTTON             equ 10h

; DrawIconEx options

DI_MASK                 equ 1
DI_IMAGE                equ 2
DI_NORMAL               equ 3
DI_COMPAT               equ 4
DI_DEFAULTSIZE          equ 8

; DrawText parameters

DT_TOP                  equ 00000h
DT_LEFT                 equ 00000h
DT_CENTER               equ 00001h
DT_RIGHT                equ 00002h
DT_VCENTER              equ 00004h
DT_BOTTOM               equ 00008h
DT_WORDBREAK            equ 00010h
DT_SINGLELINE           equ 00020h
DT_EXPANDTABS           equ 00040h
DT_TABSTOP              equ 00080h
DT_NOCLIP               equ 00100h
DT_EXTERNALLEADING      equ 00200h
DT_CALCRECT             equ 00400h
DT_NOPREFIX             equ 00800h
DT_INTERNAL             equ 01000h
DT_EDITCONTROL          equ 02000h
DT_PATH_ELLIPSIS        equ 04000h
DT_END_ELLIPSIS         equ 08000h
DT_MODIFYSTRING         equ 10000h
DT_RTLREADING           equ 20000h
DT_WORD_ELLIPSIS        equ 40000h

; GetDCEx flags

DCX_WINDOW              equ 000001h
DCX_CACHE               equ 000002h
DCX_NORESETATTRS        equ 000004h
DCX_CLIPCHILDREN        equ 000008h
DCX_CLIPSIBLINGS        equ 000010h
DCX_PARENTCLIP          equ 000020h
DCX_EXCLUDERGN          equ 000040h
DCX_INTERSECTRGN        equ 000080h
DCX_EXCLUDEUPDATE       equ 000100h
DCX_INTERSECTUPDATE     equ 000200h
DCX_LOCKWINDOWUPDATE    equ 000400h
DCX_VALIDATE            equ 200000h

; SetWindowsHook codes

WH_MSGFILTER            equ -1
WH_JOURNALRECORD        equ 0
WH_JOURNALPLAYBACK      equ 1
WH_KEYBOARD             equ 2
WH_GETMESSAGE           equ 3
WH_CALLWNDPROC          equ 4
WH_CBT                  equ 5
WH_SYSMSGFILTER         equ 6
WH_MOUSE                equ 7
WH_HARDWARE             equ 8
WH_DEBUG                equ 9
WH_SHELL                equ 10
WH_FOREGROUNDIDLE       equ 11
WH_CALLWNDPROCRET       equ 12
WH_KEYBOARD_LL          equ 13
WH_MOUSE_LL             equ 14

; Hook codes

HC_ACTION               equ 0
HC_GETNEXT              equ 1
HC_SKIP                 equ 2
HC_NOREMOVE             equ 3
HC_SYSMODALON           equ 4
HC_SYSMODALOFF          equ 5

; CBT hook codes

HCBT_MOVESIZE           equ 0
HCBT_MINMAX             equ 1
HCBT_QS                 equ 2
HCBT_CREATEWND          equ 3
HCBT_DESTROYWND         equ 4
HCBT_ACTIVATE           equ 5
HCBT_CLICKSKIPPED       equ 6
HCBT_KEYSKIPPED         equ 7
HCBT_SYSCOMMAND         equ 8
HCBT_SETFOCUS           equ 9

; ExitWindowsEx flags

EWX_LOGOFF              equ 0
EWX_SHUTDOWN            equ 1
EWX_REBOOT              equ 2
EWX_FORCE               equ 4
EWX_POWEROFF            equ 8

; WinHelp commands

HELP_CONTEXT            equ 001h
HELP_QUIT               equ 002h
HELP_INDEX              equ 003h
HELP_CONTENTS           equ 003h
HELP_HELPONHELP         equ 004h
HELP_SETINDEX           equ 005h
HELP_SETCONTENTS        equ 005h
HELP_CONTEXTPOPUP       equ 008h
HELP_FORCEFILE          equ 009h
HELP_CONTEXTMENU        equ 00Ah
HELP_FINDER             equ 00Bh
HELP_WM_HELP            equ 00Ch
HELP_SETPOPUP_POS       equ 00Dh
HELP_KEY                equ 101h
HELP_COMMAND            equ 102h
HELP_PARTIALKEY         equ 105h
HELP_MULTIKEY           equ 201h
HELP_SETWINPOS          equ 203h

; keybd_event flags

KEYEVENTF_EXTENDEDKEY   equ 1h
KEYEVENTF_KEYUP         equ 2h

; mouse_event flags

MOUSEEVENTF_MOVE        equ 0001h
MOUSEEVENTF_LEFTDOWN    equ 0002h
MOUSEEVENTF_LEFTUP      equ 0004h
MOUSEEVENTF_RIGHTDOWN   equ 0008h
MOUSEEVENTF_RIGHTUP     equ 0010h
MOUSEEVENTF_MIDDLEDOWN  equ 0020h
MOUSEEVENTF_MIDDLEUP    equ 0040h
MOUSEEVENTF_WHEEL       equ 0800h
MOUSEEVENTF_ABSOLUTE    equ 8000h

; TrackPopupMenu flags

TPM_LEFTBUTTON          equ 0000h
TPM_RIGHTBUTTON         equ 0002h
TPM_LEFTALIGN           equ 0000h
TPM_CENTERALIGN         equ 0004h
TPM_RIGHTALIGN          equ 0008h
TPM_TOPALIGN            equ 0000h
TPM_VCENTERALIGN        equ 0010h
TPM_BOTTOMALIGN         equ 0020h
TPM_HORIZONTAL          equ 0000h
TPM_VERTICAL            equ 0040h
TPM_NONOTIFY            equ 0080h
TPM_RETURNCMD           equ 0100h
TPM_RECURSE             equ 0001h
TPM_HORPOSANIMATION     equ 0400h
TPM_HORNEGANIMATION     equ 0800h
TPM_VERPOSANIMATION     equ 1000h
TPM_VERNEGANIMATION     equ 2000h
TPM_NOANIMATION         equ 4000h
TPM_LAYOUTRTL           equ 8000h

; Menu item info mask values

MIIM_STATE              equ 001h
MIIM_ID                 equ 002h
MIIM_SUBMENU            equ 004h
MIIM_CHECKMARKS         equ 008h
MIIM_TYPE               equ 010h
MIIM_DATA               equ 020h
MIIM_STRING             equ 040h
MIIM_BITMAP             equ 080h
MIIM_FTYPE              equ 100h

; DRAWITEMSTRUCT control types

ODT_MENU                equ 1
ODT_LISTBOX             equ 2
ODT_COMBOBOX            equ 3
ODT_BUTTON              equ 4
ODT_STATIC              equ 5

; DRAWITEMSTRUCT actions

ODA_DRAWENTIRE          equ 1
ODA_SELECT              equ 2
ODA_FOCUS               equ 4

; DRAWITEMSTRUCT states

ODS_SELECTED            equ 0001h
ODS_GRAYED              equ 0002h
ODS_DISABLED            equ 0004h
ODS_CHECKED             equ 0008h
ODS_FOCUS               equ 0010h
ODS_DEFAULT             equ 0020h
ODS_COMBOBOXEDIT        equ 1000h
ODS_HOTLIGHT            equ 0040h
ODS_INACTIVE            equ 0080h

; WINDOWPLACEMENT flags

WPF_SETMINPOSITION      equ 1
WPF_RESTORETOMAXIMIZED  equ 2

; Layered window attributes

LWA_COLORKEY            equ 1
LWA_ALPHA               equ 2

; UpdateLayeredWindow flags

ULW_COLORKEY            equ 1
ULW_ALPHA               equ 2
ULW_OPAQUE              equ 4

; SystemParametersInfo parameters

SPI_GETACCESSTIMEOUT      equ 60
SPI_GETANIMATION          equ 72
SPI_GETBEEP               equ 1
SPI_GETBORDER             equ 5
SPI_GETDEFAULTINPUTLANG   equ 89
SPI_GETDRAGFULLWINDOWS    equ 38
SPI_GETFASTTASKSWITCH     equ 35
SPI_GETFILTERKEYS         equ 50
SPI_GETFONTSMOOTHING      equ 74
SPI_GETGRIDGRANULARITY    equ 18
SPI_GETHIGHCONTRAST       equ 66
SPI_GETICONMETRICS        equ 45
SPI_GETICONTITLELOGFONT   equ 31
SPI_GETICONTITLEWRAP      equ 25
SPI_GETKEYBOARDDELAY      equ 22
SPI_GETKEYBOARDPREF       equ 68
SPI_GETKEYBOARDSPEED      equ 10
SPI_GETLOWPOWERACTIVE     equ 83
SPI_GETLOWPOWERTIMEOUT    equ 79
SPI_GETMENUDROPALIGNMENT  equ 27
SPI_GETMINIMIZEDMETRICS   equ 43
SPI_GETMOUSE              equ 3
SPI_GETMOUSEKEYS          equ 54
SPI_GETMOUSETRAILS        equ 94
SPI_GETNONCLIENTMETRICS   equ 41
SPI_GETPOWEROFFACTIVE     equ 84
SPI_GETPOWEROFFTIMEOUT    equ 80
SPI_GETSCREENREADER       equ 70
SPI_GETSCREENSAVEACTIVE   equ 16
SPI_GETSCREENSAVETIMEOUT  equ 14
SPI_GETSERIALKEYS         equ 62
SPI_GETSHOWSOUNDS         equ 56
SPI_GETSOUNDSENTRY        equ 64
SPI_GETSTICKYKEYS         equ 58
SPI_GETTOGGLEKEYS         equ 52
SPI_GETWINDOWSEXTENSION   equ 92
SPI_GETWORKAREA           equ 48
SPI_ICONHORIZONTALSPACING equ 13
SPI_ICONVERTICALSPACING   equ 24
SPI_LANGDRIVER            equ 12
SPI_SCREENSAVERRUNNING    equ 97
SPI_SETACCESSTIMEOUT      equ 61
SPI_SETANIMATION          equ 73
SPI_SETBEEP               equ 2
SPI_SETBORDER             equ 6
SPI_SETDEFAULTINPUTLANG   equ 90
SPI_SETDESKPATTERN        equ 21
SPI_SETDESKWALLPAPER      equ 20
SPI_SETDOUBLECLICKTIME    equ 32
SPI_SETDOUBLECLKHEIGHT    equ 30
SPI_SETDOUBLECLKWIDTH     equ 29
SPI_SETDRAGFULLWINDOWS    equ 37
SPI_SETDRAGHEIGHT         equ 77
SPI_SETDRAGWIDTH          equ 76
SPI_SETFASTTASKSWITCH     equ 36
SPI_SETFILTERKEYS         equ 51
SPI_SETFONTSMOOTHING      equ 75
SPI_SETGRIDGRANULARITY    equ 19
SPI_SETHANDHELD           equ 78
SPI_SETHIGHCONTRAST       equ 67
SPI_SETICONMETRICS        equ 46
SPI_SETICONTITLELOGFONT   equ 34
SPI_SETICONTITLEWRAP      equ 26
SPI_SETKEYBOARDDELAY      equ 23
SPI_SETKEYBOARDPREF       equ 69
SPI_SETKEYBOARDSPEED      equ 11
SPI_SETLANGTOGGLE         equ 91
SPI_SETLOWPOWERACTIVE     equ 85
SPI_SETLOWPOWERTIMEOUT    equ 81
SPI_SETMENUDROPALIGNMENT  equ 28
SPI_SETMINIMIZEDMETRICS   equ 44
SPI_SETMOUSE              equ 4
SPI_SETMOUSEBUTTONSWAP    equ 33
SPI_SETMOUSEKEYS          equ 55
SPI_SETMOUSETRAILS        equ 93
SPI_SETNONCLIENTMETRICS   equ 42
SPI_SETPENWINDOWS         equ 49
SPI_SETPOWEROFFACTIVE     equ 86
SPI_SETPOWEROFFTIMEOUT    equ 82
SPI_SETSCREENREADER       equ 71
SPI_SETSCREENSAVEACTIVE   equ 17
SPI_SETSCREENSAVERRUNNING equ 97
SPI_SETSCREENSAVETIMEOUT  equ 15
SPI_SETSERIALKEYS         equ 63
SPI_SETSHOWSOUNDS         equ 57
SPI_SETSOUNDSENTRY        equ 65
SPI_SETSTICKYKEYS         equ 59
SPI_SETTOGGLEKEYS         equ 53
SPI_SETWORKAREA           equ 47

; SystemParametersInfo flags

SPIF_UPDATEINIFILE      equ 1
SPIF_SENDWININICHANGE   equ 2
