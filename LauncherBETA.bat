@echo off
title ItsMynaX INSTALLER HELPER - BOOT LOADER
color 0B
cd /d "%~dp0"

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Admin rights...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Kiem tra file Engine
if not exist "MynaBETA.ps1" (
    echo [ERROR] Khong tim thay myna.ps1 trong thu muc hien tai!
    pause
    exit
)

cls
powershell -NoExit -ExecutionPolicy Bypass -File "%~dp0myna.ps1"