@echo off
setlocal

set DESTINO=%2
:: Create numbered list of files in a temporary file
set "tempFile=%temp%\%~nx0_fileList_%time::=.%.jpg"
dir /b /s /a-d %1 | findstr /n "^" >"%tempFile%"

:: Count the files
for /f %%N in ('type "%tempFile%" ^| find /c /v ""') do set cnt=%%N

call :openRandomFile

:: Delete the temp file
del "%tempFile%"

exit /b

:openRandomFile
set /a "randomNum=(%random% %% cnt) + 1"
for /f "tokens=1* delims=:" %%A in (
  'findstr "^%randomNum%:" "%tempFile%"'
) do echo s | xcopy "%%B" %DESTINO%*
::exit /b