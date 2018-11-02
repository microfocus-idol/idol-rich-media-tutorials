@echo off

REM ===========================================================================
REM IDOL service uninstaller
REM ===========================================================================

REM ---------------------------------------------------------------------------
REM Variables
REM ---------------------------------------------------------------------------

set COMPONENTS=( LicenseServer, MediaServer )

set VERSION=12.1.0
set INSTALL_BASE=C:\MicroFocus

set INSTALL_DIR=%INSTALL_BASE%\IDOLServer-%VERSION%

REM ---------------------------------------------------------------------------
REM Main
REM ---------------------------------------------------------------------------
REM When launched by an Administrator, still run in current directory
pushd %~dp0

for %%i in %COMPONENTS% do (
	echo.
	echo Uninstalling %%i component...

	REM Remove Windows service
	net stop %%i
  timeout 5
	sc delete %%i
)

rd /s /q %INSTALL_DIR%

popd

echo.
echo Uninstall complete.
pause
