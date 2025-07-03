@echo off

:: Задаем диск, на котором расположен пакет TASM
SET DRIVE=F

:: освобождаем место в среде переменных (будут автоматом восстановлены по окончании батника)
SET USERPROFILE=
SET ALLUSERSPROFILE=
SET DXSDKROOT=
SET APPDATA=
SET COMMONPROGRAMFILES=
SET COMPUTERNAME=

:: задаем свои переменные и пути
SET INCLUDE=%DRIVE%:\Lang\TASM\INCLUDE
SET LIB=%DRIVE%:\Lang\TASM\LIB
SET PATH=%DRIVE%:\Lang\TASM\BIN;%PATH%

:: компилируем
del alarm.exe
cls
rc /v alarm.rc
pause

echo ===========================================
echo =     Creating .EXE!....Please wait...    =
echo ===========================================
tasm32 /kh32000 /ml /m3 /i%INCLUDE% owner.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% queue.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% console.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% pcn.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% odbcdrv.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% logdlg.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% auxport.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% util.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% alarm.asm
if errorlevel == 1 goto fehler
tasm32 /kh32000 /ml /m3 /i%INCLUDE% tabctrl.asm
if errorlevel == 1 goto fehler

tlink32 -x -V4.0 -Tpe -aa -c /L%LIB% alarm pcn owner console util queue tabctrl auxport odbcdrv logdlg,,,, alarm.def,alarm.res
if errorlevel == 1 goto fehler
echo ===========================================
echo = Yeehaw! .EXE created! No Errors! Ready! =
echo ===========================================
::brcc32 alarm.rc
goto ende
:fehler
echo ######################################
echo ######### AN ERROR OCCURED! ##########
echo ######################################
:ende
del *.obj
pause
REM ASM-Batch Template by tE
