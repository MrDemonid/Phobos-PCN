include 'windef.inc'
include 'comctl32.ash'

procdesc InitCommonControls     WINAPI
procdesc InitCommonControlsEx   WINAPI  :DWORD
procdesc ImageList_Create       WINAPI  :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
procdesc ImageList_Add          WINAPI  :DWORD, :DWORD, :DWORD
procdesc ImageList_Destroy      WINAPI  :DWORD
procdesc ImageList_AddMasked    WINAPI  :DWORD, :DWORD, :DWORD
procdesc ImageList_GetImageInfo WINAPI  :DWORD, :DWORD, :DWORD
procdesc ImageList_GetIcon      WINAPI  :DWORD, :DWORD, :DWORD
procdesc ImageList_LoadImage    WINAPI  :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
procdesc ImageList_Remove       WINAPI  :DWORD, :DWORD
procdesc ImageList_Draw         WINAPI  :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
procdesc ImageList_DrawEx       WINAPI  :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
procdesc ImageList_Replace      WINAPI  :DWORD, :DWORD, :DWORD, :DWORD



