DIRECTDRAW_VERSION = 0700h


typedef LPDDPIXELFORMAT         PTR DDPIXELFORMAT
typedef LPDDSURFACEDESC         PTR DDSURFACEDESC
typedef LPDIRECTDRAW            PTR IDirectDraw
typedef LPDIRECTDRAWPALETTE     PTR IDirectDrawPalette
typedef LPDIRECTDRAWSURFACE     PTR IDirectDrawSurface
typedef LPPALETTEENTRY          PTR PALETTEENTRY
typedef LPRECT                  DWORD
typedef LPDDBLTFX               PTR DDBLTFX


typedef LPVOID                  DWORD


macro GUID gName: req, gString:req
  local @@byte
    label gName byte
    irp t, <8,6,4,2, 13,11, 18,16, 21,24,27,30,33,36,39,42>
        @@byte SUBSTR <gString>, t, 2
        @@byte CATSTR <0>, @@byte, <h>
        db @@byte
    endm
endm


macro FAILED Lab
        or      eax, eax
        js      &Lab
endm

macro SUCCES Lab
        or      eax, eax
        jns     &Lab
endm


procdesc DirectDrawCreateEx     :dword, :dword, :dword, :dword



CLSID_DirectDraw                equ <{D7B70EE0-4340-11CF-B0-63-00-20-AF-C2-CD-35}>
CLSID_DirectDraw7               equ <{3c305196-50db-11d3-9c-fe-00-c0-4f-d9-30-c5}>
CLSID_DirectDrawClipper         equ <{593817A0-7DB3-11CF-A2-DE-00-AA-00-b9-33-56}>
IID_IDirectDraw                 equ <{6C14DB80-A733-11CE-A5-21-00-20-AF-0B-E5-60}>
IID_IDirectDraw2                equ <{B3A6F3E0-2B43-11CF-A2-DE-00-AA-00-B9-33-56}>
IID_IDirectDraw3                equ <{618f8ad4-8b7a-11d0-8f-cc-00-c0-4f-d9-18-9d}>
IID_IDirectDraw4                equ <{9c59509a-39bd-11d1-8c-4a-00-c0-4f-d9-30-c5}>
IID_IDirectDraw7                equ <{15e65ec0-3b9c-11d2-b9-2f-00-60-97-97-ea-5b}>
IID_IDirectDrawSurface          equ <{6C14DB81-A733-11CE-A5-21-00-20-AF-0B-E5-60}>
IID_IDirectDrawSurface2         equ <{57805885-6eec-11cf-94-41-a8-23-03-c1-0e-27}>
IID_IDirectDrawSurface3         equ <{DA044E00-69B2-11D0-A1-D5-00-AA-00-B8-DF-BB}>
IID_IDirectDrawSurface4         equ <{0B2B8630-AD35-11D0-8E-A6-00-60-97-97-EA-5B}>
IID_IDirectDrawSurface7         equ <{06675a80-3b9b-11d2-b9-2f-00-60-97-97-ea-5b}>
IID_IDirectDrawPalette          equ <{6C14DB84-A733-11CE-A5-21-00-20-AF-0B-E5-60}>
IID_IDirectDrawClipper          equ <{6C14DB85-A733-11CE-A5-21-00-20-AF-0B-E5-60}>
IID_IDirectDrawColorControl     equ <{4B9F0EE0-0D7E-11D0-9B-06-00-A0-C9-03-A3-B8}>
IID_IDirectDrawGammaControl     equ <{69C11C3E-B46B-11D1-AD-7A-00-C0-4F-C2-9B-4E}>




DD_ROP_SPACE    = (256 / 32)    ; space required to store ROP array


struc DDARGB
  blue          db ?
  green         db ?
  red           db ?
  alpha         db ?
ends

struc DDRGBA
  red           db ?
  green         db ?
  blue          db ?
  alpha         db ?
ends

struc PALETTEENTRY
  peRed         db ?
  peGreen       db ?
  peBlue        db ?
  peFlags       db ?
ends


struc DDCOLORKEY
  dwColorSpaceLowValue  dd ?    ; low boundary of color space that is to
                                ; be treated as Color Key, inclusive
  dwColorSpaceHighValue dd ?    ; high boundary of color space that is
                                ; to be treated as Color Key, inclusive
ends


; Used to pass override information to the DIRECTDRAWSURFACE callback Blt.
struc DDBLTFX
  dwSize                dd ?    ; size of structure
  dwDDFX                dd ?    ; FX operations
  dwROP                 dd ?    ; Win32 raster operations
  dwDDROP               dd ?    ; Raster operations new for DirectDraw
  dwRotationAngle       dd ?    ; Rotation angle for blt
  dwZBufferOpCode       dd ?    ; ZBuffer compares
  dwZBufferLow          dd ?    ; Low limit of Z buffer
  dwZBufferHigh         dd ?    ; High limit of Z buffer
  dwZBufferBaseDest     dd ?    ; Destination base value
  dwZDestConstBitDepth  dd ?    ; Bit depth used to specify Z constant for destination
  union
    dwZDestConst        dd ?    ; Constant to use as Z buffer for dest
    lpDDSZBufferDest    LPDIRECTDRAWSURFACE ?; Surface to use as Z buffer for dest
  ends
  dwZSrcConstBitDepth   dd ?    ; Bit depth used to specify Z constant for source
  union
    dwZSrcConst         dd ?                            ; Constant to use as Z buffer for src
    lpDDSZBufferSrc     LPDIRECTDRAWSURFACE ?; Surface to use as Z buffer for src
  ends
  dwAlphaEdgeBlendBitDepth dd ? ; Bit depth used to specify constant for alpha edge blend
  dwAlphaEdgeBlend         dd ? ; Alpha for edge blending
  dwReserved               dd ?
  dwAlphaDestConstBitDepth dd ? ; Bit depth used to specify alpha constant for destination
  union
    dwAlphaDestConst    dd ?    ; Constant to use as Alpha Channel
    lpDDSAlphaDest      LPDIRECTDRAWSURFACE ?; Surface to use as Alpha Channel
  ends
  dwAlphaSrcConstBitDepth dd ?  ; Bit depth used to specify alpha constant for source
  union
    dwAlphaSrcConst     dd ?    ; Constant to use as Alpha Channel
    lpDDSAlphaSrc       LPDIRECTDRAWSURFACE ?; Surface to use as Alpha Channel
  ends
  union
    dwFillColor         dd ?    ; color in RGB or Palettized
    dwFillDepth         dd ?    ; depth value for z-buffer
    dwFillPixel         dd ?    ; pixel value for RGBA or RGBZ
    lpDDSPattern        LPDIRECTDRAWSURFACE ?; Surface to use as pattern
  ends
  ddckDestColorkey      DDCOLORKEY <> ; DestColorkey override
  ddckSrcColorkey       DDCOLORKEY <> ; SrcColorkey override
ends


struc DDSCAPS
  dwCaps        dd ?            ; capabilities of surface wanted
ends


struc DDSCAPSEX
  dwCaps2       dd ?
  dwCaps3       dd ?
  union
    dwCaps4       dd ?
    dwVolumeDepth dd ?
  ends
ends


struc DDSCAPS2
  dwCaps        dd ?            ; capabilities of surface wanted
  dwCaps2       dd ?
  dwCaps3       dd ?
  union
    dwCaps4       dd ?
    dwVolumeDepth dd ?
  ends
ends


struc DDCAPS
  dwSize                 dd ? ; size of the DDDRIVERCAPS structure
  dwCaps                 dd ? ; driver specific capabilities
  dwCaps2                dd ? ; more driver specific capabilites
  dwCKeyCaps             dd ? ; color key capabilities of the surface
  dwFXCaps               dd ? ; driver specific stretching and effects capabilites
  dwFXAlphaCaps          dd ? ; alpha driver specific capabilities
  dwPalCaps              dd ? ; palette capabilities
  dwSVCaps               dd ? ; stereo vision capabilities
  dwAlphaBltConstBitDepths       dd ? ; DDBD_2,4,8
  dwAlphaBltPixelBitDepths       dd ? ; DDBD_1,2,4,8
  dwAlphaBltSurfaceBitDepths     dd ? ; DDBD_1,2,4,8
  dwAlphaOverlayConstBitDepths   dd ? ; DDBD_2,4,8
  dwAlphaOverlayPixelBitDepths   dd ? ; DDBD_1,2,4,8
  dwAlphaOverlaySurfaceBitDepths dd ? ; ; DDBD_1,2,4,8
  dwZBufferBitDepths     dd ? ; DDBD_8,16,24,32
  dwVidMemTotal          dd ? ; total amount of video memory
  dwVidMemFree           dd ? ; amount of free video memory
  dwMaxVisibleOverlays   dd ? ; maximum number of visible overlays
  dwCurrVisibleOverlays  dd ? ; current number of visible overlays
  dwNumFourCCCodes       dd ? ; number of four cc codes
  dwAlignBoundarySrc     dd ? ; source rectangle alignment
  dwAlignSizeSrc         dd ? ; source rectangle byte size
  dwAlignBoundaryDest    dd ? ; dest rectangle alignment
  dwAlignSizeDest        dd ? ; dest rectangle byte size
  dwAlignStrideAlign     dd ? ; stride alignment
  dwRops                 dd DD_ROP_SPACE dup(?) ; ROPS supported
  if DIRECTDRAW_VERSION GE 600h
    tddsOldCaps          DDSCAPS <> ; Was DDSCAPS  ddsCaps. ddsCaps is of type DDSCAPS2 for DX6
  else
    tddsCaps             DDSCAPS <>
  endif
  dwMinOverlayStretch    dd ? ; minimum overlay stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
  dwMaxOverlayStretch    dd ? ; maximum overlay stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
  dwMinLiveVideoStretch  dd ? ; minimum live video stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
  dwMaxLiveVideoStretch  dd ? ; maximum live video stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
  dwMinHwCodecStretch    dd ? ; minimum hardware codec stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
  dwMaxHwCodecStretch    dd ? ; maximum hardware codec stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
  dwReserved1            dd ? ; reserved
  dwReserved2            dd ? ; reserved
  dwReserved3            dd ? ; reserved
  ; DX 3 added
  if DIRECTDRAW_VERSION GE 300h
    dwSVBCaps            dd ? ; driver specific capabilities for System->Vmem blts
    dwSVBCKeyCaps        dd ? ; driver color key capabilities for System->Vmem blts
    dwSVBFXCaps          dd ? ; driver FX capabilities for System->Vmem blts
    dwSVBRops            dd DD_ROP_SPACE dup(?) ; ROPS supported for System->Vmem blts
    dwVSBCaps            dd ? ; driver specific capabilities for Vmem->System blts
    dwVSBCKeyCaps        dd ? ; driver color key capabilities for Vmem->System blts
    dwVSBFXCaps          dd ? ; driver FX capabilities for Vmem->System blts
    dwVSBRops            dd DD_ROP_SPACE dup(?) ; ROPS supported for Vmem->System blts
    dwSSBCaps            dd ? ; driver specific capabilities for System->System blts
    dwSSBCKeyCaps        dd ? ; driver color key capabilities for System->System blts
    dwSSBFXCaps          dd ? ; driver FX capabilities for System->System blts
    dwSSBRops            dd DD_ROP_SPACE dup(?) ; ROPS supported for System->System blts
      if DIRECTDRAW_VERSION EQ 300h
        dwReserved4      dd ?
        dwReserved5      dd ?
        dwReserved6      dd ?
      else
        dwMaxVideoPorts  dd ? ; maximum number of usable video ports
        dwCurrVideoPorts dd ? ; current number of video ports used
        dwSVBCaps2       dd ? ; more driver specific capabilities for System->Vmem blts
      endif
      if DIRECTDRAW_VERSION GE 500h
        dwNLVBCaps       dd ? ; driver specific capabilities for non-local->local vidmem blts
        dwNLVBCaps2      dd ? ; more driver specific capabilities non-local->local vidmem blts
        dwNLVBCKeyCaps   dd ? ; driver color key capabilities for non-local->local vidmem blts
        dwNLVBFXCaps     dd ? ; driver FX capabilities for non-local->local blts
        dwNLVBRops       dd DD_ROP_SPACE dup(?) ; ROPS supported for non-local->local blts
      endif
    ; Members added for DX6 release
      if DIRECTDRAW_VERSION GE 600h
        tddsCaps         DDSCAPS2 <> ; Surface Caps
      endif
  endif
ends


