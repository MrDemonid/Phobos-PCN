ifndef @unicode
         HtmlHelp  equ <HtmlHelpA>
    else
         HtmlHelp  equ <HtmlHelpW>
endif ; @unicode

procdesc HtmlHelpA :DWORD,:DWORD,:DWORD,:DWORD
procdesc HtmlHelpW :DWORD,:DWORD,:DWORD,:DWORD
