ifndef @unicode
         MIMEAssociationDialog  equ <MIMEAssociationDialogA>
         TranslateURL           equ <TranslateURLA>
         URLAssociationDialog   equ <URLAssociationDialogA>
    else
         MIMEAssociationDialog  equ <MIMEAssociationDialogW>
         TranslateURL           equ <TranslateURLW>
         URLAssociationDialog   equ <URLAssociationDialogW>
endif ; @unicode

procdesc AddMIMEFileTypesPS     :DWORD,:DWORD
procdesc InetIsOffline          :DWORD
procdesc MIMEAssociationDialogA :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc MIMEAssociationDialogW :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SetInetOffline         :DWORD
procdesc TranslateURLA          :DWORD,:DWORD,:DWORD
procdesc TranslateURLW          :DWORD,:DWORD,:DWORD
procdesc URLAssociationDialogA  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc URLAssociationDialogW  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
