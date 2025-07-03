ifndef @unicode
         CreateStdAccessibleProxy   equ <CreateStdAccessibleProxyA>
         GetRoleText                equ <GetRoleTextA>
         GetStateText               equ <GetStateTextA>
    else
         CreateStdAccessibleProxy   equ <CreateStdAccessibleProxyW>
         GetRoleText                equ <GetRoleTextW>
         GetStateText               equ <GetStateTextW>
endif ; @unicode

procdesc AccessibleChildren         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AccessibleObjectFromEvent  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AccessibleObjectFromPoint  :DWORD,:DWORD,:DWORD,:DWORD
procdesc AccessibleObjectFromWindow :DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateStdAccessibleObject  :DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateStdAccessibleProxyA  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateStdAccessibleProxyW  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetOleaccVersionInfo       :DWORD,:DWORD
procdesc GetRoleTextA               :DWORD,:DWORD,:DWORD
procdesc GetRoleTextW               :DWORD,:DWORD,:DWORD
procdesc GetStateTextA              :DWORD,:DWORD,:DWORD
procdesc GetStateTextW              :DWORD,:DWORD,:DWORD
procdesc LresultFromObject          :DWORD,:DWORD,:DWORD
procdesc ObjectFromLresult          :DWORD,:DWORD,:DWORD,:DWORD
procdesc WindowFromAccessibleObject :DWORD,:DWORD
