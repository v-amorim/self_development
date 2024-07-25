##--- Oh My Posh settings
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/v-amorim/self_development/main/config/oh-my-posh/themes/v-amorim.omp.json' | Invoke-Expression
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

#--- Modules
Import-Module -Name Terminal-Icons

# [PSReadLine] Configuration
if ($PSVersionTable.PSVersion.Major -ge 7) {
    $PSROptions = @{
        ContinuationPrompt = '  '
        Colors             = @{
            Command            = $PSStyle.Foreground.Yellow
            ContinuationPrompt = $PSStyle.Foreground.BrightBlack
            Error              = $PSStyle.Foreground.Red
            InLinePrediction   = $PSStyle.Foreground.BrightBlack
            Parameter          = $PSStyle.Foreground.Magenta
            Selection          = $PSStyle.Background.BrightBlue + $PSStyle.Foreground.White
            String             = $PSStyle.Foreground.BrightBlue
        }
        HistoryNoDuplicates = $True
        HistorySearchCursorMovesToEnd = $True
    }
    Set-PSReadLineOption @PSROptions
}

# Navigate through history with Ctrl+Up/Down
Set-PSReadLineKeyHandler -Key Ctrl+UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+DownArrow -Function HistorySearchForward

#--- Variables
$profilePath = ""
if ($PSVersionTable.PSEdition -eq "Core") {
    $profilePath = "$env:userprofile\Documents\Powershell"
}
elseif ($PSVersionTable.PSEdition -eq "Desktop") {
    $profilePath = "$env:userprofile\Documents\WindowsPowerShell"
}

$historyPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
$jsonFilePath = "C:\Users\Amorim\Documents\GitHub\self_development\config\powershell\FunctionInfo.json"
$jsonContent = Get-Content -Path $jsonFilePath -Raw
$jsonData = $jsonContent | ConvertFrom-Json

$CommandColor = $PSStyle.Foreground.Yellow
$ArgumentColor = $PSStyle.Foreground.BrightBlue
$ParameterColor = $PSStyle.Foreground.Magenta
$Reset = $PSStyle.Reset

#--- Helper Functions
function Remove-DuplicateHistory {
    $historyFilePath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"

    if (Test-Path $historyFilePath) {
        try {
            $historyContent = Get-Content $historyFilePath
            $seenEntries = @{}
            $uniqueHistory = [System.Collections.Generic.List[object]]::new()

            # Process lines in reverse order
            $historyContent | ForEach-Object -Begin {
                $reversedLines = [System.Collections.Generic.Stack[object]]::new()
            } -Process {
                $reversedLines.Push($_)
            } -End {
                while ($reversedLines.Count -gt 0) {
                    $entry = $reversedLines.Pop()
                    if (-not $seenEntries.ContainsKey($entry)) {
                        $seenEntries[$entry] = $true
                        $uniqueHistory.Insert(0, $entry)
                    }
                }
            }

            $uniqueHistory | Set-Content $historyFilePath
            Write-Output "Duplicates removed from history file, keeping the most recent occurrences."
        } catch {
            Write-Error "Failed to process the history file. Error details: $_"
        }
    } else {
        Write-Error "History file does not exist at path: $historyFilePath"
    }
} Remove-DuplicateHistory

Function IsAdmin {
    $currentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}


