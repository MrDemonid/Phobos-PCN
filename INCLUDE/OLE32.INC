include 'windef.inc'

ifndef @unicode
    else
endif ; @unicode

procdesc BindMoniker                           :DWORD,:DWORD,:DWORD,:DWORD
procdesc CLIPFORMAT_UserFree                   :DWORD,:DWORD
procdesc CLIPFORMAT_UserMarshal                :DWORD,:DWORD,:DWORD
procdesc CLIPFORMAT_UserSize                   :DWORD,:DWORD,:DWORD
procdesc CLIPFORMAT_UserUnmarshal              :DWORD,:DWORD,:DWORD
procdesc CLSIDFromProgID                       :DWORD,:DWORD
procdesc CLSIDFromProgIDEx                     :DWORD,:DWORD
procdesc CLSIDFromString                       :DWORD,:DWORD
procdesc CoAddRefServerProcess
procdesc CoAllowSetForegroundWindow            :DWORD,:DWORD
procdesc CoBuildVersion
procdesc CoCancelCall                          :DWORD,:DWORD
procdesc CoCopyProxy                           :DWORD,:DWORD
procdesc CoCreateFreeThreadedMarshaler         :DWORD,:DWORD
procdesc CoCreateGuid                          :DWORD
procdesc CoCreateInstance                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoCreateInstanceEx                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoCreateObjectInContext               :DWORD,:DWORD,:DWORD,:DWORD
procdesc CoDeactivateObject                    :DWORD,:DWORD
procdesc CoDisableCallCancellation             :DWORD
procdesc CoDisconnectObject                    :DWORD,:DWORD
procdesc CoDosDateTimeToFileTime               :DWORD,:DWORD,:DWORD
procdesc CoEnableCallCancellation              :DWORD
procdesc CoFileTimeNow                         :DWORD
procdesc CoFileTimeToDosDateTime               :DWORD,:DWORD,:DWORD
procdesc CoFreeAllLibraries
procdesc CoFreeLibrary                         :DWORD
procdesc CoFreeUnusedLibraries
procdesc CoGetApartmentID                      :DWORD,:DWORD
procdesc CoGetCallContext                      :DWORD,:DWORD
procdesc CoGetCallerTID                        :DWORD
procdesc CoGetCancelObject                     :DWORD,:DWORD,:DWORD
procdesc CoGetClassObject                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoGetClassVersion                     :DWORD,:DWORD,:DWORD
procdesc CoGetCurrentLogicalThreadId           :DWORD
procdesc CoGetCurrentProcess
procdesc CoGetInstanceFromFile                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoGetInstanceFromIStorage             :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoGetInterfaceAndReleaseStream        :DWORD,:DWORD,:DWORD
procdesc CoGetMalloc                           :DWORD,:DWORD
procdesc CoGetMarshalSizeMax                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoGetObject                           :DWORD,:DWORD,:DWORD,:DWORD
procdesc CoGetObjectContext                    :DWORD,:DWORD
procdesc CoGetPSClsid                          :DWORD,:DWORD
procdesc CoGetStandardMarshal                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoGetState                            :DWORD
procdesc CoGetStdMarshalEx                     :DWORD,:DWORD,:DWORD
procdesc CoGetTreatAsClass                     :DWORD,:DWORD
procdesc CoImpersonateClient
procdesc CoInitialize                          :DWORD
procdesc CoInitializeEx                        :DWORD,:DWORD
procdesc CoInitializeSecurity                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoInitializeWOW                       :DWORD,:DWORD
procdesc CoInstall                             :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoIsHandlerConnected                  :DWORD
procdesc CoIsOle1Class                         :DWORD
procdesc CoLoadLibrary                         :DWORD,:DWORD
procdesc CoLockObjectExternal                  :DWORD,:DWORD,:DWORD
procdesc CoMarshalHresult                      :DWORD,:DWORD
procdesc CoMarshalInterThreadInterfaceInStream :DWORD,:DWORD,:DWORD
procdesc CoMarshalInterface                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoQueryAuthenticationServices         :DWORD,:DWORD
procdesc CoQueryClientBlanket                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoQueryProxyBlanket                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoQueryReleaseObject                  :DWORD
procdesc CoReactivateObject                    :DWORD,:DWORD
procdesc CoRegisterChannelHook                 :DWORD,:DWORD
procdesc CoRegisterClassObject                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoRegisterMallocSpy                   :DWORD
procdesc CoRegisterMessageFilter               :DWORD,:DWORD
procdesc CoRegisterPSClsid                     :DWORD,:DWORD
procdesc CoRegisterSurrogate                   :DWORD
procdesc CoRegisterSurrogateEx                 :DWORD,:DWORD
procdesc CoReleaseMarshalData                  :DWORD
procdesc CoReleaseServerProcess
procdesc CoResumeClassObjects
procdesc CoRevertToSelf
procdesc CoRevokeClassObject                   :DWORD
procdesc CoRevokeMallocSpy
procdesc CoSetCancelObject                     :DWORD
procdesc CoSetProxyBlanket                     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CoSetState                            :DWORD
procdesc CoSuspendClassObjects
procdesc CoSwitchCallContext                   :DWORD,:DWORD
procdesc CoTaskMemAlloc                        :DWORD
procdesc CoTaskMemFree                         :DWORD
procdesc CoTaskMemRealloc                      :DWORD,:DWORD
procdesc CoTestCancel
procdesc CoTreatAsClass                        :DWORD,:DWORD
procdesc CoUninitialize
procdesc CoUnloadingWOW                        :DWORD
procdesc CoUnmarshalHresult                    :DWORD,:DWORD
procdesc CoUnmarshalInterface                  :DWORD,:DWORD,:DWORD
procdesc CoWaitForMultipleHandles              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateAntiMoniker                     :DWORD
procdesc CreateBindCtx                         :DWORD,:DWORD
procdesc CreateClassMoniker                    :DWORD,:DWORD
procdesc CreateDataAdviseHolder                :DWORD
procdesc CreateDataCache                       :DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateFileMoniker                     :DWORD,:DWORD
procdesc CreateGenericComposite                :DWORD,:DWORD,:DWORD
procdesc CreateILockBytesOnHGlobal             :DWORD,:DWORD,:DWORD
procdesc CreateItemMoniker                     :DWORD,:DWORD,:DWORD
procdesc CreateObjrefMoniker                   :DWORD,:DWORD
procdesc CreateOleAdviseHolder                 :DWORD
procdesc CreatePointerMoniker                  :DWORD,:DWORD
procdesc CreateStdProgressIndicator            :DWORD,:DWORD,:DWORD,:DWORD
procdesc CreateStreamOnHGlobal                 :DWORD,:DWORD,:DWORD
procdesc DcomChannelSetHResult                 :DWORD,:DWORD,:DWORD
procdesc DllDebugObjectRPCHook                 :DWORD,:DWORD
procdesc DllGetClassObjectWOW                  :DWORD,:DWORD,:DWORD
procdesc DoDragDrop                            :DWORD,:DWORD,:DWORD,:DWORD
procdesc EnableHookObject                      :DWORD,:DWORD
procdesc FmtIdToPropStgName                    :DWORD,:DWORD
procdesc FreePropVariantArray                  :DWORD,:DWORD
procdesc GetClassFile                          :DWORD,:DWORD
procdesc GetConvertStg                         :DWORD
procdesc GetDocumentBitStg                     :DWORD
procdesc GetHGlobalFromILockBytes              :DWORD,:DWORD
procdesc GetHGlobalFromStream                  :DWORD,:DWORD
procdesc GetHookInterface                      :DWORD
procdesc GetRunningObjectTable                 :DWORD,:DWORD
procdesc HACCEL_UserFree                       :DWORD,:DWORD
procdesc HACCEL_UserMarshal                    :DWORD,:DWORD,:DWORD
procdesc HACCEL_UserSize                       :DWORD,:DWORD,:DWORD
procdesc HACCEL_UserUnmarshal                  :DWORD,:DWORD,:DWORD
procdesc HBITMAP_UserFree                      :DWORD,:DWORD
procdesc HBITMAP_UserMarshal                   :DWORD,:DWORD,:DWORD
procdesc HBITMAP_UserSize                      :DWORD,:DWORD,:DWORD
procdesc HBITMAP_UserUnmarshal                 :DWORD,:DWORD,:DWORD
procdesc HBRUSH_UserFree                       :DWORD,:DWORD
procdesc HBRUSH_UserMarshal                    :DWORD,:DWORD,:DWORD
procdesc HBRUSH_UserSize                       :DWORD,:DWORD,:DWORD
procdesc HBRUSH_UserUnmarshal                  :DWORD,:DWORD,:DWORD
procdesc HDC_UserFree                          :DWORD,:DWORD
procdesc HDC_UserMarshal                       :DWORD,:DWORD,:DWORD
procdesc HDC_UserSize                          :DWORD,:DWORD,:DWORD
procdesc HDC_UserUnmarshal                     :DWORD,:DWORD,:DWORD
procdesc HENHMETAFILE_UserFree                 :DWORD,:DWORD
procdesc HENHMETAFILE_UserMarshal              :DWORD,:DWORD,:DWORD
procdesc HENHMETAFILE_UserSize                 :DWORD,:DWORD,:DWORD
procdesc HENHMETAFILE_UserUnmarshal            :DWORD,:DWORD,:DWORD
procdesc HGLOBAL_UserFree                      :DWORD,:DWORD
procdesc HGLOBAL_UserMarshal                   :DWORD,:DWORD,:DWORD
procdesc HGLOBAL_UserSize                      :DWORD,:DWORD,:DWORD
procdesc HGLOBAL_UserUnmarshal                 :DWORD,:DWORD,:DWORD
procdesc HICON_UserFree                        :DWORD,:DWORD
procdesc HICON_UserMarshal                     :DWORD,:DWORD,:DWORD
procdesc HICON_UserSize                        :DWORD,:DWORD,:DWORD
procdesc HICON_UserUnmarshal                   :DWORD,:DWORD,:DWORD
procdesc HMENU_UserFree                        :DWORD,:DWORD
procdesc HMENU_UserMarshal                     :DWORD,:DWORD,:DWORD
procdesc HMENU_UserSize                        :DWORD,:DWORD,:DWORD
procdesc HMENU_UserUnmarshal                   :DWORD,:DWORD,:DWORD
procdesc HMETAFILEPICT_UserFree                :DWORD,:DWORD
procdesc HMETAFILEPICT_UserMarshal             :DWORD,:DWORD,:DWORD
procdesc HMETAFILEPICT_UserSize                :DWORD,:DWORD,:DWORD
procdesc HMETAFILEPICT_UserUnmarshal           :DWORD,:DWORD,:DWORD
procdesc HMETAFILE_UserFree                    :DWORD,:DWORD
procdesc HMETAFILE_UserMarshal                 :DWORD,:DWORD,:DWORD
procdesc HMETAFILE_UserSize                    :DWORD,:DWORD,:DWORD
procdesc HMETAFILE_UserUnmarshal               :DWORD,:DWORD,:DWORD
procdesc HPALETTE_UserFree                     :DWORD,:DWORD
procdesc HPALETTE_UserMarshal                  :DWORD,:DWORD,:DWORD
procdesc HPALETTE_UserSize                     :DWORD,:DWORD,:DWORD
procdesc HPALETTE_UserUnmarshal                :DWORD,:DWORD,:DWORD
procdesc HWND_UserFree                         :DWORD,:DWORD
procdesc HWND_UserMarshal                      :DWORD,:DWORD,:DWORD
procdesc HWND_UserSize                         :DWORD,:DWORD,:DWORD
procdesc HWND_UserUnmarshal                    :DWORD,:DWORD,:DWORD
procdesc HkOleRegisterObject                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc IIDFromString                         :DWORD,:DWORD
procdesc IsAccelerator                         :DWORD,:DWORD,:DWORD,:DWORD
procdesc IsEqualGUID                           :DWORD,:DWORD
procdesc IsValidIid                            :DWORD
procdesc IsValidInterface                      :DWORD
procdesc IsValidPtrIn                          :DWORD,:DWORD
procdesc IsValidPtrOut                         :DWORD,:DWORD
procdesc MkParseDisplayName                    :DWORD,:DWORD,:DWORD,:DWORD
procdesc MonikerCommonPrefixWith               :DWORD,:DWORD,:DWORD
procdesc MonikerRelativePathTo                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc OleBuildVersion
procdesc OleConvertIStorageToOLESTREAM         :DWORD,:DWORD
procdesc OleConvertIStorageToOLESTREAMEx       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleConvertOLESTREAMToIStorage         :DWORD,:DWORD,:DWORD
procdesc OleConvertOLESTREAMToIStorageEx       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreate                             :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateDefaultHandler               :DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateEmbeddingHelper              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateEx                           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateFromData                     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateFromDataEx                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateFromFile                     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateFromFileEx                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateLink                         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateLinkEx                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateLinkFromData                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateLinkFromDataEx               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateLinkToFile                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateLinkToFileEx                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleCreateMenuDescriptor               :DWORD,:DWORD
procdesc OleCreateStaticFromData               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleDestroyMenuDescriptor              :DWORD
procdesc OleDoAutoConvert                      :DWORD,:DWORD
procdesc OleDraw                               :DWORD,:DWORD,:DWORD,:DWORD
procdesc OleDuplicateData                      :DWORD,:DWORD,:DWORD
procdesc OleFlushClipboard
procdesc OleGetAutoConvert                     :DWORD,:DWORD
procdesc OleGetClipboard                       :DWORD
procdesc OleGetIconOfClass                     :DWORD,:DWORD,:DWORD
procdesc OleGetIconOfFile                      :DWORD,:DWORD
procdesc OleInitialize                         :DWORD
procdesc OleInitializeWOW                      :DWORD,:DWORD
procdesc OleIsCurrentClipboard                 :DWORD
procdesc OleIsRunning                          :DWORD
procdesc OleLoad                               :DWORD,:DWORD,:DWORD,:DWORD
procdesc OleLoadFromStream                     :DWORD,:DWORD,:DWORD
procdesc OleLockRunning                        :DWORD,:DWORD,:DWORD
procdesc OleMetafilePictFromIconAndLabel       :DWORD,:DWORD,:DWORD,:DWORD
procdesc OleNoteObjectVisible                  :DWORD,:DWORD
procdesc OleQueryCreateFromData                :DWORD
procdesc OleQueryLinkFromData                  :DWORD
procdesc OleRegEnumFormatEtc                   :DWORD,:DWORD,:DWORD
procdesc OleRegEnumVerbs                       :DWORD,:DWORD
procdesc OleRegGetMiscStatus                   :DWORD,:DWORD,:DWORD
procdesc OleRegGetUserType                     :DWORD,:DWORD,:DWORD
procdesc OleRun                                :DWORD
procdesc OleSave                               :DWORD,:DWORD,:DWORD
procdesc OleSaveToStream                       :DWORD,:DWORD
procdesc OleSetAutoConvert                     :DWORD,:DWORD
procdesc OleSetClipboard                       :DWORD
procdesc OleSetContainedObject                 :DWORD,:DWORD
procdesc OleSetMenuDescriptor                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc OleTranslateAccelerator               :DWORD,:DWORD,:DWORD
procdesc OleUninitialize
procdesc OpenOrCreateStream                    :DWORD,:DWORD,:DWORD
procdesc ProgIDFromCLSID                       :DWORD,:DWORD
procdesc PropStgNameToFmtId                    :DWORD,:DWORD
procdesc PropSysAllocString                    :DWORD
procdesc PropSysFreeString                     :DWORD
procdesc PropVariantClear                      :DWORD
procdesc PropVariantCopy                       :DWORD,:DWORD
procdesc ReadClassStg                          :DWORD,:DWORD
procdesc ReadClassStm                          :DWORD,:DWORD
procdesc ReadFmtUserTypeStg                    :DWORD,:DWORD,:DWORD
procdesc ReadOleStg                            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc ReadStringStream                      :DWORD,:DWORD
procdesc RegisterDragDrop                      :DWORD,:DWORD
procdesc ReleaseStgMedium                      :DWORD
procdesc RevokeDragDrop                        :DWORD
procdesc SNB_UserFree                          :DWORD,:DWORD
procdesc SNB_UserMarshal                       :DWORD,:DWORD,:DWORD
procdesc SNB_UserSize                          :DWORD,:DWORD,:DWORD
procdesc SNB_UserUnmarshal                     :DWORD,:DWORD,:DWORD
procdesc STGMEDIUM_UserFree                    :DWORD,:DWORD
procdesc STGMEDIUM_UserMarshal                 :DWORD,:DWORD,:DWORD
procdesc STGMEDIUM_UserSize                    :DWORD,:DWORD,:DWORD
procdesc STGMEDIUM_UserUnmarshal               :DWORD,:DWORD,:DWORD
procdesc SetConvertStg                         :DWORD,:DWORD
procdesc SetDocumentBitStg                     :DWORD,:DWORD
procdesc StgCreateDocfile                      :DWORD,:DWORD,:DWORD,:DWORD
procdesc StgCreateDocfileOnILockBytes          :DWORD,:DWORD,:DWORD,:DWORD
procdesc StgCreatePropSetStg                   :DWORD,:DWORD,:DWORD
procdesc StgCreatePropStg                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc StgCreateStorageEx                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc StgGetIFillLockBytesOnFile            :DWORD,:DWORD
procdesc StgGetIFillLockBytesOnILockBytes      :DWORD,:DWORD
procdesc StgIsStorageFile                      :DWORD
procdesc StgIsStorageILockBytes                :DWORD
procdesc StgOpenAsyncDocfileOnIFillLockBytes   :DWORD,:DWORD,:DWORD,:DWORD
procdesc StgOpenPropStg                        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc StgOpenStorage                        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc StgOpenStorageEx                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc StgOpenStorageOnILockBytes            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc StgSetTimes                           :DWORD,:DWORD,:DWORD,:DWORD
procdesc StringFromCLSID                       :DWORD,:DWORD
procdesc StringFromGUID2                       :DWORD,:DWORD,:DWORD
procdesc StringFromIID                         :DWORD,:DWORD
procdesc UpdateDCOMSettings
procdesc UtConvertDvtd16toDvtd32               :DWORD,:DWORD,:DWORD
procdesc UtConvertDvtd32toDvtd16               :DWORD,:DWORD,:DWORD
procdesc UtGetDvtd16Info                       :DWORD,:DWORD
procdesc UtGetDvtd32Info                       :DWORD,:DWORD
procdesc WriteClassStg                         :DWORD,:DWORD
procdesc WriteClassStm                         :DWORD,:DWORD
procdesc WriteFmtUserTypeStg                   :DWORD,:DWORD,:DWORD
procdesc WriteOleStg                           :DWORD,:DWORD,:DWORD,:DWORD
procdesc WriteStringStream                     :DWORD,:DWORD
