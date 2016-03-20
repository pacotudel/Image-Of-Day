:: NASA
::Foto ----> http://apod.nasa.gov/apod/image/1510/M16HubbleV4-X3walker1024.jpg
::Foto --- > http://apod.nasa.gov/apod/image/1510/EnceladusNorth_Cassini_1024.jpg
::http://apod.nasa.gov/apod/


@echo off
@setlocal
@SET "BIN_FLD=..\..\GitHub\bin"
@SET "CURL=%BIN_FLD%\curl\curl.exe"
@SET "TR=%BIN_FLD%\unix\tr.exe"
@set "AWK=%BIN_FLD%\awk\awk.exe"
@set "GAWK=%BIN_FLD%\gawk\gawk.exe"
@set "GREP=%BIN_FLD%\grep\grep.exe"
@SET "SED=%BIN_FLD%\unix\sed.exe"
@SET "HEAD=%BIN_FLD%\unix\head.exe"
@SET LINEA=-------------------------------------------
@SET LISTA_IMAGENES=.\imagenes\images.txt
@SET LISTA_RESULTAD=.\imagenes\lista.txt

:: For random names
@SET /a NUM=%random% %%100
@SET IMAGEN=.\imagenes\bing_%NUM%_.jpg

:: For date time based names
@for /F "tokens=1-3 delims=/ " %%i IN ('date /t') DO (
@SET DT_DAY=%%i
@SET DT_MM=%%j
@SET DT_YYYY=%%k)

@for /F "tokens=1-2 delims=: " %%i IN ('time /t') DO (
@SET DT_HOUR=%%i
@SET DT_MIN=%%j)


:: El nombre es la fecha y la hora
::@set IMAGEN=.\imagenes\%DT_DAY%_%DT_MM%_%DT_YYYY%__%DT_HOUR%_%DT_MIN%_BING_PHOTO_.jpg

:: El nombre es la fecha
@SET IMAGEN=.\imagenes\%DT_YYYY%_%DT_MM%_%DT_DAY%__NASA_PHOTO_.jpg

:: Si la imagen ya se descargo hoy finalizar
@if exist %IMAGEN% goto FIN

@cls
@rem %CURL% -s http://apod.nasa.gov/apod/     :: Se baja en modo silencioso la pagina esa
@rem %GREP% jpg                               :: Busca las lineas que continenen jpg
@rem %AWK% -F "=" "{print $2}"                :: Por cada linea imprime el segundo campo, el separador de campos es el =
@rem %SED% 's/.$//'                           :: ? Creo que quita las dobles comillas
@rem %HEAD% --lines=1                         :: Muestra la primera linea del fichero
@%CURL% -s http://apod.nasa.gov/apod/astropix.html | %GREP% jpg | %AWK% -F "=" "{print $2}" | %SED% 's/.$//' | %HEAD% --lines=1 > %LISTA_IMAGENES%


@type %LISTA_IMAGENES%
@echo GET IMAGEN %LINEA%

for /F delims^=^"^ tokens^=1 %%i in (%LISTA_IMAGENES%) do (
	@echo Coger - %%i
	@echo --- img = %IMAGEN%
	rem @echo %IMAGEN% >> %LISTA_RESULTAD%
	rem @echo %%i | %AWK% -F "_" "{print $3}"
	@%CURL% -Lo %IMAGEN% http://apod.nasa.gov/apod/%%i
	goto FIN
)
@echo fin %LINEA%


:FIN