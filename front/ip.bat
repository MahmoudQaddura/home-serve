@echo off
setlocal enabledelayedexpansion

REM Get current IPv4 address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4 Address"') do (
    set "ip=%%a"
    set "ip=!ip:~1!"
)

REM Set .env.local file path
set "file=.env.local"
set "search=VITE_BACK_IP=(ip here)"
set "replace=VITE_BACK_IP=!ip!"

REM Check if .env.local file exists
if not exist "%file%" (
    REM Create .env.local file and add IP
    echo %replace%> "%file%"
    echo .env.local created successfully.
) else (
    REM Perform the replacement
    (for /f "usebackq delims=" %%i in ("%file%") do (
        set "line=%%i"
        if "!line!" equ "%search%" (
            echo %replace%
        ) else (
            echo %%i
        )
    )) > "%file%.tmp"

    REM Replace the original file with the updated one
    move /y "%file%.tmp" "%file%" >nul
    echo .env.local updated successfully.
)