struc DDPIXELFORMAT
    dwSize                      dd ?    ; size of structure
    dwFlags                     dd ?    ; pixel format flags
    dwFourCC                    dd ?    ; (FOURCC code)
    union
        dwRGBBitCount           dd ?    ; how many bits per pixel
        dwYUVBitCount           dd ?    ; how many bits per pixel
        dwZBufferBitDepth       dd ?    ; how many total bits/pixel in z buffer (including any stencil bits)
        dwAlphaBitDepth         dd ?    ; how many bits for alpha channels
        dwLuminanceBitCount     dd ?    ; how many bits per pixel
        dwBumpBitCount          dd ?    ; how many bits per "buxel", total
        dwPrivateFormatBitCount dd ?    ; Bits per pixel of private driver formats. Only valid in texture
                                        ; format list and if DDPF_D3DFORMAT is set
    ends
    union
        dwRBitMask              dd ?    ; mask for red bit
        dwYBitMask              dd ?    ; mask for Y bits
        dwStencilBitDepth       dd ?    ; how many stencil bits (note: dwZBufferBitDepth-dwStencilBitDepth is total Z-only bits)
        dwLuminanceBitMask      dd ?    ; mask for luminance bits
        dwBumpDuBitMask         dd ?    ; mask for bump map U delta bits
        dwOperations            dd ?    ; DDPF_D3DFORMAT Operations
    ends
    union
        dwGBitMask              dd ?    ; mask for green bits
        dwUBitMask              dd ?    ; mask for U bits
        dwZBitMask              dd ?    ; mask for Z bits
        dwBumpDvBitMask         dd ?    ; mask for bump map V delta bits
        struc ; MultiSampleCaps
            wFlipMSTypes        dw ?    ; Multisample methods supported via flip for this D3DFORMAT
            wBltMSTypes         dw ?    ; Multisample methods supported via blt for this D3DFORMAT
        ends
    ends
    union
        dwBBitMask              dd ?    ; mask for blue bits
        dwVBitMask              dd ?    ; mask for V bits
        dwStencilBitMask        dd ?    ; mask for stencil bits
        dwBumpLuminanceBitMask  dd ?    ; mask for luminance in bump map
    ends
    union
        dwRGBAlphaBitMask       dd ?    ; mask for alpha channel
        dwYUVAlphaBitMask       dd ?    ; mask for alpha channel
        dwLuminanceAlphaBitMask dd ?    ; mask for alpha channel
        dwRGBZBitMask           dd ?    ; mask for Z channel
        dwYUVZBitMask           dd ?    ; mask for Z channel
    ends
ends


struc DDOVERLAYFX
  dwSize                        dd ?    ; size of structure
  dwAlphaEdgeBlendBitDepth      dd ?    ; Bit depth used to specify constant for alpha edge blend
  dwAlphaEdgeBlend              dd ?    ; Constant to use as alpha for edge blend
  dwReserved                    dd ?
  dwAlphaDestConstBitDepth      dd ?    ; Bit depth used to specify alpha constant for destination
  union
    dwAlphaDestConst            dd ?    ; Constant to use as alpha channel for dest
    lpDDSAlphaDest              LPDIRECTDRAWSURFACE ?; Surface to use as alpha channel for dest
  ends
  dwAlphaSrcConstBitDepth       dd ?    ; Bit depth used to specify alpha constant for source
  union
    dwAlphaSrcConst             dd ?    ; Constant to use as alpha channel for src
    lpDDSAlphaSrc               LPDIRECTDRAWSURFACE ?; Surface to use as alpha channel for src
  ends
  dckDestColorkey               DDCOLORKEY <>        ; DestColorkey override
  dckSrcColorkey                DDCOLORKEY <>        ; DestColorkey override
  dwDDFX                        dd ?                 ; Overlay FX
  dwFlags                       dd ?                 ; flags
ends


; BltBatch entry structure
struc DDBLTBATCH
  lprDest               LPRECT ?
  lpDDSSrc              LPDIRECTDRAWSURFACE ?
  lprSrc                LPRECT ?
  dwFlags               dd ?
  lpDDBltFx             LPDDBLTFX ?
ends


struc DDGAMMARAMP
  red                   dw 256 dup(?)
  green                 dw 256 dup(?)
  blue                  dw 256 dup(?)
ends


;*****************************************************************************
;********************************** CLASSES **********************************
;*****************************************************************************

struc IUnknown METHOD {
  virtual QueryInterface        ; (REFIID riid, LPVOID *ppvObj)
  virtual AddRef                ; ()
  virtual Release               ; ()
  }
ends


; IDirectDraw
struc IDirectDraw IUnknown METHOD {
  virtual Compact               ; ()
  virtual CreateClipper         ; (DWORD, LPDIRECTDRAWCLIPPER*, IUnknown*)
  virtual CreatePalette         ; (DWORD, LPPALETTEENTRY, LPDIRECTDRAWPALETTE*, IUnknown*)
  virtual CreateSurface         ; (LPDDSURFACEDESC, LPDIRECTDRAWSURFACE*, IUnknown*)
  virtual DuplicateSurface      ; (LPDIRECTDRAWSURFACE, LPDIRECTDRAWSURFACE*)
  virtual EnumDisplayModes      ; (DWORD, LPDDSURFACEDESC, LPVOID, LPDDENUMMODESCALLBACK)
  virtual EnumSurfaces          ; (DWORD, LPDDSURFACEDESC, LPVOID,LPDDENUMSURFACESCALLBACK)
  virtual FlipToGDISurface      ; ()
  virtual GetCaps               ; (LPDDCAPS, LPDDCAPS)
  virtual GetDisplayMode        ; (LPDDSURFACEDESC)
  virtual GetFourCCCodes        ; (LPDWORD, LPDWORD)
  virtual GetGDISurface         ; (LPDIRECTDRAWSURFACE*)
  virtual GetMonitorFrequency   ; (LPDWORD)
  virtual GetScanLine           ; (LPDWORD)
  virtual GetVerticalBlankStatus; (LPBOOL)
  virtual Initialize            ; (GUID*)
  virtual RestoreDisplayMode    ; ()
  virtual SetCooperativeLevel   ; (HWND, DWORD)
  virtual SetDisplayMode        ; (DWORD, DWORD,DWORD)
  virtual WaitForVerticalBlank  ; (DWORD, HANDLE)
  }
ends

struc IDirectDraw2 IDirectDraw METHOD {
  virtual GetAvailableVidMem    ; (LPDDSCAPS, LPDWORD, LPDWORD)
  }
ends

struc IDirectDraw4 IDirectDraw2 METHOD {
  virtual GetSurfaceFromDC      ; (HDC, LPDIRECTDRAWSURFACE4 *)
  virtual RestoreAllSurfaces    ; ()
  virtual TestCooperativeLevel  ; ()
  virtual GetDeviceIdentifier   ; (LPDDDEVICEIDENTIFIER, DWORD)
  }
ends

struc IDirectDraw7 IDirectDraw4 METHOD {
  virtual StartModeTest         ; (LPSIZE, DWORD, DWORD)
  virtual EvaluateMode          ; (DWORD, DWORD *)
  }
ends


; IDirectDrawPalette
struc IDirectDrawPalette IUnknown METHOD {
  virtual GetCaps               ; (LPDWORD)
  virtual GetEntries            ; (DWORD,DWORD,DWORD,LPPALETTEENTRY)
  virtual Initialize            ; (LPDIRECTDRAW, DWORD, LPPALETTEENTRY)
  virtual SetEntries            ; (DWORD,DWORD,DWORD,LPPALETTEENTRY)
  }
ends


; IDirectDrawClipper
struc IDirectDrawClipper IUnknown METHOD {
  virtual GetClipList           ; (LPRECT, LPRGNDATA, LPDWORD)
  virtual GetHWnd               ; (HWND *)
  virtual Initialize            ; (LPDIRECTDRAW, DWORD)
  virtual IsClipListChanged     ; (BOOL *)
  virtual SetClipList           ; (LPRGNDATA,DWORD)
  virtual SetHWnd               ; (DWORD, HWND )
  }
ends


; IDirectDrawSurface
struc IDirectDrawSurface IUnknown METHOD {
  virtual AddAttachedSurface    ; (LPDIRECTDRAWSURFACE)
  virtual AddOverlayDirtyRect   ; (LPRECT)
  virtual Blt                   ; (LPRECT,LPDIRECTDRAWSURFACE, LPRECT,DWORD, LPDDBLTFX)
  virtual BltBatch              ; (LPDDBLTBATCH, DWORD, DWORD )
  virtual BltFast               ; (DWORD,DWORD,LPDIRECTDRAWSURFACE, LPRECT,DWORD)
  virtual DeleteAttachedSurface ; (DWORD,LPDIRECTDRAWSURFACE)
  virtual EnumAttachedSurfaces  ; (LPVOID,LPDDENUMSURFACESCALLBACK)
  virtual EnumOverlayZOrders    ; (DWORD,LPVOID,LPDDENUMSURFACESCALLBACK)
  virtual Flip                  ; (LPDIRECTDRAWSURFACE, DWORD)
  virtual GetAttachedSurface    ; (LPDDSCAPS, LPDIRECTDRAWSURFACE FAR *)
  virtual GetBltStatus          ; (DWORD)
  virtual GetCaps               ; (LPDDSCAPS)
  virtual GetClipper            ; (LPDIRECTDRAWCLIPPER FAR*)
  virtual GetColorKey           ; (DWORD, LPDDCOLORKEY)
  virtual GetDC                 ; (HDC FAR *)
  virtual GetFlipStatus         ; (DWORD) ;
  virtual GetOverlayPosition    ; (LPLONG, LPLONG )
  virtual GetPalette            ; (LPDIRECTDRAWPALETTE FAR*)
  virtual GetPixelFormat        ; (LPDDPIXELFORMAT)
  virtual GetSurfaceDesc        ; (LPDDSURFACEDESC)
  virtual Initialize            ; (LPDIRECTDRAW, LPDDSURFACEDESC)
  virtual IsLost                ; ()
  virtual Lock                  ; (LPRECT,LPDDSURFACEDESC,DWORD,HANDLE)
  virtual ReleaseDC             ; (HDC)
  virtual Restore               ; ()
  virtual SetClipper            ; (LPDIRECTDRAWCLIPPER)
  virtual SetColorKey           ; (DWORD, LPDDCOLORKEY)
  virtual SetOverlayPosition    ; (LONG, LONG )
  virtual SetPalette            ; (LPDIRECTDRAWPALETTE)
  virtual Unlock                ; (LPVOID)
  virtual UpdateOverlay         ; (LPRECT, LPDIRECTDRAWSURFACE,LPRECT,DWORD, LPDDOVERLAYFX)
  virtual UpdateOverlayDisplay  ; (DWORD)
  virtual UpdateOverlayZOrder   ; (DWORD, LPDIRECTDRAWSURFACE)
  }
ends

struc IDirectDrawSurface2 IDirectDrawSurface METHOD {
  virtual GetDDInterface        ; (LPVOID *)
  virtual PageLock              ; (DWORD)
  virtual PageUnlock            ; (DWORD)
  }
ends

struc IDirectDrawSurface3 IDirectDrawSurface2 METHOD {
  virtual SetSurfaceDesc        ; (LPDDSURFACEDESC, DWORD)
  }
ends

struc IDirectDrawSurface4 IDirectDrawSurface3 METHOD {
  virtual SetPrivateData        ; (REFGUID, LPVOID, DWORD, DWORD)
  virtual GetPrivateData        ; (REFGUID, LPVOID, LPDWORD)
  virtual FreePrivateData       ; (REFGUID)
  virtual GetUniquenessValue    ; (LPDWORD)
  virtual ChangeUniquenessValue ; ()
  }
ends

struc IDirectDrawSurface7 IDirectDrawSurface4 METHOD {
  virtual SetPriority           ; (DWORD)
  virtual GetPriority           ; (LPDWORD)
  virtual SetLOD                ; (DWORD)
  virtual GetLOD                ; (LPDWORD)
  }
ends


; IDirectDrawColorControl
struc IDirectDrawColorControl IUnknown METHOD {
  virtual GetColorControls      ; (LPDDCOLORCONTROL)
  virtual SetColorControls      ; (LPDDCOLORCONTROL)
  }
ends


; IDirectDrawGammaControl
struc IDirectDrawGammaControl IUnknown METHOD {
  virtual GetGammaRamp          ; (DWORD, LPDDGAMMARAMP)
  virtual SetGammaRamp          ; (DWORD, LPDDGAMMARAMP)
  }
ends




