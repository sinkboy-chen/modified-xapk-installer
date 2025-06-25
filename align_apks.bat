@echo off
setlocal enabledelayedexpansion

REM ====== CONFIG ======
set "ZIPALIGN=C:\Users\user\AppData\Local\Android\Sdk\build-tools\34.0.0\zipalign.exe"
set "APK_DIR=%~1"
set "OUTPUT_DIR=%APK_DIR%\aligned"
REM =====================

if "%~1"=="" (
    echo Usage: align_apks.bat "C:\path\to\apk\folder"
    exit /b
)

if not exist "%APK_DIR%" (
    echo Error: Directory "%APK_DIR%" does not exist.
    exit /b
)

if not exist "%ZIPALIGN%" (
    echo Error: zipalign.exe not found. Edit the script to set the correct path.
    exit /b
)

if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

echo Aligning APKs in: %APK_DIR%
for %%f in ("%APK_DIR%\*.apk") do (
    set "FILENAME=%%~nxf"
    echo Aligning %%f ...
    "%ZIPALIGN%" -p -f 4 "%%f" "%OUTPUT_DIR%\!FILENAME!"
)

echo Done. Aligned APKs saved to: %OUTPUT_DIR%
endlocal
