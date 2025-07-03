ifndef @unicode
         CreateActivityInMT                equ <CreateActivityInMTA>
    else
         CreateActivityInMT                equ <CreateActivityInMTW>
endif ; @unicode

procdesc CoCreateInstanceWithClassInfo     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoCreateStdTrustable              :DWORD,:DWORD,:DWORD
procdesc CoLoadServices                    :DWORD,:DWORD,:DWORD,:DWORD
procdesc CoVerifyTrust                     :DWORD,:DWORD,:DWORD
procdesc ComSvcsExceptionFilter            :DWORD,:DWORD,:DWORD
procdesc ComSvcsLogError                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateActivityInMTW               :DWORD,:DWORD
procdesc CreateActivityInMTA               :DWORD,:DWORD
procdesc DllUnregisterServerWeReallyMeanIt 
procdesc MTSCreateActivity                 :DWORD,:DWORD
