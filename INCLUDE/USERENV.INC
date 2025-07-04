ifndef @unicode
         AddDesktopItem                   equ <AddDesktopItemA>
         AddItem                          equ <AddItemA>
         ApplySystemPolicy                equ <ApplySystemPolicyA>
         CopyProfileDirectory             equ <CopyProfileDirectoryA>
         CopyProfileDirectoryEx           equ <CopyProfileDirectoryExA>
         CreateGroup                      equ <CreateGroupA>
         CreateLinkFile                   equ <CreateLinkFileA>
         CreateUserProfile                equ <CreateUserProfileA>
         DeleteDesktopItem                equ <DeleteDesktopItemA>
         DeleteGroup                      equ <DeleteGroupA>
         DeleteItem                       equ <DeleteItemA>
         DeleteLinkFile                   equ <DeleteLinkFileA>
         DeleteProfile                    equ <DeleteProfileA>
         ExpandEnvironmentStringsForUser  equ <ExpandEnvironmentStringsForUserA>
         FreeGPOList                      equ <FreeGPOListA>
         GetAllUsersProfileDirectory      equ <GetAllUsersProfileDirectoryA>
         GetAppliedGPOList                equ <GetAppliedGPOListA>
         GetDefaultUserProfileDirectory   equ <GetDefaultUserProfileDirectoryA>
         GetGPOList                       equ <GetGPOListA>
         GetProfilesDirectory             equ <GetProfilesDirectoryA>
         GetSystemTempDirectory           equ <GetSystemTempDirectoryA>
         GetUserProfileDirectory          equ <GetUserProfileDirectoryA>
         LoadUserProfile                  equ <LoadUserProfileA>
    else
         AddDesktopItem                   equ <AddDesktopItemW>
         AddItem                          equ <AddItemW>
         ApplySystemPolicy                equ <ApplySystemPolicyW>
         CopyProfileDirectory             equ <CopyProfileDirectoryW>
         CopyProfileDirectoryEx           equ <CopyProfileDirectoryExW>
         CreateGroup                      equ <CreateGroupW>
         CreateLinkFile                   equ <CreateLinkFileW>
         CreateUserProfile                equ <CreateUserProfileW>
         DeleteDesktopItem                equ <DeleteDesktopItemW>
         DeleteGroup                      equ <DeleteGroupW>
         DeleteItem                       equ <DeleteItemW>
         DeleteLinkFile                   equ <DeleteLinkFileW>
         DeleteProfile                    equ <DeleteProfileW>
         ExpandEnvironmentStringsForUser  equ <ExpandEnvironmentStringsForUserW>
         FreeGPOList                      equ <FreeGPOListW>
         GetAllUsersProfileDirectory      equ <GetAllUsersProfileDirectoryW>
         GetAppliedGPOList                equ <GetAppliedGPOListW>
         GetDefaultUserProfileDirectory   equ <GetDefaultUserProfileDirectoryW>
         GetGPOList                       equ <GetGPOListW>
         GetProfilesDirectory             equ <GetProfilesDirectoryW>
         GetSystemTempDirectory           equ <GetSystemTempDirectoryW>
         GetUserProfileDirectory          equ <GetUserProfileDirectoryW>
         LoadUserProfile                  equ <LoadUserProfileW>
endif ; @unicode

procdesc AddDesktopItemA                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AddDesktopItemW                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AddItemA                         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AddItemW                         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc ApplyGroupPolicy                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc ApplySystemPolicyA               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc ApplySystemPolicyW               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CopyProfileDirectoryA            :DWORD,:DWORD,:DWORD
procdesc CopyProfileDirectoryExA          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CopyProfileDirectoryExW          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CopyProfileDirectoryW            :DWORD,:DWORD,:DWORD
procdesc CreateEnvironmentBlock           :DWORD,:DWORD,:DWORD
procdesc CreateGroupA                     :DWORD,:DWORD
procdesc CreateGroupW                     :DWORD,:DWORD
procdesc CreateLinkFileA                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateLinkFileW                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateUserProfileA               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateUserProfileW               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc DeleteDesktopItemA               :DWORD,:DWORD
procdesc DeleteDesktopItemW               :DWORD,:DWORD
procdesc DeleteGroupA                     :DWORD,:DWORD
procdesc DeleteGroupW                     :DWORD,:DWORD
procdesc DeleteItemA                      :DWORD,:DWORD,:DWORD,:DWORD
procdesc DeleteItemW                      :DWORD,:DWORD,:DWORD,:DWORD
procdesc DeleteLinkFileA                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc DeleteLinkFileW                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc DeleteProfileA                   :DWORD,:DWORD,:DWORD
procdesc DeleteProfileW                   :DWORD,:DWORD,:DWORD
procdesc DestroyEnvironmentBlock          :DWORD
procdesc DetermineProfilesLocation        :DWORD
procdesc EnterCriticalPolicySection       :DWORD
procdesc ExpandEnvironmentStringsForUserA :DWORD,:DWORD,:DWORD,:DWORD
procdesc ExpandEnvironmentStringsForUserW :DWORD,:DWORD,:DWORD,:DWORD
procdesc FreeGPOListA                     :DWORD
procdesc FreeGPOListW                     :DWORD
procdesc GetAllUsersProfileDirectoryA     :DWORD,:DWORD
procdesc GetAllUsersProfileDirectoryW     :DWORD,:DWORD
procdesc GetAppliedGPOListA               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetAppliedGPOListW               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetDefaultUserProfileDirectoryA  :DWORD,:DWORD
procdesc GetDefaultUserProfileDirectoryW  :DWORD,:DWORD
procdesc GetGPOListA                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetGPOListW                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetProfileType                   :DWORD
procdesc GetProfilesDirectoryA            :DWORD,:DWORD
procdesc GetProfilesDirectoryW            :DWORD,:DWORD
procdesc GetSystemTempDirectoryA          :DWORD,:DWORD
procdesc GetSystemTempDirectoryW          :DWORD,:DWORD
procdesc GetUserProfileDirectoryA         :DWORD,:DWORD,:DWORD
procdesc GetUserProfileDirectoryW         :DWORD,:DWORD,:DWORD
procdesc InitializeProfiles               :DWORD
procdesc LeaveCriticalPolicySection       :DWORD
procdesc LoadUserProfileA                 :DWORD,:DWORD
procdesc LoadUserProfileW                 :DWORD,:DWORD
procdesc MigrateNT4ToNT5                  
procdesc ProcessGroupPolicyCompleted      :DWORD,:DWORD,:DWORD
procdesc RefreshPolicy                    :DWORD
procdesc RegisterGPNotification           :DWORD,:DWORD
procdesc ResetUserSpecialFolderPaths      
procdesc ShutdownGPOProcessing            :DWORD
procdesc UnloadUserProfile                :DWORD,:DWORD
procdesc UnregisterGPNotification         :DWORD
