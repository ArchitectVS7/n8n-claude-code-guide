@echo off
echo ========================================
echo   Stopping Orchestration System
echo ========================================
echo.

cd /d C:\dev\GIT\automaton
docker-compose down

echo.
echo System stopped successfully.
echo.
pause
