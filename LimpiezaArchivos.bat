@echo off

echo Limpiando la carpeta Temp...
echo.

REM Verificar si se tienen privilegios de administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo No se tienen privilegios de administrador.
    echo.
    echo Ejecutando con privilegios de administrador...
    echo.
    pause
    goto UACPrompt
)

REM Eliminar archivos y subcarpetas en C:\Windows\Temp
rd /s /q "C:\Windows\Temp"
REM Eliminar los archivos contenidos en la carpeta  : %TEMP%
rd /s /q "%TEMP%\*.*"
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x"

echo.
echo Eliminación completada.
pause
goto :EOF

:UACPrompt
    echo Set UAC = CreateObject("Shell.Application") > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
