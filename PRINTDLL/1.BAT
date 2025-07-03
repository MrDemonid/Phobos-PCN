@echo off

SET USERPROFILE=
SET ALLUSERSPROFILE=
SET DXSDKROOT=
SET APPDATA=
SET COMMONPROGRAMFILES=
SET COMPUTERNAME=

SET DRIVE=D
SET PATH=%DRIVE%:\WATCOM\BINNT;%DRIVE%:\WATCOM\BINW;%PATH%
SET INCLUDE=%DRIVE%:\WATCOM\H;%DRIVE%:\WATCOM\H\NT;%INCLUDE%
::SET INCLUDE=%DRIVE%:\WATCOM\H\NT\DIRECTX;%DRIVE%:\WATCOM\H\NT\DDK;%INCLUDE%
SET LIB=%DRIVE%:\WATCOM\lib386;%DRIVE%:\WATCOM\lib386\NT;%DRIVE%:\WATCOM\lib386\nt\directx
SET WATCOM=%DRIVE%:\WATCOM
SET EDPATH=%DRIVE%:\WATCOM\EDDAT
SET WHTMLHELP=%DRIVE%:\WATCOM\BINNT\HELP
SET WIPFC=%DRIVE%:\WATCOM\WIPFC

del *.log
del *.err
del *.obj
del PrintTbl.dll
cls

echo ==================================
echo ======== do compilation ==========
echo ==================================

@echo on

::wcc386 PRINTTBL.C -i=%INCLUDE% -w4 -e25 -zq -os -of -bd -fp5 -5s -bt=nt -fo=.obj -mf
wcc386 PRINTTBL.C -i=%INCLUDE% -dUNICODE -w4 -e25 -zq -os -of -bd -fp5 -5s -bt=nt -fo=.obj -mf
wlib -q -n -b PrintTbl.imp
wlink name PrintTbl sys nt_dll op maxe=25 op q FIL PRINTTBL.obj
wlib -q -n -b PrintTbl.lib +PrintTbl.dll

del *.imp
del *.lib
del *.obj
