@ECHO off
SET firefoxOpened=0
FOR /F "delims=" %%i IN ('TASKLIST ^| FIND "firefox"') DO SET firefoxOpened=1
IF %firefoxOpened% EQU 0 (
	::firefox not runs
	START "Firefox %1" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "%1"
	TIMEOUT /T 3
	%0 %*
	GOTO :EOF
)

::firefox runs
SET profileOk=0
FOR /F "delims=" %%j IN ('WMIC PROCESS GET ProcessId^,CommandLine ^| FIND "firefox.exe""  -P ""%1"""') DO (
	SET profileOk=1
	SET CommandLineTampon=%%j
)
IF %profileOk% EQU 0 (
	::firefox runs but not at wanted profile, start it whith --no-remote option
	START "Firefox %1" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "%1" --no-remote
	TIMEOUT /T 3
	%0 %*
	GOTO :EOF
)

FOR /F "tokens=6" %%k IN ("%CommandLineTampon%") DO SET pidFfPf=%%k
IF %profileOk% EQU 1 (
	::firefox run at the wanted profile, activate it
	START ActiveWindow.ahk %pidFfPf%
)