struc DDSURFACEDESC
  dwSize                dd ?            ; size of the DDSURFACEDESC structure
  dwFlags               dd ?            ; determines what fields are valid
  dwHeight              dd ?            ; height of surface to be created
  dwWidth               dd ?            ; width of input surface
  union
    lPitch              dd ?            ; distance to start of next line (return value only)
    dwLinearSize        dd ?            ; Formless late-allocated optimized surface size
  ends
  dwBackBufferCount     dd ?            ; number of back buffers requested
  union
    dwMipMapCount       dd ?            ; number of mip-map levels requested
    dwZBufferBitDepth   dd ?            ; depth of Z buffer requested
    dwRefreshRate       dd ?            ; refresh rate (used when display mode is described)
  ends
  dwAlphaBitDepth       dd ?            ; depth of alpha buffer requested
  dwReserved            dd ?            ; reserved
  lpSurface             dd ?            ; pointer to the associated surface memory
  ddckCKDestOverlay     DDCOLORKEY <>   ; color key for destination overlay use
  ddckCKDestBlt         DDCOLORKEY <>   ; color key for destination blt use
  ddckCKSrcOverlay      DDCOLORKEY <>   ; color key for source overlay use
  ddckCKSrcBlt          DDCOLORKEY <>   ; color key for source blt use
  ddpfPixelFormat       DDPIXELFORMAT <>; pixel format description of the surface
  tddsCaps              DDSCAPS <>      ; direct draw surface capabilities
ends


struc DDSURFACEDESC2
    dwSize                      dd ?    ; size of the DDSURFACEDESC structure
    dwFlags                     dd ?    ; determines what fields are valid
    dwHeight                    dd ?    ; height of surface to be created
    dwWidth                     dd ?    ; width of input surface
    union
        lPitch                  dd ?    ; distance to start of next line (return value only)
        dwLinearSize            dd ?    ; Formless late-allocated optimized surface size
    ends
    union
        dwBackBufferCount       dd ?    ; number of back buffers requested
        dwDepth                 dd ?    ; the depth if this is a volume texture
    ends
    union
        dwMipMapCount           dd ?    ; number of mip-map levels requestde
                                        ; dwZBufferBitDepth removed, use ddpfPixelFormat one instead
        dwRefreshRate           dd ?    ; refresh rate (used when display mode is described)
        dwSrcVBHandle           dd ?    ; The source used in VB::Optimize
    ends
    dwAlphaBitDepth             dd ?    ; depth of alpha buffer requested
    dwReserved                  dd ?    ; reserved
    lpSurface                   LPVOID ?; pointer to the associated surface memory
    union
        ddckCKDestOverlay       DDCOLORKEY ?; color key for destination overlay use
        dwEmptyFaceColor        dd ?    ; Physical color for empty cubemap faces
    ends
    ddckCKDestBlt               DDCOLORKEY ?; color key for destination blt use
    ddckCKSrcOverlay            DDCOLORKEY ?; color key for source overlay use
    ddckCKSrcBlt                DDCOLORKEY ?; color key for source blt use
    union
        ddpfPixelFormat         DDPIXELFORMAT <>; pixel format description of the surface
        dwFVF                   dd ?    ; vertex format description of vertex buffers
    ends
    if DIRECTDRAW_VERSION GE 2
      tddsCaps                  DDSCAPS2 ? ; direct draw surface capabilities
      dwTextureStage            dd ?    ; stage in multitexture cascade
    else
      tddsCaps                  DDSCAPS <> ; direct draw surface capabilities
    endif
ends




; ddsCaps field is valid.
  DDSD_CAPS               equ 00000001h
  DDSD_HEIGHT             equ 00000002h
  DDSD_WIDTH              equ 00000004h
  DDSD_PITCH              equ 00000008h
  DDSD_BACKBUFFERCOUNT    equ 00000020h
  DDSD_ZBUFFERBITDEPTH    equ 00000040h ; shouldnt be used in DDSURFACEDESC2
  DDSD_ALPHABITDEPTH      equ 00000080h
  DDSD_LPSURFACE          equ 00000800h
  DDSD_PIXELFORMAT        equ 00001000h
  DDSD_CKDESTOVERLAY      equ 00002000h
  DDSD_CKDESTBLT          equ 00004000h
  DDSD_CKSRCOVERLAY       equ 00008000h
  DDSD_CKSRCBLT           equ 00010000h
  DDSD_MIPMAPCOUNT        equ 00020000h
  DDSD_REFRESHRATE        equ 00040000h
  DDSD_LINEARSIZE         equ 00080000h
  DDSD_TEXTURESTAGE       equ 00100000h
  DDSD_FVF                equ 00200000h
  DDSD_SRCVBHANDLE        equ 00400000h
  DDSD_DEPTH              equ 00800000h
  DDSD_ALL                equ 00fff9eeh


struc DDCOLORCONTROL
  dwSize                  dd ?
  dwFlags                 dd ?
  lBrightness             dd ?
  lContrast               dd ?
  lHue                    dd ?
  lSaturation             dd ?
  lSharpness              dd ?
  lGamma                  dd ?
  lColorEnable            dd ?
  dwReserved1             dd ?
ends


  DDCOLOR_BRIGHTNESS      equ 00000001h
  DDCOLOR_CONTRAST        equ 00000002h
  DDCOLOR_HUE             equ 00000004h
  DDCOLOR_SATURATION      equ 00000008h
  DDCOLOR_SHARPNESS       equ 00000010h
  DDCOLOR_GAMMA           equ 00000020h
  DDCOLOR_COLORENABLE     equ 00000040h


;============================================================================
;
; Direct Draw Capability Flags
;
; These flags are used to describe the capabilities of a given Surface.
; All flags are bit flags.
;
;==========================================================================*/

;***************************************************************************
;
; DIRECTDRAWSURFACE CAPABILITY FLAGS
;
;***************************************************************************/

;
; This bit is reserved. It should not be specified.
DDSCAPS_RESERVED1                       = 000000001h

;
; Indicates that this surface contains alpha-only information.
; (To determine if a surface is RGBA/YUVA, the pixel format must be
; interrogated.)
DDSCAPS_ALPHA                           = 000000002h

;
; Indicates that this surface is a backbuffer.  It is generally
; set by CreateSurface when the DDSCAPS_FLIP capability bit is set.
; It indicates that this surface is THE back buffer of a surface
; flipping structure.  DirectDraw supports N surfaces in a
; surface flipping structure.  Only the surface that immediately
; precedeces the DDSCAPS_FRONTBUFFER has this capability bit set.
; The other surfaces are identified as back buffers by the presence
; of the DDSCAPS_FLIP capability, their attachment order, and the
; absence of the DDSCAPS_FRONTBUFFER and DDSCAPS_BACKBUFFER
; capabilities.  The bit is sent to CreateSurface when a standalone
; back buffer is being created.  This surface could be attached to
; a front buffer and/or back buffers to form a flipping surface
; structure after the CreateSurface call.  See AddAttachments for
; a detailed description of the behaviors in this case.
DDSCAPS_BACKBUFFER                      = 000000004h

;
; Indicates a complex surface structure is being described.  A
; complex surface structure results in the creation of more than
; one surface.  The additional surfaces are attached to the root
; surface.  The complex structure can only be destroyed by
; destroying the root.
DDSCAPS_COMPLEX                         = 000000008h

;
; Indicates that this surface is a part of a surface flipping structure.
; When it is passed to CreateSurface the DDSCAPS_FRONTBUFFER and
; DDSCAP_BACKBUFFER bits are not set.  They are set by CreateSurface
; on the resulting creations.  The dwBackBufferCount field in the
; DDSURFACEDESC structure must be set to at least 1 in order for
; the CreateSurface call to succeed.  The DDSCAPS_COMPLEX capability
; must always be set with creating multiple surfaces through CreateSurface.
DDSCAPS_FLIP                            = 000000010h

;
; Indicates that this surface is THE front buffer of a surface flipping
; structure.  It is generally set by CreateSurface when the DDSCAPS_FLIP
; capability bit is set.
; If this capability is sent to CreateSurface then a standalonw front buffer
; is created.  This surface will not have the DDSCAPS_FLIP capability.
; It can be attached to other back buffers to form a flipping structure.
; See AddAttachments for a detailed description of the behaviors in this
; case.
DDSCAPS_FRONTBUFFER                     = 000000020h

;
; Indicates that this surface is any offscreen surface that is not an overlay,
; texture, zbuffer, front buffer, back buffer, or alpha surface.  It is used
; to identify plain vanilla surfaces.
DDSCAPS_OFFSCREENPLAIN                  = 000000040h

;
; Indicates that this surface is an overlay.  It may or may not be directly visible
; depending on whether or not it is currently being overlayed onto the primary
; surface.  DDSCAPS_VISIBLE can be used to determine whether or not it is being
; overlayed at the moment.
DDSCAPS_OVERLAY                         = 000000080h

;
; Indicates that unique DirectDrawPalette objects can be created and
; attached to this surface.
DDSCAPS_PALETTE                         = 000000100h

;
; Indicates that this surface is the primary surface.  The primary
; surface represents what the user is seeing at the moment.
DDSCAPS_PRIMARYSURFACE                  = 000000200h


;
; This flag used to be DDSCAPS_PRIMARYSURFACELEFT, which is now
; obsolete.
DDSCAPS_RESERVED3               = 000000400h
DDSCAPS_PRIMARYSURFACELEFT              = 000000000h

;
; Indicates that this surface memory was allocated in system memory
DDSCAPS_SYSTEMMEMORY                    = 000000800h

;
; Indicates that this surface can be used as a 3D texture.  It does not
; indicate whether or not the surface is being used for that purpose.
DDSCAPS_TEXTURE                         = 000001000h

;
; Indicates that a surface may be a destination for 3D rendering.  This
; bit must be set in order to query for a Direct3D Device Interface
; from this surface.
DDSCAPS_3DDEVICE                        = 000002000h

;
; Indicates that this surface exists in video memory.
DDSCAPS_VIDEOMEMORY                     = 000004000h

;
; Indicates that changes made to this surface are immediately visible.
; It is always set for the primary surface and is set for overlays while
; they are being overlayed and texture maps while they are being textured.
DDSCAPS_VISIBLE                         = 000008000h

;
; Indicates that only writes are permitted to the surface.  Read accesses
; from the surface may or may not generate a protection fault, but the
; results of a read from this surface will not be meaningful.  READ ONLY.
DDSCAPS_WRITEONLY                       = 000010000h

;
; Indicates that this surface is a z buffer. A z buffer does not contain
; displayable information.  Instead it contains bit depth information that is
; used to determine which pixels are visible and which are obscured.
DDSCAPS_ZBUFFER                         = 000020000h

;
; Indicates surface will have a DC associated long term
DDSCAPS_OWNDC                           = 000040000h

;
; Indicates surface should be able to receive live video
DDSCAPS_LIVEVIDEO                       = 000080000h

;
; Indicates surface should be able to have a stream decompressed
; to it by the hardware.
DDSCAPS_HWCODEC                         = 000100000h

;
; Surface is a ModeX surface.
;
DDSCAPS_MODEX                           = 000200000h

;
; Indicates surface is one level of a mip-map. This surface will
; be attached to other DDSCAPS_MIPMAP surfaces to form the mip-map.
; This can be done explicitly, by creating a number of surfaces and
; attaching them with AddAttachedSurface or by implicitly by CreateSurface.
; If this bit is set then DDSCAPS_TEXTURE must also be set.
DDSCAPS_MIPMAP                          = 000400000h

;
; This bit is reserved. It should not be specified.
DDSCAPS_RESERVED2                       = 000800000h


;
; Indicates that memory for the surface is not allocated until the surface
; is loaded (via the Direct3D texture Load() function).
DDSCAPS_ALLOCONLOAD                     = 004000000h

;
; Indicates that the surface will recieve data from a video port.
DDSCAPS_VIDEOPORT                       = 008000000h

;
; Indicates that a video memory surface is resident in true, local video
; memory rather than non-local video memory. If this flag is specified then
; so must DDSCAPS_VIDEOMEMORY. This flag is mutually exclusive with
; DDSCAPS_NONLOCALVIDMEM.
DDSCAPS_LOCALVIDMEM                     = 010000000h

;
; Indicates that a video memory surface is resident in non-local video
; memory rather than true, local video memory. If this flag is specified
; then so must DDSCAPS_VIDEOMEMORY. This flag is mutually exclusive with
; DDSCAPS_LOCALVIDMEM.
DDSCAPS_NONLOCALVIDMEM                  = 020000000h

;
; Indicates that this surface is a standard VGA mode surface, and not a
; ModeX surface. (This flag will never be set in combination with the
; DDSCAPS_MODEX flag).
DDSCAPS_STANDARDVGAMODE                 = 040000000h

;
; Indicates that this surface will be an optimized surface. This flag is
; currently only valid in conjunction with the DDSCAPS_TEXTURE flag. The surface
; will be created without any underlying video memory until loaded.
DDSCAPS_OPTIMIZED                       = 080000000h



;
; This bit is reserved
DDSCAPS2_RESERVED4                      = 000000002h
DDSCAPS2_HARDWAREDEINTERLACE            = 000000000h

