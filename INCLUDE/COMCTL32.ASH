struc INITCOMMONCONTROLSEX
  dwSize        dd ?
  dwICC         dd ?
ends

struc REBARINFO
  cbSize        dd ?
  fMask         dd ?
  himl          dd ?
ends

struc REBARBANDINFO
  cbSize        dd ?
  fMask         dd ?
  fStyle        dd ?
  clrFore       dd ?
  clrBack       dd ?
  lpText        dd ?
  cch           dd ?
  iImage        dd ?
  hwndChild     dd ?
  cxMinChild    dd ?
  cyMinChild    dd ?
  lx            dd ?
  hbmBack       dd ?
  wID           dd ?
  cyChild       dd ?
  cyMaxChild    dd ?
  cyIntegral    dd ?
  cxIdeal       dd ?
  lParam        dd ?
  cxHeader      dd ?
ends

struc NMHDR
    hwndFrom    dd ?
    idFrom      dd ?
    code        dd ?
ends

struc NMREBARCHILDSIZE
  hdr           NMHDR <>
  uBand         dd ?
  wID           dd ?
  rcChild       RECT <>
  rcBand        RECT <>
ends

struc NMREBAR
  hdr           NMHDR <>
  dwMask        dd ?
  uBand         dd ?
  fStyle        dd ?
  wID           dd ?
  lParam        dd ?
ends


struc NMRBAUTOSIZE
  hdr           NMHDR <>
  fChanged      dd ?
  rcTarget      RECT <>
  rcActual      RECT <>
ends

struc RBHITTESTINFO
  pt            POINT <>
  flags         dd ?
  iBand         dd ?
ends

struc IMAGEINFO
  hbmImage      dd ?
  hbmMask       dd ?
  Unused1       dd ?
  Unused2       dd ?
  rcImage       RECT <>
ends

struc HD_ITEM
  imask         dd ?
  lxy           dd ?
  pszText       dd ?
  hbm           dd ?
  cchTextMax    dd ?
  fmt           dd ?
  lParam        dd ?
  iImage        dd ?
  iOrder        dd ?
  itype         dd ?
  pvFilter      dd ?
ends

struc HD_LAYOUT
  prc           dd ?
  pwpos         dd ?
ends

struc HD_HITTESTINFO
  pt            POINT <>
  flags         dd ?
  iItem         dd ?
ends

struc NMHEADER
    hdr         NMHDR <>
    iItem       dd ?
    iButton     dd ?
    pitem       dd ?
ends

struc TBBUTTON
  iBitmap       dd ?
  idCommand     dd ?
  fsState       db ?
  fsStyle       db ?
  _wPad1        dw ?
  dwData        dd ?
  iString       dd ?
ends

struc COLORMAP
  From          dd ?
  To            dd ?
ends

struc TBADDBITMAP
  hInst         dd ?
  nID           dd ?
ends

struc TBSAVEPARAMS
  hkr           dd ?
  pszSubKey     dd ?
  pszValueName  dd ?
ends

struc TBREPLACEBITMAP
  hInstOld      dd ?
  nIdOld        dd ?
  hInstNew      dd ?
  nIdNew        dd ?
  nButtons      dd ?
ends

struc NMTOOLBAR
  hdr           NMHDR <>
  iItem         dd ?
  tbButton      TBBUTTON <>
  cchText       dd ?
  pszText       dd ?
ends

struc TOOLINFO
  cbSize        dd ?
  uFlags        dd ?
  hWnd          dd ?
  uId           dd ?
  rect          RECT <>
  hInst         dd ?
  lpszText      dd ?
  lParam        dd ?
ends


struc TT_HITTESTINFO
  hWnd          dd ?
  pt            POINT <>
  ti            TOOLINFO <>
ends

struc NMTTDISPINFO
  hdr           NMHDR <>
  lpszText      dd ?
  szText        TCHAR 80 dup (?)
  union
        hInst   dd ?
        hinst   dd ?
  ends
  uFlags        dd ?
  lParam        dd ?
ends

struc DRAGLISTINFO
  uNotification dd ?
  hWnd          dd ?
  ptCursor      POINT <>
ends

struc UDACCEL
  nSec          dd ?
  nInc          dd ?
ends

struc NM_UPDOWN
  hdr           NMHDR <>
  iPos          dd ?
  iDelta        dd ?
ends

struc LV_ITEM
  imask         dd ?
  iItem         dd ?
  iSubItem      dd ?
  state         dd ?
  stateMask     dd ?
  pszText       dd ?
  cchTextMax    dd ?
  iImage        dd ?
  lParam        dd ?
  iIndent       dd ?
ends

struc LV_FINDINFO
  flags         dd ?
  psz           dd ?
  lParam        dd ?
  pt            POINT <>
  vkDirection   dd ?
ends

struc LV_HITTESTINFO
  pt            POINT <>
  flags         dd ?
  iItem         dd ?
  iSubItem      dd ?
ends

struc LV_COLUMN
  imask         dd ?
  fmt           dd ?
  lx            dd ?
  pszText       dd ?
  cchTextMax    dd ?
  iSubItem      dd ?
  iImage        dd ?
  iOrder        dd ?
ends

struc NM_LISTVIEW
  hdr           NMHDR <>
  iItem         dd ?
  iSubItem      dd ?
  uNewState     dd ?
  uOldState     dd ?
  uChanged      dd ?
  ptAction      POINT <>
  lParam        dd ?
ends

struc LV_DISPINFO
  hdr           NMHDR <>
  item          LV_ITEM <>
ends

struc LV_KEYDOWN
  hdr           NMHDR <>
  wVKey         dw ?
  flags         dd ?
ends


struc TV_ITEM
  imask         dd ?
  hItem         dd ?
  state         dd ?
  stateMask     dd ?
  pszText       dd ?
  cchTextMax    dd ?
  iImage        dd ?
  iSelectedImage dd ?
  cChildren     dd ?
  lParam        dd ?
ends

struc TV_ITEMEX
  imask         dd ?
  hItem         dd ?
  state         dd ?
  stateMask     dd ?
  pszText       dd ?
  cchTextMax    dd ?
  iImage        dd ?
  iSelectedImage dd ?
  cChildren     dd ?
  lParam        dd ?
  iIntegral     dd ?
ends

union ITEMTYPE
  itemex        TV_ITEMEX <>
  item          TV_ITEM <>
ends

struc TV_INSERTSTRUCT
  hParent       dd ?
  hInsertAfter  dd ?
  union
    itemex        TV_ITEMEX <>
    item          TV_ITEM <>
  ends
ends

struc TV_HITTESTINFO
  pt            POINT <>
  flags         dd ?
  hItem         dd ?
ends

struc TV_SORTCB
  hParent       dd ?
  lpfnCompare   dd ?
  lParam        dd ?
ends

struc NM_TREEVIEW
  hdr           NMHDR <>
  action        dd ?
  itemOld       TV_ITEM <>
  itemNew       TV_ITEM <>
  ptDrag        POINT <>
ends


struc TV_DISPINFO
  hdr           NMHDR <>
  item          TV_ITEM <>
ends


struc TV_KEYDOWN
  hdr           NMHDR <>
  wVKey         dw ?
  flags         dd ?
ends

struc TC_ITEMHEADER
  imask         dd ?
  lpReserved1   dd ?
  lpReserved2   dd ?
  pszText       dd ?
  cchTextMax    dd ?
  iImage        dd ?
ends

struc TC_ITEM
  imask         dd ?
  lpReserved1   dd ?
  lpReserved2   dd ?
  pszText       dd ?
  cchTextMax    dd ?
  iImage        dd ?
  lParam        dd ?
ends

struc TC_HITTESTINFO
  pt            POINT <>
  flags         dd ?
ends

struc TC_KEYDOWN
  hdr           NMHDR <>
  wVKey         dw ?
  flags         dd ?
