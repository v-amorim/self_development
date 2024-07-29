# Adapted from: https://github.com/ChrisTitusTech/powershell-profile

function IsAdmin {
    $currentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function EnsureAdmin {
    Write-Host "[IsAdmin] " -NoNewline
    Write-Host "Checking if PowerShell has Administrator privileges..." -NoNewline -ForegroundColor Cyan
    if (-not (IsAdmin)) {
        Write-Warning "[IsAdmin] Please run this script as an Administrator!"
        exit
    }
    Write-Host "Administrator privileges confirmed" -ForegroundColor Green
}

function Test-InternetConnection {
    Write-Host "[Test-InternetConnection] " -NoNewline
    Write-Host "Checking for internet connectivity..." -NoNewline -ForegroundColor Cyan
    try {
        $testConnection = Test-Connection -ComputerName www.google.com -Count 1 -ErrorAction Stop
        Write-Host "Connected" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Warning "[Test-InternetConnection] Internet connection is required but not available. Please check your connection."
        return $false
    }
}

function EnsureInternet {
    if (-not (Test-InternetConnection)) {
        exit
    }
}

# Function to download a file and report status
function Download-File {
    param (
        [string]$url_file,
        [string]$outputPath,
        [string]$successMessage
    )

    Invoke-RestMethod "https://raw.githubusercontent.com/v-amorim/self_development/main/config/powershell/${url_file}" -OutFile $outputPath
    Write-Host "[InstallUpdate Profile] " -NoNewline
    Write-Host $successMessage -ForegroundColor Green
}

# Function to check and update PowerShell profile
function InstallOrUpdateProfile {
    Write-Host "[InstallUpdate Profile] " -NoNewline
    Write-Host "Checking for PowerShell Profile..." -NoNewline -ForegroundColor Cyan

    $profilePath = ""
    if ($PSVersionTable.PSEdition -eq "Core") {
        $profilePath = "$env:userprofile\Documents\Powershell"
    } elseif ($PSVersionTable.PSEdition -eq "Desktop") {
        $profilePath = "$env:userprofile\Documents\WindowsPowerShell"
    }

    $functionInfoPath = "$profilePath\FunctionInfo.json"

    try {
        if (-not (Test-Path -Path $PROFILE -PathType Leaf)) {
            Write-Host "No active profile exists, installing..." -ForegroundColor Yellow

            if (-not (Test-Path -Path $profilePath)) {
                New-Item -Path $profilePath -ItemType "directory"
            }

            # Install new profile and function info
            Download-File "Profile.ps1" $PROFILE "The profile @ [$PROFILE] has been created."
            Download-File "FunctionInfo.json" $functionInfoPath "FunctionInfo.json dependency has been created."
        }
        else {
            Write-Host "Active profile exists, updating..." -ForegroundColor Yellow

            # Backup existing profile and function info
            $oldProfilePath = "$env:userprofile\Documents\OldProfile.ps1"
            $oldFunctionInfoPath = "$env:userprofile\Documents\OldFunctionInfo.json"

            if ((Test-Path -Path $PROFILE) -and (Test-Path -Path $functionInfoPath)) {
                Move-Item -Path $PROFILE -Destination $oldProfilePath -Force
                Move-Item -Path $functionInfoPath -Destination $oldFunctionInfoPath -Force
                Write-Host "[InstallUpdate Profile] " -NoNewline
                Write-Host "Old profile files backed up to [$env:userprofile\Documents]." -ForegroundColor Green
            }

            # Update profile and function info
            Download-File "Profile.ps1" $PROFILE "The profile @ [$PROFILE] has been updated."
            Download-File "FunctionInfo.json" $functionInfoPath "FunctionInfo.json dependency has been updated."
        }
    }
    catch {
        Write-Host "[InstallUpdate Profile] " -NoNewline
        Write-Error "Failed to create or update the profile. Error: $_"
    }
}

# Function to install Oh My Posh
function Install-OhMyPosh {
    Write-Host "[Install Oh My Posh] " -NoNewline
    Write-Host "Checking if Oh My Posh is installed..." -NoNewline -ForegroundColor Cyan
    if (-not (winget list --id "JanDeDobbeleer.OhMyPosh" -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Oh My Posh..." -NoNewline -ForegroundColor Yellow
        try {
            winget install --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
            Write-Host "Done" -ForegroundColor Green
        }
        catch {
            Write-Host "[Install Oh My Posh] " -NoNewline
            Write-Error "Failed to install Oh My Posh. Error: $_"
        }
    } else {
        Write-Host "Oh My Posh is already installed. Skipping installation." -ForegroundColor Yellow
    }
}

# Function to install Nerd Fonts
function Install-NerdFonts {
    param (
        [string]$FontName = "FiraCode",
        [string]$FontDisplayName = "FiraCode Nerd Font Mono"
    )

    Write-Host "[Install-NerdFonts] " -NoNewline
    Write-Host "Installing ${FontDisplayName} NerdFont..." -NoNewline -ForegroundColor Cyan
    try {
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        if ($fontFamilies -notcontains "${FontDisplayName}") {
            $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FontName}.zip"
            $zipFilePath = "$env:TEMP\${FontName}.zip"
            $extractPath = "$env:TEMP\${FontName}"

            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFileAsync((New-Object System.Uri($fontZipUrl)), $zipFilePath)

            while ($webClient.IsBusy) {
                Start-Sleep -Seconds 2
            }

            Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
            $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
            Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
                If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                    $destination.CopyHere($_.FullName, 0x10)
                }
            }

            Remove-Item -Path $extractPath -Recurse -Force
            Remove-Item -Path $zipFilePath -Force
            Write-Host "Done" -ForegroundColor Green
        } else {
            Write-Host "Font ${FontDisplayName} already installed" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "[Install-NerdFonts] " -NoNewline
        Write-Error "Failed to download or install ${FontDisplayName} font. Error: $_"
    }
}

