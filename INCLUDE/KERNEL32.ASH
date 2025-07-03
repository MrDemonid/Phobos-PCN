; KERNEL32.DLL structures and constants

struc SYSTEM_INFO
  wProcessorArchitecture      dw ?
  wReserved                   dw ?
  dwPageSize                  dd ?
  lpMinimumApplicationAddress dd ?
  lpMaximumApplicationAddress dd ?
  dwActiveProcessorMask       dd ?
  dwNumberOfProcessors        dd ?
  dwProcessorType             dd ?
  dwAllocationGranularity     dd ?
  wProcessorLevel             dw ?
  wProcessorRevision          dw ?
ends

struc OSVERSIONINFO
  dwOSVersionInfoSize dd ?
  dwMajorVersion      dd ?
  dwMinorVersion      dd ?
  dwBuildNumber       dd ?
  dwPlatformId        dd ?
  szCSDVersion        TCHAR 128 dup(?)
ends


struc MEMORYSTATUS
  dwiLength       dd ?
  dwMemoryLoad    dd ?
  dwTotalPhys     dd ?
  dwAvailPhys     dd ?
  dwTotalPageFile dd ?
  dwAvailPageFile dd ?
  dwTotalVirtual  dd ?
  dwAvailVirtual  dd ?
ends

struc STARTUPINFO
  cb              dd ?
  lpReserved      dd ?
  lpDesktop       dd ?
  lpTitle         dd ?
  dwX             dd ?
  dwY             dd ?
  dwXSize         dd ?
  dwYSize         dd ?
  dwXCountChars   dd ?
  dwYCountChars   dd ?
  dwFillAttribute dd ?
  dwFlags         dd ?
  wShowWindow     dw ?
  cbReserved2     dw ?
  lpReserved2     dd ?
  hStdInput       dd ?
  hStdOutput      dd ?
  hStdError       dd ?
ends

struc PROCESS_INFORMATION
  hProcess        dd ?
  hThread         dd ?
  dwProcessId     dd ?
  dwThreadId      dd ?
ends

struc FILETIME
  dwLowDateTime   dd ?
  dwHighDateTime  dd ?
ends

struc SYSTEMTIME
  wYear           dw ?
  wMonth          dw ?
  wDayOfWeek      dw ?
  wDay            dw ?
  wHour           dw ?
  wMinute         dw ?
  wSecond         dw ?
  wMilliseconds   dw ?
ends

struc BY_HANDLE_FILE_INFORMATION
  dwFileAttributes     dd ?
  ftCreationTime       FILETIME <>
  ftLastAccessTime     FILETIME <>
  ftLastWriteTime      FILETIME <>
  dwVolumeSerialNumber dd ?
  nFileSizeHigh        dd ?
  nFileSizeLow         dd ?
  nNumberOfLinks       dd ?
  nFileIndexHigh       dd ?
  nFileIndexLow        dd ?
ends

struc FINDDATA
  dwFileAttributes   dd ?
  ftCreationTime     FILETIME <>
  ftLastAccessTime   FILETIME <>
  ftLastWriteTime    FILETIME <>
  nFileSizeHigh      dd ?
  nFileSizeLow       dd ?
  dwReserved0        dd ?
  dwReserved1        dd ?
  cFileName          TCHAR 260 dup (?)
  cAlternateFileName TCHAR 14 dup (?)
ends

struc COMMPROP
  wPacketLength       dw ?
  wPacketVersion      dw ?
  dwServiceMask       dd ?
  dwReserved1         dd ?
  dwMaxTxQueue        dd ?
  dwMaxRxQueue        dd ?
  dwMaxBaud           dd ?
  dwProvSubType       dd ?
  dwProvCapabilities  dd ?
  dwSettableParams    dd ?
  dwSettableBaud      dd ?
  wSettableData       dw ?
  wSettableStopParity dw ?
  dwCurrentTxQueue    dd ?
  dwCurrentRxQueue    dd ?
  dwProvSpec1         dd ?
  dwProvSpec2         dd ?
  wcProvChar          dw 1 dup (?)
  filler              dw ?
ends

record COMRECORD fCtsHold:1, fDsrHold:1,fRlsdHold:1,fXoffHold:1,fXoffSent:1,fEof:1,fTxim:1,fReserved:25
struc COMSTAT
  comrec                        COMRECORD <>
  cbInQue                       dd ?
  cbOutQue                      dd ?
ends


record BITDCB   fBinary           :1,\  ; Binary Mode (skip EOF check)
                fParity           :1,\  ; Enable parity checking
                fOutxCtsFlow      :1,\  ; CTS handshaking on output
                fOutxDsrFlow      :1,\  ; DSR handshaking on output
                fDtrControl       :2,\  ; DTR Flow control
                fDsrSensitivity   :1,\  ; DSR Sensitivity
                fTXContinueOnXoff :1,\  ; Continue TX when Xoff sent
                fOutX             :1,\  ; Enable output X-ON/X-OFF
                fInX              :1,\  ; Enable input X-ON/X-OFF
                fErrorChar        :1,\  ; Enable Err Replacement
                fNull             :1,\  ; Enable Null stripping
                fRtsControl       :2,\  ; Rts Flow control
                fAbortOnError     :1,\  ; Abort all reads and writes on Error
                fDummy2           :17   ; Reserved

struc DCB
  DCBlength     dd ?                    ; sizeof(DCB)
  BaudRate      dd ?                    ; Baudrate at which running
  fbits         BITDCB <>
  wReserved     dw ?                    ; Not currently used
  XonLim        dw ?                    ; Transmit X-ON threshold
  XoffLim       dw ?                    ; Transmit X-OFF threshold
  ByteSize      db ?                    ; Number of bits/byte, 4-8
  Parity        db ?                    ; 0-4equNone,Odd,Even,Mark,Space
  StopBits      db ?                    ; 0,1,2 equ 1, 1.5, 2
  XonChar       db ?                    ; Tx and Rx X-ON character
  XoffChar      db ?                    ; Tx and Rx X-OFF character
  ErrorChar     db ?                    ; Error replacement char
  EofChar       db ?                    ; End of Input character
  EvtChar       db ?                    ; Received Event character
  wReserved1    dw ?                    ; Fill for now.
