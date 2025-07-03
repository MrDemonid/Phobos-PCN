; GDI32.DLL structures and constants

struc POINT
  x             dd ?
  y             dd ?
ends

struc POINTS
  x             dw ?
  y             dw ?
ends

struc SIZEL
  x             dd ?
  y             dd ?
ends

struc BITMAP
  bmType        dd ?
  bmWidth       dd ?
  bmHeight      dd ?
  bmWidthBytes  dd ?
  bmPlanes      dw ?
  bmBitsPixel   dw ?
  bmBits        dd ?
ends

struc RGBTRIPLE
  rgbBlue       db ?
  rgbGree       db ?
  rgbRed        db ?
ends

struc RGBQUAD
  rgbBlue       db ?
  rgbGree       db ?
  rgbRed        db ?
  rgbReserved   db ?
ends

struc BITMAPCOREHEADER
  bcSize        dd ?
  bcWidth       dw ?
  bcHeight      dw ?
  bcPlanes      dw ?
  bcBitCount    dw ?
ends

struc BITMAPINFOHEADER
  biSize          dd ?
  biWidth         dd ?
  biHeight        dd ?
  biPlanes        dw ?
  biBitCount      dw ?
  biCompression   dd ?
  biSizeImage     dd ?
  biXPelsPerMeter dd ?
  biYPelsPerMeter dd ?
  biClrUsed       dd ?
  biClrImportant  dd ?
ends

struc BITMAPFILEHEADER
  bfType        dw ?
  bfSize        dd ?
  bfReserved1   dw ?
  bfReserved2   dw ?
  bfOffBits     dd ?
ends

struc TEXTMETRIC
  tmHeight              dd ?
  tmAscent              dd ?
  tmDescent             dd ?
  tmInternalLeading     dd ?
  tmExternalLeading     dd ?
  tmAveCharWidth        dd ?
  tmMaxCharWidth        dd ?
  tmWeight              dd ?
  tmOverhang            dd ?
  tmDigitizedAspectX    dd ?
  tmDigitizedAspectY    dd ?
  tmFirstChar           TCHAR ?
  tmLastChar            TCHAR ?
  tmDefaultChar         TCHAR ?
  tmBreakChar           TCHAR ?
  tmItalic              db ?
  tmUnderlined          db ?
  tmStruckOut           db ?
  tmPitchAndFamily      db ?
  tmCharSet             db ?
ends

struc LOGBRUSH
  lbStyle               dd ?
  lbColor               dd ?
  lbHatch               dd ?
ends

struc LOGPEN
  lopnStyle             dd ?
  lopnWidth             POINT <>
  lopnColor             dd ?
ends

struc EXTLOGPEN
  elpPenStyle           dd ?
  elpWidth              dd ?
  elpBrushStyle         dd ?
  elpColor              dd ?
  elpHatch              dd ?
  elpNumEntries         dd ?
  elpStyleEntry         dd ?
ends

struc LOGFONT
  lfHeight              dd ?
  lfWidth               dd ?
  lfEscapement          dd ?
  lfOrientation         dd ?
  lfWeight              dd ?
  lfItalic              db ?
  lfUnderline           db ?
  lfStrikeOut           db ?
  lfCharSet             db ?
  lfOutPrecision        db ?
  lfClipPrecision       db ?
  lfQuality             db ?
  lfPitchAndFamily      db ?
  lfFaceName            TCHAR 32 dup (?)
ends

struc ENUMLOGFONT
  elfLogFont            LOGFONT <>
  elfFullName           TCHAR 64 dup (?)
  elfStyle              TCHAR 32 dup (?)
ends

struc ENUMLOGFONTEX
  elfLogFont            LOGFONT <>
  elfFullName           TCHAR 64 dup (?)
  elfStyle              TCHAR 32 dup (?)
  elfScript             TCHAR 32 dup (?)
ends