function Format-Hyperlink { # Credits https://stackoverflow.com/a/78366066/7977183
    param(
        [Parameter(ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Uri] $Uri,

        [Parameter(Mandatory=$false, Position = 1)]
        [string] $Label
    )

    if ($PSVersionTable.PSVersion.Major -lt 6 -and -not ($IsWindows -and $Env:WT_SESSION)) {
        # Fallback for Windows users not inside Windows Terminal
        if ($Label) {
        return "$Label ($Uri)"
        }
        return "$Uri"
    }

    if ($Label) {
        return "`e]8;;$Uri`e\$Label`e]8;;`e\"
    }

    return "$Uri"
}

$Credits = "$ParameterColor$(Format-Hyperlink -Uri "https://github.com/v-amorim" -Label "@v-amorim")$Reset"

function Get-FunctionNames {
    foreach ($category in $jsonData.PSObject.Properties.Name) {
        Write-Output "${ArgumentColor}${category}${Reset}"

        $commands = $jsonData.$category.PSObject.Properties.Name
        $formattedCommands = @()

        foreach ($command in $commands) {
            $formattedCommands += "[${CommandColor}${command}${Reset}]"
        }
        $commandsList = $formattedCommands -join ", "

        Write-Output "${commandsList}`n"
    }
}

function Get-FunctionDetails {
    $maxFunctionNameLength = 0
    $detailedInfo = ""

    foreach ($category in $jsonData.PSObject.Properties.Name) {
        foreach ($function in $jsonData.$category.PSObject.Properties.Name) {
            $description = $jsonData.$category.$function
            $functionName = $function
            $maxFunctionNameLength = [Math]::Max($maxFunctionNameLength, $functionName.Length)
        }
    }

    foreach ($category in $jsonData.PSObject.Properties.Name) {
        Write-Output "${ArgumentColor}${category}${Reset}"
        foreach ($function in $jsonData.$category.PSObject.Properties.Name) {
            $description = $jsonData.$category.$function
            $functionName = $function
            $paddedFunctionName = $functionName.PadLeft($maxFunctionNameLength)
            $detailedInfo = "[${CommandColor}${paddedFunctionName}${Reset}]: ${description}"
            Write-Output $detailedInfo
        }
        Write-Output ""
    }
}

#--- General Functions
function alias_help {
    param (
        [string]$Alias
    )

    foreach ($category in $jsonData.PSObject.Properties.Name) {
        if ($jsonData.$category.PSObject.Properties.Name -contains $Alias) {
            $value = $jsonData.$category.$Alias
            Write-Output "${Alias}: ${value}"
            return
        }
    }
    if ($args -eq "-list") {
        @"
${Credits}
PowerShell Profile - Help [List]
=======================
"@
        Get-FunctionNames
    } elseif ($args -eq "-detail") {
        @"
${Credits}
PowerShell Profile - Help [Detail]
=======================
"@
        Get-FunctionDetails
    } else {
        @"
${Credits}
PowerShell Profile - Help
=======================
${CommandColor}alias_help${Reset} ${ArgumentColor}command${Reset}: to get the detailed help for a command
${CommandColor}alias_help${Reset} ${ArgumentColor}-list${Reset}  : to list all available commands
${CommandColor}alias_help${Reset} ${ArgumentColor}-detail${Reset}: to get the detailed help for all commands

"@
    }
}
function alias_edit   { code $PROFILE }
function alias_update { . $PROFILE }
function cls     { Clear-Host }
function credits { Write-Output "Link to my GitHub: ${Credits}" }
function hist    { code $historyPath }
function ls      { Get-ChildItem $args }
function mkdir   { New-Item -ItemType Directory $args[0] | Set-Location }
function s       { Invoke-Item . }
function uomp    { winget upgrade JanDeDobbeleer.OhMyPosh -s winget }
function update  { winget upgrade }
function winutil { iwr -useb https://christitus.com/win | iex }
function wsls    { wsl --shutdown }
function y       { yt-dlp $args }
function ys      { yt-dlp --sponsorblock-mark all,-filler $args }


#--- Directory Navigation Functions
function ..      { Set-Location .. }
function ...     { Set-Location ..\.. }
function ....    { Set-Location ..\..\.. }
function .....   { Set-Location ..\..\..\.. }
function home    { Set-Location $env:USERPROFILE }


#--- Python Functions
function p      { python $args }
function pf     { python -m pip freeze }
function pm     { python -m $args }
function pp     { python -m pip install $args }
function ppu    { python -m pip install -U $args }

#--- Pyenv Functions
function pe     { pyenv $args }
function pev    { pyenv versions }
function pes    { pyenv shell $args }
function peu    { pyenv update }

##--- Poetry Functions
function poi    { poetry install }
function por    { poetry run $args }
function pos    { poetry shell }

##--- Pre-commit Functions
function pc     { pre-commit $* }
function pcall  { pre-commit run --all-files }
function pci    { pre-commit install }

##--- Pip-tools Functions
function ptc    { python -m piptools compile }
function pts    { python -m piptools sync }

##--- Virtual Environment Functions
function a {
    try {
        & .venv\Scripts\activate.ps1
    } catch {
        Write-Error "Failed to activate the virtual environment. Ensure the path is correct, contains a virtual env.`nError details: $_"
    }
}

function d {
    try {
        deactivate
    } catch {
        Write-Error "Failed to deactivate the virtual environment. Ensure that there is an active virtual environment."
    }
}

#--- General Multi-line Functions
function add_to_path {
    param (
        [string]$filePath
    )

    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $directory = [System.IO.Path]::GetDirectoryName($filePath)

    if ($currentPath -notlike "*$directory*") {
        $newPath = "$currentPath;$directory"
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Output "Added $directory to PATH."
    } else {
        Write-Output "$directory is already in PATH."
    }
}

Function sudo {
    param (
        [string]$command
    )

    $psVersion = $PSVersionTable.PSVersion.Major
    $shell = if ($psVersion -lt 6) { "powershell.exe" } else { "pwsh" }

    if (IsAdmin) {
        & $shell -NoExit -ExecutionPolicy Bypass -Command "$command"
    } else {
        Start-Process wt.exe -ArgumentList "new-tab $shell -NoExit -ExecutionPolicy Bypass -Command $command" -Verb RunAs
    }
}


#--- Functions adapted/retrieved from: https://github.com/ChrisTitusTech/powershell-profile
function getip { (Invoke-WebRequest http://ifconfig.me/ip).Content }
function sysinfo { Get-ComputerInfo }
function flushdns {
	Clear-DnsClientCache
	Write-Host "DNS has been flushed"
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
}