;
; Indicates to the driver that this surface will be locked very frequently
; (for procedural textures, dynamic lightmaps, etc). Surfaces with this cap
; set must also have DDSCAPS_TEXTURE. This cap cannot be used with
; DDSCAPS2_HINTSTATIC and DDSCAPS2_OPAQUE.
DDSCAPS2_HINTDYNAMIC                    = 000000004h

;
; Indicates to the driver that this surface can be re-ordered/retiled on
; load. This operation will not change the size of the texture. It is
; relatively fast and symmetrical, since the application may lock these
; bits (although it will take a performance hit when doing so). Surfaces
; with this cap set must also have DDSCAPS_TEXTURE. This cap cannot be
; used with DDSCAPS2_HINTDYNAMIC and DDSCAPS2_OPAQUE.
DDSCAPS2_HINTSTATIC                     = 000000008h

;
; Indicates that the client would like this texture surface to be managed by the
; DirectDraw/Direct3D runtime. Surfaces with this cap set must also have
; DDSCAPS_TEXTURE set.
DDSCAPS2_TEXTUREMANAGE                  = 000000010h

;
; These bits are reserved for internal use
DDSCAPS2_RESERVED1                      = 000000020h
DDSCAPS2_RESERVED2                      = 000000040h

;
; Indicates to the driver that this surface will never be locked again.
; The driver is free to optimize this surface via retiling and actual compression.
; All calls to Lock() or Blts from this surface will fail. Surfaces with this
; cap set must also have DDSCAPS_TEXTURE. This cap cannot be used with
; DDSCAPS2_HINTDYNAMIC and DDSCAPS2_HINTSTATIC.
DDSCAPS2_OPAQUE                         = 000000080h

;
; Applications should set this bit at CreateSurface time to indicate that they
; intend to use antialiasing. Only valid if DDSCAPS_3DDEVICE is also set.
DDSCAPS2_HINTANTIALIASING               = 000000100h


;
; This flag is used at CreateSurface time to indicate that this set of
; surfaces is a cubic environment map
DDSCAPS2_CUBEMAP                        = 000000200h

;
; These flags preform two functions:
; - At CreateSurface time, they define which of the six cube faces are
;   required by the application.
; - After creation, each face in the cubemap will have exactly one of these
;   bits set.
DDSCAPS2_CUBEMAP_POSITIVEX              = 000000400h
DDSCAPS2_CUBEMAP_NEGATIVEX              = 000000800h
DDSCAPS2_CUBEMAP_POSITIVEY              = 000001000h
DDSCAPS2_CUBEMAP_NEGATIVEY              = 000002000h
DDSCAPS2_CUBEMAP_POSITIVEZ              = 000004000h
DDSCAPS2_CUBEMAP_NEGATIVEZ              = 000008000h

;
; This macro may be used to specify all faces of a cube map at CreateSurface time
DDSCAPS2_CUBEMAP_ALLFACES               = DDSCAPS2_CUBEMAP_POSITIVEX or DDSCAPS2_CUBEMAP_NEGATIVEX or DDSCAPS2_CUBEMAP_POSITIVEY or DDSCAPS2_CUBEMAP_NEGATIVEY or DDSCAPS2_CUBEMAP_POSITIVEZ or DDSCAPS2_CUBEMAP_NEGATIVEZ


;
; This flag is an additional flag which is present on mipmap sublevels from DX7 onwards
; It enables easier use of GetAttachedSurface rather than EnumAttachedSurfaces for surface
; constructs such as Cube Maps, wherein there are more than one mipmap surface attached
; to the root surface.
; This caps bit is ignored by CreateSurface
DDSCAPS2_MIPMAPSUBLEVEL                 = 000010000h

; This flag indicates that the texture should be managed by D3D only
DDSCAPS2_D3DTEXTUREMANAGE               = 000020000h

; This flag indicates that the managed surface can be safely lost
DDSCAPS2_DONOTPERSIST                   = 000040000h

; indicates that this surface is part of a stereo flipping chain
DDSCAPS2_STEREOSURFACELEFT              = 000080000h


;
; Indicates that the surface is a volume.
; Can be combined with DDSCAPS_MIPMAP to indicate a multi-level volume
DDSCAPS2_VOLUME                         = 000200000h

;
; Indicates that the surface may be locked multiple times by the application.
; This cap cannot be used with DDSCAPS2_OPAQUE.
DDSCAPS2_NOTUSERLOCKABLE                = 000400000h

;
; Indicates that the vertex buffer data can be used to render points and
; point sprites.
DDSCAPS2_POINTS                         = 000800000h

;
; Indicates that the vertex buffer data can be used to render rt pactches.
DDSCAPS2_RTPATCHES                      = 001000000h

;
; Indicates that the vertex buffer data can be used to render n patches.
DDSCAPS2_NPATCHES                       = 002000000h

;
; This bit is reserved for internal use
DDSCAPS2_RESERVED3                      = 004000000h


;
; Indicates that the contents of the backbuffer do not have to be preserved
; the contents of the backbuffer after they are presented.
DDSCAPS2_DISCARDBACKBUFFER              = 010000000h

;
; Indicates that all surfaces in this creation chain should be given an alpha channel.
; This flag will be set on primary surface chains that may have no explicit pixel format
; (and thus take on the format of the current display mode).
; The driver should infer that all these surfaces have a format having an alpha channel.
; (e.g. assume D3DFMT_A8R8G8B8 if the display mode is x888.)
DDSCAPS2_ENABLEALPHACHANNEL             = 020000000h


;
; This is a mask that indicates the set of bits that may be set
; at createsurface time to indicate number of samples per pixel
; when multisampling
DDSCAPS3_MULTISAMPLE_MASK               = 00000001Fh


 ;***************************************************************************
;
; DIRECTDRAW DRIVER CAPABILITY FLAGS
;
;***************************************************************************/

;
; Display hardware has 3D acceleration.
DDCAPS_3D                       = 000000001h

;
; Indicates that DirectDraw will support only dest rectangles that are aligned
; on DIRECTDRAWCAPS.dwAlignBoundaryDest boundaries of the surface, respectively.
; READ ONLY.
DDCAPS_ALIGNBOUNDARYDEST        = 000000002h

;
; Indicates that DirectDraw will support only source rectangles  whose sizes in
; BYTEs are DIRECTDRAWCAPS.dwAlignSizeDest multiples, respectively.  READ ONLY.
DDCAPS_ALIGNSIZEDEST            = 000000004h
;
; Indicates that DirectDraw will support only source rectangles that are aligned
; on DIRECTDRAWCAPS.dwAlignBoundarySrc boundaries of the surface, respectively.
; READ ONLY.
DDCAPS_ALIGNBOUNDARYSRC         = 000000008h

;
; Indicates that DirectDraw will support only source rectangles  whose sizes in
; BYTEs are DIRECTDRAWCAPS.dwAlignSizeSrc multiples, respectively.  READ ONLY.
DDCAPS_ALIGNSIZESRC             = 000000010h

;
; Indicates that DirectDraw will create video memory surfaces that have a stride
; alignment equal to DIRECTDRAWCAPS.dwAlignStride.  READ ONLY.
DDCAPS_ALIGNSTRIDE              = 000000020h

;
; Display hardware is capable of blt operations.
DDCAPS_BLT                      = 000000040h

;
; Display hardware is capable of asynchronous blt operations.
DDCAPS_BLTQUEUE                 = 000000080h

;
; Display hardware is capable of color space conversions during the blt operation.
DDCAPS_BLTFOURCC                = 000000100h

;
; Display hardware is capable of stretching during blt operations.
DDCAPS_BLTSTRETCH               = 000000200h

;
; Display hardware is shared with GDI.
DDCAPS_GDI                      = 000000400h

;
; Display hardware can overlay.
DDCAPS_OVERLAY                  = 000000800h

;
; Set if display hardware supports overlays but can not clip them.
DDCAPS_OVERLAYCANTCLIP          = 000001000h

;
; Indicates that overlay hardware is capable of color space conversions during
; the overlay operation.
DDCAPS_OVERLAYFOURCC            = 000002000h

;
; Indicates that stretching can be done by the overlay hardware.
DDCAPS_OVERLAYSTRETCH           = 000004000h

;
; Indicates that unique DirectDrawPalettes can be created for DirectDrawSurfaces
; other than the primary surface.
DDCAPS_PALETTE                  = 000008000h

;
; Indicates that palette changes can be syncd with the veritcal refresh.
DDCAPS_PALETTEVSYNC             = 000010000h

;
; Display hardware can return the current scan line.
DDCAPS_READSCANLINE             = 000020000h


;
; This flag used to bo DDCAPS_STEREOVIEW, which is now obsolete
DDCAPS_RESERVED1                = 000040000h

;
; Display hardware is capable of generating a vertical blank interrupt.
DDCAPS_VBI                      = 000080000h

;
; Supports the use of z buffers with blt operations.
DDCAPS_ZBLTS                    = 000100000h

;
; Supports Z Ordering of overlays.
DDCAPS_ZOVERLAYS                = 000200000h

;
; Supports color key
DDCAPS_COLORKEY                 = 000400000h

;
; Supports alpha surfaces
DDCAPS_ALPHA                    = 000800000h

;
; colorkey is hardware assisted(DDCAPS_COLORKEY will also be set)
DDCAPS_COLORKEYHWASSIST         = 001000000h

;
; no hardware support at all
DDCAPS_NOHARDWARE               = 002000000h

;
; Display hardware is capable of color fill with bltter
DDCAPS_BLTCOLORFILL             = 004000000h

;
; Display hardware is bank switched, and potentially very slow at
; random access to VRAM.
DDCAPS_BANKSWITCHED             = 008000000h

;
; Display hardware is capable of depth filling Z-buffers with bltter
DDCAPS_BLTDEPTHFILL             = 010000000h

;
; Display hardware is capable of clipping while bltting.
DDCAPS_CANCLIP                  = 020000000h

;
; Display hardware is capable of clipping while stretch bltting.
DDCAPS_CANCLIPSTRETCHED         = 040000000h

;
; Display hardware is capable of bltting to or from system memory
DDCAPS_CANBLTSYSMEM             = 080000000h


 ;***************************************************************************
;
; MORE DIRECTDRAW DRIVER CAPABILITY FLAGS (dwCaps2)
;
;***************************************************************************/

;
; Display hardware is certified
DDCAPS2_CERTIFIED              = 000000001h

;
; Driver cannot interleave 2D operations (lock and blt) to surfaces with
; Direct3D rendering operations between calls to BeginScene() and EndScene()
DDCAPS2_NO2DDURING3DSCENE       = 000000002h

;
; Display hardware contains a video port
DDCAPS2_VIDEOPORT               = 000000004h

;
; The overlay can be automatically flipped according to the video port
; VSYNCs, providing automatic doubled buffered display of video port
; data using an overlay
DDCAPS2_AUTOFLIPOVERLAY         = 000000008h

;
; Overlay can display each field of interlaced data individually while
; it is interleaved in memory without causing jittery artifacts.
DDCAPS2_CANBOBINTERLEAVED       = 000000010h

;
; Overlay can display each field of interlaced data individually while
; it is not interleaved in memory without causing jittery artifacts.
DDCAPS2_CANBOBNONINTERLEAVED    = 000000020h

;
; The overlay surface contains color controls (brightness, sharpness, etc.)
DDCAPS2_COLORCONTROLOVERLAY     = 000000040h

;
; The primary surface contains color controls (gamma, etc.)
DDCAPS2_COLORCONTROLPRIMARY     = 000000080h

;
; RGBZ -> RGB supported for 16:16 RGB:Z
DDCAPS2_CANDROPZ16BIT           = 000000100h

;
; Driver supports non-local video memory.
DDCAPS2_NONLOCALVIDMEM          = 000000200h

;
; Dirver supports non-local video memory but has different capabilities for
; non-local video memory surfaces. If this bit is set then so must
; DDCAPS2_NONLOCALVIDMEM.
DDCAPS2_NONLOCALVIDMEMCAPS      = 000000400h

;
; Driver neither requires nor prefers surfaces to be pagelocked when performing
; blts involving system memory surfaces
DDCAPS2_NOPAGELOCKREQUIRED      = 000000800h

;
; Driver can create surfaces which are wider than the primary surface
DDCAPS2_WIDESURFACES            = 000001000h

;
; Driver supports bob without using a video port by handling the
; DDFLIP_ODD and DDFLIP_EVEN flags specified in Flip.
DDCAPS2_CANFLIPODDEVEN          = 000002000h

;
; Driver supports bob using hardware
DDCAPS2_CANBOBHARDWARE          = 000004000h

;
; Driver supports bltting any FOURCC surface to another surface of the same FOURCC
DDCAPS2_COPYFOURCC              = 000008000h


;
; Driver supports loadable gamma ramps for the primary surface
DDCAPS2_PRIMARYGAMMA            = 000020000h

