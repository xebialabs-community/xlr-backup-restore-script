@echo off
REM
REM Backup the H2 Repository and Archive Database
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

set BACKUP_SCRIPT="org.h2.tools.Script"
set args=%*

REM Run backup script
(
%JAVACMD% -cp "%H2_CLASSPATH%" %BACKUP_SCRIPT% ^
-url jdbc:h2:file:%XL_RELEASE_SERVER_HOME%\repository\db ^
-user sa -script backup-repository.zip -options compression zip %args%

%JAVACMD% -cp "%H2_CLASSPATH%" %BACKUP_SCRIPT% ^
-url jdbc:h2:file:%XL_RELEASE_SERVER_HOME%\archive\db ^
-user sa -script backup-archive.zip -options compression zip %args%
)

endlocal