ends

struc COMMTIMEOUTS
  ReadIntervalTimeout           dd ?    ; Maximum time between read chars
  ReadTotalTimeoutMultiplier    dd ?    ; Multiplier of characters
  ReadTotalTimeoutConstant      dd ?    ; Constant in milliseconds
  WriteTotalTimeoutMultiplier   dd ?    ; Multiplier of characters
  WriteTotalTimeoutConstant     dd ?    ; Constant in milliseconds
ends

struc COMMCONFIG
  dwSize                dd ?            ; Size of the entire struct
  wVersion              dw ?            ; version of the structure
  wReserved             dw ?            ; alignment
  dcbx                  DCB <>          ; device control block
  dwProviderSubType     dd ?            ; ordinal value for identifying provider-defined data structure format
  dwProviderOffset      dd ?            ; Specifies the offset of provider specific data field in bytes from the start
  dwProviderSize        dd ?            ; size of the provider-specific data field
  wcProviderData        dw ?            ; provider-specific data
ends

struc OVERLAPPED
  Internal              dd ?
  InternalHigh          dd ?
  loffset               dd ?
  OffsetHigh            dd ?
  hEvent                dd ?
ends



; General constants

;NULL                    equ 0
;TRUE                    equ 1
;FALSE                   equ 0

MAX_PATH                  equ 260

; Access rights

DELETE_RIGHT              equ 00010000h
READ_CONTROL              equ 00020000h
WRITE_DAC                 equ 00040000h
WRITE_OWNER               equ 00080000h
SYNCHRONIZE               equ 00100000h
STANDARD_RIGHTS_READ      equ READ_CONTROL
STANDARD_RIGHTS_WRITE     equ READ_CONTROL
STANDARD_RIGHTS_EXECUTE   equ READ_CONTROL
STANDARD_RIGHTS_REQUIRED  equ 000F0000h
STANDARD_RIGHTS_ALL       equ 001F0000h
SPECIFIC_RIGHTS_ALL       equ 0000FFFFh
ACCESS_SYSTEM_SECURITY    equ 01000000h
MAXIMUM_ALLOWED           equ 02000000h
GENERIC_READ              equ 80000000h
GENERIC_WRITE             equ 40000000h
GENERIC_EXECUTE           equ 20000000h
GENERIC_ALL               equ 10000000h
PROCESS_TERMINATE         equ 00000001h
PROCESS_CREATE_THREAD     equ 00000002h
PROCESS_VM_OPERATION      equ 00000008h
PROCESS_VM_READ           equ 00000010h
PROCESS_VM_WRITE          equ 00000020h
PROCESS_DUP_HANDLE        equ 00000040h
PROCESS_CREATE_PROCESS    equ 00000080h
PROCESS_SET_QUOTA         equ 00000100h
PROCESS_SET_INFORMATION   equ 00000200h
PROCESS_QUERY_INFORMATION equ 00000400h
PROCESS_ALL_ACCESS        equ STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0FFFh
FILE_SHARE_READ           equ 00000001h
FILE_SHARE_WRITE          equ 00000002h
FILE_SHARE_DELETE         equ 00000004h

; CreateFile actions

CREATE_NEW              equ 1
CREATE_ALWAYS           equ 2
OPEN_EXISTING           equ 3
OPEN_ALWAYS             equ 4
TRUNCATE_EXISTING       equ 5

; OpenFile modes

OF_READ                 equ 0000h
OF_WRITE                equ 0001h
OF_READWRITE            equ 0002h
OF_SHARE_COMPAT         equ 0000h
OF_SHARE_EXCLUSIVE      equ 0010h
OF_SHARE_DENY_WRITE     equ 0020h
OF_SHARE_DENY_READ      equ 0030h
OF_SHARE_DENY_NONE      equ 0040h
OF_PARSE                equ 0100h
OF_DELETE               equ 0200h
OF_VERIFY               equ 0400h
OF_CANCEL               equ 0800h
OF_CREATE               equ 1000h
OF_PROMPT               equ 2000h
OF_EXIST                equ 4000h
OF_REOPEN               equ 8000h

; SetFilePointer methods

FILE_BEGIN              equ 0
FILE_CURRENT            equ 1
FILE_END                equ 2

; File attributes

FILE_ATTRIBUTE_READONLY   equ 001h
FILE_ATTRIBUTE_HIDDEN     equ 002h
FILE_ATTRIBUTE_SYSTEM     equ 004h
FILE_ATTRIBUTE_DIRECTORY  equ 010h
FILE_ATTRIBUTE_ARCHIVE    equ 020h
FILE_ATTRIBUTE_NORMAL     equ 080h
FILE_ATTRIBUTE_TEMPORARY  equ 100h
FILE_ATTRIBUTE_COMPRESSED equ 800h

; File flags

FILE_FLAG_WRITE_THROUGH    equ 80000000h
FILE_FLAG_OVERLAPPED       equ 40000000h
FILE_FLAG_NO_BUFFERING     equ 20000000h
FILE_FLAG_RANDOM_ACCESS    equ 10000000h
FILE_FLAG_SEQUENTIAL_SCAN  equ 08000000h
FILE_FLAG_DELETE_ON_CLOSE  equ 04000000h
FILE_FLAG_BACKUP_SEMANTICS equ 02000000h
FILE_FLAG_POSIX_SEMANTICS  equ 01000000h

; Notify filters

