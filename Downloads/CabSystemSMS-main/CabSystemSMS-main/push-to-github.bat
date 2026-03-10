@echo off
echo ========================================
echo Git Commit and Push Script
echo ========================================

echo Checking if git is available...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git is not installed or not in PATH!
    echo Please install Git from: https://git-scm.com/downloads
    echo Or use GitHub Desktop: https://desktop.github.com/
    pause
    exit /b 1
)

echo Git is available. Checking repository status...
if not exist .git (
    echo ERROR: This is not a git repository!
    echo Please initialize git first: git init
    pause
    exit /b 1
)

echo.
echo Adding all changes...
git add .

echo.
echo Committing changes...
git commit -m "Fix Docker build for Render - ultra-simple Dockerfile"

echo.
echo Pushing to GitHub...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo ✅ SUCCESS! Changes pushed to GitHub.
    echo Now redeploy on Render - it should work!
) else (
    echo.
    echo ❌ Push failed. Please check your git configuration.
    echo Make sure you have:
    echo - Remote origin set: git remote -v
    echo - Proper authentication
)

echo.
pause