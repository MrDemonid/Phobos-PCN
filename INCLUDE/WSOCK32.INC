ifndef @unicode
         EnumProtocols               equ <EnumProtocolsA>
         GetAddressByName            equ <GetAddressByNameA>
         GetNameByType               equ <GetNameByTypeA>
         GetService                  equ <GetServiceA>
         GetTypeByName               equ <GetTypeByNameA>
         SetService                  equ <SetServiceA>
    else
         EnumProtocols               equ <EnumProtocolsW>
         GetAddressByName            equ <GetAddressByNameW>
         GetNameByType               equ <GetNameByTypeW>
         GetService                  equ <GetServiceW>
         GetTypeByName               equ <GetTypeByNameW>
         SetService                  equ <SetServiceW>
endif ; @unicode

procdesc AcceptEx                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc EnumProtocolsA              :DWORD,:DWORD,:DWORD
procdesc EnumProtocolsW              :DWORD,:DWORD,:DWORD
procdesc GetAcceptExSockaddrs        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetAddressByNameA           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetAddressByNameW           :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetNameByTypeA              :DWORD,:DWORD,:DWORD
procdesc GetNameByTypeW              :DWORD,:DWORD,:DWORD
procdesc GetServiceA                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetServiceW                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc GetTypeByNameA              :DWORD,:DWORD
procdesc GetTypeByNameW              :DWORD,:DWORD
procdesc MigrateWinsockConfiguration :DWORD,:DWORD,:DWORD
procdesc NPLoadNameSpaces            :DWORD,:DWORD,:DWORD
procdesc SetServiceA                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc SetServiceW                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc TransmitFile                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WEP                         
procdesc WSAAsyncGetHostByAddr       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetHostByName       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetProtoByName      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetProtoByNumber    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetServByName       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncGetServByPort       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc WSAAsyncSelect              :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSACancelAsyncRequest       :DWORD
procdesc WSACancelBlockingCall       
procdesc WSACleanup                  
procdesc WSAGetLastError             
procdesc WSAIsBlocking               
procdesc WSARecvEx                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc WSASetBlockingHook          :DWORD
procdesc WSASetLastError             :DWORD
procdesc WSAStartup                  :DWORD,:DWORD
procdesc WSAUnhookBlockingHook       
procdesc __WSAFDIsSet                :DWORD,:DWORD
procdesc accept                      :DWORD,:DWORD,:DWORD
procdesc bind                        :DWORD,:DWORD,:DWORD
procdesc closesocket                 :DWORD
procdesc connect                     :DWORD,:DWORD,:DWORD
procdesc dn_expand                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc gethostbyaddr               :DWORD,:DWORD,:DWORD
procdesc gethostbyname               :DWORD
procdesc gethostname                 :DWORD,:DWORD
procdesc getnetbyname                :DWORD
procdesc getpeername                 :DWORD,:DWORD,:DWORD
procdesc getprotobyname              :DWORD
procdesc getprotobynumber            :DWORD
procdesc getservbyname               :DWORD,:DWORD
procdesc getservbyport               :DWORD,:DWORD
procdesc getsockname                 :DWORD,:DWORD,:DWORD
procdesc getsockopt                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc htonl                       :DWORD
procdesc htons                       :DWORD
procdesc inet_addr                   :DWORD
procdesc inet_network                :DWORD
procdesc inet_ntoa                   :DWORD
procdesc ioctlsocket                 :DWORD,:DWORD,:DWORD
procdesc listen                      :DWORD,:DWORD
procdesc ntohl                       :DWORD
procdesc ntohs                       :DWORD
procdesc rcmd                        :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc recv                        :DWORD,:DWORD,:DWORD,:DWORD
procdesc recvfrom                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc rexec                       :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc rresvport                   :DWORD
procdesc s_perror                    :DWORD,:DWORD
procdesc select                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc send                        :DWORD,:DWORD,:DWORD,:DWORD
procdesc sendto                      :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc sethostname                 :DWORD,:DWORD
procdesc setsockopt                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc shutdown                    :DWORD,:DWORD
procdesc socket                      :DWORD,:DWORD,:DWORD