FILE_NOTIFY_CHANGE_FILE_NAME  equ 001h
FILE_NOTIFY_CHANGE_DIR_NAME   equ 002h
FILE_NOTIFY_CHANGE_ATTRIBUTES equ 004h
FILE_NOTIFY_CHANGE_SIZE       equ 008h
FILE_NOTIFY_CHANGE_LAST_WRITE equ 010h
FILE_NOTIFY_CHANGE_SECURITY   equ 100h

; File types

FILE_TYPE_UNKNOWN       equ 0
FILE_TYPE_DISK          equ 1
FILE_TYPE_CHAR          equ 2
FILE_TYPE_PIPE          equ 3
FILE_TYPE_REMOTE        equ 8000h

; LockFileEx flags

LOCKFILE_FAIL_IMMEDIATELY equ 1
LOCKFILE_EXCLUSIVE_LOCK   equ 2

; MoveFileEx flags

MOVEFILE_REPLACE_EXISTING   equ 1
MOVEFILE_COPY_ALLOWED       equ 2
MOVEFILE_DELAY_UNTIL_REBOOT equ 4
MOVEFILE_WRITE_THROUGH      equ 8

; FindFirstFileEx flags

FIND_FIRST_EX_CASE_SENSITIVE equ 1

; Device handles

INVALID_HANDLE_VALUE    equ -1
STD_INPUT_HANDLE        equ -10
STD_OUTPUT_HANDLE       equ -11
STD_ERROR_HANDLE        equ -12

; DuplicateHandle options

DUPLICATE_CLOSE_SOURCE  equ 1
DUPLICATE_SAME_ACCESS   equ 2

; File mapping acccess rights

SECTION_QUERY           equ 01h
SECTION_MAP_WRITE       equ 02h
SECTION_MAP_READ        equ 04h
SECTION_MAP_EXECUTE     equ 08h
SECTION_EXTEND_SIZE     equ 10h
SECTION_ALL_ACCESS      equ STANDARD_RIGHTS_REQUIRED or SECTION_QUERY or SECTION_MAP_WRITE or SECTION_MAP_READ or SECTION_MAP_EXECUTE or SECTION_EXTEND_SIZE
FILE_MAP_COPY           equ SECTION_QUERY
FILE_MAP_WRITE          equ SECTION_MAP_WRITE
FILE_MAP_READ           equ SECTION_MAP_READ
FILE_MAP_ALL_ACCESS     equ SECTION_ALL_ACCESS

; File system flags

FILE_CASE_SENSITIVE_SEARCH equ 0001h
FILE_CASE_PRESERVED_NAMES  equ 0002h
FILE_UNICODE_ON_DISK       equ 0004h
FILE_PERSISTENT_ACLS       equ 0008h
FILE_FILE_COMPRESSION      equ 0010h
FILE_VOLUME_IS_COMPRESSED  equ 8000h
FS_CASE_IS_PRESERVED       equ FILE_CASE_PRESERVED_NAMES
FS_CASE_SENSITIVE          equ FILE_CASE_SENSITIVE_SEARCH
FS_UNICODE_STORED_ON_DISK  equ FILE_UNICODE_ON_DISK
FS_PERSISTENT_ACLS         equ FILE_PERSISTENT_ACLS

; Drive types

DRIVE_UNKNOWN           equ 0
DRIVE_NO_ROOT_DIR       equ 1
DRIVE_REMOVABLE         equ 2
DRIVE_FIXED             equ 3
DRIVE_REMOTE            equ 4
DRIVE_CDROM             equ 5
DRIVE_RAMDISK           equ 6

; Pipe modes

PIPE_ACCESS_INBOUND      equ 1
PIPE_ACCESS_OUTBOUND     equ 2
PIPE_ACCESS_DUPLEX       equ 3
PIPE_CLIENT_END          equ 0
PIPE_SERVER_END          equ 1
PIPE_WAIT                equ 0
PIPE_NOWAIT              equ 1
PIPE_READMODE_BYTE       equ 0
PIPE_READMODE_MESSAGE    equ 2
PIPE_TYPE_BYTE           equ 0
PIPE_TYPE_MESSAGE        equ 4
PIPE_UNLIMITED_INSTANCES equ 255

; Global memory flags

GMEM_FIXED              equ 0000h
GMEM_MOVEABLE           equ 0002h
GMEM_NOCOMPACT          equ 0010h
GMEM_NODISCARD          equ 0020h
GMEM_ZEROINIT           equ 0040h
GMEM_MODIFY             equ 0080h
GMEM_DISCARDABLE        equ 0100h
GMEM_NOT_BANKED         equ 1000h
GMEM_SHARE              equ 2000h
GMEM_DDESHARE           equ 2000h
GMEM_NOTIFY             equ 4000h
GMEM_LOWER              equ GMEM_NOT_BANKED
GMEM_VALID_FLAGS        equ 7F72h
GMEM_INVALID_HANDLE     equ 8000h
GMEM_DISCARDED          equ 4000h
GMEM_LOCKCOUNT          equ 0FFh
GHND                    equ GMEM_MOVEABLE + GMEM_ZEROINIT
GPTR                    equ GMEM_FIXED + GMEM_ZEROINIT

; Local memory flags

LMEM_FIXED              equ 0000h
LMEM_MOVEABLE           equ 0002h
LMEM_NOCOMPACT          equ 0010h
LMEM_NODISCARD          equ 0020h
LMEM_ZEROINIT           equ 0040h
LMEM_MODIFY             equ 0080h
LMEM_DISCARDABLE        equ 0F00h
LMEM_VALID_FLAGS        equ 0F72h
LMEM_INVALID_HANDLE     equ 8000h
LHND                    equ LMEM_MOVEABLE + LMEM_ZEROINIT
LPTR                    equ LMEM_FIXED + LMEM_ZEROINIT
LMEM_DISCARDED          equ 4000h
LMEM_LOCKCOUNT          equ 00FFh

; Page access flags

