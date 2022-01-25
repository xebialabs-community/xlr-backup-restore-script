@echo off
REM
REM Restore the H2 Repository and Archive Database
REM

setlocal ENABLEDELAYEDEXPANSION

REM Get Java executable
if "%JAVA_HOME%"=="" (
  set JAVACMD=java
) else (
  set JAVACMD="%JAVA_HOME%\bin\java"
)

REM Get XL Release server home dir
if "%XL_RELEASE_SERVER_HOME%"=="" (
  cd /d "%~dp0"
  cd ..
  set XL_RELEASE_SERVER_HOME=!CD!
)

cd /d "%XL_RELEASE_SERVER_HOME%"

set H2_CLASSPATH="%XL_RELEASE_SERVER_HOME%\lib\*"

set RESTORE_SCRIPT="org.h2.tools.RunScript"
set args=%*

REM Run restore script
(
%JAVACMD% -cp "%H2_CLASSPATH%" %RESTORE_SCRIPT% ^
-url jdbc:h2:file:%XL_RELEASE_SERVER_HOME%\repository\db ^
-user sa ^
-script %XL_RELEASE_SERVER_HOME%\backup-repository.zip ^
-options compression zip QUIRKS_MODE VARIABLE_BINARY %args%

%JAVACMD% -cp "%H2_CLASSPATH%" %RESTORE_SCRIPT% ^
-url jdbc:h2:file:%XL_RELEASE_SERVER_HOME%\archive\db ^
-user sa ^
-script %XL_RELEASE_SERVER_HOME%\backup-archive.zip ^
-options compression zip QUIRKS_MODE VARIABLE_BINARY %args%

del %XL_RELEASE_SERVER_HOME%\backup-repository.zip
del %XL_RELEASE_SERVER_HOME%\backup-archive.zip
)
endlocal
