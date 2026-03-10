@echo off
echo ========================================
echo Cab System SMS - Docker Build Script
echo ========================================

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed or not running!
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo Docker is installed. Checking Docker Compose...
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker Compose is not available!
    pause
    exit /b 1
)

echo.
echo Choose an option:
echo 1. Build and run (foreground)
echo 2. Build and run (background)
echo 3. Stop application
echo 4. View logs
echo 5. Clean up
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto build_run
if "%choice%"=="2" goto build_run_bg
if "%choice%"=="3" goto stop
if "%choice%"=="4" goto logs
if "%choice%"=="5" goto cleanup
goto invalid

:build_run
echo.
echo Building and running application in foreground...
docker-compose up --build
goto end

:build_run_bg
echo.
echo Building and running application in background...
docker-compose up -d --build
echo.
echo Application started! Check http://localhost:8080
echo Use 'docker-compose logs -f' to view logs
goto end

:stop
echo.
echo Stopping application...
docker-compose down
echo Application stopped.
goto end

:logs
echo.
echo Showing application logs...
docker-compose logs -f
goto end

:cleanup
echo.
echo Cleaning up Docker resources...
docker-compose down
docker system prune -f
docker image rm cab-system-sms 2>nul
echo Cleanup completed.
goto end

:invalid
echo Invalid choice. Please run the script again.
:end
echo.
pause