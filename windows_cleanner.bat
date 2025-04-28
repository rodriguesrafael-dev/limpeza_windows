@echo off
title LIMPEZA E MANUTENCAO COMPLETA DO WINDOWS
color 0A

echo ==========================================
echo      INICIANDO MANUTENCAO DO SISTEMA
echo ==========================================
timeout /t 2 >nul

:: Limpando arquivos temporarios e recentes
echo [1/8] Limpando TEMP...
del /f /s /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1
md %temp%

echo [2/8] Limpando %TEMP%...
del /f /s /q "%USERPROFILE%\AppData\Local\Temp\*" >nul 2>&1

echo [3/8] Limpando PREFETCH...
del /f /s /q C:\Windows\Prefetch\*.* >nul 2>&1

echo [4/8] Limpando arquivos RECENTES...
del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1

:: Limpeza de disco
echo [5/8] Executando Limpeza de Disco...
cleanmgr /sagerun:1

:: Verificando arquivos corrompidos
echo [6/8] Executando verificacao de arquivos do sistema (SFC)...
sfc /scannow

:: DISM: integridade da imagem do sistema
echo [7/8] Verificando integridade da imagem do Windows...
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth

:: Verificacao de disco
echo [8/8] Verificando disco com CHKDSK (pode agendar para o proximo boot)...
chkdsk C: /f /r

:: Executando ferramenta de remocao de software malicioso
echo [+] Iniciando MRT (Ferramenta de Remocao de Software Malicioso)...
start mrt

echo.
echo ==========================================
echo       PROCESSO DE MANUTENCAO CONCLUIDO
echo ==========================================
pause
exit