;
; Driver can render in windowed mode.
DDCAPS2_CANRENDERWINDOWED       = 000080000h

;
; A calibrator is available to adjust the gamma ramp according to the
; physical display properties so that the result will be identical on
; all calibrated systems.
DDCAPS2_CANCALIBRATEGAMMA       = 000100000h

;
; Indicates that the driver will respond to DDFLIP_INTERVALn flags
DDCAPS2_FLIPINTERVAL            = 000200000h

;
; Indicates that the driver will respond to DDFLIP_NOVSYNC
DDCAPS2_FLIPNOVSYNC             = 000400000h

;
; Driver supports management of video memory, if this flag is ON,
; driver manages the texture if requested with DDSCAPS2_TEXTUREMANAGE on
; DirectX manages the texture if this flag is OFF and surface has DDSCAPS2_TEXTUREMANAGE on
DDCAPS2_CANMANAGETEXTURE        = 000800000h

;
; The Direct3D texture manager uses this cap to decide whether to put managed
; surfaces in non-local video memory. If the cap is set, the texture manager will
; put managed surfaces in non-local vidmem. Drivers that cannot texture from
; local vidmem SHOULD NOT set this cap.
DDCAPS2_TEXMANINNONLOCALVIDMEM  = 001000000h

;
; Indicates that the driver supports DX7 type of stereo in at least one mode (which may
; not necessarily be the current mode). Applications should use IDirectDraw7 (or higher)
; ::EnumDisplayModes and check the DDSURFACEDESC.ddsCaps.dwCaps2 field for the presence of
; DDSCAPS2_STEREOSURFACELEFT to check if a particular mode supports stereo. The application
; can also use IDirectDraw7(or higher)::GetDisplayMode to check the current mode.
DDCAPS2_STEREO                  = 002000000h

;
; This caps bit is intended for internal DirectDraw use.
; -It is only valid if DDCAPS2_NONLOCALVIDMEMCAPS is set.
; -If this bit is set, then DDCAPS_CANBLTSYSMEM MUST be set by the driver (and
;  all the assoicated system memory blt caps must be correct).
; -It implies that the system->video blt caps in DDCAPS also apply to system to
;  nonlocal blts. I.e. the dwSVBCaps, dwSVBCKeyCaps, dwSVBFXCaps and dwSVBRops
;  members of DDCAPS (DDCORECAPS) are filled in correctly.
; -Any blt from system to nonlocal memory that matches these caps bits will
;  be passed to the driver.
;
; NOTE: This is intended to enable the driver itself to do efficient reordering
; of textures. This is NOT meant to imply that hardware can write into AGP memory.
; This operation is not currently supported.
DDCAPS2_SYSTONONLOCAL_AS_SYSTOLOCAL   = 004000000h

;
; was DDCAPS2_PUREHAL
DDCAPS2_RESERVED1                     = 008000000h

;
; Driver supports management of video memory, if this flag is ON,
; driver manages the resource if requested with DDSCAPS2_TEXTUREMANAGE on
; DirectX manages the resource if this flag is OFF and surface has DDSCAPS2_TEXTUREMANAGE on
DDCAPS2_CANMANAGERESOURCE             = 010000000h

;
; Driver supports dynamic textures. This will allow the application to set
; D3DUSAGE_DYNAMIC (DDSCAPS2_HINTDYNAMIC for drivers) at texture create time.
; Video memory dynamic textures WILL be lockable by applications. It is
; expected that these locks will be very efficient (which implies that the
; driver should always maintain a linear copy, a pointer to which can be
; quickly handed out to the application).
DDCAPS2_DYNAMICTEXTURES               = 020000000h


;***************************************************************************
;
; DIRECTDRAW FX ALPHA CAPABILITY FLAGS
;
;***************************************************************************/

;
; Supports alpha blending around the edge of a source color keyed surface.
; For Blt.
DDFXALPHACAPS_BLTALPHAEDGEBLEND         = 000000001h

;
; Supports alpha information in the pixel format.  The bit depth of alpha
; information in the pixel format can be 1,2,4, or 8.  The alpha value becomes
; more opaque as the alpha value increases.  (0 is transparent.)
; For Blt.
DDFXALPHACAPS_BLTALPHAPIXELS            = 000000002h

;
; Supports alpha information in the pixel format.  The bit depth of alpha
; information in the pixel format can be 1,2,4, or 8.  The alpha value
; becomes more transparent as the alpha value increases.  (0 is opaque.)
; This flag can only be set if DDCAPS_ALPHA is set.
; For Blt.
DDFXALPHACAPS_BLTALPHAPIXELSNEG         = 000000004h

;
; Supports alpha only surfaces.  The bit depth of an alpha only surface can be
; 1,2,4, or 8.  The alpha value becomes more opaque as the alpha value increases.
; (0 is transparent.)
; For Blt.
DDFXALPHACAPS_BLTALPHASURFACES          = 000000008h

;
; The depth of the alpha channel data can range can be 1,2,4, or 8.
; The NEG suffix indicates that this alpha channel becomes more transparent
; as the alpha value increases. (0 is opaque.)  This flag can only be set if
; DDCAPS_ALPHA is set.
; For Blt.
DDFXALPHACAPS_BLTALPHASURFACESNEG       = 000000010h

;
; Supports alpha blending around the edge of a source color keyed surface.
; For Overlays.
DDFXALPHACAPS_OVERLAYALPHAEDGEBLEND     = 000000020h

;
; Supports alpha information in the pixel format.  The bit depth of alpha
; information in the pixel format can be 1,2,4, or 8.  The alpha value becomes
; more opaque as the alpha value increases.  (0 is transparent.)
; For Overlays.
DDFXALPHACAPS_OVERLAYALPHAPIXELS        = 000000040h

;
; Supports alpha information in the pixel format.  The bit depth of alpha
; information in the pixel format can be 1,2,4, or 8.  The alpha value
; becomes more transparent as the alpha value increases.  (0 is opaque.)
; This flag can only be set if DDCAPS_ALPHA is set.
; For Overlays.
DDFXALPHACAPS_OVERLAYALPHAPIXELSNEG     = 000000080h

;
; Supports alpha only surfaces.  The bit depth of an alpha only surface can be
; 1,2,4, or 8.  The alpha value becomes more opaque as the alpha value increases.
; (0 is transparent.)
; For Overlays.
DDFXALPHACAPS_OVERLAYALPHASURFACES      = 000000100h

;
; The depth of the alpha channel data can range can be 1,2,4, or 8.
; The NEG suffix indicates that this alpha channel becomes more transparent
; as the alpha value increases. (0 is opaque.)  This flag can only be set if
; DDCAPS_ALPHA is set.
; For Overlays.
DDFXALPHACAPS_OVERLAYALPHASURFACESNEG   = 000000200h



;***************************************************************************
;
; DIRECTDRAW FX CAPABILITY FLAGS
;
;***************************************************************************/

;
; Uses arithmetic operations to stretch and shrink surfaces during blt
; rather than pixel doubling techniques.  Along the Y axis.
DDFXCAPS_BLTARITHSTRETCHY       = 000000020h

;
; Uses arithmetic operations to stretch during blt
; rather than pixel doubling techniques.  Along the Y axis. Only
; works for x1, x2, etc.
DDFXCAPS_BLTARITHSTRETCHYN      = 000000010h

;
; Supports mirroring left to right in blt.
DDFXCAPS_BLTMIRRORLEFTRIGHT     = 000000040h

;
; Supports mirroring top to bottom in blt.
DDFXCAPS_BLTMIRRORUPDOWN        = 000000080h

;
; Supports arbitrary rotation for blts.
DDFXCAPS_BLTROTATION            = 000000100h

;
; Supports 90 degree rotations for blts.
DDFXCAPS_BLTROTATION90          = 000000200h

;
; DirectDraw supports arbitrary shrinking of a surface along the
; x axis (horizontal direction) for blts.
DDFXCAPS_BLTSHRINKX             = 000000400h

;
; DirectDraw supports integer shrinking (1x,2x,) of a surface
; along the x axis (horizontal direction) for blts.
DDFXCAPS_BLTSHRINKXN            = 000000800h

;
; DirectDraw supports arbitrary shrinking of a surface along the
; y axis (horizontal direction) for blts.
DDFXCAPS_BLTSHRINKY             = 000001000h

;
; DirectDraw supports integer shrinking (1x,2x,) of a surface
; along the y axis (vertical direction) for blts.
DDFXCAPS_BLTSHRINKYN            = 000002000h

;
; DirectDraw supports arbitrary stretching of a surface along the
; x axis (horizontal direction) for blts.
DDFXCAPS_BLTSTRETCHX            = 000004000h

;
; DirectDraw supports integer stretching (1x,2x,) of a surface
; along the x axis (horizontal direction) for blts.
DDFXCAPS_BLTSTRETCHXN           = 000008000h

;
; DirectDraw supports arbitrary stretching of a surface along the
; y axis (horizontal direction) for blts.
DDFXCAPS_BLTSTRETCHY            = 000010000h

;
; DirectDraw supports integer stretching (1x,2x,) of a surface
; along the y axis (vertical direction) for blts.
DDFXCAPS_BLTSTRETCHYN           = 000020000h

;
; Uses arithmetic operations to stretch and shrink surfaces during
; overlay rather than pixel doubling techniques.  Along the Y axis
; for overlays.
DDFXCAPS_OVERLAYARITHSTRETCHY   = 000040000h

;
; Uses arithmetic operations to stretch surfaces during
; overlay rather than pixel doubling techniques.  Along the Y axis
; for overlays. Only works for x1, x2, etc.
DDFXCAPS_OVERLAYARITHSTRETCHYN  = 000000008h

;
; DirectDraw supports arbitrary shrinking of a surface along the
; x axis (horizontal direction) for overlays.
DDFXCAPS_OVERLAYSHRINKX         = 000080000h

;
; DirectDraw supports integer shrinking (1x,2x,) of a surface
; along the x axis (horizontal direction) for overlays.
DDFXCAPS_OVERLAYSHRINKXN        = 000100000h

;
; DirectDraw supports arbitrary shrinking of a surface along the
; y axis (horizontal direction) for overlays.
DDFXCAPS_OVERLAYSHRINKY         = 000200000h

;
; DirectDraw supports integer shrinking (1x,2x,) of a surface
; along the y axis (vertical direction) for overlays.
DDFXCAPS_OVERLAYSHRINKYN        = 000400000h

;
; DirectDraw supports arbitrary stretching of a surface along the
; x axis (horizontal direction) for overlays.
DDFXCAPS_OVERLAYSTRETCHX        = 000800000h

;
; DirectDraw supports integer stretching (1x,2x,) of a surface
; along the x axis (horizontal direction) for overlays.
DDFXCAPS_OVERLAYSTRETCHXN       = 001000000h

;
; DirectDraw supports arbitrary stretching of a surface along the
; y axis (horizontal direction) for overlays.
DDFXCAPS_OVERLAYSTRETCHY        = 002000000h

;
; DirectDraw supports integer stretching (1x,2x,) of a surface
; along the y axis (vertical direction) for overlays.
DDFXCAPS_OVERLAYSTRETCHYN       = 004000000h

;
; DirectDraw supports mirroring of overlays across the vertical axis
DDFXCAPS_OVERLAYMIRRORLEFTRIGHT = 008000000h

;
; DirectDraw supports mirroring of overlays across the horizontal axis
DDFXCAPS_OVERLAYMIRRORUPDOWN    = 010000000h

;
; DirectDraw supports deinterlacing of overlay surfaces
DDFXCAPS_OVERLAYDEINTERLACE     = 020000000h

;
; Driver can do alpha blending for blits.
DDFXCAPS_BLTALPHA               = 000000001h


;
; Driver can do surface-reconstruction filtering for warped blits.
DDFXCAPS_BLTFILTER              = DDFXCAPS_BLTARITHSTRETCHY

;
; Driver can do alpha blending for overlays.
DDFXCAPS_OVERLAYALPHA           = 000000004h


;
; Driver can do surface-reconstruction filtering for warped overlays.
DDFXCAPS_OVERLAYFILTER          = DDFXCAPS_OVERLAYARITHSTRETCHY

;***************************************************************************
;
; DIRECTDRAW STEREO VIEW CAPABILITIES
;
;***************************************************************************/

;
; This flag used to be DDSVCAPS_ENIGMA, which is now obsolete

DDSVCAPS_RESERVED1              = 000000001h

;
; This flag used to be DDSVCAPS_FLICKER, which is now obsolete
DDSVCAPS_RESERVED2              = 000000002h

;
; This flag used to be DDSVCAPS_REDBLUE, which is now obsolete
DDSVCAPS_RESERVED3              = 000000004h

;
; This flag used to be DDSVCAPS_SPLIT, which is now obsolete
DDSVCAPS_RESERVED4              = 000000008h

