#Requires -RunAsAdministrator

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Git Auto-Installer for Windows" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Git is already installed
try {
    $gitVersion = git --version 2>$null
    if ($gitVersion) {
        Write-Host "Git is already installed: $gitVersion" -ForegroundColor Green
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 0
    }
} catch {
    # Git not found, proceed with installation
}

# Git download URL (64-bit)
$gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
$installerPath = "$env:TEMP\Git-Installer.exe"

Write-Host "Downloading Git installer..." -ForegroundColor Yellow
Write-Host "This may take a few minutes depending on your internet speed." -ForegroundColor Gray
Write-Host ""

try {
    # Download the installer
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $gitUrl -OutFile $installerPath -UseBasicParsing
    
    Write-Host "Download complete!" -ForegroundColor Green
    Write-Host "Installing Git silently..." -ForegroundColor Yellow
    Write-Host ""
    
    # Install silently with default options
    Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/CLOSEAPPLICATIONS", "/RESTARTAPPLICATIONS" -Wait
    
    # Clean up installer
    Remove-Item $installerPath -Force -ErrorAction SilentlyContinue
    
    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host "  Git installed successfully!" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host ""
    
    # Verify installation
    try {
        $newVersion = & "C:\Program Files\Git\bin\git.exe" --version 2>$null
        Write-Host "Installed version: $newVersion" -ForegroundColor Green
    } catch {
        # Ignore verification error
    }
    
    Write-Host ""
    Write-Host "IMPORTANT: Close this window and open a NEW Command Prompt" -ForegroundColor Magenta
    Write-Host "before running push-to-github.bat" -ForegroundColor Magenta
    Write-Host ""
    Read-Host "Press Enter to exit"
    
} catch {
    Write-Host "ERROR: Failed to install Git." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install manually from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
}