PAGE_NOACCESS           equ 001h
PAGE_READONLY           equ 002h
PAGE_READWRITE          equ 004h
PAGE_WRITECOPY          equ 008h
PAGE_EXECUTE            equ 010h
PAGE_EXECUTE_READ       equ 020h
PAGE_EXECUTE_READWRITE  equ 040h
PAGE_EXECUTE_WRITECOPY  equ 080h
PAGE_GUARD              equ 100h
PAGE_NOCACHE            equ 200h

; Memory allocation flags

MEM_COMMIT              equ 001000h
MEM_RESERVE             equ 002000h
MEM_DECOMMIT            equ 004000h
MEM_RELEASE             equ 008000h
MEM_FREE                equ 010000h
MEM_PRIVATE             equ 020000h
MEM_MAPPED              equ 040000h
MEM_RESET               equ 080000h
MEM_TOP_DOWN            equ 100000h

; Heap allocation flags

HEAP_NO_SERIALIZE        equ 1
HEAP_GENERATE_EXCEPTIONS equ 4
HEAP_ZERO_MEMORY         equ 8

; Platform identifiers

VER_PLATFORM_WIN32s        equ 0
VER_PLATFORM_WIN32_WINDOWS equ 1
VER_PLATFORM_WIN32_NT      equ 2

; GetBinaryType return values

SCS_32BIT_BINARY        equ 0
SCS_DOS_BINARY          equ 1
SCS_WOW_BINARY          equ 2
SCS_PIF_BINARY          equ 3
SCS_POSIX_BINARY        equ 4
SCS_OS216_BINARY        equ 5

; CreateProcess flags

DEBUG_PROCESS            equ 001h
DEBUG_ONLY_THIS_PROCESS  equ 002h
CREATE_SUSPENDED         equ 004h
DETACHED_PROCESS         equ 008h
CREATE_NEW_CONSOLE       equ 010h
NORMAL_PRIORITY_CLASS    equ 020h
IDLE_PRIORITY_CLASS      equ 040h
HIGH_PRIORITY_CLASS      equ 080h
REALTIME_PRIORITY_CLASS  equ 100h
CREATE_NEW_PROCESS_GROUP equ 200h
CREATE_SEPARATE_WOW_VDM  equ 800h

; Thread priority values

THREAD_BASE_PRIORITY_MIN      equ -2
THREAD_BASE_PRIORITY_MAX      equ 2
THREAD_BASE_PRIORITY_LOWRT    equ 15
THREAD_BASE_PRIORITY_IDLE     equ -15
THREAD_PRIORITY_LOWEST        equ THREAD_BASE_PRIORITY_MIN
THREAD_PRIORITY_BELOW_NORMAL  equ THREAD_PRIORITY_LOWEST + 1
THREAD_PRIORITY_NORMAL        equ 0
THREAD_PRIORITY_HIGHEST       equ THREAD_BASE_PRIORITY_MAX
THREAD_PRIORITY_ABOVE_NORMAL  equ THREAD_PRIORITY_HIGHEST - 1
THREAD_PRIORITY_ERROR_RETURN  equ 7FFFFFFFh
THREAD_PRIORITY_TIME_CRITICAL equ THREAD_BASE_PRIORITY_LOWRT
THREAD_PRIORITY_IDLE          equ THREAD_BASE_PRIORITY_IDLE

; Startup flags

STARTF_USESHOWWINDOW    equ 001h
STARTF_USESIZE          equ 002h
STARTF_USEPOSITION      equ 004h
STARTF_USECOUNTCHARS    equ 008h
STARTF_USEFILLATTRIBUTE equ 010h
STARTF_RUNFULLSCREEN    equ 020h
STARTF_FORCEONFEEDBACK  equ 040h
STARTF_FORCEOFFFEEDBACK equ 080h
STARTF_USESTDHANDLES    equ 100h

; Shutdown flags

SHUTDOWN_NORETRY        equ 1h

; LoadLibraryEx flags

DONT_RESOLVE_DLL_REFERENCES   equ 1
LOAD_LIBRARY_AS_DATAFILE      equ 2
LOAD_WITH_ALTERED_SEARCH_PATH equ 8

; DLL entry-point calls

DLL_PROCESS_DETACH      equ 0
DLL_PROCESS_ATTACH      equ 1
DLL_THREAD_ATTACH       equ 2
DLL_THREAD_DETACH       equ 3

; Status codes

STATUS_WAIT_0                   equ 000000000h
STATUS_ABANDONED_WAIT_0         equ 000000080h
STATUS_USER_APC                 equ 0000000C0h
STATUS_TIMEOUT                  equ 000000102h
STATUS_PENDING                  equ 000000103h
STATUS_DATATYPE_MISALIGNMENT    equ 080000002h
STATUS_BREAKPOINT               equ 080000003h
STATUS_SINGLE_STEP              equ 080000004h
STATUS_ACCESS_VIOLATION         equ 0C0000005h
STATUS_IN_PAGE_ERROR            equ 0C0000006h
STATUS_NO_MEMORY                equ 0C0000017h
STATUS_ILLEGAL_INSTRUCTION      equ 0C000001Dh
STATUS_NONCONTINUABLE_EXCEPTION equ 0C0000025h
STATUS_INVALID_DISPOSITION      equ 0C0000026h
STATUS_ARRAY_BOUNDS_EXCEEDED    equ 0C000008Ch
STATUS_FLOAT_DENORMAL_OPERAND   equ 0C000008Dh
STATUS_FLOAT_DIVIDE_BY_ZERO     equ 0C000008Eh
STATUS_FLOAT_INEXACT_RESULT     equ 0C000008Fh
STATUS_FLOAT_INVALID_OPERATION  equ 0C0000090h
STATUS_FLOAT_OVERFLOW           equ 0C0000091h
STATUS_FLOAT_STACK_CHECK        equ 0C0000092h
STATUS_FLOAT_UNDERFLOW          equ 0C0000093h
STATUS_INTEGER_DIVIDE_BY_ZERO   equ 0C0000094h
STATUS_INTEGER_OVERFLOW         equ 0C0000095h
STATUS_PRIVILEGED_INSTRUCTION   equ 0C0000096h
STATUS_STACK_OVERFLOW           equ 0C00000FDh
STATUS_CONTROL_C_EXIT           equ 0C000013Ah
WAIT_FAILED                     equ -1
WAIT_OBJECT_0                   equ STATUS_WAIT_0
WAIT_ABANDONED                  equ STATUS_ABANDONED_WAIT_0
WAIT_ABANDONED_0                equ STATUS_ABANDONED_WAIT_0
WAIT_TIMEOUT                    equ STATUS_TIMEOUT
WAIT_IO_COMPLETION              equ STATUS_USER_APC
STILL_ACTIVE                    equ STATUS_PENDING

