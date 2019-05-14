SET CHROMEBASE=%LOCALAPPDATA%\Google\Chrome\User Data\Default
SET CHROMEBACKUPDIR=P:\Documents\T1_Bookmarks
SET LOGZ=P:\Documents\T1_Bookmarks\logfile.log
SET USER=%userdomain%\%username%

:CHROMERESTORE
TASKLIST -v /FI "USERNAME eq %USER%" | findstr "chrome.exe" > nul
IF %ERRORLEVEL% == 0 (
CALL :CHROMEOPEN
GOTO :CHROMERESTORE
)
IF EXIST "%CHROMEBACKUPDIR%" ROBOCOPY "%CHROMEBACKUPDIR%" "%CHROMEBASE%" /copy:DAT /R:5 /ETA /log:"%LOGZ%"
GOTO :EOF

:CHROMEOPEN
ECHO When you get a chance close Google Chrome.
ECHO.
ECHO If it appears to be closed but you still get this error please use task manager to end tasks with the name of "chrome.exe".
ECHO.
ECHO I will automatically try again once you continue.
ECHO Press any key to continue.
CHOICE /N /C Y /D Y /T 2 > NUL
PAUSE >NUL
GOTO :EOF
