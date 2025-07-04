ifndef @unicode
         WSAAddressToString               equ <WSAAddressToStringA>
         WSADuplicateSocket               equ <WSADuplicateSocketA>
         WSAEnumNameSpaceProviders        equ <WSAEnumNameSpaceProvidersA>
         WSAEnumProtocols                 equ <WSAEnumProtocolsA>
         WSAGetServiceClassInfo           equ <WSAGetServiceClassInfoA>
         WSAGetServiceClassNameByClassId  equ <WSAGetServiceClassNameByClassIdA>
         WSAInstallServiceClass           equ <WSAInstallServiceClassA>
         WSALookupServiceBegin            equ <WSALookupServiceBeginA>
         WSALookupServiceNext             equ <WSALookupServiceNextA>
         WSASetService                    equ <WSASetServiceA>
         WSASocket                        equ <WSASocketA>
         WSAStringToAddress               equ <WSAStringToAddressA>
    else
         WSAAddressToString               equ <WSAAddressToStringW>
         WSADuplicateSocket               equ <WSADuplicateSocketW>
         WSAEnumNameSpaceProviders        equ <WSAEnumNameSpaceProvidersW>
         WSAEnumProtocols                 equ <WSAEnumProtocolsW>
         WSAGetServiceClassInfo           equ <WSAGetServiceClassInfoW>
         WSAGetServiceClassNameByClassId  equ <WSAGetServiceClassNameByClassIdW>
         WSAInstallServiceClass           equ <WSAInstallServiceClassW>
         WSALookupServiceBegin            equ <WSALookupServiceBeginW>
         WSALookupServiceNext             equ <WSALookupServiceNextW>
         WSASetService                    equ <WSASetServiceW>
         WSASocket                        equ <WSASocketW>
         WSAStringToAddress               equ <WSAStringToAddressW>
endif ; @unicode

procdesc WEP                              
procdesc WPUCompleteOverlappedRequest     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAccept                        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAddressToStringA              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAddressToStringW              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetHostByAddr            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetHostByName            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetProtoByName           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetProtoByNumber         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetServByName            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetServByPort            :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncSelect                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSACancelAsyncRequest            :DWORD
procdesc WSACancelBlockingCall            
procdesc WSACleanup                       
procdesc WSACloseEvent                    :DWORD
procdesc WSAConnect                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSACreateEvent                   
procdesc WSADuplicateSocketA              :DWORD,:DWORD,:DWORD
procdesc WSADuplicateSocketW              :DWORD,:DWORD,:DWORD
procdesc WSAEnumNameSpaceProvidersA       :DWORD,:DWORD
procdesc WSAEnumNameSpaceProvidersW       :DWORD,:DWORD
procdesc WSAEnumNetworkEvents             :DWORD,:DWORD,:DWORD
procdesc WSAEnumProtocolsA                :DWORD,:DWORD,:DWORD
procdesc WSAEnumProtocolsW                :DWORD,:DWORD,:DWORD
procdesc WSAEventSelect                   :DWORD,:DWORD,:DWORD
procdesc WSAGetLastError                  
procdesc WSAGetOverlappedResult           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAGetQOSByName                  :DWORD,:DWORD,:DWORD
procdesc WSAGetServiceClassInfoA          :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAGetServiceClassInfoW          :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAGetServiceClassNameByClassIdA :DWORD,:DWORD,:DWORD
procdesc WSAGetServiceClassNameByClassIdW :DWORD,:DWORD,:DWORD
procdesc WSAHtonl                         :DWORD,:DWORD,:DWORD
procdesc WSAHtons                         :DWORD,:DWORD,:DWORD
procdesc WSAInstallServiceClassA          :DWORD
procdesc WSAInstallServiceClassW          :DWORD
procdesc WSAIoctl                         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAIsBlocking                    
procdesc WSAJoinLeaf                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSALookupServiceBeginA           :DWORD,:DWORD,:DWORD
procdesc WSALookupServiceBeginW           :DWORD,:DWORD,:DWORD
procdesc WSALookupServiceEnd              :DWORD
procdesc WSALookupServiceNextA            :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSALookupServiceNextW            :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSANtohl                         :DWORD,:DWORD,:DWORD
procdesc WSANtohs                         :DWORD,:DWORD,:DWORD
procdesc WSAProviderConfigChange          :DWORD,:DWORD,:DWORD
procdesc WSARecv                          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSARecvDisconnect                :DWORD,:DWORD
procdesc WSARecvFrom                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSARemoveServiceClass            :DWORD
procdesc WSAResetEvent                    :DWORD
procdesc WSASend                          :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSASendDisconnect                :DWORD,:DWORD
procdesc WSASendTo                        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSASetBlockingHook               :DWORD
procdesc WSASetEvent                      :DWORD
procdesc WSASetLastError                  :DWORD
procdesc WSASetServiceA                   :DWORD,:DWORD,:DWORD
procdesc WSASetServiceW                   :DWORD,:DWORD,:DWORD
procdesc WSASocketA                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSASocketW                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAStartup                       :DWORD,:DWORD
procdesc WSAStringToAddressA              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAStringToAddressW              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAUnhookBlockingHook            
procdesc WSAWaitForMultipleEvents         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSCDeinstallProvider             :DWORD,:DWORD
procdesc WSCEnableNSProvider              :DWORD,:DWORD
procdesc WSCEnumProtocols                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSCGetProviderPath               :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSCInstallNameSpace              :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSCInstallProvider               :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSCUnInstallNameSpace            :DWORD
procdesc WSCWriteNameSpaceOrder           :DWORD,:DWORD
procdesc WSCWriteProviderOrder            :DWORD,:DWORD
procdesc __WSAFDIsSet                     :DWORD,:DWORD
procdesc accept                           :DWORD,:DWORD,:DWORD
procdesc bind                             :DWORD,:DWORD,:DWORD
procdesc closesocket                      :DWORD
procdesc connect                          :DWORD,:DWORD,:DWORD
procdesc gethostbyaddr                    :DWORD,:DWORD,:DWORD
procdesc gethostbyname                    :DWORD
procdesc gethostname                      :DWORD,:DWORD
procdesc getpeername                      :DWORD,:DWORD,:DWORD
procdesc getprotobyname                   :DWORD
procdesc getprotobynumber                 :DWORD
procdesc getservbyname                    :DWORD,:DWORD
procdesc getservbyport                    :DWORD,:DWORD
procdesc getsockname                      :DWORD,:DWORD,:DWORD
procdesc getsockopt                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc htonl                            :DWORD
procdesc htons                            :DWORD
procdesc inet_addr                        :DWORD
procdesc inet_ntoa                        :DWORD
procdesc ioctlsocket                      :DWORD,:DWORD,:DWORD
procdesc listen                           :DWORD,:DWORD
procdesc ntohl                            :DWORD
procdesc ntohs                            :DWORD
procdesc recv                             :DWORD,:DWORD,:DWORD,:DWORD
procdesc recvfrom                         :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc select                           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc send                             :DWORD,:DWORD,:DWORD,:DWORD
procdesc sendto                           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc setsockopt                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc shutdown                         :DWORD,:DWORD
procdesc socket                           :DWORD,:DWORD,:DWORD