struc PIXELFORMATDESCRIPTOR
  nSize                 dw ?
  nVersion              dw ?
  dwFlags               dd ?
  iPixelType            db ?
  cColorBits            db ?
  cRedBits              db ?
  cRedShift             db ?
  cGreenBits            db ?
  cGreenShift           db ?
  cBlueBits             db ?
  cBlueShift            db ?
  cAlphaBits            db ?
  cAlphaShift           db ?
  cAccumBits            db ?
  cAccumRedBits         db ?
  cAccumGreenBits       db ?
  cAccumBlueBits        db ?
  cAccumAlphaBits       db ?
  cDepthBits            db ?
  cStencilBits          db ?
  cAuxBuffers           db ?
  iLayerType            db ?
  bReserved             db ?
  dwLayerMask           dd ?
  dwVisibleMask         dd ?
  dwDamageMask          dd ?
ends


; Document information
struc DOCINFO
  cbSize                dd ?
  lpszDocName           dd ?
  lpszOutput            dd ?
  ; #if (WINVER >= 0x0400)
  lpszDatatype          dd ?
  fwType                dd ?
ends


; General constants

GDI_ERROR               equ 0FFFFFFFFh
HGDI_ERROR              equ 0FFFFFFFFh

; Binary raster operations

R2_BLACK                equ 1
R2_NOTMERGEPEN          equ 2
R2_MASKNOTPEN           equ 3
R2_NOTCOPYPEN           equ 4
R2_MASKPENNOT           equ 5
R2_NOT                  equ 6
R2_XORPEN               equ 7
R2_NOTMASKPEN           equ 8
R2_MASKPEN              equ 9
R2_NOTXORPEN            equ 10
R2_NOP                  equ 11
R2_MERGENOTPEN          equ 12
R2_COPYPEN              equ 13
R2_MERGEPENNOT          equ 14
R2_MERGEPEN             equ 15
R2_WHITE                equ 16

; Raster operations

SRCCOPY                 equ 00CC0020h
SRCPAINT                equ 00EE0086h
SRCAND                  equ 008800C6h
SRCINVERT               equ 00660046h
SRCERASE                equ 00440328h
NOTSRCCOPY              equ 00330008h
NOTSRCERASE             equ 001100A6h
MERGECOPY               equ 00C000CAh
MERGEPAINT              equ 00BB0226h
PATCOPY                 equ 00F00021h
PATPAINT                equ 00FB0A09h
PATINVERT               equ 005A0049h
DSTINVERT               equ 00550009h
BLACKNESS               equ 00000042h
WHITENESS               equ 00FF0062h

; Region flags

ERROR                   equ 0
NULLREGION              equ 1
SIMPLEREGION            equ 2
COMPLEXREGION           equ 3

; CombineRgn styles

RGN_AND                 equ 1
RGN_OR                  equ 2
RGN_XOR                 equ 3
RGN_DIFF                equ 4
RGN_COPY                equ 5

; StretchBlt modes

BLACKONWHITE            equ 1
WHITEONBLACK            equ 2
COLORONCOLOR            equ 3
HALFTONE                equ 4
STRETCH_ANDSCANS        equ BLACKONWHITE
STRETCH_ORSCANS         equ WHITEONBLACK
STRETCH_DELETESCANS     equ COLORONCOLOR
STRETCH_HALFTONE        equ HALFTONE

; PolyFill modes

ALTERNATE               equ 1
WINDING                 equ 2

; Background modes

TRANSPARENT             equ 1
OPAQUE                  equ 2

; Point types

PT_CLOSEFIGURE          equ 1
PT_LINETO               equ 2
PT_BEZIERTO             equ 4
PT_MOVETO               equ 6

; Mapping modes

MM_TEXT                 equ 1
MM_LOMETRIC             equ 2
MM_HIMETRIC             equ 3
MM_LOENGLISH            equ 4
MM_HIENGLISH            equ 5
MM_TWIPS                equ 6
MM_ISOTROPIC            equ 7
MM_ANISOTROPIC          equ 8

; Coordinate modes

ABSOLUTE                equ 1
RELATIVE                equ 2

; Stock logical objects

