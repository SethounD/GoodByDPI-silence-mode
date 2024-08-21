## Ссылка на оригинальную версию: https://github.com/ValdikSS/GoodbyeDPI

# Скрытый запуск `goodbyedpi.exe` через CMD и VBScript

Этот репозиторий содержит скрипт для запуска `goodbyedpi.exe` в тихом режиме, чтобы программа не отображалась на панели задач Windows. Для этого используется комбинация командного файла (CMD) и встроенного скрипта VBScript.

## Как работает скрипт

1. **Определение архитектуры**: Скрипт определяет архитектуру процессора (x86 или x86_64) и выбирает соответствующую версию программы `goodbyedpi.exe`.

2. **Создание и запуск временного VBScript**:
    - В скрипте создается временный файл `temp.vbs`, который отвечает за скрытый запуск `goodbyedpi.exe`.
    - Этот VBScript запускает `goodbyedpi.exe` с нужными параметрами, не отображая окно программы.
    - После запуска временный файл удаляется.

3. **Тихий режим**: Запуск `goodbyedpi.exe` происходит в фоновом режиме, и программа не отображается на панели задач, что делает её работу незаметной для пользователя.

## Инструкция по запуску

1. Клонируйте этот репозиторий или скачайте файлы.

2. Поместите `goodbyedpi.exe` и файлы черного списка (`russia-blacklist.txt` и `russia-youtube.txt`) в соответствующие директории (x86 и x86_64).

3. Запустите файл `run_goodbyedpi.cmd`. Этот файл автоматически:
    - Определит архитектуру вашего процессора.
    - Создаст временный VBScript для скрытого запуска `goodbyedpi.exe`.
    - Запустит `goodbyedpi.exe` с указанными параметрами без отображения окна на панели задач.
    - Удалит временный VBScript.

## Пример содержания `1_russia_blacklist.cmd`

```cmd
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