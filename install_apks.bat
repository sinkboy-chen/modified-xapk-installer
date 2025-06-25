@echo off
setlocal enabledelayedexpansion

REM Check if input directory was provided
if "%~1"=="" (
    echo Usage: install_apks.bat [directory_path]
    exit /b
)

set "APK_DIR=%~1"

REM Verify the directory exists
if not exist "%APK_DIR%" (
    echo Error: Directory "%APK_DIR%" does not exist.
    exit /b
)

set "APK_LIST="

REM Loop through .apk files and build install list
for %%f in ("%APK_DIR%\*.apk") do (
    set "APK_LIST=!APK_LIST! "%%f""
)

REM Check if any APKs were found
if "!APK_LIST!"=="" (
    echo No .apk files found in "%APK_DIR%".
    exit /b
)

echo Installing the following APKs:
echo !APK_LIST!

REM Run adb install-multiple
adb install-multiple !APK_LIST!

endlocal