WHITE_BRUSH             equ 0
LTGRAY_BRUSH            equ 1
GRAY_BRUSH              equ 2
DKGRAY_BRUSH            equ 3
BLACK_BRUSH             equ 4
NULL_BRUSH              equ 5
HOLLOW_BRUSH            equ NULL_BRUSH
WHITE_PEN               equ 6
BLACK_PEN               equ 7
NULL_PEN                equ 8
OEM_FIXED_FONT          equ 10
ANSI_FIXED_FONT         equ 11
ANSI_VAR_FONT           equ 12
SYSTEM_FONT             equ 13
DEVICE_DEFAULT_FONT     equ 14
DEFAULT_PALETTE         equ 15
SYSTEM_FIXED_FONT       equ 16
DEFAULT_GUI_FONT        equ 17

; Brush styles

BS_SOLID                equ 0
BS_NULL                 equ 1
BS_HOLLOW               equ BS_NULL
BS_HATCHED              equ 2
BS_PATTERN              equ 3
BS_INDEXED              equ 4
BS_DIBPATTERN           equ 5
BS_DIBPATTERNPT         equ 6
BS_PATTERN8X8           equ 7
BS_DIBPATTERN8X8        equ 8
BS_MONOPATTERN          equ 9

; Hatch styles

HS_HORIZONTAL           equ 0
HS_VERTICAL             equ 1
HS_FDIAGONAL            equ 2
HS_BDIAGONAL            equ 3
HS_CROSS                equ 4
HS_DIAGCROSS            equ 5

; Pen styles

PS_SOLID                equ 0
PS_DASH                 equ 1
PS_DOT                  equ 2
PS_DASHDOT              equ 3
PS_DASHDOTDOT           equ 4
PS_NULL                 equ 5
PS_INSIDEFRAME          equ 6
PS_USERSTYLE            equ 7
PS_ALTERNATE            equ 8
PS_ENDCAP_ROUND         equ 0
PS_ENDCAP_SQUARE        equ 100h
PS_ENDCAP_FLAT          equ 200h
PS_JOIN_ROUND           equ 0
PS_JOIN_BEVEL           equ 1000h
PS_JOIN_MITER           equ 2000h
PS_COSMETIC             equ 0
PS_GEOMETRIC            equ 010000h

; Arc directions

AD_COUNTERCLOCKWISE     equ 1
AD_CLOCKWISE            equ 2

; Text alignment options

TA_NOUPDATECP           equ 0
TA_UPDATECP             equ 1
TA_LEFT                 equ 0
TA_RIGHT                equ 2
TA_CENTER               equ 6
TA_TOP                  equ 0
TA_BOTTOM               equ 8
TA_BASELINE             equ 24
TA_RTLREADING           equ 100h
VTA_BASELINE            equ TA_BASELINE
VTA_LEFT                equ TA_BOTTOM
VTA_RIGHT               equ TA_TOP
VTA_CENTER              equ TA_CENTER
VTA_BOTTOM              equ TA_RIGHT
VTA_TOP                 equ TA_LEFT

; ExtTextOut options

ETO_OPAQUE              equ 0002h
ETO_CLIPPED             equ 0004h
ETO_GLYPH_INDEX         equ 0010h
ETO_RTLREADING          equ 0080h
ETO_IGNORELANGUAGE      equ 1000h

; Bitmap compression types

BI_RGB                  equ 0
BI_RLE8                 equ 1
BI_RLE4                 equ 2
BI_BITFIELDS            equ 3

; tmPitchAndFamily flags

TMPF_FIXED_PITCH        equ 1
TMPF_VECTOR             equ 2
TMPF_TRUETYPE           equ 4
TMPF_DEVICE             equ 8

; Font output precision values

OUT_DEFAULT_PRECIS      equ 0
OUT_STRING_PRECIS       equ 1
OUT_CHARACTER_PRECIS    equ 2
OUT_STROKE_PRECIS       equ 3
OUT_TT_PRECIS           equ 4
OUT_DEVICE_PRECIS       equ 5
OUT_RASTER_PRECIS       equ 6
OUT_TT_ONLY_PRECIS      equ 7
OUT_OUTLINE_PRECIS      equ 8
OUT_SCREEN_OUTLINE_PRECIS equ 9

