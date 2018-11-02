@echo off

REM ===========================================================================
REM IDOL service installer
REM ===========================================================================

REM ---------------------------------------------------------------------------
REM Variables
REM ---------------------------------------------------------------------------

set COMPONENTS=( LicenseServer, MediaServer )

set VERSION=12.1.0
set INSTALL_BASE=C:\MicroFocus

set SOURCE_DIR=%HOMEPATH%\Downloads
set LICENSE_KEY=licensekey.dat

set SERVICE_PREFIX=MicroFocus-
set INSTALL_DIR=%INSTALL_BASE%\IDOLServer-%VERSION%

REM ---------------------------------------------------------------------------
REM Main
REM ---------------------------------------------------------------------------
REM When launched by an Administrator, still run in current directory
pushd %~dp0

rd /s /q %INSTALL_DIR%
mkdir %INSTALL_DIR%

for %%i in %COMPONENTS% do (

  echo.
  echo Extracting %%i component...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%SOURCE_DIR%\%%i_%VERSION%_WINDOWS_X86_64.zip', '%INSTALL_DIR%'); }"
  ren %INSTALL_DIR%\%%i_%VERSION%_WINDOWS_X86_64 %%i

  echo Installing %%i runtime dependencies...
  if exist %INSTALL_DIR%\%%i\vcredist_2013.exe (
    %INSTALL_DIR%\%%i\vcredist_2013.exe /install /passive /norestart
  )
  if exist %INSTALL_DIR%\%%i\runtime\vcredist_2010.exe (
    %INSTALL_DIR%\%%i\runtime\vcredist_2010.exe /passive /norestart
  )
  if exist %INSTALL_DIR%\%%i\runtime\vcredist_2013.exe (
    %INSTALL_DIR%\%%i\runtime\vcredist_2013.exe /install /passive /norestart
  )
  if exist %INSTALL_DIR%\%%i\runtime\vcredist_x86_2013.exe (
    %INSTALL_DIR%\%%i\runtime\vcredist_x86_2013.exe /install /passive /norestart
  )

  echo Configuring %%i as a Windows service
  %INSTALL_DIR%\%%i\%%i.exe -install
  sc config %%i DisplayName= "%SERVICE_PREFIX%%%i"

  if /i %%i==LicenseServer (
    echo Copying license key file...
    copy /y %SOURCE_DIR%\%LICENSE_KEY% %INSTALL_DIR%\LicenseServer\licensekey.dat
  )
)

popd

echo.
echo Install complete.
pause
