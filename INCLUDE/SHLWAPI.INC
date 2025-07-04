ifndef @unicode
         AssocQueryKey              equ <AssocQueryKeyA>
         AssocQueryString           equ <AssocQueryStringA>
         AssocQueryStringByKey      equ <AssocQueryStringByKeyA>
         ChrCmpI                    equ <ChrCmpIA>
         IntlStrEqWorker            equ <IntlStrEqWorkerA>
         PathAddBackslash           equ <PathAddBackslashA>
         PathAddExtension           equ <PathAddExtensionA>
         PathAppend                 equ <PathAppendA>
         PathBuildRoot              equ <PathBuildRootA>
         PathCanonicalize           equ <PathCanonicalizeA>
         PathCombine                equ <PathCombineA>
         PathCommonPrefix           equ <PathCommonPrefixA>
         PathCompactPath            equ <PathCompactPathA>
         PathCompactPathEx          equ <PathCompactPathExA>
         PathCreateFromUrl          equ <PathCreateFromUrlA>
         PathFileExists             equ <PathFileExistsA>
         PathFindExtension          equ <PathFindExtensionA>
         PathFindFileName           equ <PathFindFileNameA>
         PathFindNextComponent      equ <PathFindNextComponentA>
         PathFindOnPath             equ <PathFindOnPathA>
         PathFindSuffixArray        equ <PathFindSuffixArrayA>
         PathGetArgs                equ <PathGetArgsA>
         PathGetCharType            equ <PathGetCharTypeA>
         PathGetDriveNumber         equ <PathGetDriveNumberA>
         PathIsContentType          equ <PathIsContentTypeA>
         PathIsDirectory            equ <PathIsDirectoryA>
         PathIsDirectoryEmpty       equ <PathIsDirectoryEmptyA>
         PathIsFileSpec             equ <PathIsFileSpecA>
         PathIsLFNFileSpec          equ <PathIsLFNFileSpecA>
         PathIsNetworkPath          equ <PathIsNetworkPathA>
         PathIsPrefix               equ <PathIsPrefixA>
         PathIsRelative             equ <PathIsRelativeA>
         PathIsRoot                 equ <PathIsRootA>
         PathIsSameRoot             equ <PathIsSameRootA>
         PathIsSystemFolder         equ <PathIsSystemFolderA>
         PathIsUNC                  equ <PathIsUNCA>
         PathIsUNCServer            equ <PathIsUNCServerA>
         PathIsUNCServerShare       equ <PathIsUNCServerShareA>
         PathIsURL                  equ <PathIsURLA>
         PathMakePretty             equ <PathMakePrettyA>
         PathMakeSystemFolder       equ <PathMakeSystemFolderA>
         PathMatchSpec              equ <PathMatchSpecA>
         PathParseIconLocation      equ <PathParseIconLocationA>
         PathQuoteSpaces            equ <PathQuoteSpacesA>
         PathRelativePathTo         equ <PathRelativePathToA>
         PathRemoveArgs             equ <PathRemoveArgsA>
         PathRemoveBackslash        equ <PathRemoveBackslashA>
         PathRemoveBlanks           equ <PathRemoveBlanksA>
         PathRemoveExtension        equ <PathRemoveExtensionA>
         PathRemoveFileSpec         equ <PathRemoveFileSpecA>
         PathRenameExtension        equ <PathRenameExtensionA>
         PathSearchAndQualify       equ <PathSearchAndQualifyA>
         PathSetDlgItemPath         equ <PathSetDlgItemPathA>
         PathSkipRoot               equ <PathSkipRootA>
         PathStripPath              equ <PathStripPathA>
         PathStripToRoot            equ <PathStripToRootA>
         PathUnExpandEnvStrings     equ <PathUnExpandEnvStringsA>
         PathUndecorate             equ <PathUndecorateA>
         PathUnmakeSystemFolder     equ <PathUnmakeSystemFolderA>
         PathUnquoteSpaces          equ <PathUnquoteSpacesA>
         SHCopyKey                  equ <SHCopyKeyA>
         SHCreateStreamOnFile       equ <SHCreateStreamOnFileA>
         SHDeleteEmptyKey           equ <SHDeleteEmptyKeyA>
         SHDeleteKey                equ <SHDeleteKeyA>
         SHDeleteOrphanKey          equ <SHDeleteOrphanKeyA>
         SHDeleteValue              equ <SHDeleteValueA>
         SHEnumKeyEx                equ <SHEnumKeyExA>
         SHEnumValue                equ <SHEnumValueA>
         SHGetValue                 equ <SHGetValueA>
         SHOpenRegStream2           equ <SHOpenRegStream2A>
         SHOpenRegStream            equ <SHOpenRegStreamA>
         SHQueryInfoKey             equ <SHQueryInfoKeyA>
         SHQueryValueEx             equ <SHQueryValueExA>
         SHRegCreateUSKey           equ <SHRegCreateUSKeyA>
         SHRegDeleteEmptyUSKey      equ <SHRegDeleteEmptyUSKeyA>
         SHRegDeleteUSValue         equ <SHRegDeleteUSValueA>
         SHRegEnumUSKey             equ <SHRegEnumUSKeyA>
         SHRegEnumUSValue           equ <SHRegEnumUSValueA>
         SHRegGetBoolUSValue        equ <SHRegGetBoolUSValueA>
         SHRegGetPath               equ <SHRegGetPathA>
         SHRegGetUSValue            equ <SHRegGetUSValueA>
         SHRegOpenUSKey             equ <SHRegOpenUSKeyA>
         SHRegQueryInfoUSKey        equ <SHRegQueryInfoUSKeyA>
         SHRegQueryUSValue          equ <SHRegQueryUSValueA>
         SHRegSetPath               equ <SHRegSetPathA>
         SHRegSetUSValue            equ <SHRegSetUSValueA>
         SHRegWriteUSValue          equ <SHRegWriteUSValueA>
         SHSetValue                 equ <SHSetValueA>
         SHStrDup                   equ <SHStrDupA>
         StrCSpn                    equ <StrCSpnA>
         StrCSpnI                   equ <StrCSpnIA>
         StrCatBuff                 equ <StrCatBuffA>
         StrChr                     equ <StrChrA>
         StrChrI                    equ <StrChrIA>
         StrCmpN                    equ <StrCmpNA>
         StrCmpNI                   equ <StrCmpNIA>
         StrDup                     equ <StrDupA>
         StrFormatByteSize64        equ <StrFormatByteSize64A>
         StrFormatByteSize          equ <StrFormatByteSizeA>
         StrFormatKBSize            equ <StrFormatKBSizeA>
         StrFromTimeInterval        equ <StrFromTimeIntervalA>
         StrIsIntlEqual             equ <StrIsIntlEqualA>
         StrNCat                    equ <StrNCatA>
         StrPBrk                    equ <StrPBrkA>
         StrRChr                    equ <StrRChrA>
         StrRChrI                   equ <StrRChrIA>
         StrRStrI                   equ <StrRStrIA>
         StrRetToBuf                equ <StrRetToBufA>
         StrRetToStr                equ <StrRetToStrA>
         StrSpn                     equ <StrSpnA>
         StrStr                     equ <StrStrA>
         StrStrI                    equ <StrStrIA>
         StrToInt                   equ <StrToIntA>
         StrToIntEx                 equ <StrToIntExA>
         StrTrim                    equ <StrTrimA>
         UrlApplyScheme             equ <UrlApplySchemeA>
         UrlCanonicalize            equ <UrlCanonicalizeA>
         UrlCombine                 equ <UrlCombineA>
         UrlCompare                 equ <UrlCompareA>
         UrlCreateFromPath          equ <UrlCreateFromPathA>
         UrlEscape                  equ <UrlEscapeA>
         UrlGetLocation             equ <UrlGetLocationA>
         UrlGetPart                 equ <UrlGetPartA>
         UrlHash                    equ <UrlHashA>
         UrlIs                      equ <UrlIsA>
         UrlIsNoHistory             equ <UrlIsNoHistoryA>
         UrlIsOpaque                equ <UrlIsOpaqueA>
         UrlUnescape                equ <UrlUnescapeA>
         wvnsprintf                 equ <wvnsprintfA>
    else
         AssocQueryKey              equ <AssocQueryKeyW>
         AssocQueryString           equ <AssocQueryStringW>
         AssocQueryStringByKey      equ <AssocQueryStringByKeyW>
         ChrCmpI                    equ <ChrCmpIW>
         IntlStrEqWorker            equ <IntlStrEqWorkerW>
         PathAddBackslash           equ <PathAddBackslashW>
         PathAddExtension           equ <PathAddExtensionW>
         PathAppend                 equ <PathAppendW>
         PathBuildRoot              equ <PathBuildRootW>
         PathCanonicalize           equ <PathCanonicalizeW>
         PathCombine                equ <PathCombineW>
         PathCommonPrefix           equ <PathCommonPrefixW>
         PathCompactPath            equ <PathCompactPathW>
         PathCompactPathEx          equ <PathCompactPathExW>
         PathCreateFromUrl          equ <PathCreateFromUrlW>
         PathFileExists             equ <PathFileExistsW>
         PathFindExtension          equ <PathFindExtensionW>
         PathFindFileName           equ <PathFindFileNameW>
         PathFindNextComponent      equ <PathFindNextComponentW>
         PathFindOnPath             equ <PathFindOnPathW>
         PathFindSuffixArray        equ <PathFindSuffixArrayW>
         PathGetArgs                equ <PathGetArgsW>
         PathGetCharType            equ <PathGetCharTypeW>
         PathGetDriveNumber         equ <PathGetDriveNumberW>
         PathIsContentType          equ <PathIsContentTypeW>
         PathIsDirectory            equ <PathIsDirectoryW>
         PathIsDirectoryEmpty       equ <PathIsDirectoryEmptyW>
         PathIsFileSpec             equ <PathIsFileSpecW>
         PathIsLFNFileSpec          equ <PathIsLFNFileSpecW>
         PathIsNetworkPath          equ <PathIsNetworkPathW>
         PathIsPrefix               equ <PathIsPrefixW>
         PathIsRelative             equ <PathIsRelativeW>
         PathIsRoot                 equ <PathIsRootW>
         PathIsSameRoot             equ <PathIsSameRootW>
         PathIsSystemFolder         equ <PathIsSystemFolderW>
         PathIsUNC                  equ <PathIsUNCW>
         PathIsUNCServer            equ <PathIsUNCServerW>
         PathIsUNCServerShare       equ <PathIsUNCServerShareW>
         PathIsURL                  equ <PathIsURLW>
         PathMakePretty             equ <PathMakePrettyW>
         PathMakeSystemFolder       equ <PathMakeSystemFolderW>
         PathMatchSpec              equ <PathMatchSpecW>
         PathParseIconLocation      equ <PathParseIconLocationW>
         PathQuoteSpaces            equ <PathQuoteSpacesW>
         PathRelativePathTo         equ <PathRelativePathToW>
         PathRemoveArgs             equ <PathRemoveArgsW>
         PathRemoveBackslash        equ <PathRemoveBackslashW>
         PathRemoveBlanks           equ <PathRemoveBlanksW>
         PathRemoveExtension        equ <PathRemoveExtensionW>
         PathRemoveFileSpec         equ <PathRemoveFileSpecW>
         PathRenameExtension        equ <PathRenameExtensionW>
         PathSearchAndQualify       equ <PathSearchAndQualifyW>
         PathSetDlgItemPath         equ <PathSetDlgItemPathW>
         PathSkipRoot               equ <PathSkipRootW>
         PathStripPath              equ <PathStripPathW>
         PathStripToRoot            equ <PathStripToRootW>
         PathUnExpandEnvStrings     equ <PathUnExpandEnvStringsW>
         PathUndecorate             equ <PathUndecorateW>
         PathUnmakeSystemFolder     equ <PathUnmakeSystemFolderW>
         PathUnquoteSpaces          equ <PathUnquoteSpacesW>
         SHCopyKey                  equ <SHCopyKeyW>
         SHCreateStreamOnFile       equ <SHCreateStreamOnFileW>
         SHDeleteEmptyKey           equ <SHDeleteEmptyKeyW>
         SHDeleteKey                equ <SHDeleteKeyW>
         SHDeleteOrphanKey          equ <SHDeleteOrphanKeyW>
         SHDeleteValue              equ <SHDeleteValueW>
         SHEnumKeyEx                equ <SHEnumKeyExW>
         SHEnumValue                equ <SHEnumValueW>
         SHGetValue                 equ <SHGetValueW>
         SHOpenRegStream2           equ <SHOpenRegStream2W>
         SHOpenRegStream            equ <SHOpenRegStreamW>
         SHQueryInfoKey             equ <SHQueryInfoKeyW>
         SHQueryValueEx             equ <SHQueryValueExW>
         SHRegCreateUSKey           equ <SHRegCreateUSKeyW>
         SHRegDeleteEmptyUSKey      equ <SHRegDeleteEmptyUSKeyW>
         SHRegDeleteUSValue         equ <SHRegDeleteUSValueW>
         SHRegEnumUSKey             equ <SHRegEnumUSKeyW>
         SHRegEnumUSValue           equ <SHRegEnumUSValueW>
         SHRegGetBoolUSValue        equ <SHRegGetBoolUSValueW>
         SHRegGetPath               equ <SHRegGetPathW>
         SHRegGetUSValue            equ <SHRegGetUSValueW>
         SHRegOpenUSKey             equ <SHRegOpenUSKeyW>
         SHRegQueryInfoUSKey        equ <SHRegQueryInfoUSKeyW>
         SHRegQueryUSValue          equ <SHRegQueryUSValueW>
         SHRegSetPath               equ <SHRegSetPathW>
         SHRegSetUSValue            equ <SHRegSetUSValueW>
         SHRegWriteUSValue          equ <SHRegWriteUSValueW>
         SHSetValue                 equ <SHSetValueW>
         SHStrDup                   equ <SHStrDupW>
         StrCSpn                    equ <StrCSpnW>
         StrCSpnI                   equ <StrCSpnIW>
         StrCatBuff                 equ <StrCatBuffW>
         StrChr                     equ <StrChrW>
         StrChrI                    equ <StrChrIW>
         StrCmpN                    equ <StrCmpNW>
         StrCmpNI                   equ <StrCmpNIW>
         StrDup                     equ <StrDupW>
         StrFormatByteSize64        equ <StrFormatByteSize64W>
         StrFormatByteSize          equ <StrFormatByteSizeW>
         StrFormatKBSize            equ <StrFormatKBSizeW>
         StrFromTimeInterval        equ <StrFromTimeIntervalW>
         StrIsIntlEqual             equ <StrIsIntlEqualW>
         StrNCat                    equ <StrNCatW>
         StrPBrk                    equ <StrPBrkW>
         StrRChr                    equ <StrRChrW>
         StrRChrI                   equ <StrRChrIW>
         StrRStrI                   equ <StrRStrIW>
         StrRetToBuf                equ <StrRetToBufW>
         StrRetToStr                equ <StrRetToStrW>
         StrSpn                     equ <StrSpnW>
         StrStr                     equ <StrStrW>
         StrStrI                    equ <StrStrIW>
         StrToInt                   equ <StrToIntW>
         StrToIntEx                 equ <StrToIntExW>
         StrTrim                    equ <StrTrimW>
         UrlApplyScheme             equ <UrlApplySchemeW>
         UrlCanonicalize            equ <UrlCanonicalizeW>
         UrlCombine                 equ <UrlCombineW>
         UrlCompare                 equ <UrlCompareW>
         UrlCreateFromPath          equ <UrlCreateFromPathW>
         UrlEscape                  equ <UrlEscapeW>
         UrlGetLocation             equ <UrlGetLocationW>
         UrlGetPart                 equ <UrlGetPartW>
         UrlHash                    equ <UrlHashW>
         UrlIs                      equ <UrlIsW>
         UrlIsNoHistory             equ <UrlIsNoHistoryW>
         UrlIsOpaque                equ <UrlIsOpaqueW>
         UrlUnescape                equ <UrlUnescapeW>
         wvnsprintf                 equ <wvnsprintfW>