; Font clipping precision values

CLIP_DEFAULT_PRECIS     equ 0
CLIP_CHARACTER_PRECIS   equ 1
CLIP_STROKE_PRECIS      equ 2
CLIP_LH_ANGLES          equ 10h
CLIP_TT_ALWAYS          equ 20h
CLIP_EMBEDDED           equ 80h

; Font output quality values

DEFAULT_QUALITY         equ 0
DRAFT_QUALITY           equ 1
PROOF_QUALITY           equ 2
NONANTIALIASED_QUALITY  equ 3
ANTIALIASED_QUALITY     equ 4

; Font pitch values

DEFAULT_PITCH           equ 0
FIXED_PITCH             equ 1
VARIABLE_PITCH          equ 2
MONO_FONT               equ 8

; Font families

FF_DONTCARE             equ 00h
FF_ROMAN                equ 10h
FF_SWISS                equ 20h
FF_MODERN               equ 30h
FF_SCRIPT               equ 40h
FF_DECORATIVE           equ 50h

; Font weights

FW_DONTCARE             equ 0
FW_THIN                 equ 100
FW_EXTRALIGHT           equ 200
FW_LIGHT                equ 300
FW_NORMAL               equ 400
FW_MEDIUM               equ 500
FW_SEMIBOLD             equ 600
FW_BOLD                 equ 700
FW_EXTRABOLD            equ 800
FW_HEAVY                equ 900
FW_ULTRALIGHT           equ FW_EXTRALIGHT
FW_REGULAR              equ FW_NORMAL
FW_DEMIBOLD             equ FW_SEMIBOLD
FW_ULTRABOLD            equ FW_EXTRABOLD
FW_BLACK                equ FW_HEAVY

; Character set values

ANSI_CHARSET            equ 0
DEFAULT_CHARSET         equ 1
SYMBOL_CHARSET          equ 2
SHIFTJIS_CHARSET        equ 128
HANGEUL_CHARSET         equ 129
GB2312_CHARSET          equ 134
CHINESEBIG5_CHARSET     equ 136
OEM_CHARSET             equ 255
JOHAB_CHARSET           equ 130
HEBREW_CHARSET          equ 177
ARABIC_CHARSET          equ 178
GREEK_CHARSET           equ 161
TURKISH_CHARSET         equ 162
VIETNAMESE_CHARSET      equ 163
THAI_CHARSET            equ 222
EASTEUROPE_CHARSET      equ 238
RUSSIAN_CHARSET         equ 204
MAC_CHARSET             equ 77
BALTIC_CHARSET          equ 186

; Pixel format constants

PFD_TYPE_RGBA             equ 0
PFD_TYPE_COLORINDEX       equ 1
PFD_MAIN_PLANE            equ 0
PFD_OVERLAY_PLANE         equ 1
PFD_UNDERLAY_PLANE        equ -1
PFD_DOUBLEBUFFER          equ 1
PFD_STEREO                equ 2
PFD_DRAW_TO_WINDOW        equ 4
PFD_DRAW_TO_BITMAP        equ 8
PFD_SUPPORT_GDI           equ 10h
PFD_SUPPORT_OPENGL        equ 20h
PFD_GENERIC_FORMAT        equ 40h
PFD_NEED_PALETTE          equ 80h
PFD_NEED_SYSTEM_PALETTE   equ 100h
PFD_SWAP_EXCHANGE         equ 200h
PFD_SWAP_COPY             equ 400h
PFD_SWAP_LAYER_BUFFERS    equ 800h
PFD_GENERIC_ACCELERATED   equ 1000h
PFD_DEPTH_DONTCARE        equ 20000000h
PFD_DOUBLEBUFFER_DONTCARE equ 40000000h
PFD_STEREO_DONTCARE       equ 80000000h

