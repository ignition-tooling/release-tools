@echo on

set SCRIPT_DIR=%~dp0
set PLATFORM_TO_BUILD=x86

cd %WORKSPACE%\haptix-comm
call "make_sdk.bat" %PLATFORM_TO_BUILD%