ends


; --------------------------- comctl equates -------------------------------

ODT_HEADER          equ 100
ODT_TAB             equ 101
ODT_LISTVIEW        equ 102
LVM_FIRST           equ 1000h

TV_FIRST            equ 1100h
HDM_FIRST           equ 1200h
CCS_TOP             equ 00000001h
CCS_NOMOVEY         equ 00000002h
CCS_BOTTOM          equ 00000003h
CCS_NORESIZE        equ 00000004h
CCS_NOPARENTALIGN   equ 00000008h
CCS_ADJUSTABLE      equ 00000020h
CCS_NODIVIDER       equ 00000040h
CCM_FIRST           equ 2000h
CCM_LAST            equ <CCM_FIRST + 200h>
CCM_SETBKCOLOR      equ <CCM_FIRST + 1>
CCM_SETCOLORSCHEME  equ <CCM_FIRST + 2>
CCM_GETCOLORSCHEME  equ <CCM_FIRST + 3>
CCM_GETDROPTARGET   equ <CCM_FIRST + 4>
CCM_SETUNICODEFORMAT equ <CCM_FIRST + 5>
CCM_GETUNICODEFORMAT equ <CCM_FIRST + 6>
LVN_FIRST        equ 0-100
LVN_LAST         equ 0-199
HDN_FIRST        equ 0-300
HDN_LAST         equ 0-399
TVN_FIRST        equ 0-400
TVN_LAST         equ 0-499
TTN_FIRST        equ 0-520
TTN_LAST         equ 0-549
TCN_FIRST        equ 0-550
TCN_LAST         equ 0-580
;CDN_FIRST        equ 0-601
;CDN_LAST         equ 0-699
TBN_FIRST        equ 0-700
TBN_LAST         equ 0-720
UDN_FIRST        equ 0-721
UDN_LAST         equ 0-740
MCN_FIRST        equ 0-750
MCN_LAST         equ 0-759
DTN_FIRST        equ 0-760
DTN_LAST         equ 0-799
CBEN_FIRST       equ 0-800
CBEN_LAST        equ 0-830
RBN_FIRST        equ 0-831
RBN_LAST         equ 0-859
IPN_FIRST        equ 0-860
IPN_LAST         equ 0-879
SBN_FIRST        equ 0-880
SBN_LAST         equ 0-899
PGN_FIRST        equ 0-900
PGN_LAST         equ 0-950
PGM_FIRST               equ 1400h
MSGF_COMMCTRL_BEGINDRAG            equ 4200h
MSGF_COMMCTRL_SIZEHEADER           equ 4201h
MSGF_COMMCTRL_DRAGSELECT           equ 4202h
MSGF_COMMCTRL_TOOLBARCUST          equ 4203h
ICC_LISTVIEW_CLASSES             equ 00000001h
ICC_TREEVIEW_CLASSES             equ 00000002h
ICC_BAR_CLASSES  equ 00000004h
ICC_TAB_CLASSES  equ 00000008h
ICC_UPDOWN_CLASS equ 00000010h
ICC_PROGRESS_CLASS               equ 00000020h
ICC_HOTKEY_CLASS equ 00000040h
ICC_ANIMATE_CLASS                equ 00000080h
ICC_WIN95_CLASSES                equ 000000FFh
ICC_DATE_CLASSES equ 00000100h
ICC_USEREX_CLASSES               equ 00000200h
ICC_COOL_CLASSES equ 00000400h
ICC_INTERNET_CLASSES             equ 00000800h
ICC_PAGESCROLLER_CLASS           equ 00001000h
ICC_NATIVEFNTCTL_CLASS           equ 00002000h
RBIM_IMAGELIST equ 1
RBS_TOOLTIPS   equ 100h
RBS_VARHEIGHT  equ 200h
RBS_BANDBORDERS                equ 400h
RBS_FIXEDORDER equ 800h
RBS_REGISTERDROP               equ 1000h
RBS_AUTOSIZE   equ 2000h
RBS_VERTICALGRIPPER            equ 4000h
RBS_DBLCLKTOGGLE               equ 8000h
RBBS_BREAK     equ 1
RBBS_FIXEDSIZE equ 2
RBBS_CHILDEDGE equ 4
RBBS_HIDDEN    equ 8
RBBS_NOVERT    equ 10h
RBBS_FIXEDBMP  equ 20h
RBBS_VARIABLEHEIGHT            equ 40h
RBBS_GRIPPERALWAYS             equ 80h
RBBS_NOGRIPPER equ 100h
RBBIM_STYLE    equ 1
RBBIM_COLORS   equ 2
RBBIM_TEXT     equ 4
RBBIM_IMAGE    equ 8
RBBIM_CHILD    equ 10h
RBBIM_CHILDSIZE equ 20h
RBBIM_SIZE     equ 40h
RBBIM_BACKGROUND               equ 80h
RBBIM_ID       equ 100h
RBBIM_IDEALSIZE                equ 00000200h
RBBIM_LPARAM   equ 00000400h
RBBIM_HEADERSIZE               equ 00000800h

RB_INSERTBAND  equ <WM_USER +  1>
RB_DELETEBAND  equ <WM_USER +  2>
RB_GETBARINFO  equ <WM_USER +  3>
RB_SETBARINFO  equ <WM_USER +  4>
RB_GETBANDINFO equ <WM_USER +  29>
RB_SETBANDINFO equ <WM_USER +  6>
RB_SETPARENT   equ <WM_USER +  7>
RB_HITTEST     equ <WM_USER +  8>
RB_GETRECT     equ <WM_USER +  9>
RB_GETBANDCOUNT                equ <WM_USER +  1>
RB_GETROWCOUNT equ <WM_USER +  13
RB_GETROWHEIGHT                equ <WM_USER +  14>
RB_IDTOINDEX   equ <WM_USER +  16>
RB_GETTOOLTIPS equ <WM_USER +  17>
RB_SETTOOLTIPS equ <WM_USER +  18>
RB_SETBKCOLOR  equ <WM_USER +  19>
RB_GETBKCOLOR  equ <WM_USER +  20>
RB_SETTEXTCOLOR                equ <WM_USER +  21>
RB_GETTEXTCOLOR                equ <WM_USER +  22>
RB_SIZETORECT  equ <WM_USER +  23>
RB_SETCOLORSCHEME              equ <CCM_SETCOLORSCHEME>
RB_GETCOLORSCHEME              equ <CCM_GETCOLORSCHEME>
RB_BEGINDRAG   equ <WM_USER + 24>
RB_ENDDRAG     equ <WM_USER + 25>
RB_DRAGMOVE    equ <WM_USER + 26>
RB_GETBARHEIGHT                equ <WM_USER + 27>
RB_MINIMIZEBAND                equ <WM_USER + 30>
RB_MAXIMIZEBAND                equ <WM_USER + 31>
RB_GETDROPTARGET               equ <CCM_GETDROPTARGET>
RB_GETBANDBORDERS              equ <WM_USER + 34>
RB_SHOWBAND    equ <WM_USER + 35>
RB_SETPALETTE  equ <WM_USER + 37>
RB_GETPALETTE  equ <WM_USER + 38>
RB_MOVEBAND    equ <WM_USER + 39>
RB_SETUNICODEFORMAT            equ <CCM_SETUNICODEFORMAT>
RB_GETUNICODEFORMAT            equ <CCM_GETUNICODEFORMAT>

