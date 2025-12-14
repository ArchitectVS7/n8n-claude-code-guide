@echo off
echo ========================================
echo   Claude Code Orchestration System
echo ========================================
echo.
echo Starting services in WSL...
echo.

wsl -d Ubuntu bash -c "~/start-orchestration.sh"

echo.
echo ========================================
echo   System Ready!
echo ========================================
echo.
echo n8n Dashboard: http://localhost:5678
echo ngrok Status:  http://localhost:4040
echo.
echo Press any key to open n8n in browser...
pause >nul
start http://localhost:5678