; wait
MAXIMUM_WAIT_OBJECTS            equ 64
MAXIMUM_SUSPEND_COUNT           equ 127

; Exception codes

EXCEPTION_CONTINUABLE           equ 0
EXCEPTION_NONCONTINUABLE        equ 1
EXCEPTION_ACCESS_VIOLATION      equ STATUS_ACCESS_VIOLATION
EXCEPTION_DATATYPE_MISALIGNMENT equ STATUS_DATATYPE_MISALIGNMENT
EXCEPTION_BREAKPOINT            equ STATUS_BREAKPOINT
EXCEPTION_SINGLE_STEP           equ STATUS_SINGLE_STEP
EXCEPTION_ARRAY_BOUNDS_EXCEEDED equ STATUS_ARRAY_BOUNDS_EXCEEDED
EXCEPTION_FLT_DENORMAL_OPERAND  equ STATUS_FLOAT_DENORMAL_OPERAND
EXCEPTION_FLT_DIVIDE_BY_ZERO    equ STATUS_FLOAT_DIVIDE_BY_ZERO
EXCEPTION_FLT_INEXACT_RESULT    equ STATUS_FLOAT_INEXACT_RESULT
EXCEPTION_FLT_INVALID_OPERATION equ STATUS_FLOAT_INVALID_OPERATION
EXCEPTION_FLT_OVERFLOW          equ STATUS_FLOAT_OVERFLOW
EXCEPTION_FLT_STACK_CHECK       equ STATUS_FLOAT_STACK_CHECK
EXCEPTION_FLT_UNDERFLOW         equ STATUS_FLOAT_UNDERFLOW
EXCEPTION_INT_DIVIDE_BY_ZERO    equ STATUS_INTEGER_DIVIDE_BY_ZERO
EXCEPTION_INT_OVERFLOW          equ STATUS_INTEGER_OVERFLOW
EXCEPTION_ILLEGAL_INSTRUCTION   equ STATUS_ILLEGAL_INSTRUCTION
EXCEPTION_PRIV_INSTRUCTION      equ STATUS_PRIVILEGED_INSTRUCTION
EXCEPTION_IN_PAGE_ERROR         equ STATUS_IN_PAGE_ERROR

; Registry options

REG_OPTION_RESERVED            equ 0
REG_OPTION_NON_VOLATILE        equ 0
REG_OPTION_VOLATILE            equ 1
REG_OPTION_CREATE_LINK         equ 2
REG_OPTION_BACKUP_RESTORE      equ 4
REG_CREATED_NEW_KEY            equ 1
REG_OPENED_EXISTING_KEY        equ 2
REG_WHOLE_HIVE_VOLATILE        equ 1
REG_REFRESH_HIVE               equ 2
REG_NOTIFY_CHANGE_NAME         equ 1
REG_NOTIFY_CHANGE_ATTRIBUTES   equ 2
REG_NOTIFY_CHANGE_LAST_SET     equ 4
REG_NOTIFY_CHANGE_SECURITY     equ 8
REG_LEGAL_CHANGE_FILTER        equ REG_NOTIFY_CHANGE_NAME or REG_NOTIFY_CHANGE_ATTRIBUTES or REG_NOTIFY_CHANGE_LAST_SET or REG_NOTIFY_CHANGE_SECURITY
REG_LEGAL_OPTION               equ REG_OPTION_RESERVED or REG_OPTION_NON_VOLATILE or REG_OPTION_VOLATILE or REG_OPTION_CREATE_LINK or REG_OPTION_BACKUP_RESTORE
REG_NONE                       equ 0
REG_SZ                         equ 1
REG_EXPAND_SZ                  equ 2
REG_BINARY                     equ 3
REG_DWORD                      equ 4
REG_DWORD_LITTLE_ENDIAN        equ 4
REG_DWORD_BIG_ENDIAN           equ 5
REG_LINK                       equ 6
REG_MULTI_SZ                   equ 7
REG_RESOURCE_LIST              equ 8
REG_FULL_RESOURCE_DESCRIPTOR   equ 9
REG_RESOURCE_REQUIREMENTS_LIST equ 10

; Registry access modes

KEY_QUERY_VALUE         equ 1
KEY_SET_VALUE           equ 2
KEY_CREATE_SUB_KEY      equ 4
KEY_ENUMERATE_SUB_KEYS  equ 8
KEY_NOTIFY              equ 10h
KEY_CREATE_LINK         equ 20h
KEY_READ                equ STANDARD_RIGHTS_READ or KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS or KEY_NOTIFY and not SYNCHRONIZE
KEY_WRITE               equ STANDARD_RIGHTS_WRITE or KEY_SET_VALUE or KEY_CREATE_SUB_KEY and not SYNCHRONIZE
KEY_EXECUTE             equ KEY_READ
KEY_ALL_ACCESS          equ STANDARD_RIGHTS_ALL or KEY_QUERY_VALUE or KEY_SET_VALUE or KEY_CREATE_SUB_KEY or KEY_ENUMERATE_SUB_KEYS or KEY_NOTIFY or KEY_CREATE_LINK and not SYNCHRONIZE