RBN_HEIGHTCHANGE               equ <RBN_FIRST - 0>
RBN_GETOBJECT  equ <RBN_FIRST - 1>
RBN_LAYOUTCHANGED              equ <RBN_FIRST - 2>
RBN_AUTOSIZE   equ <RBN_FIRST - 3>
RBN_BEGINDRAG  equ <RBN_FIRST - 4>
RBN_ENDDRAG    equ <RBN_FIRST - 5>
RBN_DELETINGBAND               equ <RBN_FIRST - 6>
RBN_DELETEDBAND                equ <RBN_FIRST - 7>
RBN_CHILDSIZE  equ <RBN_FIRST - 8>
RBNM_ID        equ 00000001h
RBNM_STYLE     equ 00000002h
RBNM_LPARAM    equ 00000004h
RBHT_NOWHERE   equ 0001h
RBHT_CAPTION   equ 0002h
RBHT_CLIENT    equ 0003h
RBHT_GRABBER   equ 0004h
CLR_NONE         equ 0FFFFFFFFh
CLR_DEFAULT      equ 0FF000000h
ILC_MASK         equ 0001h
ILC_COLOR        equ 0000h
ILC_COLORDDB     equ 00FEh
ILC_COLOR4       equ 0004h
ILC_COLOR8       equ 0008h
ILC_COLOR16      equ 0010h
ILC_COLOR24      equ 0018h
ILC_COLOR32      equ 0020h
ILC_PALETTE      equ 0800h
ILD_NORMAL       equ 0000h
ILD_TRANSPARENT  equ 0001h
ILD_MASK         equ 0010h
ILD_IMAGE        equ 0020h
ILD_BLEND25      equ 0002h
ILD_BLEND50      equ 0004h
ILD_OVERLAYMASK  equ 0F00h
ILD_SELECTED     equ <ILD_BLEND50>
ILD_FOCUS        equ <ILD_BLEND25>
ILD_BLEND        equ <ILD_BLEND50>
CLR_HILIGHT      equ <CLR_DEFAULT>
HDS_HORZ         equ 00000000h
HDS_BUTTONS      equ 00000002h
HDS_HIDDEN       equ 00000008h

HDI_WIDTH        equ 0001h
HDI_HEIGHT       equ <HDI_WIDTH>
HDI_TEXT         equ 0002h
HDI_FORMAT       equ 0004h
HDI_LPARAM       equ 0008h
HDI_BITMAP       equ 0010h
HDF_LEFT         equ 0
HDF_RIGHT        equ 1
HDF_CENTER       equ 2
HDF_JUSTIFYMASK  equ 0003h
HDF_RTLREADING   equ 4
HDF_OWNERDRAW    equ 8000h
HDF_STRING       equ 4000h
HDF_BITMAP       equ 2000h

HDM_GETITEMCOUNT equ <HDM_FIRST + 0>
HDM_INSERTITEMA  equ <HDM_FIRST + 1>
HDM_INSERTITEMW  equ <HDM_FIRST + 10>
HDM_DELETEITEM   equ <HDM_FIRST + 2>
HDM_GETITEMA     equ <HDM_FIRST + 3>
HDM_GETITEMW     equ <HDM_FIRST + 11>
HDM_SETITEMA     equ <HDM_FIRST + 4>
HDM_SETITEMW     equ <HDM_FIRST + 12>
HDM_LAYOUT       equ <HDM_FIRST + 5>
HHT_NOWHERE      equ 0001h
HHT_ONHEADER     equ 0002h
HHT_ONDIVIDER    equ 0004h
HHT_ONDIVOPEN    equ 0008h
HHT_ABOVE        equ 0100h
HHT_BELOW        equ 0200h
HHT_TORIGHT      equ 0400h
HHT_TOLEFT       equ 0800h
HDM_HITTEST      equ <HDM_FIRST + 6>
HDN_ITEMCHANGINGA equ <HDN_FIRST - 0>
HDN_ITEMCHANGINGW equ <HDN_FIRST - 20>
HDN_ITEMCHANGEDA equ <HDN_FIRST - 1>
HDN_ITEMCHANGEDW equ <HDN_FIRST - 21>
HDN_ITEMCLICKA   equ <HDN_FIRST - 2>
HDN_ITEMCLICKW   equ <HDN_FIRST - 22>
HDN_ITEMDBLCLICKA equ <HDN_FIRST - 3>
HDN_ITEMDBLCLICKW    equ <HDN_FIRST - 23>
HDN_DIVIDERDBLCLICKA equ <HDN_FIRST - 5>
HDN_DIVIDERDBLCLICKW equ <HDN_FIRST - 25>
HDN_BEGINTRACKA      equ <HDN_FIRST - 6>
HDN_BEGINTRACKW      equ <HDN_FIRST - 26>
HDN_ENDTRACKA        equ <HDN_FIRST - 7>
HDN_ENDTRACKW        equ <HDN_FIRST - 27>
HDN_TRACKA           equ <HDN_FIRST - 8>
HDN_TRACKW           equ <HDN_FIRST - 28>
ifndef @unicode
  HDM_INSERTITEM                equ HDM_INSERTITEMA
  HDM_GETITEM                   equ HDM_GETITEMA
  HDM_SETITEM                   equ HDM_SETITEMA
  HDN_ITEMCHANGING              equ HDN_ITEMCHANGINGA
  HDN_ITEMCHANGED               equ HDN_ITEMCHANGEDA
  HDN_ITEMCLICK                 equ HDN_ITEMCLICKA
  HDN_ITEMDBLCLICK              equ HDN_ITEMDBLCLICKA
  HDN_DIVIDERDBLCLICK           equ HDN_DIVIDERDBLCLICKA
  HDN_BEGINTRACK                equ HDN_BEGINTRACKA
  HDN_ENDTRACK                  equ HDN_ENDTRACKA
  HDN_TRACK                     equ HDN_TRACKA
else
  HDM_INSERTITEM                equ HDM_INSERTITEMW
  HDM_GETITEM                   equ HDM_GETITEMW
  HDM_SETITEM                   equ HDM_SETITEMW
  HDN_ITEMCHANGING              equ HDN_ITEMCHANGINGW
  HDN_ITEMCHANGED               equ HDN_ITEMCHANGEDW
  HDN_ITEMCLICK                 equ HDN_ITEMCLICKW
  HDN_ITEMDBLCLICK              equ HDN_ITEMDBLCLICKW
  HDN_DIVIDERDBLCLICK           equ HDN_DIVIDERDBLCLICKW
  HDN_BEGINTRACK                equ HDN_BEGINTRACKW
  HDN_ENDTRACK                  equ HDN_ENDTRACKW
  HDN_TRACK                     equ HDN_TRACKW
endif


