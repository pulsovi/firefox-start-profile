::@ECHO off
REM "C:\Program Files\Mozilla Firefox\firefox.exe" -P "David" -no-remote
SET firefoxOpened=0
FOR /F "delimiters=" %%i IN ('TASKLIST ^| FIND "firefox"') DO SET firefoxOpened=1
IF %firefoxOpened% EQU 1 (
	::firefox is run
	SET profileOk=0
	FOR /F "delimiters=" %%j IN ('WMIC PROCESS GET commandline ^| FIND "firefox.exe""  -P ""%1"""') DO (
		SET profileOk=1
		ECHO %%j
	)
	IF %%profileOk%% EQU 1 (
		::firefox profile is run
		echo ok
	) ELSE (
		::firefox is run on another profile
		echo ko
		::START "Firefox %1" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "%1" -no-remote
	)
) ELSE (
	::firefox not run
	START "Firefox %1" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "%1"
)