# Function to install Chocolatey
function Install-Chocolatey {
    Write-Host "[Install Chocolatey] " -NoNewline
    Write-Host "Checking if Chocolatey is installed..." -NoNewline -ForegroundColor Cyan
    if (-not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..." -NoNewline -ForegroundColor Yellow
        try {
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            Write-Host "Done" -ForegroundColor Green
        }
        catch {
            Write-Host "[Install Chocolatey] " -NoNewline
            Write-Error " Failed to install Chocolatey. Error: $_"
        }
    } else {
        Write-Host "Chocolatey is already installed. Skipping installation." -ForegroundColor Yellow
    }
}

# Function to install Terminal Icons module
function Install-TerminalIcons {
    Write-Host "[Install Terminal-Icons] " -NoNewline
    Write-Host "Installing Terminal-Icons..." -NoNewline -ForegroundColor Cyan
    try {
        Install-Module -Name Terminal-Icons -Repository PSGallery -Force
        Write-Host "Done" -ForegroundColor Green
    }
    catch {
        Write-Host "[Install Terminal-Icons] " -NoNewline
        Write-Error "Failed to install Terminal Icons module. Error: $_"
    }
}

# Function to install PSReadLine module
function Install-PSReadLine {
    Write-Host "[Install PSReadLine] " -NoNewline
    Write-Host "Checking if PSReadLine is installed..." -NoNewline -ForegroundColor Cyan
    if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
        Write-Host "Installing PSReadLine..." -NoNewline -ForegroundColor Yellow
        try {
            Install-Module PSReadLine -Force
            Write-Host "Done" -ForegroundColor Green
        }
        catch {
            Write-Host "[Install PSReadLine] " -NoNewline
            Write-Error "Failed to install PSReadLine. Error: $_"
        }
    } else {
        Write-Host "PSReadLine is already installed. Skipping installation." -ForegroundColor Yellow
    }
}

function Get-Fonts { # https://wenijinew.medium.com/use-powershell-to-print-installed-font-family-names-5a6348745372
    param (
        $regex
    )
    $AllFonts = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
    if ($null -ne $regex) {
        $FilteredFonts = $($AllFonts | Select-String -Pattern ".*${regex}.*")
        return $FilteredFonts
    }
    return $AllFonts
}

# Function to check and report final status
function Final-Check {
    Write-Host "[Profile Setup] " -NoNewline
    Write-Host "Final check..." -NoNewline -ForegroundColor Cyan
    if ((Test-Path -Path $PROFILE) -and (winget list --id "OhMyPosh") -and (Get-Fonts -regex "FiraCode Nerd Font Mono")) {
        Write-Host "completed successfully. Please restart your PowerShell session to apply changes." -ForegroundColor Green
    } else {
        Write-Warning "completed with errors. Please check the error messages above."
    }
}

# Main function to run all tasks
function Main {
    EnsureAdmin
    EnsureInternet

    InstallOrUpdateProfile
    Install-OhMyPosh
    Install-NerdFonts -FontName "FiraCode" -FontDisplayName "FiraCode Nerd Font Mono"
    Install-Chocolatey
    Install-TerminalIcons
    Install-PSReadLine
    Final-Check
    . $PROFILE # Reload the profile
}

# Run the main function
Main