CMB_MASKED      equ 02h
TBSTATE_CHECKED equ 01h
TBSTATE_PRESSED equ 02h
TBSTATE_ENABLED equ 04h
TBSTATE_HIDDEN  equ 08h
TBSTATE_INDETERMINATE equ 10h
TBSTATE_WRAP    equ 20h
TBSTYLE_BUTTON  equ 00h
TBSTYLE_SEP     equ 01h
TBSTYLE_CHECK   equ 02h
TBSTYLE_GROUP   equ 04h
TBSTYLE_CHECKGROUP equ <TBSTYLE_GROUP OR TBSTYLE_CHECK>
TBSTYLE_TOOLTIPS equ 0100h
TBSTYLE_WRAPABLE equ 0200h
TBSTYLE_ALTDRAG  equ 0400h
TBSTYLE_FLAT     equ 0800h
TBSTYLE_LIST     equ 1000h
TBSTYLE_CUSTOMERASE              equ 2000h
TBSTYLE_REGISTERDROP             equ 4000h
TBSTYLE_TRANSPARENT              equ 8000h
TB_ENABLEBUTTON  equ <WM_USER + 1>
TB_CHECKBUTTON   equ <WM_USER + 2>
TB_PRESSBUTTON   equ <WM_USER + 3>
TB_HIDEBUTTON    equ <WM_USER + 4>
TB_INDETERMINATE equ <WM_USER + 5>
TB_ISBUTTONENABLED equ <WM_USER + 9>
TB_ISBUTTONCHECKED equ <WM_USER + 10>
TB_ISBUTTONPRESSED equ <WM_USER + 11>
TB_ISBUTTONHIDDEN  equ <WM_USER + 12>
TB_ISBUTTONINDETERMINATE         equ <WM_USER + 13>
TB_SETSTATE      equ <WM_USER + 17>
TB_GETSTATE      equ <WM_USER + 18>
TB_ADDBITMAP     equ <WM_USER + 19>
TB_SETSTYLE      equ <WM_USER + 56>
TB_GETSTYLE      equ <WM_USER + 57>
HINST_COMMCTRL   equ -1
IDB_STD_SMALL_COLOR              equ 0
IDB_STD_LARGE_COLOR              equ 1
IDB_VIEW_SMALL_COLOR             equ 4
IDB_VIEW_LARGE_COLOR             equ 5
STD_CUT          equ 0
STD_COPY         equ 1
STD_PASTE        equ 2
STD_UNDO         equ 3
STD_REDOW        equ 4
STD_DELETE       equ 5
STD_FILENEW      equ 6
STD_FILEOPEN     equ 7
STD_FILESAVE     equ 8
STD_PRINTPRE     equ 9
STD_PROPERTIES   equ 10
STD_HELP         equ 11
STD_FIND         equ 12
STD_REPLACE      equ 13
STD_PRINT        equ 14
VIEW_LARGEICONS  equ 0
VIEW_SMALLICONS  equ 1
VIEW_LIST        equ 2
VIEW_DETAILS     equ 3
VIEW_SORTNAME    equ 4
VIEW_SORTSIZE    equ 5
VIEW_SORTDATE    equ 6
VIEW_SORTTYPE    equ 7
VIEW_PARENTFOLDER                equ 8
VIEW_NETCONNECT  equ 9
VIEW_NETDISCONNECT               equ 10
VIEW_NEWFOLDER   equ 11

TB_ADDBUTTONS    equ <WM_USER + 20>
TB_INSERTBUTTON  equ <WM_USER + 21>
TB_DELETEBUTTON  equ <WM_USER + 22>
TB_GETBUTTON     equ <WM_USER + 23>
TB_BUTTONCOUNT   equ <WM_USER + 24>
TB_COMMANDTOINDEX equ <WM_USER + 25>
TB_SAVERESTORE   equ <WM_USER + 26>
TB_CUSTOMIZE     equ <WM_USER + 27>
TB_ADDSTRING     equ <WM_USER + 28>
TB_GETITEMRECT   equ <WM_USER + 29>
TB_BUTTONSTRUCTSIZE              equ <WM_USER + 30>
TB_SETBUTTONSIZE equ <WM_USER + 31>
TB_SETBITMAPSIZE equ <WM_USER + 32>
TB_AUTOSIZE      equ <WM_USER + 33>
TB_GETTOOLTIPS   equ <WM_USER + 35>
TB_SETTOOLTIPS   equ <WM_USER + 36>
TB_SETPARENT     equ <WM_USER + 37>
TB_SETROWS       equ <WM_USER + 39>
TB_GETROWS       equ <WM_USER + 40>
TB_SETCMDID      equ <WM_USER + 42>
TB_CHANGEBITMAP  equ <WM_USER + 43>
TB_GETBITMAP     equ <WM_USER + 44>
TB_GETBUTTONTEXT equ <WM_USER + 45>
TB_REPLACEBITMAP equ <WM_USER + 46>
TBBF_LARGE       equ 1
TB_GETBITMAPFLAGS                equ <WM_USER + 41>
TBN_GETBUTTONINFO                equ <TBN_FIRST>
TBN_BEGINDRAG    equ <TBN_FIRST-1>
TBN_ENDDRAG      equ <TBN_FIRST-2>
TBN_BEGINADJUST  equ <TBN_FIRST-3>
TBN_ENDADJUST    equ <TBN_FIRST-4>
TBN_RESET        equ <TBN_FIRST-5>
TBN_QUERYINSERT  equ <TBN_FIRST-6>
TBN_QUERYDELETE  equ <TBN_FIRST-7>
TBN_TOOLBARCHANGE equ <TBN_FIRST-8>
TBN_CUSTHELP     equ <TBN_FIRST-9>
TTS_ALWAYSTIP    equ 01h
TTS_NOPREFIX     equ 02h
TTF_IDISHWND     equ 01h
TTF_CENTERTIP    equ 02h
TTF_RTLREADING   equ 04h
TTF_SUBCLASS     equ 10h
TTDT_AUTOMATIC   equ 0
TTDT_RESHOW      equ 1
TTDT_AUTOPOP     equ 2
TTDT_INITIAL     equ 3

TTM_ACTIVATE     equ <WM_USER + 1>
TTM_SETDELAYTIME equ <WM_USER + 3>
TTM_ADDTOOLA     equ <WM_USER + 4>
TTM_ADDTOOLW     equ <WM_USER + 50>
TTM_DELTOOLA     equ <WM_USER + 5>
TTM_DELTOOLW     equ <WM_USER + 51>
TTM_NEWTOOLRECTA equ <WM_USER + 6>
TTM_NEWTOOLRECTW equ <WM_USER + 52>
TTM_RELAYEVENT   equ <WM_USER + 7>
TTM_GETTOOLINFOA equ <WM_USER + 8>
TTM_GETTOOLINFOW equ <WM_USER + 53>
TTM_SETTOOLINFOA equ <WM_USER + 9>
TTM_SETTOOLINFOW equ <WM_USER + 54>
TTM_HITTESTA     equ <WM_USER +10>
TTM_HITTESTW     equ <WM_USER +55>
TTM_GETTEXTA     equ <WM_USER +11>
TTM_GETTEXTW     equ <WM_USER +56>
TTM_UPDATETIPTEXTA equ <WM_USER +12>
TTM_UPDATETIPTEXTW equ <WM_USER +57>
TTM_GETTOOLCOUNT equ <WM_USER +13>
TTM_ENUMTOOLSA   equ <WM_USER +14>
TTM_ENUMTOOLSW   equ <WM_USER +58>
TTM_GETCURRENTTOOLA              equ <WM_USER + 15>
TTM_GETCURRENTTOOLW              equ <WM_USER + 59>
TTM_WINDOWFROMPOINT              equ <WM_USER + 16>
TTN_NEEDTEXTA    equ <TTN_FIRST - 0>
TTN_NEEDTEXTW    equ <TTN_FIRST - 10>
TTN_SHOW         equ <TTN_FIRST - 1>
TTN_POP          equ <TTN_FIRST - 2>
ifndef @unicode
  TTM_ADDTOOL                   equ TTM_ADDTOOLA
  TTM_DELTOOL                   equ TTM_DELTOOLA
  TTM_NEWTOOLRECT               equ TTM_NEWTOOLRECTA
  TTM_GETTOOLINFO               equ TTM_GETTOOLINFOA
  TTM_SETTOOLINFO               equ TTM_SETTOOLINFOA
  TTM_HITTEST                   equ TTM_HITTESTA
  TTM_GETTEXT                   equ TTM_GETTEXTA
  TTM_UPDATETIPTEXT             equ TTM_UPDATETIPTEXTA
  TTM_ENUMTOOLS                 equ TTM_ENUMTOOLSA
  TTM_GETCURRENTTOOL            equ TTM_GETCURRENTTOOLA
  TTN_NEEDTEXT                  equ TTN_NEEDTEXTA
else
  TTM_ADDTOOL                   equ TTM_ADDTOOLW
  TTM_DELTOOL                   equ TTM_DELTOOLW
  TTM_NEWTOOLRECT               equ TTM_NEWTOOLRECTW
  TTM_GETTOOLINFO               equ TTM_GETTOOLINFOW
  TTM_SETTOOLINFO               equ TTM_SETTOOLINFOW
  TTM_HITTEST                   equ TTM_HITTESTW
  TTM_GETTEXT                   equ TTM_GETTEXTW
  TTM_UPDATETIPTEXT             equ TTM_UPDATETIPTEXTW
  TTM_ENUMTOOLS                 equ TTM_ENUMTOOLSW
  TTM_GETCURRENTTOOL            equ TTM_GETCURRENTTOOLW
  TTN_NEEDTEXT                  equ TTN_NEEDTEXTW
