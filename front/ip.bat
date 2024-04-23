@echo off
setlocal enabledelayedexpansion

REM Get current IPv4 address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4 Address"') do (
    set "ip=%%a"
    set "ip=!ip:~1!"
)

REM Set .env.local file path
set "file=.env.local"
set "search=VITE_BACK_IP="

REM Check if .env.local file exists
if not exist "%file%" (
    REM Create .env.local file and add IP
    echo %search%!ip!> "%file%"
    echo .env.local created successfully.
) else (
    REM Check if .env.local file contains VITE_BACK_IP=
    findstr /C:"%search%" "%file%" >nul
    if errorlevel 1 (
        REM Append IP to .env.local file
        echo %search%!ip!>> "%file%"
        echo VITE_BACK_IP added to .env.local
    ) else (
        REM Perform the replacement
        (for /f "usebackq tokens=*" %%i in ("%file%") do (
            set "line=%%i"
  
            echo !line! | findstr /C:"%search%" > nul
            if not errorlevel 1 (

                echo %search%!ip!
            ) else (
 
                echo %%i
            )
        )) > "%file%.tmp"

        REM Replace the original file with the updated one
        move /y "%file%.tmp" "%file%" >nul
        echo .env.local updated successfully.
    )
)