endif ; @unicode

procdesc AssocCreate                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AssocQueryKeyA             :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AssocQueryKeyW             :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AssocQueryStringA          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AssocQueryStringByKeyA     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AssocQueryStringByKeyW     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc AssocQueryStringW          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc ChrCmpIA                   :DWORD,:DWORD
procdesc ChrCmpIW                   :DWORD,:DWORD
procdesc ColorAdjustLuma            :DWORD,:DWORD,:DWORD
procdesc ColorHLSToRGB              :DWORD,:DWORD,:DWORD
procdesc ColorRGBToHLS              :DWORD,:DWORD,:DWORD,:DWORD
procdesc GetMenuPosFromID           :DWORD,:DWORD
procdesc HashData                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc IntlStrEqWorkerA           :DWORD,:DWORD,:DWORD,:DWORD
procdesc IntlStrEqWorkerW           :DWORD,:DWORD,:DWORD,:DWORD
procdesc PathAddBackslashA          :DWORD
procdesc PathAddBackslashW          :DWORD
procdesc PathAddExtensionA          :DWORD,:DWORD
procdesc PathAddExtensionW          :DWORD,:DWORD
procdesc PathAppendA                :DWORD,:DWORD
procdesc PathAppendW                :DWORD,:DWORD
procdesc PathBuildRootA             :DWORD,:DWORD
procdesc PathBuildRootW             :DWORD,:DWORD
procdesc PathCanonicalizeA          :DWORD,:DWORD
procdesc PathCanonicalizeW          :DWORD,:DWORD
procdesc PathCombineA               :DWORD,:DWORD,:DWORD
procdesc PathCombineW               :DWORD,:DWORD,:DWORD
procdesc PathCommonPrefixA          :DWORD,:DWORD,:DWORD
procdesc PathCommonPrefixW          :DWORD,:DWORD,:DWORD
procdesc PathCompactPathA           :DWORD,:DWORD,:DWORD
procdesc PathCompactPathExA         :DWORD,:DWORD,:DWORD,:DWORD
procdesc PathCompactPathExW         :DWORD,:DWORD,:DWORD,:DWORD
procdesc PathCompactPathW           :DWORD,:DWORD,:DWORD
procdesc PathCreateFromUrlA         :DWORD,:DWORD,:DWORD,:DWORD
procdesc PathCreateFromUrlW         :DWORD,:DWORD,:DWORD,:DWORD
procdesc PathFileExistsA            :DWORD
procdesc PathFileExistsW            :DWORD
procdesc PathFindExtensionA         :DWORD
procdesc PathFindExtensionW         :DWORD
procdesc PathFindFileNameA          :DWORD
procdesc PathFindFileNameW          :DWORD
procdesc PathFindNextComponentA     :DWORD
procdesc PathFindNextComponentW     :DWORD
procdesc PathFindOnPathA            :DWORD,:DWORD
procdesc PathFindOnPathW            :DWORD,:DWORD
procdesc PathFindSuffixArrayA       :DWORD,:DWORD,:DWORD
procdesc PathFindSuffixArrayW       :DWORD,:DWORD,:DWORD
procdesc PathGetArgsA               :DWORD
procdesc PathGetArgsW               :DWORD
procdesc PathGetCharTypeA           :DWORD
procdesc PathGetCharTypeW           :DWORD
procdesc PathGetDriveNumberA        :DWORD
procdesc PathGetDriveNumberW        :DWORD
procdesc PathIsContentTypeA         :DWORD,:DWORD
procdesc PathIsContentTypeW         :DWORD,:DWORD
procdesc PathIsDirectoryA           :DWORD
procdesc PathIsDirectoryEmptyA      :DWORD
procdesc PathIsDirectoryEmptyW      :DWORD
procdesc PathIsDirectoryW           :DWORD
procdesc PathIsFileSpecA            :DWORD
procdesc PathIsFileSpecW            :DWORD
procdesc PathIsLFNFileSpecA         :DWORD
procdesc PathIsLFNFileSpecW         :DWORD
procdesc PathIsNetworkPathA         :DWORD
procdesc PathIsNetworkPathW         :DWORD
procdesc PathIsPrefixA              :DWORD,:DWORD
procdesc PathIsPrefixW              :DWORD,:DWORD
procdesc PathIsRelativeA            :DWORD
procdesc PathIsRelativeW            :DWORD
procdesc PathIsRootA                :DWORD
procdesc PathIsRootW                :DWORD
procdesc PathIsSameRootA            :DWORD,:DWORD
procdesc PathIsSameRootW            :DWORD,:DWORD
procdesc PathIsSystemFolderA        :DWORD,:DWORD
procdesc PathIsSystemFolderW        :DWORD,:DWORD
procdesc PathIsUNCA                 :DWORD
procdesc PathIsUNCServerA           :DWORD
procdesc PathIsUNCServerShareA      :DWORD
procdesc PathIsUNCServerShareW      :DWORD
procdesc PathIsUNCServerW           :DWORD
procdesc PathIsUNCW                 :DWORD
procdesc PathIsURLA                 :DWORD
procdesc PathIsURLW                 :DWORD
procdesc PathMakePrettyA            :DWORD
procdesc PathMakePrettyW            :DWORD
procdesc PathMakeSystemFolderA      :DWORD
procdesc PathMakeSystemFolderW      :DWORD
procdesc PathMatchSpecA             :DWORD,:DWORD
procdesc PathMatchSpecW             :DWORD,:DWORD
procdesc PathParseIconLocationA     :DWORD
procdesc PathParseIconLocationW     :DWORD
procdesc PathQuoteSpacesA           :DWORD
procdesc PathQuoteSpacesW           :DWORD
procdesc PathRelativePathToA        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc PathRelativePathToW        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc PathRemoveArgsA            :DWORD
procdesc PathRemoveArgsW            :DWORD
procdesc PathRemoveBackslashA       :DWORD
procdesc PathRemoveBackslashW       :DWORD
procdesc PathRemoveBlanksA          :DWORD
procdesc PathRemoveBlanksW          :DWORD
procdesc PathRemoveExtensionA       :DWORD
procdesc PathRemoveExtensionW       :DWORD
procdesc PathRemoveFileSpecA        :DWORD
procdesc PathRemoveFileSpecW        :DWORD
procdesc PathRenameExtensionA       :DWORD,:DWORD
procdesc PathRenameExtensionW       :DWORD,:DWORD
procdesc PathSearchAndQualifyA      :DWORD,:DWORD,:DWORD
procdesc PathSearchAndQualifyW      :DWORD,:DWORD,:DWORD
procdesc PathSetDlgItemPathA        :DWORD,:DWORD,:DWORD
procdesc PathSetDlgItemPathW        :DWORD,:DWORD,:DWORD
procdesc PathSkipRootA              :DWORD
procdesc PathSkipRootW              :DWORD
procdesc PathStripPathA             :DWORD
procdesc PathStripPathW             :DWORD
procdesc PathStripToRootA           :DWORD
procdesc PathStripToRootW           :DWORD
procdesc PathUnExpandEnvStringsA    :DWORD,:DWORD,:DWORD
procdesc PathUnExpandEnvStringsW    :DWORD,:DWORD,:DWORD
procdesc PathUndecorateA            :DWORD
procdesc PathUndecorateW            :DWORD
procdesc PathUnmakeSystemFolderA    :DWORD
procdesc PathUnmakeSystemFolderW    :DWORD
procdesc PathUnquoteSpacesA         :DWORD
procdesc PathUnquoteSpacesW         :DWORD
procdesc SHAutoComplete             :DWORD,:DWORD
procdesc SHCopyKeyA                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHCopyKeyW                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHCreateShellPalette       :DWORD
procdesc SHCreateStreamOnFileA      :DWORD,:DWORD,:DWORD
procdesc SHCreateStreamOnFileW      :DWORD,:DWORD,:DWORD
procdesc SHCreateStreamWrapper      :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHCreateThread             :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHDeleteEmptyKeyA          :DWORD,:DWORD
procdesc SHDeleteEmptyKeyW          :DWORD,:DWORD
procdesc SHDeleteKeyA               :DWORD,:DWORD
procdesc SHDeleteKeyW               :DWORD,:DWORD
procdesc SHDeleteOrphanKeyA         :DWORD,:DWORD
procdesc SHDeleteOrphanKeyW         :DWORD,:DWORD
procdesc SHDeleteValueA             :DWORD,:DWORD,:DWORD
procdesc SHDeleteValueW             :DWORD,:DWORD,:DWORD
procdesc SHEnumKeyExA               :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHEnumKeyExW               :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHEnumValueA               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHEnumValueW               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHGetInverseCMAP           :DWORD,:DWORD
procdesc SHGetThreadRef             :DWORD
procdesc SHGetValueA                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHGetValueW                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHIsLowMemoryMachine       :DWORD
procdesc SHOpenRegStream2A          :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHOpenRegStream2W          :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHOpenRegStreamA           :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHOpenRegStreamW           :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHQueryInfoKeyA            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHQueryInfoKeyW            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHQueryValueExA            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHQueryValueExW            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegCloseUSKey            :DWORD
procdesc SHRegCreateUSKeyA          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegCreateUSKeyW          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegDeleteEmptyUSKeyA     :DWORD,:DWORD,:DWORD
procdesc SHRegDeleteEmptyUSKeyW     :DWORD,:DWORD,:DWORD
procdesc SHRegDeleteUSValueA        :DWORD,:DWORD,:DWORD
procdesc SHRegDeleteUSValueW        :DWORD,:DWORD,:DWORD
procdesc SHRegDuplicateHKey         :DWORD
procdesc SHRegEnumUSKeyA            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegEnumUSKeyW            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegEnumUSValueA          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegEnumUSValueW          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegGetBoolUSValueA       :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegGetBoolUSValueW       :DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegGetPathA              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegGetPathW              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegGetUSValueA           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegGetUSValueW           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegOpenUSKeyA            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegOpenUSKeyW            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegQueryInfoUSKeyA       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegQueryInfoUSKeyW       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegQueryUSValueA         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegQueryUSValueW         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegSetPathA              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegSetPathW              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegSetUSValueA           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegSetUSValueW           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegWriteUSValueA         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegWriteUSValueW         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHRegisterValidateTemplate :DWORD,:DWORD
procdesc SHSetThreadRef             :DWORD
procdesc SHSetValueA                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHSetValueW                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SHSkipJunction             :DWORD,:DWORD
procdesc SHStrDupA                  :DWORD,:DWORD
procdesc SHStrDupW                  :DWORD,:DWORD
procdesc StrCSpnA                   :DWORD,:DWORD
procdesc StrCSpnIA                  :DWORD,:DWORD
procdesc StrCSpnIW                  :DWORD,:DWORD
procdesc StrCSpnW                   :DWORD,:DWORD
procdesc StrCatBuffA                :DWORD,:DWORD,:DWORD
procdesc StrCatBuffW                :DWORD,:DWORD,:DWORD
procdesc StrCatW                    :DWORD,:DWORD
procdesc StrChrA                    :DWORD,:DWORD
procdesc StrChrIA                   :DWORD,:DWORD
procdesc StrChrIW                   :DWORD,:DWORD
procdesc StrChrW                    :DWORD,:DWORD
procdesc StrCmpIW                   :DWORD,:DWORD
procdesc StrCmpNA                   :DWORD,:DWORD,:DWORD
procdesc StrCmpNIA                  :DWORD,:DWORD,:DWORD
procdesc StrCmpNIW                  :DWORD,:DWORD,:DWORD
procdesc StrCmpNW                   :DWORD,:DWORD,:DWORD
procdesc StrCmpW                    :DWORD,:DWORD
procdesc StrCpyNW                   :DWORD,:DWORD,:DWORD
procdesc StrCpyW                    :DWORD,:DWORD
procdesc StrDupA                    :DWORD
procdesc StrDupW                    :DWORD
procdesc StrFormatByteSize64W       :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrFormatByteSize64A       :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrFormatByteSizeA         :DWORD,:DWORD,:DWORD
procdesc StrFormatByteSizeW         :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrFormatKBSizeA           :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrFormatKBSizeW           :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrFromTimeIntervalA       :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrFromTimeIntervalW       :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrIsIntlEqualA            :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrIsIntlEqualW            :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrNCatA                   :DWORD,:DWORD,:DWORD
procdesc StrNCatW                   :DWORD,:DWORD,:DWORD
procdesc StrPBrkA                   :DWORD,:DWORD
procdesc StrPBrkW                   :DWORD,:DWORD
procdesc StrRChrA                   :DWORD,:DWORD,:DWORD
procdesc StrRChrIA                  :DWORD,:DWORD,:DWORD
procdesc StrRChrIW                  :DWORD,:DWORD,:DWORD
procdesc StrRChrW                   :DWORD,:DWORD,:DWORD
procdesc StrRStrIA                  :DWORD,:DWORD,:DWORD
procdesc StrRStrIW                  :DWORD,:DWORD,:DWORD
procdesc StrRetToBufA               :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrRetToBufW               :DWORD,:DWORD,:DWORD,:DWORD
procdesc StrRetToStrA               :DWORD,:DWORD,:DWORD
procdesc StrRetToStrW               :DWORD,:DWORD,:DWORD
procdesc StrSpnA                    :DWORD,:DWORD
procdesc StrSpnW                    :DWORD,:DWORD
procdesc StrStrA                    :DWORD,:DWORD
procdesc StrStrIA                   :DWORD,:DWORD
procdesc StrStrIW                   :DWORD,:DWORD
procdesc StrStrW                    :DWORD,:DWORD
procdesc StrToIntA                  :DWORD
procdesc StrToIntExA                :DWORD,:DWORD,:DWORD
procdesc StrToIntExW                :DWORD,:DWORD,:DWORD
procdesc StrToIntW                  :DWORD
procdesc StrTrimA                   :DWORD,:DWORD
procdesc StrTrimW                   :DWORD,:DWORD
procdesc UrlApplySchemeA            :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlApplySchemeW            :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlCanonicalizeA           :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlCanonicalizeW           :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlCombineA                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlCombineW                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlCompareA                :DWORD,:DWORD,:DWORD
procdesc UrlCompareW                :DWORD,:DWORD,:DWORD
procdesc UrlCreateFromPathA         :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlCreateFromPathW         :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlEscapeA                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlEscapeW                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlGetLocationA            :DWORD
procdesc UrlGetLocationW            :DWORD
procdesc UrlGetPartA                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlGetPartW                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlHashA                   :DWORD,:DWORD,:DWORD
procdesc UrlHashW                   :DWORD,:DWORD,:DWORD
procdesc UrlIsA                     :DWORD,:DWORD
procdesc UrlIsNoHistoryA            :DWORD
procdesc UrlIsNoHistoryW            :DWORD
procdesc UrlIsOpaqueA               :DWORD
procdesc UrlIsOpaqueW               :DWORD
procdesc UrlIsW                     :DWORD,:DWORD
procdesc UrlUnescapeA               :DWORD,:DWORD,:DWORD,:DWORD
procdesc UrlUnescapeW               :DWORD,:DWORD,:DWORD,:DWORD
procdesc wvnsprintfA                :DWORD,:DWORD,:DWORD,:DWORD
procdesc wvnsprintfW                :DWORD,:DWORD,:DWORD,:DWORD
