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

net session >nul 2>&1
if not %errorlevel%==0 (
    echo Пожалуйста, запустите этот скрипт от имени администратора.
    pause
    exit /b
)

schtasks /create /tn "GoodbyeDPI Task" /tr "\"%~dp0%~nx0\"" /sc onlogon /rl highest /f
if %errorlevel%==0 (
    echo Задача успешно создана в планировщике задач.
) else (
    echo Ошибка при создании задачи. Код ошибки: %errorlevel%
)
pause
