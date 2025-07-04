ifndef @unicode
         PlaySound                    equ <PlaySoundA>
         auxGetDevCaps                equ <auxGetDevCapsA>
         joyGetDevCaps                equ <joyGetDevCapsA>
         mciGetDeviceID               equ <mciGetDeviceIDA>
         mciGetDeviceIDFromElementID  equ <mciGetDeviceIDFromElementIDA>
         mciGetErrorString            equ <mciGetErrorStringA>
         mciSendCommand               equ <mciSendCommandA>
         mciSendString                equ <mciSendStringA>
         midiInGetDevCaps             equ <midiInGetDevCapsA>
         midiInGetErrorText           equ <midiInGetErrorTextA>
         midiOutGetDevCaps            equ <midiOutGetDevCapsA>
         midiOutGetErrorText          equ <midiOutGetErrorTextA>
         mixerGetControlDetails       equ <mixerGetControlDetailsA>
         mixerGetDevCaps              equ <mixerGetDevCapsA>
         mixerGetLineControls         equ <mixerGetLineControlsA>
         mixerGetLineInfo             equ <mixerGetLineInfoA>
         mmioInstallIOProc            equ <mmioInstallIOProcA>
         mmioOpen                     equ <mmioOpenA>
         mmioRename                   equ <mmioRenameA>
         mmioStringToFOURCC           equ <mmioStringToFOURCCA>
         sndPlaySound                 equ <sndPlaySoundA>
         waveInGetDevCaps             equ <waveInGetDevCapsA>
         waveInGetErrorText           equ <waveInGetErrorTextA>
         waveOutGetDevCaps            equ <waveOutGetDevCapsA>
         waveOutGetErrorText          equ <waveOutGetErrorTextA>
    else
         PlaySound                    equ <PlaySoundW>
         auxGetDevCaps                equ <auxGetDevCapsW>
         joyGetDevCaps                equ <joyGetDevCapsW>
         mciGetDeviceID               equ <mciGetDeviceIDW>
         mciGetDeviceIDFromElementID  equ <mciGetDeviceIDFromElementIDW>
         mciGetErrorString            equ <mciGetErrorStringW>
         mciSendCommand               equ <mciSendCommandW>
         mciSendString                equ <mciSendStringW>
         midiInGetDevCaps             equ <midiInGetDevCapsW>
         midiInGetErrorText           equ <midiInGetErrorTextW>
         midiOutGetDevCaps            equ <midiOutGetDevCapsW>
         midiOutGetErrorText          equ <midiOutGetErrorTextW>
         mixerGetControlDetails       equ <mixerGetControlDetailsW>
         mixerGetDevCaps              equ <mixerGetDevCapsW>
         mixerGetLineControls         equ <mixerGetLineControlsW>
         mixerGetLineInfo             equ <mixerGetLineInfoW>
         mmioInstallIOProc            equ <mmioInstallIOProcW>
         mmioOpen                     equ <mmioOpenW>
         mmioRename                   equ <mmioRenameW>
         mmioStringToFOURCC           equ <mmioStringToFOURCCW>
         sndPlaySound                 equ <sndPlaySoundW>
         waveInGetDevCaps             equ <waveInGetDevCapsW>
         waveInGetErrorText           equ <waveInGetErrorTextW>
         waveOutGetDevCaps            equ <waveOutGetDevCapsW>
         waveOutGetErrorText          equ <waveOutGetErrorTextW>
endif ; @unicode