;
; The stereo view is accomplished with switching technology

DDSVCAPS_STEREOSEQUENTIAL       = 000000010h



;***************************************************************************
;
; DIRECTDRAWPALETTE CAPABILITIES
;
;***************************************************************************/

;
; Index is 4 bits.  There are sixteen color entries in the palette table.
DDPCAPS_4BIT                    = 000000001h

;
; Index is onto a 8 bit color index.  This field is only valid with the
; DDPCAPS_1BIT, DDPCAPS_2BIT or DDPCAPS_4BIT capability and the target
; surface is in 8bpp. Each color entry is one byte long and is an index
; into destination surface's 8bpp palette.
DDPCAPS_8BITENTRIES             = 000000002h

;
; Index is 8 bits.  There are 256 color entries in the palette table.
DDPCAPS_8BIT                    = 000000004h

;
; Indicates that this DIRECTDRAWPALETTE should use the palette color array
; passed into the lpDDColorArray parameter to initialize the DIRECTDRAWPALETTE
; object.
; This flag is obsolete. DirectDraw always initializes the color array from
; the lpDDColorArray parameter. The definition remains for source-level
; compatibility.
DDPCAPS_INITIALIZE              = 000000000h

;
; This palette is the one attached to the primary surface.  Changing this
; table has immediate effect on the display unless DDPSETPAL_VSYNC is specified
; and supported.
DDPCAPS_PRIMARYSURFACE          = 000000010h

;
; This palette is the one attached to the primary surface left.  Changing
; this table has immediate effect on the display for the left eye unless
; DDPSETPAL_VSYNC is specified and supported.
DDPCAPS_PRIMARYSURFACELEFT      = 000000020h

;
; This palette can have all 256 entries defined
DDPCAPS_ALLOW256                = 000000040h

;
; This palette can have modifications to it synced with the monitors
; refresh rate.
DDPCAPS_VSYNC                   = 000000080h

;
; Index is 1 bit.  There are two color entries in the palette table.
DDPCAPS_1BIT                    = 000000100h

;
; Index is 2 bit.  There are four color entries in the palette table.
DDPCAPS_2BIT                    = 000000200h

;
; The peFlags member of PALETTEENTRY denotes an 8 bit alpha value
DDPCAPS_ALPHA                   = 000000400h


;***************************************************************************
;
; DIRECTDRAWPALETTE SETENTRY CONSTANTS
;
;***************************************************************************/


;***************************************************************************
;
; DIRECTDRAWPALETTE GETENTRY CONSTANTS
;
;***************************************************************************/

; 0 is the only legal value

;***************************************************************************
;
; DIRECTDRAWSURFACE SETPRIVATEDATA CONSTANTS
;
;***************************************************************************/

;
; The passed pointer is an IUnknown ptr. The cbData argument to SetPrivateData
; must be set to sizeof(IUnknown*). DirectDraw will call AddRef through this
; pointer and Release when the private data is destroyed. This includes when
; the surface or palette is destroyed before such priovate data is destroyed.
DDSPD_IUNKNOWNPOINTER           = 000000001h

;
; Private data is only valid for the current state of the object,
; as determined by the uniqueness value.
DDSPD_VOLATILE                  = 000000002h


;***************************************************************************
;
; DIRECTDRAWSURFACE SETPALETTE CONSTANTS
;
;***************************************************************************/


;***************************************************************************
;
; DIRECTDRAW BITDEPTH CONSTANTS
;
; NOTE:  These are only used to indicate supported bit depths.   These
; are flags only, they are not to be used as an actual bit depth.   The
; absolute numbers 1, 2, 4, 8, 16, 24 and 32 are used to indicate actual
; bit depths in a surface or for changing the display mode.
;
;***************************************************************************/

;
; 1 bit per pixel.
DDBD_1                  = 000004000h

;
; 2 bits per pixel.
DDBD_2                  = 000002000h

;
; 4 bits per pixel.
DDBD_4                  = 000001000h

;
; 8 bits per pixel.
DDBD_8                  = 000000800h

;
; 16 bits per pixel.
DDBD_16                 = 000000400h

;
; 24 bits per pixel.
DDBD_24                 = 000000200h

;
; 32 bits per pixel.
DDBD_32                 = 000000100h

;***************************************************************************
;
; DIRECTDRAWSURFACE SET/GET COLOR KEY FLAGS
;
;***************************************************************************/

;
; Set if the structure contains a color space.  Not set if the structure
; contains a single color key.
DDCKEY_COLORSPACE       = 000000001h

;
; Set if the structure specifies a color key or color space which is to be
; used as a destination color key for blt operations.
DDCKEY_DESTBLT          = 000000002h

;
; Set if the structure specifies a color key or color space which is to be
; used as a destination color key for overlay operations.
DDCKEY_DESTOVERLAY      = 000000004h

;
; Set if the structure specifies a color key or color space which is to be
; used as a source color key for blt operations.
DDCKEY_SRCBLT           = 000000008h

;
; Set if the structure specifies a color key or color space which is to be
; used as a source color key for overlay operations.
DDCKEY_SRCOVERLAY       = 000000010h


;***************************************************************************
;
; DIRECTDRAW COLOR KEY CAPABILITY FLAGS
;
;***************************************************************************/

;
; Supports transparent blting using a color key to identify the replaceable
; bits of the destination surface for RGB colors.
DDCKEYCAPS_DESTBLT                      = 000000001h

;
; Supports transparent blting using a color space to identify the replaceable
; bits of the destination surface for RGB colors.
DDCKEYCAPS_DESTBLTCLRSPACE              = 000000002h

;
; Supports transparent blting using a color space to identify the replaceable
; bits of the destination surface for YUV colors.
DDCKEYCAPS_DESTBLTCLRSPACEYUV           = 000000004h

;
; Supports transparent blting using a color key to identify the replaceable
; bits of the destination surface for YUV colors.
DDCKEYCAPS_DESTBLTYUV                   = 000000008h

;
; Supports overlaying using colorkeying of the replaceable bits of the surface
; being overlayed for RGB colors.
DDCKEYCAPS_DESTOVERLAY                  = 000000010h

;
; Supports a color space as the color key for the destination for RGB colors.
DDCKEYCAPS_DESTOVERLAYCLRSPACE          = 000000020h

;
; Supports a color space as the color key for the destination for YUV colors.
DDCKEYCAPS_DESTOVERLAYCLRSPACEYUV       = 000000040h

;
; Supports only one active destination color key value for visible overlay
; surfaces.
DDCKEYCAPS_DESTOVERLAYONEACTIVE         = 000000080h

;
; Supports overlaying using colorkeying of the replaceable bits of the
; surface being overlayed for YUV colors.
DDCKEYCAPS_DESTOVERLAYYUV               = 000000100h

;
; Supports transparent blting using the color key for the source with
; this surface for RGB colors.
DDCKEYCAPS_SRCBLT                       = 000000200h

;
; Supports transparent blting using a color space for the source with
; this surface for RGB colors.
DDCKEYCAPS_SRCBLTCLRSPACE               = 000000400h

;
; Supports transparent blting using a color space for the source with
; this surface for YUV colors.
DDCKEYCAPS_SRCBLTCLRSPACEYUV            = 000000800h

;
; Supports transparent blting using the color key for the source with
; this surface for YUV colors.
DDCKEYCAPS_SRCBLTYUV                    = 000001000h

;
; Supports overlays using the color key for the source with this
; overlay surface for RGB colors.
DDCKEYCAPS_SRCOVERLAY                   = 000002000h

;
; Supports overlays using a color space as the source color key for
; the overlay surface for RGB colors.
DDCKEYCAPS_SRCOVERLAYCLRSPACE           = 000004000h

;
; Supports overlays using a color space as the source color key for
; the overlay surface for YUV colors.
DDCKEYCAPS_SRCOVERLAYCLRSPACEYUV        = 000008000h

;
; Supports only one active source color key value for visible
; overlay surfaces.
DDCKEYCAPS_SRCOVERLAYONEACTIVE          = 000010000h

;
; Supports overlays using the color key for the source with this
; overlay surface for YUV colors.
DDCKEYCAPS_SRCOVERLAYYUV                = 000020000h

;
; there are no bandwidth trade-offs for using colorkey with an overlay
DDCKEYCAPS_NOCOSTOVERLAY                = 000040000h


;***************************************************************************
;
; DIRECTDRAW PIXELFORMAT FLAGS
;
;***************************************************************************/

;
; The surface has alpha channel information in the pixel format.
DDPF_ALPHAPIXELS                        = 000000001h

;
; The pixel format contains alpha only information
DDPF_ALPHA                              = 000000002h

;
; The FourCC code is valid.
DDPF_FOURCC                             = 000000004h

;
; The surface is 4-bit color indexed.
DDPF_PALETTEINDEXED4                    = 000000008h

;
; The surface is indexed into a palette which stores indices
; into the destination surface's 8-bit palette.
DDPF_PALETTEINDEXEDTO8                  = 000000010h

;
; The surface is 8-bit color indexed.
DDPF_PALETTEINDEXED8                    = 000000020h

;
; The RGB data in the pixel format structure is valid.
DDPF_RGB                                = 000000040h

;
; The surface will accept pixel data in the format specified
; and compress it during the write.
DDPF_COMPRESSED                         = 000000080h

;
; The surface will accept RGB data and translate it during
; the write to YUV data.  The format of the data to be written
; will be contained in the pixel format structure.  The DDPF_RGB
; flag will be set.
DDPF_RGBTOYUV                           = 000000100h

;
; pixel format is YUV - YUV data in pixel format struct is valid
DDPF_YUV                                = 000000200h

;
; pixel format is a z buffer only surface
DDPF_ZBUFFER                            = 000000400h

;
; The surface is 1-bit color indexed.
DDPF_PALETTEINDEXED1                    = 000000800h

;
; The surface is 2-bit color indexed.
DDPF_PALETTEINDEXED2                    = 000001000h

;
; The surface contains Z information in the pixels
DDPF_ZPIXELS                            = 000002000h

;
; The surface contains stencil information along with Z
DDPF_STENCILBUFFER                      = 000004000h

;
; Premultiplied alpha format -- the color components have been
; premultiplied by the alpha component.
DDPF_ALPHAPREMULT                       = 000008000h


;
; Luminance data in the pixel format is valid.
; Use this flag for luminance-only or luminance+alpha surfaces,
; the bit depth is then ddpf.dwLuminanceBitCount.
DDPF_LUMINANCE                          = 000020000h

;
; Luminance data in the pixel format is valid.
; Use this flag when hanging luminance off bumpmap surfaces,
; the bit mask for the luminance portion of the pixel is then
; ddpf.dwBumpLuminanceBitMask
DDPF_BUMPLUMINANCE                      = 000040000h

;
; Bump map dUdV data in the pixel format is valid.
DDPF_BUMPDUDV                           = 000080000h


;===========================================================================
;
;
; DIRECTDRAW CALLBACK FLAGS
;
;
;==========================================================================*/

;***************************************************************************
;
; DIRECTDRAW ENUMSURFACES FLAGS
;
;***************************************************************************/

;
; Enumerate all of the surfaces that meet the search criterion.
DDENUMSURFACES_ALL                      = 000000001h

;
; A search hit is a surface that matches the surface description.
DDENUMSURFACES_MATCH                    = 000000002h

;
; A search hit is a surface that does not match the surface description.
DDENUMSURFACES_NOMATCH                  = 000000004h

;
; Enumerate the first surface that can be created which meets the search criterion.
DDENUMSURFACES_CANBECREATED             = 000000008h

;
; Enumerate the surfaces that already exist that meet the search criterion.
DDENUMSURFACES_DOESEXIST                = 000000010h


;***************************************************************************
;
; DIRECTDRAW SETDISPLAYMODE FLAGS
;
;***************************************************************************/

;
; The desired mode is a standard VGA mode
DDSDM_STANDARDVGAMODE                   = 000000001h


;***************************************************************************
;
; DIRECTDRAW ENUMDISPLAYMODES FLAGS
;
;***************************************************************************/

;
; Enumerate Modes with different refresh rates.  EnumDisplayModes guarantees
; that a particular mode will be enumerated only once.  This flag specifies whether
; the refresh rate is taken into account when determining if a mode is unique.
DDEDM_REFRESHRATES                      = 000000001h

;
; Enumerate VGA modes. Specify this flag if you wish to enumerate supported VGA
; modes such as mode 0x13 in addition to the usual ModeX modes (which are always
; enumerated if the application has previously called SetCooperativeLevel with the
; DDSCL_ALLOWMODEX flag set).
DDEDM_STANDARDVGAMODES                  = 000000002h


;***************************************************************************
;
; DIRECTDRAW SETCOOPERATIVELEVEL FLAGS
;
;***************************************************************************/

