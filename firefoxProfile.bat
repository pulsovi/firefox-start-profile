@ECHO off
SET firefoxOpened=0
FOR /F "delims=" %%i IN ('TASKLIST ^| FIND "firefox"') DO SET firefoxOpened=1
IF %firefoxOpened% EQU 0 (
	START "Firefox %1" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "%1"
	GOTO :EOF
)

SET profileOk=0
FOR /F "delims=" %%j IN ('WMIC PROCESS GET ProcessId^,CommandLine ^| FIND "firefox.exe""  -P ""%1"""') DO (
	SET profileOk=1
	SET CommandLineTampon=%%j
)
IF %profileOk% EQU 0 (
	START "Firefox %1" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "%1" --no-remote
	GOTO :EOF
)

FOR /F "tokens=6" %%k IN ("%CommandLineTampon%") DO SET pidFfPf=%%k
IF %profileOk% EQU 1 (
	START ActiveWindow.ahk %pidFfPf%
)