procdesc CloseDriver                  :DWORD,:DWORD,:DWORD
procdesc DefDriverProc                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc DriverCallback               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc DrvGetModuleHandle           :DWORD
procdesc GetDriverModuleHandle        :DWORD
procdesc MigrateAllDrivers            
procdesc MigrateMidiUser              
procdesc MigrateSoundEvents           
procdesc NotifyCallbackData           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OpenDriver                   :DWORD,:DWORD,:DWORD
procdesc PlaySoundA                   :DWORD,:DWORD,:DWORD
procdesc PlaySoundW                   :DWORD,:DWORD,:DWORD
procdesc SendDriverMessage            :DWORD,:DWORD,:DWORD,:DWORD
procdesc WOW32DriverCallback          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WOW32ResolveMultiMediaHandle :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WOWAppExit                   :DWORD
procdesc WinmmLogoff                  
procdesc WinmmLogon                   :DWORD
procdesc aux32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc auxGetDevCapsA               :DWORD,:DWORD,:DWORD
procdesc auxGetDevCapsW               :DWORD,:DWORD,:DWORD
procdesc auxGetNumDevs                
procdesc auxGetVolume                 :DWORD,:DWORD
procdesc auxOutMessage                :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxSetVolume                 :DWORD,:DWORD
procdesc joy32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc joyConfigChanged             :DWORD
procdesc joyGetDevCapsA               :DWORD,:DWORD,:DWORD
procdesc joyGetDevCapsW               :DWORD,:DWORD,:DWORD
procdesc joyGetNumDevs                
procdesc joyGetPos                    :DWORD,:DWORD
procdesc joyGetPosEx                  :DWORD,:DWORD
procdesc joyGetThreshold              :DWORD,:DWORD
procdesc joyReleaseCapture            :DWORD
procdesc joySetCapture                :DWORD,:DWORD,:DWORD,:DWORD
procdesc joySetThreshold              :DWORD,:DWORD
procdesc mci32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc mciDriverNotify              :DWORD,:DWORD,:DWORD
procdesc mciDriverYield               :DWORD
procdesc mciExecute                   :DWORD
procdesc mciFreeCommandResource       :DWORD
procdesc mciGetCreatorTask            :DWORD
procdesc mciGetDeviceIDA              :DWORD
procdesc mciGetDeviceIDFromElementIDA :DWORD,:DWORD
procdesc mciGetDeviceIDFromElementIDW :DWORD,:DWORD
procdesc mciGetDeviceIDW              :DWORD
procdesc mciGetDriverData             :DWORD
procdesc mciGetErrorStringA           :DWORD,:DWORD,:DWORD
procdesc mciGetErrorStringW           :DWORD,:DWORD,:DWORD
procdesc mciGetYieldProc              :DWORD,:DWORD
procdesc mciLoadCommandResource       :DWORD,:DWORD,:DWORD
procdesc mciSendCommandA              :DWORD,:DWORD,:DWORD,:DWORD
procdesc mciSendCommandW              :DWORD,:DWORD,:DWORD,:DWORD
procdesc mciSendStringA               :DWORD,:DWORD,:DWORD,:DWORD
procdesc mciSendStringW               :DWORD,:DWORD,:DWORD,:DWORD
procdesc mciSetDriverData             :DWORD,:DWORD
procdesc mciSetYieldProc              :DWORD,:DWORD,:DWORD
procdesc mid32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc midiConnect                  :DWORD,:DWORD,:DWORD
procdesc midiDisconnect               :DWORD,:DWORD,:DWORD
procdesc midiInAddBuffer              :DWORD,:DWORD,:DWORD
procdesc midiInClose                  :DWORD
procdesc midiInGetDevCapsA            :DWORD,:DWORD,:DWORD
procdesc midiInGetDevCapsW            :DWORD,:DWORD,:DWORD
procdesc midiInGetErrorTextA          :DWORD,:DWORD,:DWORD
procdesc midiInGetErrorTextW          :DWORD,:DWORD,:DWORD
procdesc midiInGetID                  :DWORD,:DWORD
procdesc midiInGetNumDevs             
procdesc midiInMessage                :DWORD,:DWORD,:DWORD,:DWORD
procdesc midiInOpen                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc midiInPrepareHeader          :DWORD,:DWORD,:DWORD
procdesc midiInReset                  :DWORD
procdesc midiInStart                  :DWORD
procdesc midiInStop                   :DWORD
procdesc midiInUnprepareHeader        :DWORD,:DWORD,:DWORD
procdesc midiOutCacheDrumPatches      :DWORD,:DWORD,:DWORD,:DWORD
procdesc midiOutCachePatches          :DWORD,:DWORD,:DWORD,:DWORD
procdesc midiOutClose                 :DWORD
procdesc midiOutGetDevCapsA           :DWORD,:DWORD,:DWORD
procdesc midiOutGetDevCapsW           :DWORD,:DWORD,:DWORD
procdesc midiOutGetErrorTextA         :DWORD,:DWORD,:DWORD
procdesc midiOutGetErrorTextW         :DWORD,:DWORD,:DWORD
procdesc midiOutGetID                 :DWORD,:DWORD
procdesc midiOutGetNumDevs            
procdesc midiOutGetVolume             :DWORD,:DWORD
procdesc midiOutLongMsg               :DWORD,:DWORD,:DWORD
procdesc midiOutMessage               :DWORD,:DWORD,:DWORD,:DWORD
procdesc midiOutOpen                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc midiOutPrepareHeader         :DWORD,:DWORD,:DWORD
procdesc midiOutReset                 :DWORD
procdesc midiOutSetVolume             :DWORD,:DWORD
procdesc midiOutShortMsg              :DWORD,:DWORD
procdesc midiOutUnprepareHeader       :DWORD,:DWORD,:DWORD
procdesc midiStreamClose              :DWORD
procdesc midiStreamOpen               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc midiStreamOut                :DWORD,:DWORD,:DWORD
procdesc midiStreamPause              :DWORD
procdesc midiStreamPosition           :DWORD,:DWORD,:DWORD
procdesc midiStreamProperty           :DWORD,:DWORD,:DWORD
procdesc midiStreamRestart            :DWORD
procdesc midiStreamStop               :DWORD
procdesc mixerClose                   :DWORD
procdesc mixerGetControlDetailsA      :DWORD,:DWORD,:DWORD
procdesc mixerGetControlDetailsW      :DWORD,:DWORD,:DWORD
procdesc mixerGetDevCapsA             :DWORD,:DWORD,:DWORD
procdesc mixerGetDevCapsW             :DWORD,:DWORD,:DWORD
procdesc mixerGetID                   :DWORD,:DWORD,:DWORD
procdesc mixerGetLineControlsA        :DWORD,:DWORD,:DWORD
procdesc mixerGetLineControlsW        :DWORD,:DWORD,:DWORD
procdesc mixerGetLineInfoA            :DWORD,:DWORD,:DWORD
procdesc mixerGetLineInfoW            :DWORD,:DWORD,:DWORD
procdesc mixerGetNumDevs              
procdesc mixerMessage                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc mixerOpen                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc mixerSetControlDetails       :DWORD,:DWORD,:DWORD
procdesc mmDrvInstall                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc mmGetCurrentTask             
procdesc mmTaskBlock                  :DWORD
procdesc mmTaskCreate                 :DWORD,:DWORD,:DWORD
procdesc mmTaskSignal                 :DWORD
procdesc mmTaskYield                  
procdesc mmioAdvance                  :DWORD,:DWORD,:DWORD
procdesc mmioAscend                   :DWORD,:DWORD,:DWORD
procdesc mmioClose                    :DWORD,:DWORD
procdesc mmioCreateChunk              :DWORD,:DWORD,:DWORD
procdesc mmioDescend                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc mmioFlush                    :DWORD,:DWORD
procdesc mmioGetInfo                  :DWORD,:DWORD,:DWORD
procdesc mmioInstallIOProcA           :DWORD,:DWORD,:DWORD
procdesc mmioInstallIOProcW           :DWORD,:DWORD,:DWORD
procdesc mmioOpenA                    :DWORD,:DWORD,:DWORD
procdesc mmioOpenW                    :DWORD,:DWORD,:DWORD
procdesc mmioRead                     :DWORD,:DWORD,:DWORD
procdesc mmioRenameA                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc mmioRenameW                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc mmioSeek                     :DWORD,:DWORD,:DWORD
procdesc mmioSendMessage              :DWORD,:DWORD,:DWORD,:DWORD
procdesc mmioSetBuffer                :DWORD,:DWORD,:DWORD,:DWORD
procdesc mmioSetInfo                  :DWORD,:DWORD,:DWORD
procdesc mmioStringToFOURCCA          :DWORD,:DWORD
procdesc mmioStringToFOURCCW          :DWORD,:DWORD
procdesc mmioWrite                    :DWORD,:DWORD,:DWORD
procdesc mmsystemGetVersion           
procdesc mod32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc mxd32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc sndPlaySoundA                :DWORD,:DWORD
procdesc sndPlaySoundW                :DWORD,:DWORD
procdesc tid32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc timeBeginPeriod              :DWORD
procdesc timeEndPeriod                :DWORD
procdesc timeGetDevCaps               :DWORD,:DWORD
procdesc timeGetSystemTime            :DWORD,:DWORD
procdesc timeGetTime                  
procdesc timeKillEvent                :DWORD
procdesc timeSetEvent                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc waveInAddBuffer              :DWORD,:DWORD,:DWORD
procdesc waveInClose                  :DWORD
procdesc waveInGetDevCapsA            :DWORD,:DWORD,:DWORD
procdesc waveInGetDevCapsW            :DWORD,:DWORD,:DWORD
procdesc waveInGetErrorTextA          :DWORD,:DWORD,:DWORD
procdesc waveInGetErrorTextW          :DWORD,:DWORD,:DWORD
procdesc waveInGetID                  :DWORD,:DWORD
procdesc waveInGetNumDevs             
procdesc waveInGetPosition            :DWORD,:DWORD,:DWORD
procdesc waveInMessage                :DWORD,:DWORD,:DWORD,:DWORD
procdesc waveInOpen                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc waveInPrepareHeader          :DWORD,:DWORD,:DWORD
procdesc waveInReset                  :DWORD
procdesc waveInStart                  :DWORD
procdesc waveInStop                   :DWORD
procdesc waveInUnprepareHeader        :DWORD,:DWORD,:DWORD
procdesc waveOutBreakLoop             :DWORD
procdesc waveOutClose                 :DWORD
procdesc waveOutGetDevCapsA           :DWORD,:DWORD,:DWORD
procdesc waveOutGetDevCapsW           :DWORD,:DWORD,:DWORD
procdesc waveOutGetErrorTextA         :DWORD,:DWORD,:DWORD
procdesc waveOutGetErrorTextW         :DWORD,:DWORD,:DWORD
procdesc waveOutGetID                 :DWORD,:DWORD
procdesc waveOutGetNumDevs            
procdesc waveOutGetPitch              :DWORD,:DWORD
procdesc waveOutGetPlaybackRate       :DWORD,:DWORD
procdesc waveOutGetPosition           :DWORD,:DWORD,:DWORD
procdesc waveOutGetVolume             :DWORD,:DWORD
procdesc waveOutMessage               :DWORD,:DWORD,:DWORD,:DWORD
procdesc waveOutOpen                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc waveOutPause                 :DWORD
procdesc waveOutPrepareHeader         :DWORD,:DWORD,:DWORD
procdesc waveOutReset                 :DWORD
procdesc waveOutRestart               :DWORD
procdesc waveOutSetPitch              :DWORD,:DWORD
procdesc waveOutSetPlaybackRate       :DWORD,:DWORD
procdesc waveOutSetVolume             :DWORD,:DWORD
procdesc waveOutUnprepareHeader       :DWORD,:DWORD,:DWORD
procdesc waveOutWrite                 :DWORD,:DWORD,:DWORD
procdesc wid32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc winmmSetDebugLevel           :DWORD
procdesc wod32Message                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