;
; Exclusive mode owner will be responsible for the entire primary surface.
; GDI can be ignored. used with DD
DDSCL_FULLSCREEN                        = 000000001h

;
; allow CTRL_ALT_DEL to work while in fullscreen exclusive mode
DDSCL_ALLOWREBOOT                       = 000000002h

;
; prevents DDRAW from modifying the application window.
; prevents DDRAW from minimize/restore the application window on activation.
DDSCL_NOWINDOWCHANGES                   = 000000004h

;
; app wants to work as a regular Windows application
DDSCL_NORMAL                            = 000000008h

;
; app wants exclusive access
DDSCL_EXCLUSIVE                         = 000000010h


;
; app can deal with non-windows display modes
DDSCL_ALLOWMODEX                        = 000000040h

;
; this window will receive the focus messages
DDSCL_SETFOCUSWINDOW                    = 000000080h

;
; this window is associated with the DDRAW object and will
; cover the screen in fullscreen mode
DDSCL_SETDEVICEWINDOW                   = 000000100h

;
; app wants DDRAW to create a window to be associated with the
; DDRAW object
DDSCL_CREATEDEVICEWINDOW                = 000000200h

;
; App explicitly asks DDRAW/D3D to be multithread safe. This makes D3D
; take the global crtisec more frequently.
DDSCL_MULTITHREADED                     = 000000400h

;
; App specifies that it would like to keep the FPU set up for optimal Direct3D
; performance (single precision and exceptions disabled) so Direct3D
; does not need to explicitly set the FPU each time. This is assumed by
; default in DirectX 7. See also DDSCL_FPUPRESERVE
DDSCL_FPUSETUP                          = 000000800h

;
; App specifies that it needs either double precision FPU or FPU exceptions
; enabled. This makes Direct3D explicitly set the FPU state eah time it is
; called. Setting the flag will reduce Direct3D performance. The flag is
; assumed by default in DirectX 6 and earlier. See also DDSCL_FPUSETUP
DDSCL_FPUPRESERVE                       = 000001000h


;***************************************************************************
;
; DIRECTDRAW BLT FLAGS
;
;***************************************************************************/

;
; Use the alpha information in the pixel format or the alpha channel surface
; attached to the destination surface as the alpha channel for this blt.
DDBLT_ALPHADEST                         = 000000001h

;
; Use the dwConstAlphaDest field in the DDBLTFX structure as the alpha channel
; for the destination surface for this blt.
DDBLT_ALPHADESTCONSTOVERRIDE            = 000000002h

;
; The NEG suffix indicates that the destination surface becomes more
; transparent as the alpha value increases. (0 is opaque)
DDBLT_ALPHADESTNEG                      = 000000004h

;
; Use the lpDDSAlphaDest field in the DDBLTFX structure as the alpha
; channel for the destination for this blt.
DDBLT_ALPHADESTSURFACEOVERRIDE          = 000000008h

;
; Use the dwAlphaEdgeBlend field in the DDBLTFX structure as the alpha channel
; for the edges of the image that border the color key colors.
DDBLT_ALPHAEDGEBLEND                    = 000000010h

;
; Use the alpha information in the pixel format or the alpha channel surface
; attached to the source surface as the alpha channel for this blt.
DDBLT_ALPHASRC                          = 000000020h

;
; Use the dwConstAlphaSrc field in the DDBLTFX structure as the alpha channel
; for the source for this blt.
DDBLT_ALPHASRCCONSTOVERRIDE             = 000000040h

;
; The NEG suffix indicates that the source surface becomes more transparent
; as the alpha value increases. (0 is opaque)
DDBLT_ALPHASRCNEG                       = 000000080h

;
; Use the lpDDSAlphaSrc field in the DDBLTFX structure as the alpha channel
; for the source for this blt.
DDBLT_ALPHASRCSURFACEOVERRIDE           = 000000100h

;
; Do this blt asynchronously through the FIFO in the order received.  If
; there is no room in the hardware FIFO fail the call.
DDBLT_ASYNC                             = 000000200h

;
; Uses the dwFillColor field in the DDBLTFX structure as the RGB color
; to fill the destination rectangle on the destination surface with.
DDBLT_COLORFILL                         = 000000400h

;
; Uses the dwDDFX field in the DDBLTFX structure to specify the effects
; to use for the blt.
DDBLT_DDFX                              = 000000800h

;
; Uses the dwDDROPS field in the DDBLTFX structure to specify the ROPS
; that are not part of the Win32 API.
DDBLT_DDROPS                            = 000001000h

;
; Use the color key associated with the destination surface.
DDBLT_KEYDEST                           = 000002000h

;
; Use the dckDestColorkey field in the DDBLTFX structure as the color key
; for the destination surface.
DDBLT_KEYDESTOVERRIDE                   = 000004000h

;
; Use the color key associated with the source surface.
DDBLT_KEYSRC                            = 000008000h

;
; Use the dckSrcColorkey field in the DDBLTFX structure as the color key
; for the source surface.
DDBLT_KEYSRCOVERRIDE                    = 000010000h

;
; Use the dwROP field in the DDBLTFX structure for the raster operation
; for this blt.  These ROPs are the same as the ones defined in the Win32 API.
DDBLT_ROP                               = 000020000h

;
; Use the dwRotationAngle field in the DDBLTFX structure as the angle
; (specified in 1/100th of a degree) to rotate the surface.
DDBLT_ROTATIONANGLE                     = 000040000h

;
; Z-buffered blt using the z-buffers attached to the source and destination
; surfaces and the dwZBufferOpCode field in the DDBLTFX structure as the
; z-buffer opcode.
DDBLT_ZBUFFER                           = 000080000h

;
; Z-buffered blt using the dwConstDest Zfield and the dwZBufferOpCode field
; in the DDBLTFX structure as the z-buffer and z-buffer opcode respectively
; for the destination.
DDBLT_ZBUFFERDESTCONSTOVERRIDE          = 000100000h

;
; Z-buffered blt using the lpDDSDestZBuffer field and the dwZBufferOpCode
; field in the DDBLTFX structure as the z-buffer and z-buffer opcode
; respectively for the destination.
DDBLT_ZBUFFERDESTOVERRIDE               = 000200000h

;
; Z-buffered blt using the dwConstSrcZ field and the dwZBufferOpCode field
; in the DDBLTFX structure as the z-buffer and z-buffer opcode respectively
; for the source.
DDBLT_ZBUFFERSRCCONSTOVERRIDE           = 000400000h

;
; Z-buffered blt using the lpDDSSrcZBuffer field and the dwZBufferOpCode
; field in the DDBLTFX structure as the z-buffer and z-buffer opcode
; respectively for the source.
DDBLT_ZBUFFERSRCOVERRIDE                = 000800000h

;
; wait until the device is ready to handle the blt
; this will cause blt to not return DDERR_WASSTILLDRAWING
DDBLT_WAIT                              = 001000000h

;
; Uses the dwFillDepth field in the DDBLTFX structure as the depth value
; to fill the destination rectangle on the destination Z-buffer surface
; with.
DDBLT_DEPTHFILL                         = 002000000h


;
; wait until the device is ready to handle the blt
; this will cause blt to not return DDERR_WASSTILLDRAWING
DDBLT_DONOTWAIT                         = 008000000h

;
; These flags indicate a presentation blt (i.e. a blt
; that moves surface contents from an offscreen back buffer to the primary
; surface). The driver is not allowed to "queue"  more than three such blts.
; The "end" of the presentation blt is indicated, since the
; blt may be clipped, in which case the runtime will call the driver with
; several blts. All blts (even if not clipped) are tagged with DDBLT_PRESENTATION
; and the last (even if not clipped) additionally with DDBLT_LAST_PRESENTATION.
; Thus the true rule is that the driver must not schedule a DDBLT_PRESENTATION
; blt if there are 3 or more DDBLT_PRESENTLAST blts in the hardware pipe.
; If there are such blts in the pipe, the driver should return DDERR_WASSTILLDRAWING
; until the oldest queued DDBLT_LAST_PRESENTATION blts has been retired (i.e. the
; pixels have been actually written to the primary surface). Once the oldest blt
; has been retired, the driver is free to schedule the current blt.
; The goal is to provide a mechanism whereby the device's hardware queue never
; gets more than 3 frames ahead of the frames being generated by the application.
; When excessive queueing occurs, applications become unusable because the application
; visibly lags user input, and such problems make windowed interactive applications impossible.
; Some drivers may not have sufficient knowledge of their hardware's FIFO to know
; when a certain blt has been retired. Such drivers should code cautiously, and
; simply not allow any frames to be queued at all. DDBLT_LAST_PRESENTATION should cause
; such drivers to return DDERR_WASSTILLDRAWING until the accelerator is completely
; finished- exactly as if the application had called Lock on the source surface
; before calling Blt.
; In other words, the driver is allowed and encouraged to
; generate as much latency as it can, but never more than 3 frames worth.
; Implementation detail: Drivers should count blts against the SOURCE surface, not
; against the primary surface. This enables multiple parallel windowed application
; to function more optimally.
; This flag is passed only to DX8 or higher drivers.
;
; APPLICATIONS DO NOT SET THESE FLAGS. THEY ARE SET BY THE DIRECTDRAW RUNTIME.
;
DDBLT_PRESENTATION                      = 010000000h
DDBLT_LAST_PRESENTATION                 = 020000000h



;***************************************************************************
;
; BLTFAST FLAGS
;
;***************************************************************************/

DDBLTFAST_NOCOLORKEY                    = 000000000h
DDBLTFAST_SRCCOLORKEY                   = 000000001h
DDBLTFAST_DESTCOLORKEY                  = 000000002h
DDBLTFAST_WAIT                          = 000000010h
DDBLTFAST_DONOTWAIT                     = 000000020h

;***************************************************************************
;
; FLIP FLAGS
;
;***************************************************************************/

DDFLIP_WAIT                          = 000000001h

;
; Indicates that the target surface contains the even field of video data.
; This flag is only valid with an overlay surface.
DDFLIP_EVEN                          = 000000002h

;
; Indicates that the target surface contains the odd field of video data.
; This flag is only valid with an overlay surface.
DDFLIP_ODD                           = 000000004h

;
; Causes DirectDraw to perform the physical flip immediately and return
; to the application. Typically, what was the front buffer but is now the back
; buffer will still be visible (depending on timing) until the next vertical
; retrace. Subsequent operations involving the two flipped surfaces will
; not check to see if the physical flip has finished (i.e. will not return
; DDERR_WASSTILLDRAWING for that reason (but may for other reasons)).
; This allows an application to perform Flips at a higher frequency than the
; monitor refresh rate, but may introduce visible artifacts.
; Only effective if DDCAPS2_FLIPNOVSYNC is set. If that bit is not set,
; DDFLIP_NOVSYNC has no effect.
DDFLIP_NOVSYNC                       = 000000008h


;
; Flip Interval Flags. These flags indicate how many vertical retraces to wait between
; each flip. The default is one. DirectDraw will return DDERR_WASSTILLDRAWING for each
; surface involved in the flip until the specified number of vertical retraces has
; ocurred. Only effective if DDCAPS2_FLIPINTERVAL is set. If that bit is not set,
; DDFLIP_INTERVALn has no effect.

;
; DirectDraw will flip on every other vertical sync
DDFLIP_INTERVAL2                     = 002000000h


;
; DirectDraw will flip on every third vertical sync
DDFLIP_INTERVAL3                     = 003000000h


;
; DirectDraw will flip on every fourth vertical sync
DDFLIP_INTERVAL4                     = 004000000h

;
; DirectDraw will flip and display a main stereo surface
DDFLIP_STEREO                        = 000000010h

;
; On IDirectDrawSurface7 and higher interfaces, the default is DDFLIP_WAIT. If you wish
; to override the default and use time when the accelerator is busy (as denoted by
; the DDERR_WASSTILLDRAWING return code) then use DDFLIP_DONOTWAIT.
DDFLIP_DONOTWAIT                     = 000000020h


;***************************************************************************
;
; DIRECTDRAW SURFACE OVERLAY FLAGS
;
;***************************************************************************/

;
; Use the alpha information in the pixel format or the alpha channel surface
; attached to the destination surface as the alpha channel for the
; destination overlay.
DDOVER_ALPHADEST                        = 000000001h

;
; Use the dwConstAlphaDest field in the DDOVERLAYFX structure as the
; destination alpha channel for this overlay.
DDOVER_ALPHADESTCONSTOVERRIDE           = 000000002h

;
; The NEG suffix indicates that the destination surface becomes more
; transparent as the alpha value increases.
DDOVER_ALPHADESTNEG                     = 000000004h

;
; Use the lpDDSAlphaDest field in the DDOVERLAYFX structure as the alpha
; channel destination for this overlay.
DDOVER_ALPHADESTSURFACEOVERRIDE         = 000000008h

