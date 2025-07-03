ifndef @unicode
         SHGetFolderPath  equ <SHGetFolderPathA>
    else
         SHGetFolderPath  equ <SHGetFolderPathW>
endif ; @unicode

procdesc SHGetFolderPathA :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHGetFolderPathW :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
