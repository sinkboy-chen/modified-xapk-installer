@echo off
setlocal enabledelayedexpansion

REM ===== USER CONFIGURATION =====
set "KEYSTORE_PATH=my-release-key.jks"
set "KEY_ALIAS=myalias"
set "KEY_PASSWORD=123456"
set "APK_DIR=%~1"
set "APKSIGNER_PATH=C:\Users\user\AppData\Local\Android\Sdk\build-tools\34.0.0\apksigner.bat"
REM ==============================

if "%~1"=="" (
    echo Usage: sign_apks_with_apksigner.bat "C:\path\to\apk\folder"
    exit /b
)

if not exist "%APK_DIR%" (
    echo Error: Directory "%APK_DIR%" does not exist.
    exit /b
)

REM Sign each APK using apksigner
for %%f in ("%APK_DIR%\*.apk") do (
    echo Signing: %%f
    call "%APKSIGNER_PATH%" sign --ks "%KEYSTORE_PATH%" --ks-key-alias "%KEY_ALIAS%" --ks-pass pass:%KEY_PASSWORD% --key-pass pass:%KEY_PASSWORD% "%%f"

    if errorlevel 1 (
        echo ❌ Failed to sign %%f
    ) else (
        echo ✅ Signed %%f successfully
    )
)

echo All APKs processed.
endlocal