;
; Use the dwAlphaEdgeBlend field in the DDOVERLAYFX structure as the alpha
; channel for the edges of the image that border the color key colors.
DDOVER_ALPHAEDGEBLEND                   = 000000010h

;
; Use the alpha information in the pixel format or the alpha channel surface
; attached to the source surface as the source alpha channel for this overlay.
DDOVER_ALPHASRC                         = 000000020h

;
; Use the dwConstAlphaSrc field in the DDOVERLAYFX structure as the source
; alpha channel for this overlay.
DDOVER_ALPHASRCCONSTOVERRIDE            = 000000040h

;
; The NEG suffix indicates that the source surface becomes more transparent
; as the alpha value increases.
DDOVER_ALPHASRCNEG                      = 000000080h

;
; Use the lpDDSAlphaSrc field in the DDOVERLAYFX structure as the alpha channel
; source for this overlay.
DDOVER_ALPHASRCSURFACEOVERRIDE          = 000000100h

;
; Turn this overlay off.
DDOVER_HIDE                             = 000000200h

;
; Use the color key associated with the destination surface.
DDOVER_KEYDEST                          = 000000400h

;
; Use the dckDestColorkey field in the DDOVERLAYFX structure as the color key
; for the destination surface
DDOVER_KEYDESTOVERRIDE                  = 000000800h

;
; Use the color key associated with the source surface.
DDOVER_KEYSRC                           = 000001000h

;
; Use the dckSrcColorkey field in the DDOVERLAYFX structure as the color key
; for the source surface.
DDOVER_KEYSRCOVERRIDE                   = 000002000h

;
; Turn this overlay on.
DDOVER_SHOW                             = 000004000h

;
; Add a dirty rect to an emulated overlayed surface.
DDOVER_ADDDIRTYRECT                     = 000008000h

;
; Redraw all dirty rects on an emulated overlayed surface.
DDOVER_REFRESHDIRTYRECTS                = 000010000h

;
; Redraw the entire surface on an emulated overlayed surface.
DDOVER_REFRESHALL                      = 000020000h


;
; Use the overlay FX flags to define special overlay FX
DDOVER_DDFX                             = 000080000h

;
; Autoflip the overlay when ever the video port autoflips
DDOVER_AUTOFLIP                         = 000100000h

;
; Display each field of video port data individually without
; causing any jittery artifacts
DDOVER_BOB                              = 000200000h

;
; Indicates that bob/weave decisions should not be overridden by other
; interfaces.
DDOVER_OVERRIDEBOBWEAVE                 = 000400000h

;
; Indicates that the surface memory is composed of interleaved fields.
DDOVER_INTERLEAVED                      = 000800000h

;
; Indicates that bob will be performed using hardware rather than
; software or emulated.
DDOVER_BOBHARDWARE                      = 001000000h

;
; Indicates that overlay FX structure contains valid ARGB scaling factors.
DDOVER_ARGBSCALEFACTORS                 = 002000000h

;
; Indicates that ARGB scaling factors can be degraded to fit driver capabilities.
DDOVER_DEGRADEARGBSCALING               = 004000000h


;***************************************************************************
;
; DIRECTDRAWSURFACE LOCK FLAGS
;
;***************************************************************************/

;
; The default.  Set to indicate that Lock should return a valid memory pointer
; to the top of the specified rectangle.  If no rectangle is specified then a
; pointer to the top of the surface is returned.
DDLOCK_SURFACEMEMORYPTR                 = 000000000h

;
; Set to indicate that Lock should wait until it can obtain a valid memory
; pointer before returning.  If this bit is set, Lock will never return
; DDERR_WASSTILLDRAWING.
DDLOCK_WAIT                             = 000000001h

;
; Set if an event handle is being passed to Lock.  Lock will trigger the event
; when it can return the surface memory pointer requested.
DDLOCK_EVENT                            = 000000002h

;
; Indicates that the surface being locked will only be read from.
DDLOCK_READONLY                         = 000000010h

;
; Indicates that the surface being locked will only be written to
DDLOCK_WRITEONLY                        = 000000020h


;
; Indicates that a system wide lock should not be taken when this surface
; is locked. This has several advantages (cursor responsiveness, ability
; to call more Windows functions, easier debugging) when locking video
; memory surfaces. However, an application specifying this flag must
; comply with a number of conditions documented in the help file.
; Furthermore, this flag cannot be specified when locking the primary.
DDLOCK_NOSYSLOCK                        = 000000800h

;
; Used only with Direct3D Vertex Buffer Locks. Indicates that no vertices
; that were referred to in Draw*PrimtiveVB calls since the start of the
; frame (or the last lock without this flag) will be modified during the
; lock. This can be useful when one is only appending data to the vertex
; buffer
DDLOCK_NOOVERWRITE                      = 000001000h

;
; Indicates that no assumptions will be made about the contents of the
; surface or vertex buffer during this lock.
; This enables two things:
; -    Direct3D or the driver may provide an alternative memory
;      area as the vertex buffer. This is useful when one plans to clear the
;      contents of the vertex buffer and fill in new data.
; -    Drivers sometimes store surface data in a re-ordered format.
;      When the application locks the surface, the driver is forced to un-re-order
;      the surface data before allowing the application to see the surface contents.
;      This flag is a hint to the driver that it can skip the un-re-ordering process
;      since the application plans to overwrite every single pixel in the surface
;      or locked rectangle (and so erase any un-re-ordered pixels anyway).
;      Applications should always set this flag when they intend to overwrite the entire
;      surface or locked rectangle.
DDLOCK_DISCARDCONTENTS                  = 000002000h
;
; DDLOCK_OKTOSWAP is an older, less informative name for DDLOCK_DISCARDCONTENTS
DDLOCK_OKTOSWAP                         = 000002000h

;
; On IDirectDrawSurface7 and higher interfaces, the default is DDLOCK_WAIT. If you wish
; to override the default and use time when the accelerator is busy (as denoted by
; the DDERR_WASSTILLDRAWING return code) then use DDLOCK_DONOTWAIT.
DDLOCK_DONOTWAIT                        = 000004000h

;
; This indicates volume texture lock with front and back specified.
DDLOCK_HASVOLUMETEXTUREBOXRECT          = 000008000h

;
; This indicates that the driver should not update dirty rect information for this lock.
DDLOCK_NODIRTYUPDATE                    = 000010000h


;***************************************************************************
;
; DIRECTDRAWSURFACE PAGELOCK FLAGS
;
;***************************************************************************/

;
; No flags defined at present


;***************************************************************************
;
; DIRECTDRAWSURFACE PAGEUNLOCK FLAGS
;
;***************************************************************************/

;
; No flags defined at present


;***************************************************************************
;
; DIRECTDRAWSURFACE BLT FX FLAGS
;
;***************************************************************************/

;
; If stretching, use arithmetic stretching along the Y axis for this blt.
DDBLTFX_ARITHSTRETCHY                   = 000000001h

;
; Do this blt mirroring the surface left to right.  Spin the
; surface around its y-axis.
DDBLTFX_MIRRORLEFTRIGHT                 = 000000002h

;
; Do this blt mirroring the surface up and down.  Spin the surface
; around its x-axis.
DDBLTFX_MIRRORUPDOWN                    = 000000004h

;
; Schedule this blt to avoid tearing.
DDBLTFX_NOTEARING                       = 000000008h

;
; Do this blt rotating the surface one hundred and eighty degrees.
DDBLTFX_ROTATE180                       = 000000010h

;
; Do this blt rotating the surface two hundred and seventy degrees.
DDBLTFX_ROTATE270                       = 000000020h

;
; Do this blt rotating the surface ninety degrees.
DDBLTFX_ROTATE90                        = 000000040h

;
; Do this z blt using dwZBufferLow and dwZBufferHigh as  range values
; specified to limit the bits copied from the source surface.
DDBLTFX_ZBUFFERRANGE                    = 000000080h

;
; Do this z blt adding the dwZBufferBaseDest to each of the sources z values
; before comparing it with the desting z values.
DDBLTFX_ZBUFFERBASEDEST                 = 000000100h

;***************************************************************************
;
; DIRECTDRAWSURFACE OVERLAY FX FLAGS
;
;***************************************************************************/

;
; If stretching, use arithmetic stretching along the Y axis for this overlay.
DDOVERFX_ARITHSTRETCHY                  = 000000001h

;
; Mirror the overlay across the vertical axis
DDOVERFX_MIRRORLEFTRIGHT                = 000000002h

;
; Mirror the overlay across the horizontal axis
DDOVERFX_MIRRORUPDOWN                   = 000000004h

;
; Deinterlace the overlay, if possible
DDOVERFX_DEINTERLACE                    = 000000008h


;***************************************************************************
;
; DIRECTDRAW WAITFORVERTICALBLANK FLAGS
;
;***************************************************************************/

;
; return when the vertical blank interval begins
DDWAITVB_BLOCKBEGIN                     = 000000001h

;
; set up an event to trigger when the vertical blank begins
DDWAITVB_BLOCKBEGINEVENT                = 000000002h

;
; return when the vertical blank interval ends and display begins
DDWAITVB_BLOCKEND                       = 000000004h

;***************************************************************************
;
; DIRECTDRAW GETFLIPSTATUS FLAGS
;
;***************************************************************************/

;
; is it OK to flip now?
DDGFS_CANFLIP                   = 000000001h

;
; is the last flip finished?
DDGFS_ISFLIPDONE                = 000000002h

;***************************************************************************
;
; DIRECTDRAW GETBLTSTATUS FLAGS
;
;***************************************************************************/

;
; is it OK to blt now?
DDGBS_CANBLT                    = 000000001h

;
; is the blt to the surface finished?
DDGBS_ISBLTDONE                 = 000000002h


;***************************************************************************
;
; DIRECTDRAW ENUMOVERLAYZORDER FLAGS
;
;***************************************************************************/

;
; Enumerate overlays back to front.
DDENUMOVERLAYZ_BACKTOFRONT      = 000000000h

;
; Enumerate overlays front to back
DDENUMOVERLAYZ_FRONTTOBACK      = 000000001h

;***************************************************************************
;
; DIRECTDRAW UPDATEOVERLAYZORDER FLAGS
;
;***************************************************************************/

;
; Send overlay to front
DDOVERZ_SENDTOFRONT             = 000000000h

;
; Send overlay to back
DDOVERZ_SENDTOBACK              = 000000001h

;
; Move Overlay forward
DDOVERZ_MOVEFORWARD             = 000000002h

;
; Move Overlay backward
DDOVERZ_MOVEBACKWARD            = 000000003h

;
; Move Overlay in front of relative surface
DDOVERZ_INSERTINFRONTOF         = 000000004h

;
; Move Overlay in back of relative surface
DDOVERZ_INSERTINBACKOF          = 000000005h


;***************************************************************************
;
; DIRECTDRAW SETGAMMARAMP FLAGS
;
;***************************************************************************/

;
; Request calibrator to adjust the gamma ramp according to the physical
; properties of the display so that the result should appear identical
; on all systems.
DDSGR_CALIBRATE                        = 000000001h


;***************************************************************************
;
; DIRECTDRAW STARTMODETEST FLAGS
;
;***************************************************************************/

;
; Indicates that the mode being tested has passed
DDSMT_ISTESTREQUIRED                   = 000000001h


;***************************************************************************
;
; DIRECTDRAW EVALUATEMODE FLAGS
;
;***************************************************************************/

;
; Indicates that the mode being tested has passed
DDEM_MODEPASSED                        = 000000001h

;
; Indicates that the mode being tested has failed
DDEM_MODEFAILED                        = 000000002h


;===========================================================================
;
;
; DIRECTDRAW RETURN CODES
;
; The return values from DirectDraw Commands and Surface that return an HRESULT
; are codes from DirectDraw concerning the results of the action
; requested by DirectDraw.
;
;==========================================================================*/

S_OK                                   = 0
S_FALSE                                = 1
;
; Status is OK
;
; Issued by: DirectDraw Commands and all callbacks
DD_OK                                  = S_OK
DD_FALSE                               = S_FALSE

;***************************************************************************
;
; DIRECTDRAW ENUMCALLBACK RETURN VALUES
;
; EnumCallback returns are used to control the flow of the DIRECTDRAW and
; DIRECTDRAWSURFACE object enumerations.   They can only be returned by
; enumeration callback routines.
;
;***************************************************************************/

;
; stop the enumeration
DDENUMRET_CANCEL                       = 0

;
; continue the enumeration
DDENUMRET_OK                           = 1

;***************************************************************************
;
; DIRECTDRAW ERRORS
;
; Errors are represented by negative values and cannot be combined.
;
;***************************************************************************/

DDERR_SURFACELOST                      = 88760000h or 450