endif


SBARS_SIZEGRIP   equ 0100h
SB_SETTEXTA     equ <WM_USER+1>
SB_SETTEXTW     equ <WM_USER+11>
SB_GETTEXTA     equ <WM_USER+2>
SB_GETTEXTW     equ <WM_USER+13>
SB_GETTEXTLENGTHA               equ <WM_USER+3>
SB_GETTEXTLENGTHW               equ <WM_USER+12>
SB_SETPARTS      equ <WM_USER+4>
SB_GETPARTS      equ <WM_USER+6>
SB_GETBORDERS    equ <WM_USER+7>
SB_SETMINHEIGHT  equ <WM_USER+8>
SB_SIMPLE        equ <WM_USER+9>
SB_GETRECT       equ <WM_USER+10>
SBT_OWNERDRAW     equ 1000h
SBT_NOBORDERS     equ 0100h
SBT_POPOUT        equ 0200h
SBT_RTLREADING    equ 0400h
MINSYSCOMMAND           equ <SC_SIZE>
ifndef @unicode
  SB_SETTEXT                    equ SB_SETTEXTA
  SB_GETTEXT                    equ SB_GETTEXTA
  SB_GETTEXTLENGTH              equ SB_GETTEXTLENGTHA
else
  SB_SETTEXT                    equ SB_SETTEXTW
  SB_GETTEXT                    equ SB_GETTEXTW
  SB_GETTEXTLENGTH              equ SB_GETTEXTLENGTHW
endif


TBS_AUTOTICKS   equ 0001h
TBS_VERT        equ 0002h
TBS_HORZ        equ 0000h
TBS_TOP         equ 0004h
TBS_BOTTOM      equ 0000h
TBS_LEFT        equ 0004h
TBS_RIGHT       equ 0000h
TBS_BOTH        equ 0008h
TBS_NOTICKS     equ 0010h
TBS_ENABLESELRANGE              equ 0020h
TBS_FIXEDLENGTH equ 0040h
TBS_NOTHUMB     equ 0080h

TBM_GETPOS      equ <WM_USER>
TBM_GETRANGEMIN equ <WM_USER+1>
TBM_GETRANGEMAX equ <WM_USER+2>
TBM_GETTIC      equ <WM_USER+3>
TBM_SETTIC      equ <WM_USER+4>
TBM_SETPOS      equ <WM_USER+5>
TBM_SETRANGE    equ <WM_USER+6>
TBM_SETRANGEMIN equ <WM_USER+7>
TBM_SETRANGEMAX equ <WM_USER+8>
TBM_CLEARTICS   equ <WM_USER+9>
TBM_SETSEL      equ <WM_USER+10>
TBM_SETSELSTART equ <WM_USER+11>
TBM_SETSELEND   equ <WM_USER+12>
TBM_GETPTICS    equ <WM_USER+14>
TBM_GETTICPOS   equ <WM_USER+15>
TBM_GETNUMTICS  equ <WM_USER+16>
TBM_GETSELSTART equ <WM_USER+17>
TBM_GETSELEND   equ <WM_USER+18>
TBM_CLEARSEL    equ <WM_USER+19>
TBM_SETTICFREQ  equ <WM_USER+20>
TBM_SETPAGESIZE equ <WM_USER+21>
TBM_GETPAGESIZE equ <WM_USER+22>
TBM_SETLINESIZE equ <WM_USER+23>
TBM_GETLINESIZE equ <WM_USER+24>
TBM_GETTHUMBRECT                equ <WM_USER+25>
TBM_GETCHANNELRECT              equ <WM_USER+26>
TBM_SETTHUMBLENGTH              equ <WM_USER+27>
TBM_GETTHUMBLENGTH              equ <WM_USER+28>

TB_LINEUP       equ 0
TB_LINEDOWN     equ 1
TB_PAGEUP       equ 2
TB_PAGEDOWN     equ 3
TB_THUMBPOSITION                equ 4
TB_THUMBTRACK   equ 5
TB_TOP          equ 6
TB_BOTTOM       equ 7
TB_ENDTRACK     equ 8

DL_BEGINDRAG    equ <WM_USER+133>
DL_DRAGGING     equ <WM_USER+134>
DL_DROPPED      equ <WM_USER+135>
DL_CANCELDRAG   equ <WM_USER+136>
DL_CURSORSET    equ 0
DL_STOPCURSOR   equ 1
DL_COPYCURSOR   equ 2
DL_MOVECURSOR   equ 3

UD_MAXVAL       equ 7FFFh
UD_MINVAL       equ <- UD_MAXVAL>
UDS_WRAP        equ 0001h
UDS_SETBUDDYINT equ 0002h
UDS_ALIGNRIGHT  equ 0004h
UDS_ALIGNLEFT   equ 0008h
UDS_AUTOBUDDY   equ 0010h
UDS_ARROWKEYS   equ 0020h
UDS_HORZ        equ 0040h
UDS_NOTHOUSANDS equ 0080h

UDM_SETRANGE    equ <WM_USER+101>
UDM_GETRANGE    equ <WM_USER+102>
UDM_SETPOS      equ <WM_USER+103>
UDM_GETPOS      equ <WM_USER+104>
UDM_SETBUDDY    equ <WM_USER+105>
UDM_GETBUDDY    equ <WM_USER+106>
UDM_SETACCEL    equ <WM_USER+107>
UDM_GETACCEL    equ <WM_USER+108>
UDM_SETBASE     equ <WM_USER+109>
UDM_GETBASE     equ <WM_USER+110>
UDN_DELTAPOS    equ <UDN_FIRST - 1>
PBM_SETRANGE    equ <WM_USER+1>
PBM_SETPOS      equ <WM_USER+2>
PBM_DELTAPOS    equ <WM_USER+3>
PBM_SETSTEP     equ <WM_USER+4>
PBM_STEPIT      equ <WM_USER+5>

HKCOMB_NONE     equ 0001h
HKCOMB_S        equ 0002h
HKCOMB_C        equ 0004h
HKCOMB_A        equ 0008h
HKCOMB_SC       equ 0010h
HKCOMB_SA       equ 0020h
HKCOMB_CA       equ 0040h
HKCOMB_SCA      equ 0080h
HKM_SETHOTKEY   equ <WM_USER+1>
HKM_GETHOTKEY   equ <WM_USER+2>
HKM_SETRULES    equ <WM_USER+3>
LVS_ICON        equ 0000h
LVS_REPORT      equ 0001h
LVS_SMALLICON   equ 0002h
LVS_LIST        equ 0003h
LVS_TYPEMASK    equ 0003h
LVS_SINGLESEL   equ 0004h
LVS_SHOWSELALWAYS               equ 0008h
LVS_SORTASCENDING               equ 0010h
LVS_SORTDESCENDING              equ 0020h
LVS_SHAREIMAGELISTS             equ 0040h
LVS_NOLABELWRAP equ 0080h
LVS_AUTOARRANGE equ 0100h
LVS_EDITLABELS  equ 0200h
LVS_NOSCROLL    equ 2000h
LVS_TYPESTYLEMASK               equ 0fc00h
LVS_ALIGNTOP    equ 0000h
LVS_ALIGNLEFT   equ 0800h
LVS_ALIGNMASK   equ 0c00h
LVS_OWNERDRAWFIXED              equ 0400h
LVS_NOCOLUMNHEADER              equ 4000h
LVS_NOSORTHEADER                equ 8000h
LVM_GETBKCOLOR  equ <LVM_FIRST + 0>
LVM_SETBKCOLOR  equ <LVM_FIRST + 1>
LVM_GETIMAGELIST                equ <LVM_FIRST + 2>
LVM_GETSUBITEMRECT           equ <LVM_FIRST + 56>
LVM_SUBITEMHITTEST              equ <LVM_FIRST + 57>
LVSIL_NORMAL    equ 0
LVSIL_SMALL     equ 1
LVSIL_STATE     equ 2
LVM_SETIMAGELIST                equ <LVM_FIRST + 3>
LVM_GETITEMCOUNT                equ <LVM_FIRST + 4>
LVIF_TEXT       equ 0001h
LVIF_IMAGE      equ 0002h
LVIF_PARAM      equ 0004h
LVIF_STATE      equ 0008h
LVIS_FOCUSED    equ 0001h
LVIS_SELECTED   equ 0002h
LVIS_CUT        equ 0004h
LVIS_DROPHILITED                equ 0008h
LVIS_OVERLAYMASK                equ 0F00h
LVIS_STATEIMAGEMASK             equ 0F000h

