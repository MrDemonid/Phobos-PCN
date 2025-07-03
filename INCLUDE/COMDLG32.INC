include 'windef.inc'
include 'comdlg32.ash'

ifndef @unicode
         ChooseColor                       equ <ChooseColorA>
         ChooseFont                        equ <ChooseFontA>
         FindText                          equ <FindTextA>
         GetFileTitle                      equ <GetFileTitleA>
         GetOpenFileName                   equ <GetOpenFileNameA>
         GetSaveFileName                   equ <GetSaveFileNameA>
         PageSetupDlg                      equ <PageSetupDlgA>
         PrintDlg                          equ <PrintDlgA>
         PrintDlgEx                        equ <PrintDlgExA>
         ReplaceText                       equ <ReplaceTextA>
    else
         ChooseColor                       equ <ChooseColorW>
         ChooseFont                        equ <ChooseFontW>
         FindText                          equ <FindTextW>
         GetFileTitle                      equ <GetFileTitleW>
         GetOpenFileName                   equ <GetOpenFileNameW>
         GetSaveFileName                   equ <GetSaveFileNameW>
         PageSetupDlg                      equ <PageSetupDlgW>
         PrintDlg                          equ <PrintDlgW>
         PrintDlgEx                        equ <PrintDlgExW>
         ReplaceText                       equ <ReplaceTextW>
endif ; @unicode

procdesc ChooseColorA                      :DWORD
procdesc ChooseColorW                      :DWORD
procdesc ChooseFontA                       :DWORD
procdesc ChooseFontW                       :DWORD
procdesc CommDlgExtendedError
procdesc FindTextA                         :DWORD
procdesc FindTextW                         :DWORD
procdesc FormatCharDlgProc                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc GetFileTitleA                     :DWORD,:DWORD,:DWORD
procdesc GetFileTitleW                     :DWORD,:DWORD,:DWORD
procdesc GetOpenFileNameA                  :DWORD
procdesc GetOpenFileNameW                  :DWORD
procdesc GetSaveFileNameA                  :DWORD
procdesc GetSaveFileNameW                  :DWORD
procdesc LoadAlterBitmap                   :DWORD,:DWORD,:DWORD
procdesc PageSetupDlgA                     :DWORD
procdesc PageSetupDlgW                     :DWORD
procdesc PrintDlgA                         :DWORD
procdesc PrintDlgExA                       :DWORD
procdesc PrintDlgExW                       :DWORD
procdesc PrintDlgW                         :DWORD
procdesc ReplaceTextA                      :DWORD
procdesc ReplaceTextW                      :DWORD
procdesc Ssync_ANSI_UNICODE_Struct_For_WOW :DWORD,:DWORD,:DWORD
procdesc WantArrows                        :DWORD,:DWORD,:DWORD,:DWORD
procdesc dwLBSubclass                      :DWORD,:DWORD,:DWORD,:DWORD
procdesc dwOKSubclass                      :DWORD,:DWORD,:DWORD,:DWORD
