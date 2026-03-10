@echo off
echo ========================================
echo Render Deployment Fix Script
echo ========================================

echo Backing up current Dockerfile...
copy Dockerfile Dockerfile.multi 2>nul

echo Switching to simple Dockerfile for Render...
copy Dockerfile.simple Dockerfile

echo Updating .dockerignore to not exclude src...
REM Remove any line containing 'src/' from .dockerignore
powershell -Command "(Get-Content .dockerignore) -notmatch '^src/' | Set-Content .dockerignore.tmp"
move .dockerignore.tmp .dockerignore

echo.
echo ✅ Fixed! Now commit and push to GitHub:
echo.
echo git add .
echo git commit -m "Fix Docker build for Render deployment"
echo git push origin main
echo.
echo Then redeploy on Render.
echo.
pause