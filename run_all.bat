@echo off
setlocal enabledelayedexpansion

:: Check if folder name was provided as argument
if "%~1"=="" (
    echo Usage: %~nx0 foldername
    exit /b 1
)

set folder=%~1

:: Delete the aligned folder if it exists
if exist "%folder%\aligned" (
    echo Deleting existing "%folder%\aligned" folder...
    rmdir /s /q "%folder%\aligned"
)

echo Running align_apks.bat...
call align_apks.bat %folder%

echo Running sign_apks.bat...
call sign_apks.bat %folder%\aligned

echo Running install_apks.bat...
call install_apks.bat %folder%\aligned

echo Done.
pause