; Device Parameters for GetDeviceCaps()
DRIVERVERSION           equ 0     ; Device driver version
TECHNOLOGY              equ 2     ; Device classification
HORZSIZE                equ 4     ; Horizontal size in millimeters
VERTSIZE                equ 6     ; Vertical size in millimeters
HORZRES                 equ 8     ; Horizontal width in pixels
VERTRES                 equ 10    ; Vertical height in pixels
BITSPIXEL               equ 12    ; Number of bits per pixel
PLANES                  equ 14    ; Number of planes
NUMBRUSHES              equ 16    ; Number of brushes the device has
NUMPENS                 equ 18    ; Number of pens the device has
NUMMARKERS              equ 20    ; Number of markers the device has
NUMFONTS                equ 22    ; Number of fonts the device has
NUMCOLORS               equ 24    ; Number of colors the device supports
PDEVICESIZE             equ 26    ; Size required for device descriptor
CURVECAPS               equ 28    ; Curve capabilities
LINECAPS                equ 30    ; Line capabilities
POLYGONALCAPS           equ 32    ; Polygonal capabilities
TEXTCAPS                equ 34    ; Text capabilities
CLIPCAPS                equ 36    ; Clipping capabilities
RASTERCAPS              equ 38    ; Bitblt capabilities
ASPECTX                 equ 40    ; Length of the X leg
ASPECTY                 equ 42    ; Length of the Y leg
ASPECTXY                equ 44    ; Length of the hypotenuse
LOGPIXELSX              equ 88    ; Logical pixels/inch in X
LOGPIXELSY              equ 90    ; Logical pixels/inch in Y
SIZEPALETTE             equ 104   ; Number of entries in physical palette
NUMRESERVED             equ 106   ; Number of reserved entries in palette
COLORRES                equ 108   ; Actual color resolution

; Printing related DeviceCaps. These replace the appropriate Escapes

PHYSICALWIDTH           equ 110   ; Physical Width in device units
PHYSICALHEIGHT          equ 111   ; Physical Height in device units
PHYSICALOFFSETX         equ 112   ; Physical Printable Area x margin
PHYSICALOFFSETY         equ 113   ; Physical Printable Area y margin
SCALINGFACTORX          equ 114   ; Scaling factor x
SCALINGFACTORY          equ 115   ; Scaling factor y

; Display driver specific

VREFRESH                equ 116   ; Current vertical refresh rate of the display device (for displays only) in Hz
DESKTOPVERTRES          equ 117   ; Horizontal width of entire desktop in pixels
DESKTOPHORZRES          equ 118   ; Vertical height of entire desktop in pixels
BLTALIGNMENT            equ 119   ; Preferred blt alignment

; Device Capability Masks:

; Device Technologies
DT_PLOTTER              equ 0     ; Vector plotter
DT_RASDISPLAY           equ 1     ; Raster display
DT_RASPRINTER           equ 2     ; Raster printer
DT_RASCAMERA            equ 3     ; Raster camera
DT_CHARSTREAM           equ 4     ; Character-stream, PLP
DT_METAFILE             equ 5     ; Metafile, VDM
DT_DISPFILE             equ 6     ; Display-file

; Curve Capabilities
CC_NONE                 equ 0     ; Curves not supported
CC_CIRCLES              equ 1     ; Can do circles
CC_PIE                  equ 2     ; Can do pie wedges
CC_CHORD                equ 4     ; Can do chord arcs
CC_ELLIPSES             equ 8     ; Can do ellipese
CC_WIDE                 equ 16    ; Can do wide lines
CC_STYLED               equ 32    ; Can do styled lines
CC_WIDESTYLED           equ 64    ; Can do wide styled lines
CC_INTERIORS            equ 128   ; Can do interiors
CC_ROUNDRECT            equ 256

