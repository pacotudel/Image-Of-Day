:: National Geographic
:: http://photography.nationalgeographic.com/photography/photo-of-the-day/

@echo off
@setlocal
@SET "BIN_FLD=..\..\GitHub\bin"
@SET "CURL=%BIN_FLD%\curl\curl.exe"
@SET "TR=%BIN_FLD%\unix\tr.exe"
@set "AWK=%BIN_FLD%\awk\awk.exe"
@set "GAWK=%BIN_FLD%\gawk\gawk.exe"
@set "GREP=%BIN_FLD%\grep\grep.exe"
@set "SED=%BIN_FLD%\unix\sed.exe"
@SET LINEA=-------------------------------------------
@SET LISTA_IMAGENES=.\imagenes\images.txt
@SET LISTA_RESULTAD=.\imagenes\lista.txt

:: For random names
@set /a NUM=%random% %%100
@set IMAGEN=.\imagenes\bing_%NUM%_.jpg

:: For date time based names
@for /F "tokens=1-3 delims=/ " %%i IN ('date /t') DO (
@set DT_DAY=%%i
@set DT_MM=%%j
@set DT_YYYY=%%k)

@for /F "tokens=1-2 delims=: " %%i IN ('time /t') DO (
@set DT_HOUR=%%i
@set DT_MIN=%%j)


:: El nombre es la fecha y la hora
::@set IMAGEN=.\imagenes\%DT_DAY%_%DT_MM%_%DT_YYYY%__%DT_HOUR%_%DT_MIN%_BING_PHOTO_.jpg

:: El nombre es la fecha
@set IMAGEN=.\imagenes\%DT_YYYY%_%DT_MM%_%DT_DAY%__NGEO_PHOTO_.jpg

:: Si la imagen ya se descargo hoy finalizar
@if exist %IMAGEN% goto FIN

@cls
@%CURL% -s  http://photography.nationalgeographic.com/photography/photo-of-the-day/ | %GREP% jpg | %AWK% -F "=" "{print $2}" | %GREP% media-live | %AWK% "{print $1}" | %AWK% -F "//" "{print $2}" | %GREP% 990  | %SED% 's/.$//' > %LISTA_IMAGENES%


@type %LISTA_IMAGENES%
@echo get img %LINEA%

for /F "tokens=*" %%i in (%LISTA_IMAGENES%) do (
	@echo get %%i
	@echo --- img = %IMAGEN%
	rem @echo %IMAGEN% >> %LISTA_RESULTAD%
	rem @echo %%i | %AWK% -F "_" "{print $3}"
	@%CURL% -Lo %IMAGEN% http://%%i
)
@echo fin %LINEA%


:FIN