@ECHO OFF
PUSHD "%~dp0"
set _arch=x86
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set _arch=x86_64)
IF DEFINED PROCESSOR_ARCHITEW6432 (set _arch=x86_64)
PUSHD "%_arch%"

echo Set WshShell = CreateObject("WScript.Shell") > temp.vbs
echo WshShell.Run "goodbyedpi.exe -9 --blacklist ..\russia-blacklist.txt --blacklist ..\russia-youtube.txt", 0, False >> temp.vbs
wscript temp.vbs
del temp.vbs

POPD
POPD