; Predefined registry keys

HKEY_CLASSES_ROOT       equ 80000000h
HKEY_CURRENT_USER       equ 80000001h
HKEY_LOCAL_MACHINE      equ 80000002h
HKEY_USERS              equ 80000003h
HKEY_PERFORMANCE_DATA   equ 80000004h
HKEY_CURRENT_CONFIG     equ 80000005h
HKEY_DYN_DATA           equ 80000006h

; FormatMessage flags

FORMAT_MESSAGE_ALLOCATE_BUFFER equ 0100h
FORMAT_MESSAGE_IGNORE_INSERTS  equ 0200h
FORMAT_MESSAGE_FROM_STRING     equ 0400h
FORMAT_MESSAGE_FROM_HMODULE    equ 0800h
FORMAT_MESSAGE_FROM_SYSTEM     equ 1000h
FORMAT_MESSAGE_ARGUMENT_ARRAY  equ 2000h
FORMAT_MESSAGE_MAX_WIDTH_MASK  equ 00FFh

; Language identifiers

LANG_NEUTRAL            equ 00h
LANG_BULGARIAN          equ 02h
LANG_CHINESE            equ 04h
LANG_CROATIAN           equ 1Ah
LANG_CZECH              equ 05h
LANG_DANISH             equ 06h
LANG_DUTCH              equ 13h
LANG_ENGLISH            equ 09h
LANG_FINNISH            equ 0Bh
LANG_FRENCH             equ 0Ch
LANG_GERMAN             equ 07h
LANG_GREEK              equ 08h
LANG_HUNGARIAN          equ 0Eh
LANG_ICELANDIC          equ 0Fh
LANG_ITALIAN            equ 10h
LANG_JAPANESE           equ 11h
LANG_KOREAN             equ 12h
LANG_NORWEGIAN          equ 14h
LANG_POLISH             equ 15h
LANG_PORTUGUESE         equ 16h
LANG_ROMANIAN           equ 18h
LANG_RUSSIAN            equ 19h
LANG_SLOVAK             equ 1Bh
LANG_SLOVENIAN          equ 24h
LANG_SPANISH            equ 0Ah
LANG_SWEDISH            equ 1Dh
LANG_THAI               equ 1Eh
LANG_TURKISH            equ 1Fh

; Sublanguage identifiers

SUBLANG_NEUTRAL              equ 00h shl 10
SUBLANG_DEFAULT              equ 01h shl 10
SUBLANG_SYS_DEFAULT          equ 02h shl 10
SUBLANG_CHINESE_TRADITIONAL  equ 01h shl 10
SUBLANG_CHINESE_SIMPLIFIED   equ 02h shl 10
SUBLANG_CHINESE_HONGKONG     equ 03h shl 10
SUBLANG_CHINESE_SINGAPORE    equ 04h shl 10
SUBLANG_DUTCH                equ 01h shl 10
SUBLANG_DUTCH_BELGIAN        equ 02h shl 10
SUBLANG_ENGLISH_US           equ 01h shl 10
SUBLANG_ENGLISH_UK           equ 02h shl 10
SUBLANG_ENGLISH_AUS          equ 03h shl 10
SUBLANG_ENGLISH_CAN          equ 04h shl 10
SUBLANG_ENGLISH_NZ           equ 05h shl 10
SUBLANG_ENGLISH_EIRE         equ 06h shl 10
SUBLANG_FRENCH               equ 01h shl 10
SUBLANG_FRENCH_BELGIAN       equ 02h shl 10
SUBLANG_FRENCH_CANADIAN      equ 03h shl 10
SUBLANG_FRENCH_SWISS         equ 04h shl 10
SUBLANG_GERMAN               equ 01h shl 10
SUBLANG_GERMAN_SWISS         equ 02h shl 10
SUBLANG_GERMAN_AUSTRIAN      equ 03h shl 10
SUBLANG_ITALIAN              equ 01h shl 10
SUBLANG_ITALIAN_SWISS        equ 02h shl 10
SUBLANG_NORWEGIAN_BOKMAL     equ 01h shl 10
SUBLANG_NORWEGIAN_NYNORSK    equ 02h shl 10
SUBLANG_PORTUGUESE           equ 02h shl 10
SUBLANG_PORTUGUESE_BRAZILIAN equ 01h shl 10
SUBLANG_SPANISH              equ 01h shl 10
SUBLANG_SPANISH_MEXICAN      equ 02h shl 10
SUBLANG_SPANISH_MODERN       equ 03h shl 10

; Sorting identifiers

SORT_DEFAULT             equ 0 shl 16
SORT_JAPANESE_XJIS       equ 0 shl 16
SORT_JAPANESE_UNICODE    equ 1 shl 16
SORT_CHINESE_BIG5        equ 0 shl 16
SORT_CHINESE_PRCP        equ 0 shl 16
SORT_CHINESE_UNICODE     equ 1 shl 16
SORT_CHINESE_PRC         equ 2 shl 16
SORT_CHINESE_BOPOMOFO    equ 3 shl 16
SORT_KOREAN_KSC          equ 0 shl 16
SORT_KOREAN_UNICODE      equ 1 shl 16
SORT_GERMAN_PHONE_BOOK   equ 1 shl 16
SORT_HUNGARIAN_DEFAULT   equ 0 shl 16
SORT_HUNGARIAN_TECHNICAL equ 1 shl 16

; Resource types

