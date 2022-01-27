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

REM Default live db is repository. For Archive db, pass explicit argument -db archive 
set DB_NAME=repository
if "%args%" neq "" (
    if "%args%" neq "%args:-db archive%" set DB_NAME=archive
)

REM Run backup script
%JAVACMD% -cp "%H2_CLASSPATH%" %BACKUP_SCRIPT% ^
-url jdbc:h2:file:%XL_RELEASE_SERVER_HOME%\%DB_NAME%\db ^
-user sa -script backup-%DB_NAME%.zip -options compression zip

endlocal
