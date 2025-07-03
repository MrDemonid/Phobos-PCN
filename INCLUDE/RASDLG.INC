ifndef @unicode
         RasAutodialDisableDlg        equ <RasAutodialDisableDlgA>
         RasAutodialQueryDlg          equ <RasAutodialQueryDlgA>
         RasDialDlg                   equ <RasDialDlgA>
         RasEntryDlg                  equ <RasEntryDlgA>
         RasMonitorDlg                equ <RasMonitorDlgA>
         RasPhonebookDlg              equ <RasPhonebookDlgA>
         RouterEntryDlg               equ <RouterEntryDlgA>
    else
         RasAutodialDisableDlg        equ <RasAutodialDisableDlgW>
         RasAutodialQueryDlg          equ <RasAutodialQueryDlgW>
         RasDialDlg                   equ <RasDialDlgW>
         RasEntryDlg                  equ <RasEntryDlgW>
         RasMonitorDlg                equ <RasMonitorDlgW>
         RasPhonebookDlg              equ <RasPhonebookDlgW>
         RouterEntryDlg               equ <RouterEntryDlgW>
endif ; @unicode

procdesc GetRasDialOutProtocols       
procdesc RasAutodialDisableDlgW       :DWORD
procdesc RasAutodialDisableDlgA       :DWORD
procdesc RasAutodialQueryDlgW         :DWORD,:DWORD,:DWORD
procdesc RasAutodialQueryDlgA         :DWORD,:DWORD,:DWORD
procdesc RasDialDlgA                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc RasDialDlgW                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc RasEntryDlgA                 :DWORD,:DWORD,:DWORD
procdesc RasEntryDlgW                 :DWORD,:DWORD,:DWORD
procdesc RasMonitorDlgA               :DWORD,:DWORD
procdesc RasMonitorDlgW               :DWORD,:DWORD
procdesc RasPhonebookDlgA             :DWORD,:DWORD,:DWORD
procdesc RasPhonebookDlgW             :DWORD,:DWORD,:DWORD
procdesc RasSharedAccessSettingsDlg   :DWORD,:DWORD
procdesc RasSrvAddPropPages           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc RasSrvAddWizPages            :DWORD,:DWORD,:DWORD
procdesc RasSrvAllowConnectionsConfig :DWORD
procdesc RasSrvCleanupService         
procdesc RasSrvEnumConnections        :DWORD,:DWORD,:DWORD
procdesc RasSrvHangupConnection       :DWORD
procdesc RasSrvInitializeService      
procdesc RasSrvIsConnectionConnected  :DWORD,:DWORD
procdesc RasSrvIsServiceRunning       :DWORD
procdesc RasSrvQueryShowIcon          :DWORD
procdesc RasUserEnableManualDial      :DWORD,:DWORD,:DWORD
procdesc RasUserGetManualDial         :DWORD,:DWORD,:DWORD
procdesc RasUserPrefsDlg              :DWORD
procdesc RasWizCreateNewEntry         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc RasWizGetSuggestedEntryName  :DWORD,:DWORD,:DWORD
procdesc RasWizIsEntryRenamable       :DWORD,:DWORD,:DWORD
procdesc RasWizQueryMaxPageCount      :DWORD
procdesc RasWizSetEntryName           :DWORD,:DWORD,:DWORD
procdesc RouterEntryDlgA              :DWORD,:DWORD,:DWORD,:DWORD
procdesc RouterEntryDlgW              :DWORD,:DWORD,:DWORD,:DWORD