RT_CURSOR               equ 1
RT_BITMAP               equ 2
RT_ICON                 equ 3
RT_MENU                 equ 4
RT_DIALOG               equ 5
RT_STRING               equ 6
RT_FONTDIR              equ 7
RT_FONT                 equ 8
RT_ACCELERATOR          equ 9
RT_RCDATA               equ 10
RT_MESSAGETABLE         equ 11
RT_GROUP_CURSOR         equ 12
RT_GROUP_ICON           equ 14
RT_VERSION              equ 16
RT_DLGINCLUDE           equ 17
RT_PLUGPLAY             equ 19
RT_VXD                  equ 20
RT_ANICURSOR            equ 21
RT_ANIICON              equ 22
RT_HTML                 equ 23
RT_MANIFEST             equ 24

; Clipboard formats

CF_TEXT                 equ 001h
CF_BITMAP               equ 002h
CF_METAFILEPICT         equ 003h
CF_SYLK                 equ 004h
CF_DIF                  equ 005h
CF_TIFF                 equ 006h
CF_OEMTEXT              equ 007h
CF_DIB                  equ 008h
CF_PALETTE              equ 009h
CF_PENDATA              equ 00Ah
CF_RIFF                 equ 00Bh
CF_WAVE                 equ 00Ch
CF_UNICODETEXT          equ 00Dh
CF_ENHMETAFILE          equ 00Eh
CF_HDROP                equ 00Fh
CF_LOCALE               equ 010h
CF_OWNERDISPLAY         equ 080h
CF_DSPTEXT              equ 081h
CF_DSPBITMAP            equ 082h
CF_DSPMETAFILEPICT      equ 083h
CF_DSPENHMETAFILE       equ 08Eh
CF_PRIVATEFIRST         equ 200h
CF_PRIVATELAST          equ 2FFh
CF_GDIOBJFIRST          equ 300h
CF_GDIOBJLAST           equ 3FFh

; OS types for version info

VOS_UNKNOWN             equ 00000000h
VOS_DOS                 equ 00010000h
VOS_OS216               equ 00020000h
VOS_OS232               equ 00030000h
VOS_NT                  equ 00040000h
VOS__BASE               equ 00000000h
VOS__WINDOWS16          equ 00000001h
VOS__PM16               equ 00000002h
VOS__PM32               equ 00000003h
VOS__WINDOWS32          equ 00000004h
VOS_DOS_WINDOWS16       equ 00010001h
VOS_DOS_WINDOWS32       equ 00010004h
VOS_OS216_PM16          equ 00020002h
VOS_OS232_PM32          equ 00030003h
VOS_NT_WINDOWS32        equ 00040004h

; File types for version info

VFT_UNKNOWN             equ 00000000h
VFT_APP                 equ 00000001h
VFT_DLL                 equ 00000002h
VFT_DRV                 equ 00000003h
VFT_FONT                equ 00000004h
VFT_VXD                 equ 00000005h
VFT_STATIC_LIB          equ 00000007h

; File subtypes for version info

VFT2_UNKNOWN               equ 00000000h
VFT2_DRV_PRINTER           equ 00000001h
VFT2_DRV_KEYBOARD          equ 00000002h
VFT2_DRV_LANGUAGE          equ 00000003h
VFT2_DRV_DISPLAY           equ 00000004h
VFT2_DRV_MOUSE             equ 00000005h
VFT2_DRV_NETWORK           equ 00000006h
VFT2_DRV_SYSTEM            equ 00000007h
VFT2_DRV_INSTALLABLE       equ 00000008h
VFT2_DRV_SOUND             equ 00000009h
VFT2_DRV_COMM              equ 0000000Ah
VFT2_DRV_INPUTMETHOD       equ 0000000Bh
VFT2_DRV_VERSIONED_PRINTER equ 0000000Ch
VFT2_FONT_RASTER           equ 00000001h
VFT2_FONT_VECTOR           equ 00000002h
VFT2_FONT_TRUETYPE         equ 00000003h


; Serial provider type.

SP_SERIALCOMM           equ 00000001h

; Provider SubTypes

PST_UNSPECIFIED         equ 00000000h
PST_RS232               equ 00000001h
PST_PARALLELPORT        equ 00000002h
PST_RS422               equ 00000003h
PST_RS423               equ 00000004h
PST_RS449               equ 00000005h
PST_MODEM               equ 00000006h
PST_FAX                 equ 00000021h
PST_SCANNER             equ 00000022h
PST_NETWORK_BRIDGE      equ 00000100h
PST_LAT                 equ 00000101h
PST_TCPIP_TELNET        equ 00000102h
PST_X25                 equ 00000103h

; Provider capabilities flags.

PCF_DTRDSR              equ 0001h
PCF_RTSCTS              equ 0002h
PCF_RLSD                equ 0004h
PCF_PARITY_CHECK        equ 0008h
PCF_XONXOFF             equ 0010h
PCF_SETXCHAR            equ 0020h
PCF_TOTALTIMEOUTS       equ 0040h
PCF_INTTIMEOUTS         equ 0080h
PCF_SPECIALCHARS        equ 0100h
PCF_16BITMODE           equ 0200h

; Comm provider settable parameters.

SP_PARITY               equ 0001h
SP_BAUD                 equ 0002h
SP_DATABITS             equ 0004h
SP_STOPBITS             equ 0008h
SP_HANDSHAKING          equ 0010h
SP_PARITY_CHECK         equ 0020h
SP_RLSD                 equ 0040h

; Settable baud rates in the provider.

BAUD_075                equ 00000001h
BAUD_110                equ 00000002h
BAUD_134_5              equ 00000004h
BAUD_150                equ 00000008h
BAUD_300                equ 00000010h
BAUD_600                equ 00000020h
BAUD_1200               equ 00000040h
BAUD_1800               equ 00000080h
BAUD_2400               equ 00000100h
BAUD_4800               equ 00000200h
BAUD_7200               equ 00000400h
BAUD_9600               equ 00000800h
BAUD_14400              equ 00001000h
BAUD_19200              equ 00002000h
BAUD_38400              equ 00004000h
BAUD_56K                equ 00008000h
BAUD_128K               equ 00010000h
BAUD_115200             equ 00020000h
BAUD_57600              equ 00040000h
BAUD_USER               equ 10000000h