LPSTR_TEXTCALLBACKW             equ -1
LPSTR_TEXTCALLBACKA             equ -1
ifndef @unicode
  LPSTR_TEXTCALLBACK            equ LPSTR_TEXTCALLBACKA
else
  LPSTR_TEXTCALLBACK            equ LPSTR_TEXTCALLBACKW
endif

I_IMAGECALLBACK                 equ -1

LVM_GETITEMA                    equ <LVM_FIRST + 5>
LVM_GETITEMW                    equ <LVM_FIRST + 75>
LVM_SETITEMA                    equ <LVM_FIRST + 6>
LVM_SETITEMW                    equ <LVM_FIRST + 76>
LVM_INSERTITEMA                 equ <LVM_FIRST + 7>
LVM_INSERTITEMW                 equ <LVM_FIRST + 77>
LVM_DELETEITEM                  equ <LVM_FIRST + 8>
LVM_DELETEALLITEMS              equ <LVM_FIRST + 9>
LVM_GETCALLBACKMASK             equ <LVM_FIRST + 10>
LVM_SETCALLBACKMASK             equ <LVM_FIRST + 11>
ifndef @unicode
  LVM_GETITEM                   equ LVM_GETITEMA
  LVM_SETITEM                   equ LVM_SETITEMA
  LVM_INSERTITEM                equ LVM_INSERTITEMA
else
  LVM_GETITEM                   equ LVM_GETITEMW
  LVM_SETITEM                   equ LVM_SETITEMW
  LVM_INSERTITEM                equ LVM_INSERTITEMW
endif


LVNI_ALL        equ 0000h
LVNI_FOCUSED    equ 0001h
LVNI_SELECTED   equ 0002h
LVNI_CUT        equ 0004h
LVNI_DROPHILITED                equ 0008h
LVNI_ABOVE      equ 0100h
LVNI_BELOW      equ 0200h
LVNI_TOLEFT     equ 0400h
LVNI_TORIGHT    equ 0800h
LVFI_PARAM      equ 0001h
LVFI_STRING     equ 0002h
LVFI_PARTIAL    equ 0008h
LVFI_WRAP       equ 0020h
LVFI_NEARESTXY  equ 0040h
LVIR_BOUNDS     equ 0
LVIR_ICON       equ 1
LVIR_LABEL      equ 2
LVIR_SELECTBOUNDS               equ 3
LVHT_NOWHERE    equ 0001h
LVHT_ONITEMICON equ 0002h
LVHT_ONITEMLABEL                equ 0004h
LVHT_ONITEMSTATEICON            equ 0008h
LVHT_ONITEM     equ <LVHT_ONITEMICON OR LVHT_ONITEMLABEL OR LVHT_ONITEMSTATEICON>
LVHT_ABOVE      equ 0008h
LVHT_BELOW      equ 0010h
LVHT_TORIGHT    equ 0020h
LVHT_TOLEFT     equ 0040h
LVA_DEFAULT     equ 0000h
LVA_ALIGNLEFT   equ 0001h
LVA_ALIGNTOP    equ 0002h
LVA_SNAPTOGRID  equ 0005h
LVCF_FMT        equ 0001h
LVCF_WIDTH      equ 0002h
LVCF_TEXT       equ 0004h
LVCF_SUBITEM    equ 0008h
LVCFMT_LEFT     equ 0000h
LVCFMT_RIGHT    equ 0001h
LVCFMT_CENTER   equ 0002h
LVCFMT_JUSTIFYMASK              equ 0003h

LVM_FINDITEMA   equ <LVM_FIRST + 13>
LVM_FINDITEMW   equ <LVM_FIRST + 83>
LVM_GETNEXTITEM equ <LVM_FIRST + 12>
LVM_GETITEMRECT equ <LVM_FIRST + 14>
LVM_SETITEMPOSITION             equ <LVM_FIRST + 15>
LVM_GETITEMPOSITION             equ <LVM_FIRST + 16>
LVM_GETSTRINGWIDTHA             equ <LVM_FIRST + 17>
LVM_GETSTRINGWIDTHW             equ <LVM_FIRST + 87>
LVM_HITTEST     equ <LVM_FIRST + 18>
LVM_ENSUREVISIBLE equ <LVM_FIRST + 19>
LVM_SCROLL      equ <LVM_FIRST + 20>
LVM_REDRAWITEMS equ <LVM_FIRST + 21>
LVM_ARRANGE     equ <LVM_FIRST + 22>
LVM_EDITLABELA  equ <LVM_FIRST + 23>
LVM_EDITLABELW  equ <LVM_FIRST + 118>
LVM_GETEDITCONTROL equ <LVM_FIRST + 24>
LVM_GETCOLUMNA  equ <LVM_FIRST + 25>
LVM_GETCOLUMNW  equ <LVM_FIRST + 95>
LVM_SETCOLUMNA  equ <LVM_FIRST + 26>
LVM_SETCOLUMNW  equ <LVM_FIRST + 96>
LVM_INSERTCOLUMNA               equ <LVM_FIRST + 27>
LVM_INSERTCOLUMNW               equ <LVM_FIRST + 97>
LVM_DELETECOLUMN                equ <LVM_FIRST + 28>
LVM_GETCOLUMNWIDTH              equ <LVM_FIRST + 29>
LVSCW_AUTOSIZE      equ -1
LVSCW_AUTOSIZE_USEHEADER            equ -2
LVM_SETCOLUMNWIDTH  equ <LVM_FIRST + 30>
LVM_CREATEDRAGIMAGE             equ <LVM_FIRST + 33>
LVM_GETVIEWRECT equ <LVM_FIRST + 34>
LVM_GETTEXTCOLOR                equ <LVM_FIRST + 35>
LVM_SETTEXTCOLOR                equ <LVM_FIRST + 36>
LVM_GETTEXTBKCOLOR              equ <LVM_FIRST + 37>
LVM_SETTEXTBKCOLOR              equ <LVM_FIRST + 38>
LVM_GETTOPINDEX equ <LVM_FIRST + 39>
LVM_GETCOUNTPERPAGE             equ <LVM_FIRST + 40>
LVM_GETORIGIN   equ <LVM_FIRST + 41>
LVM_UPDATE      equ <LVM_FIRST + 42>
LVM_SETITEMSTATE                equ <LVM_FIRST + 43>
LVM_GETITEMSTATE                equ <LVM_FIRST + 44>
LVM_GETITEMTEXTA equ <LVM_FIRST + 45>
LVM_GETITEMTEXTW                equ <LVM_FIRST + 115>
LVM_SETITEMTEXTA equ <LVM_FIRST + 46>
LVM_SETITEMTEXTW                equ <LVM_FIRST + 116>
LVM_SETITEMCOUNT                equ <LVM_FIRST + 47>
LVM_SORTITEMS   equ <LVM_FIRST + 48>
LVM_SETITEMPOSITION32           equ <LVM_FIRST + 49>
LVM_GETSELECTEDCOUNT            equ <LVM_FIRST + 50>
LVM_GETITEMSPACING              equ <LVM_FIRST + 51>
LVM_GETISEARCHSTRINGA           equ <LVM_FIRST + 52>
LVM_GETISEARCHSTRINGW           equ <LVM_FIRST + 117>
LVM_SETEXTENDEDLISTVIEWSTYLE    EQU LVM_FIRST + 54
LVM_GETEXTENDEDLISTVIEWSTYLE    EQU LVM_FIRST + 55
ifndef @unicode
  LVM_FINDITEM                  equ LVM_FINDITEMA
  LVM_GETSTRINGWIDTH            equ LVM_GETSTRINGWIDTHA
  LVM_EDITLABEL                 equ LVM_EDITLABELA
  LVM_GETCOLUMN                 equ LVM_GETCOLUMNA
  LVM_SETCOLUMN                 equ LVM_SETCOLUMNA
  LVM_INSERTCOLUMN              equ LVM_INSERTCOLUMNA
  LVM_GETITEMTEXT               equ LVM_GETITEMTEXTA
  LVM_SETITEMTEXT               equ LVM_SETITEMTEXTA
  LVM_GETISEARCHSTRING          equ LVM_GETISEARCHSTRINGA