; Line Capabilities
LC_NONE                 equ 0     ; Lines not supported
LC_POLYLINE             equ 2     ; Can do polylines
LC_MARKER               equ 4     ; Can do markers
LC_POLYMARKER           equ 8     ; Can do polymarkers
LC_WIDE                 equ 16    ; Can do wide lines
LC_STYLED               equ 32    ; Can do styled lines
LC_WIDESTYLED           equ 64    ; Can do wide styled lines
LC_INTERIORS            equ 128   ; Can do interiors

; Polygonal Capabilities
PC_NONE                 equ 0     ; Polygonals not supported
PC_POLYGON              equ 1     ; Can do polygons
PC_RECTANGLE            equ 2     ; Can do rectangles
PC_WINDPOLYGON          equ 4     ; Can do winding polygons
PC_TRAPEZOID            equ 4     ; Can do trapezoids
PC_SCANLINE             equ 8     ; Can do scanlines
PC_WIDE                 equ 16    ; Can do wide borders
PC_STYLED               equ 32    ; Can do styled borders
PC_WIDESTYLED           equ 64    ; Can do wide styled borders
PC_INTERIORS            equ 128   ; Can do interiors
PC_POLYPOLYGON          equ 256   ; Can do polypolygons
PC_PATHS                equ 512   ; Can do paths

; Clipping Capabilities
CP_NONE                 equ 0     ; No clipping of output
CP_RECTANGLE            equ 1     ; Output clipped to rects
CP_REGION               equ 2     ; obsolete

; Text Capabilities
TC_OP_CHARACTER         equ 00001h; Can do OutputPrecision   CHARACTER
TC_OP_STROKE            equ 00002h; Can do OutputPrecision   STROKE
TC_CP_STROKE            equ 00004h; Can do ClipPrecision     STROKE
TC_CR_90                equ 00008h; Can do CharRotAbility    90
TC_CR_ANY               equ 00010h; Can do CharRotAbility    ANY
TC_SF_X_YINDEP          equ 00020h; Can do ScaleFreedom      X_YINDEPENDENT
TC_SA_DOUBLE            equ 00040h; Can do ScaleAbility      DOUBLE
TC_SA_INTEGER           equ 00080h; Can do ScaleAbility      INTEGER
TC_SA_CONTIN            equ 00100h; Can do ScaleAbility      CONTINUOUS
TC_EA_DOUBLE            equ 00200h; Can do EmboldenAbility   DOUBLE
TC_IA_ABLE              equ 00400h; Can do ItalisizeAbility  ABLE
TC_UA_ABLE              equ 00800h; Can do UnderlineAbility  ABLE
TC_SO_ABLE              equ 01000h; Can do StrikeOutAbility  ABLE
TC_RA_ABLE              equ 02000h; Can do RasterFontAble    ABLE
TC_VA_ABLE              equ 04000h; Can do VectorFontAble    ABLE
TC_RESERVED             equ 08000h;
TC_SCROLLBLT            equ 10000h; Don't do text scroll with blt

; Raster Capabilities
RC_BITBLT               equ 1     ; Can do standard BLT.
RC_BANDING              equ 2     ; Device requires banding support
RC_SCALING              equ 4     ; Device requires scaling support
RC_BITMAP64             equ 8     ; Device can support >64K bitmap
RC_GDI20_OUTPUT         equ 0010h ; has 2.0 output calls
RC_GDI20_STATE          equ 0020h
RC_SAVEBITMAP           equ 0040h
RC_DI_BITMAP            equ 0080h ; supports DIB to memory
RC_PALETTE              equ 0100h ; supports a palette
RC_DIBTODEV             equ 0200h ; supports DIBitsToDevice
RC_BIGFONT              equ 0400h ; supports >64K fonts
RC_STRETCHBLT           equ 0800h ; supports StretchBlt
RC_FLOODFILL            equ 1000h ; supports FloodFill
RC_STRETCHDIB           equ 2000h ; supports StretchDIBits
RC_OP_DX_OUTPUT         equ 4000h
RC_DEVBITS              equ 8000h

; DIB color table identifiers

DIB_RGB_COLORS          equ 0     ; color table in RGBs
DIB_PAL_COLORS          equ 1     ; color table in palette indices
