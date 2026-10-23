@echo off
setlocal
title BOOK NEXUS
cd /d "%~dp0"

where.exe node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found. Install Node.js 24 or newer, then run this file again.
  goto :finish
)

where.exe npm.cmd >nul 2>nul
if errorlevel 1 (
  echo npm.cmd was not found. Reinstall Node.js, then run this file again.
  goto :finish
)

netstat -ano -p tcp | findstr ":3021" | findstr "LISTENING" >nul
if not errorlevel 1 (
  echo Port 3021 is already in use. If BOOK NEXUS is open, double-click BOOK-NEXUS-OPEN.url.
  echo Otherwise, close the program using port 3021 and run this file again.
  goto :finish
)

if not exist "node_modules\next\package.json" (
  echo Installing BOOK NEXUS dependencies...
  call npm.cmd ci --legacy-peer-deps
  if errorlevel 1 goto :failed
)

echo Building BOOK NEXUS from %CD%...
call npm.cmd run build
if errorlevel 1 goto :failed

echo Starting BOOK NEXUS from %CD%
echo Keep this window open. After Ready appears, double-click BOOK-NEXUS-OPEN.url.
echo Address: http://localhost:3021
call npm.cmd run start -- -p 3021
if errorlevel 1 goto :failed
echo BOOK NEXUS stopped.
goto :finish

:failed
echo.
echo BOOK NEXUS could not start. If port 3021 is in use, close the other server window and try again.
echo This window will stay open so you can read the error above.

:finish
echo.
pause