else
  LVM_FINDITEM                  equ LVM_FINDITEMW
  LVM_GETSTRINGWIDTH            equ LVM_GETSTRINGWIDTHW
  LVM_EDITLABEL                 equ LVM_EDITLABELW
  LVM_GETCOLUMN                 equ LVM_GETCOLUMNW
  LVM_SETCOLUMN                 equ LVM_SETCOLUMNW
  LVM_INSERTCOLUMN              equ LVM_INSERTCOLUMNW
  LVM_GETITEMTEXT               equ LVM_GETITEMTEXTW
  LVM_SETITEMTEXT               equ LVM_SETITEMTEXTW
  LVM_GETISEARCHSTRING          equ LVM_GETISEARCHSTRINGW
endif

LVN_ITEMCHANGING                equ <LVN_FIRST-0>
LVN_ITEMCHANGED                 equ <LVN_FIRST-1>
LVN_INSERTITEM                  equ <LVN_FIRST-2>
LVN_DELETEITEM                  equ <LVN_FIRST-3>
LVN_DELETEALLITEMS              equ <LVN_FIRST-4>
LVN_BEGINLABELEDITA             equ <LVN_FIRST-5>
LVN_BEGINLABELEDITW             equ <LVN_FIRST-75>
LVN_ENDLABELEDITA               equ <LVN_FIRST-6>
LVN_ENDLABELEDITW               equ <LVN_FIRST-76>
LVN_COLUMNCLICK                 equ <LVN_FIRST-8>
LVN_BEGINDRAG                   equ <LVN_FIRST-9>
LVN_BEGINRDRAG                  equ <LVN_FIRST-11>
LVN_GETDISPINFOA                equ <LVN_FIRST-50>
LVN_GETDISPINFOW                equ <LVN_FIRST-77>
LVN_SETDISPINFOA                equ <LVN_FIRST-51>
LVN_SETDISPINFOW                equ <LVN_FIRST-78>
ifndef @unicode
  LVN_BEGINLABELEDIT            equ LVN_BEGINLABELEDITA
  LVN_ENDLABELEDIT              equ LVN_ENDLABELEDITA
  LVN_GETDISPINFO               equ LVN_GETDISPINFOA
  LVN_SETDISPINFO               equ LVN_SETDISPINFOA
else
  LVN_BEGINLABELEDIT            equ LVN_BEGINLABELEDITW
  LVN_ENDLABELEDIT              equ LVN_ENDLABELEDITW
  LVN_GETDISPINFO               equ LVN_GETDISPINFOW
  LVN_SETDISPINFO               equ LVN_SETDISPINFOW
endif



LVIF_DI_SETITEM equ 1000h
LVN_KEYDOWN     equ <LVN_FIRST-55>
TVS_HASBUTTONS  equ 0001h
TVS_HASLINES    equ 0002h
TVS_LINESATROOT equ 0004h
TVS_EDITLABELS  equ 0008h
TVS_DISABLEDRAGDROP             equ 0010h
TVS_SHOWSELALWAYS               equ 0020h
TVIF_TEXT       equ 0001h
TVIF_IMAGE      equ 0002h
TVIF_PARAM      equ 0004h
TVIF_STATE      equ 0008h
TVIF_HANDLE     equ 0010h
TVIF_SELECTEDIMAGE              equ 0020h
TVIF_CHILDREN   equ 0040h
TVIS_FOCUSED    equ 0001h
TVIS_SELECTED   equ 0002h
TVIS_CUT        equ 0004h
TVIS_DROPHILITED                equ 0008h
TVIS_BOLD       equ 0010h
TVIS_EXPANDED   equ 0020h
TVIS_EXPANDEDONCE               equ 0040h
TVIS_OVERLAYMASK                equ 0F00h
TVIS_STATEIMAGEMASK             equ 0F000h
TVIS_USERMASK   equ 0F000h
I_CHILDRENCALLBACK              equ -1
TVI_ROOT        equ 0FFFF0000h
TVI_FIRST       equ 0FFFF0001h
TVI_LAST        equ 0FFFF0002h
TVI_SORT        equ 0FFFF0003h
TVGN_ROOT       equ 0000h
TVGN_NEXT       equ 0001h
TVGN_PREVIOUS   equ 0002h
TVGN_PARENT     equ 0003h
TVGN_CHILD      equ 0004h
TVGN_FIRSTVISIBLE               equ 0005h
TVGN_NEXTVISIBLE                equ 0006h
TVGN_PREVIOUSVISIBLE            equ 0007h
TVGN_DROPHILITE equ 0008h
TVGN_CARET      equ 0009h
TVM_INSERTITEMA equ <TV_FIRST + 0>
TVM_INSERTITEMW equ <TV_FIRST + 50>
TVM_DELETEITEM  equ <TV_FIRST + 1>
TVM_EXPAND      equ <TV_FIRST + 2>
TVE_COLLAPSE    equ 0001h
TVE_EXPAND      equ 0002h
TVE_TOGGLE      equ 0003h
TVE_COLLAPSERESET               equ 8000h
TVM_GETITEMRECT equ <TV_FIRST + 4>
TVM_GETCOUNT    equ <TV_FIRST + 5>
TVM_GETINDENT   equ <TV_FIRST + 6>
TVM_SETINDENT   equ <TV_FIRST + 7>
TVM_GETIMAGELIST                equ <TV_FIRST + 8>
TVSIL_NORMAL    equ 0
TVSIL_STATE     equ 2
TVM_SETIMAGELIST                equ <TV_FIRST + 9>
TVM_GETNEXTITEM equ <TV_FIRST + 10>
TVM_SELECTITEM  equ <TV_FIRST + 11>
TVM_GETITEMA    equ <TV_FIRST + 12>
TVM_GETITEMW    equ <TV_FIRST + 62>
TVM_SETITEMA    equ <TV_FIRST + 13>
TVM_SETITEMW    equ <TV_FIRST + 63>
TVM_EDITLABELA  equ <TV_FIRST + 14>
TVM_EDITLABELW  equ <TV_FIRST + 65>
ifdef @unicode
  TVM_INSERTITEM equ TVM_INSERTITEMW
  TVM_GETITEM    equ TVM_GETITEMW
  TVM_SETITEM    equ TVM_SETITEMW
  TVM_EDITLABEL  equ TVM_EDITLABELW
else
  TVM_INSERTITEM equ TVM_INSERTITEMA
  TVM_GETITEM    equ TVM_GETITEMA
  TVM_SETITEM    equ TVM_SETITEMA
  TVM_EDITLABEL  equ TVM_EDITLABELA
