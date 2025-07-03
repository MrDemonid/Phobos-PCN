ifndef @unicode
    else
endif ; @unicode

procdesc SfcClose                  :DWORD
procdesc SfcConnectToServer        :DWORD
procdesc SfcFileException          :DWORD,:DWORD,:DWORD
procdesc SfcGetNextProtectedFile   :DWORD,:DWORD
procdesc SfcInitProt               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SfcInitiateScan           :DWORD,:DWORD
procdesc SfcInstallProtectedFiles  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SfcIsFileProtected        :DWORD,:DWORD
procdesc SfcTerminateWatcherThread 
procdesc SfcWLEventLogoff          :DWORD
procdesc SfcWLEventLogon           :DWORD
procdesc SfpDeleteCatalog          :DWORD,:DWORD
procdesc SfpInstallCatalog         :DWORD,:DWORD,:DWORD
procdesc SfpVerifyFile             :DWORD,:DWORD,:DWORD
