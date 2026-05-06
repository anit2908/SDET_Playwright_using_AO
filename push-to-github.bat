@echo off
echo ==========================================
echo  Git Setup and Push Script
echo ==========================================
echo.

cd /d "%~dp0"

echo Checking for Git...
git --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: Git is not installed or not in PATH.
    echo Please download and install Git from:
    echo https://git-scm.com/download/win
    echo.
    echo After installing, close this window and run this script again.
    pause
    exit /b 1
)

echo Git is installed!
echo.

if not exist ".git" (
    echo Initializing Git repository...
    git init
) else (
    echo Git repository already initialized.
)

echo.
echo Adding remote origin...
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    git remote add origin https://github.com/anit2908/SDET_Playwright_using_AO.git
    echo Remote added.
) else (
    git remote set-url origin https://github.com/anit2908/SDET_Playwright_using_AO.git
    echo Remote updated.
)

echo.
echo Staging all files...
git add .

echo.
echo Checking for changes to commit...
git diff --cached --quiet
if errorlevel 1 (
    echo Committing changes...
    git commit -m "Initial commit: Project setup"
) else (
    echo No changes to commit.
)

echo.
echo Setting branch to main...
git branch -M main

echo.
echo Pushing to GitHub...
git push -u origin main

if errorlevel 1 (
    echo.
    echo ERROR: Push failed. Common issues:
    echo - You may need to authenticate with GitHub (use Personal Access Token)
    echo - Check your internet connection
    echo - Make sure the repository exists at GitHub
    pause
    exit /b 1
)

echo.
echo ==========================================
echo  SUCCESS! Code pushed to GitHub.
echo ==========================================
pause