; Settable Data Bits

DATABITS_5              equ 0001h
DATABITS_6              equ 0002h
DATABITS_7              equ 0004h
DATABITS_8              equ 0008h
DATABITS_16             equ 0010h
DATABITS_16X            equ 0020h

; Settable Stop and Parity bits.

STOPBITS_10             equ 0001h
STOPBITS_15             equ 0002h
STOPBITS_20             equ 0004h
PARITY_NONE             equ 0100h
PARITY_ODD              equ 0200h
PARITY_EVEN             equ 0400h
PARITY_MARK             equ 0800h
PARITY_SPACE            equ 1000h

; Set dwProvSpec1 to COMMPROP_INITIALIZED to indicate that wPacketLength
; is valid before a call to GetCommProperties().

COMMPROP_INITIALIZED    equ 0E73CF52Eh

; DTR Control Flow Values.

DTR_CONTROL_DISABLE     equ 00
DTR_CONTROL_ENABLE      equ 01
DTR_CONTROL_HANDSHAKE   equ 02

; RTS Control Flow Values

RTS_CONTROL_DISABLE     equ 00
RTS_CONTROL_ENABLE      equ 01
RTS_CONTROL_HANDSHAKE   equ 02
RTS_CONTROL_TOGGLE      equ 03

;

NOPARITY                equ 0
ODDPARITY               equ 1
EVENPARITY              equ 2
MARKPARITY              equ 3
SPACEPARITY             equ 4

ONESTOPBIT              equ 0
ONE5STOPBITS            equ 1
TWOSTOPBITS             equ 2

IGNORE                  equ 0             ; Ignore signal
INFINITE                equ 0FFFFFFFFh    ; Infinite timeout

WAIT_OBJECT_0           equ 0
WAIT_OBJECT_1           equ 1

; Baud rates at which the communication device operates

CBR_110                 equ 110
CBR_300                 equ 300
CBR_600                 equ 600
CBR_1200                equ 1200
CBR_2400                equ 2400
CBR_4800                equ 4800
CBR_9600                equ 9600
CBR_14400               equ 14400
CBR_19200               equ 19200
CBR_38400               equ 38400
CBR_56000               equ 56000
CBR_57600               equ 57600
CBR_115200              equ 115200
CBR_128000              equ 128000
CBR_256000              equ 256000

; Error Flags

CE_RXOVER               equ 0001h ; Receive Queue overflow
CE_OVERRUN              equ 0002h ; Receive Overrun Error
CE_RXPARITY             equ 0004h ; Receive Parity Error
CE_FRAME                equ 0008h ; Receive Framing error
CE_BREAK                equ 0010h ; Break Detected
CE_TXFULL               equ 0100h ; TX Queue is full
CE_PTO                  equ 0200h ; LPTx Timeout
CE_IOE                  equ 0400h ; LPTx I/O Error
CE_DNS                  equ 0800h ; LPTx Device not selected
CE_OOP                  equ 1000h ; LPTx Out-Of-Paper
CE_MODE                 equ 8000h ; Requested mode unsupported

IE_BADID                equ -1  ; Invalid or unsupported id
IE_OPEN                 equ -2  ; Device Already Open
IE_NOPEN                equ -3  ; Device Not Open
IE_MEMORY               equ -4  ; Unable to allocate queues
IE_DEFAULT              equ -5  ; Error in default parameters
IE_HARDWARE             equ -10 ; Hardware Not Present
IE_BYTESIZE             equ -11 ; Illegal Byte Size
IE_BAUDRATE             equ -12 ; Unsupported BaudRate

; Events

EV_RXCHAR               equ 0001h ; Any Character received
EV_RXFLAG               equ 0002h ; Received certain character
EV_TXEMPTY              equ 0004h ; Transmitt Queue Empty
EV_CTS                  equ 0008h ; CTS changed state
EV_DSR                  equ 0010h ; DSR changed state
EV_RLSD                 equ 0020h ; RLSD changed state
EV_BREAK                equ 0040h ; BREAK received
EV_ERR                  equ 0080h ; Line status error occurred
EV_RING                 equ 0100h ; Ring signal detected
EV_PERR                 equ 0200h ; Printer error occured
EV_RX80FULL             equ 0400h ; Receive buffer is 80 percent full
EV_EVENT1               equ 0800h ; Provider specific event 1
EV_EVENT2               equ 1000h ; Provider specific event 2

; Escape Functions

SETXOFF                 equ 1     ; Simulate XOFF received
SETXON                  equ 2     ; Simulate XON received
SETRTS                  equ 3     ; Set RTS high
CLRRTS                  equ 4     ; Set RTS low
SETDTR                  equ 5     ; Set DTR high
CLRDTR                  equ 6     ; Set DTR low
RESETDEV                equ 7     ; Reset device if possible
SETBREAK                equ 8     ; Set the device break line.
CLRBREAK                equ 9     ; Clear the device break line.

; PURGE function flags.

PURGE_TXABORT           equ 0001  ; Kill the pending/current writes to the comm port.
PURGE_RXABORT           equ 0002  ; Kill the pending/current reads to the comm port.
PURGE_TXCLEAR           equ 0004  ; Kill the transmit queue if there.
PURGE_RXCLEAR           equ 0008  ; Kill the typeahead buffer if there.

LPTx                    equ 80    ; Set if ID is for LPT device

; Modem Status Flags

MS_CTS_ON               equ 0010h
MS_DSR_ON               equ 0020h
MS_RING_ON              equ 0040h
MS_RLSD_ON              equ 0080h

; GetConsoleMode flags
CONSOLE_FULLSCREEN      equ 1
CONSOLE_FULLSCREEN_HARDWARE equ 2