endif



TVM_GETEDITCONTROL              equ <TV_FIRST + 15>
TVM_GETVISIBLECOUNT             equ <TV_FIRST + 16>
TVM_HITTEST     equ <TV_FIRST + 17>
TVHT_NOWHERE    equ 0001h
TVHT_ONITEMICON equ 0002h
TVHT_ONITEMLABEL                equ 0004h
TVHT_ONITEMSTATEICON            equ 0040h
TVHT_ONITEM     equ <TVHT_ONITEMICON OR TVHT_ONITEMLABEL OR TVHT_ONITEMSTATEICON>
TVHT_ONITEMINDENT               equ 0008h
TVHT_ONITEMBUTTON               equ 0010h
TVHT_ONITEMRIGHT                equ 0020h
TVHT_ABOVE      equ 0100h
TVHT_BELOW      equ 0200h
TVHT_TORIGHT    equ 0400h
TVHT_TOLEFT     equ 0800h
TVM_CREATEDRAGIMAGE             equ <TV_FIRST + 18>
TVM_SORTCHILDREN                equ <TV_FIRST + 19>
TVM_ENSUREVISIBLE               equ <TV_FIRST + 20>
TVM_SORTCHILDRENCB              equ <TV_FIRST + 21>
TVM_GETISEARCHSTRING            equ <TV_FIRST + 23>
TVN_SELCHANGING                 equ <TVN_FIRST-1>
TVN_SELCHANGED equ <TVN_FIRST-2>

; if IE version >= 0x400
TVM_SETITEMHEIGHT               equ <TV_FIRST + 27>
TVM_GETITEMHEIGHT               equ <TV_FIRST + 28>
TVM_SETBKCOLOR                  equ <TV_FIRST + 29>
TVM_SETTEXTCOLOR                equ <TV_FIRST + 30>
TVM_GETBKCOLOR                  equ <TV_FIRST + 31>
TVM_GETTEXTCOLOR                equ <TV_FIRST + 32>
TVM_SETSCROLLTIME               equ <TV_FIRST + 33>
TVM_GETSCROLLTIME               equ <TV_FIRST + 34>
TVM_SETINSERTMARKCOLOR          equ <TV_FIRST + 37>
TVM_GETINSERTMARKCOLOR          equ <TV_FIRST + 38>
; endif


TVC_UNKNOWN     equ 0000h
TVC_BYMOUSE     equ 0001h
TVC_BYKEYBOARD  equ 0002h
TVN_GETDISPINFO                equ <TVN_FIRST-3>
TVN_SETDISPINFO                equ <TVN_FIRST-4>
TVIF_DI_SETITEM equ 1000h
TVN_ITEMEXPANDING               equ <TVN_FIRST-5>
TVN_ITEMEXPANDED                equ <TVN_FIRST-6>
TVN_BEGINDRAG   equ <TVN_FIRST-7>
TVN_BEGINRDRAG  equ <TVN_FIRST-8>
TVN_DELETEITEM  equ <TVN_FIRST-9>
TVN_BEGINLABELEDIT              equ <TVN_FIRST-10>
TVN_ENDLABELEDIT                equ <TVN_FIRST-11>
TVN_KEYDOWN     equ <TVN_FIRST-12>
TCS_FORCEICONLEFT                equ 0010h
TCS_FORCELABELLEFT               equ 0020h
TCS_TABS         equ 0000h
TCS_BUTTONS      equ 0100h
TCS_SINGLELINE   equ 0000h
TCS_MULTILINE    equ 0200h
TCS_RIGHTJUSTIFY equ 0000h
TCS_FIXEDWIDTH   equ 0400h
TCS_RAGGEDRIGHT  equ 0800h
TCS_FOCUSONBUTTONDOWN            equ 1000h
TCS_OWNERDRAWFIXED               equ 2000h
TCS_TOOLTIPS     equ 4000h
TCS_FOCUSNEVER   equ 8000h
TCM_FIRST        equ 1300h
TCM_GETIMAGELIST equ <TCM_FIRST + 2>
TCM_SETIMAGELIST equ <TCM_FIRST + 3>
TCM_GETITEMCOUNT equ <TCM_FIRST + 4>
TCIF_TEXT        equ 0001h
TCIF_IMAGE       equ 0002h
TCIF_RTLREADING  equ 0004h
TCIF_PARAM       equ 0008h
TCM_GETITEM      equ <TCM_FIRST + 5>

TCM_SETITEMA     equ <TCM_FIRST + 6>
TCM_SETITEMW     equ <TCM_FIRST + 61>
TCM_INSERTITEMA  equ <TCM_FIRST + 7>
TCM_INSERTITEMW  equ <TCM_FIRST + 62>
TCM_DELETEITEM   equ <TCM_FIRST + 8>
TCM_DELETEALLITEMS equ <TCM_FIRST + 9>
TCM_GETITEMRECT  equ <TCM_FIRST + 10>
TCM_GETCURSEL    equ <TCM_FIRST + 11>
TCM_SETCURSEL    equ <TCM_FIRST + 12>
TCHT_NOWHERE     equ 0001h
TCHT_ONITEMICON  equ 0002h
TCHT_ONITEMLABEL equ 0004h
TCHT_ONITEM      equ <TCHT_ONITEMICON OR TCHT_ONITEMLABEL>
TCM_HITTEST      equ <TCM_FIRST + 13>
TCM_SETITEMEXTRA equ <TCM_FIRST + 14>
TCM_ADJUSTRECT   equ <TCM_FIRST + 40>
TCM_SETITEMSIZE  equ <TCM_FIRST + 41>
TCM_REMOVEIMAGE  equ <TCM_FIRST + 42>
TCM_SETPADDING   equ <TCM_FIRST + 43>
TCM_GETROWCOUNT  equ <TCM_FIRST + 44>
TCM_GETTOOLTIPS  equ <TCM_FIRST + 45>
TCM_SETTOOLTIPS  equ <TCM_FIRST + 46>
TCM_GETCURFOCUS  equ <TCM_FIRST + 47>
TCM_SETCURFOCUS  equ <TCM_FIRST + 48>
ifndef @unicode
  TCM_SETITEM    equ TCM_SETITEMA
  TCM_INSERTITEM equ TCM_INSERTITEMA
else
  TCM_SETITEM    equ TCM_SETITEMW
  TCM_INSERTITEM equ TCM_INSERTITEMW
endif


TCN_KEYDOWN      equ <TCN_FIRST - 0>
TCN_SELCHANGE    equ <TCN_FIRST - 1>
TCN_SELCHANGING  equ <TCN_FIRST - 2>

ACS_CENTER      equ 0001h
ACS_TRANSPARENT equ 0002h
ACS_AUTOPLAY    equ 0004h

ACM_OPENA       equ <WM_USER+100>
ACM_OPENW       equ <WM_USER+103>
ifndef @unicode
  ACM_OPEN      equ ACM_OPENA
else
  ACM_OPEN      equ ACM_OPENW
endif

ACM_PLAY        equ <WM_USER+101>
ACM_STOP        equ <WM_USER+102>
ACN_START       equ 1
ACN_STOP        equ 2

FXPT2DOT30      equ  <DWORD>
LCSCSTYPE       equ  <DWORD>
LCSGAMUTMATCH   equ  <DWORD>
MMVERSION       equ  <DWORD>
MAX_JOYSTICKOEMVXDNAME equ 260
FOURCC          equ  <DWORD>
SECURITY_CONTEXT_TRACKING_MODE  equ  <BOOLEAN>

EVENT_MODIFY_STATE      equ 2


DTM_FIRST                       equ 1000h
DTM_SETFORMAT                   equ DTM_FIRST + 5
DTM_SETSYSTEMTIME               equ DTM_FIRST + 2
DTM_GETSYSTEMTIME               equ DTM_FIRST + 1

