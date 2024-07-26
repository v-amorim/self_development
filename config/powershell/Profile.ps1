##--- Oh My Posh settings
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/v-amorim/self_development/main/config/oh-my-posh/themes/v-amorim.omp.json' | Invoke-Expression
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1


#--- Modules
Import-Module -Name Terminal-Icons


#--- Variables
$historyPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
$jsonFilePath = "C:\Users\Amorim\Documents\GitHub\self_development\config\powershell\FunctionInfo.json"
$jsonContent = Get-Content -Path $jsonFilePath -Raw
$jsonData = $jsonContent | ConvertFrom-Json
$Reset = $PSStyle.Reset

$escapeChar = ""
if ($PSVersionTable.PSEdition -eq "Core") {
    $escapeChar = "`e"
} elseif ($PSVersionTable.PSEdition -eq "Desktop") {
    $escapeChar = "$([char]0x1b)"
}

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
            Write-Host "Duplicates removed from history file, keeping the most recent occurrences."
        } catch {
            Write-Error "Failed to process the history file. Error details: $_"
        }
    } else {
        Write-Error "History file does not exist at path: $historyFilePath"
    }
} Remove-DuplicateHistory

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
        return "$escapeChar]8;;$Uri$escapeChar\$Label$escapeChar]8;;$escapeChar\"
    }

    return "$Uri"
}

function Convert-HexToRgb {
    param (
        [string]$HexColor
    )
    # Remove the '#' character if present
    $HexColor = $HexColor.TrimStart('#')

    # Extract RGB values from the hex color
    $r = [convert]::ToInt32($HexColor.Substring(0, 2), 16)
    $g = [convert]::ToInt32($HexColor.Substring(2, 2), 16)
    $b = [convert]::ToInt32($HexColor.Substring(4, 2), 16)

    return @($r, $g, $b)
}

function Convert-HexToAnsiColor {
    param (
        [string]$ForegroundHexColor = '',
        [string]$BackgroundHexColor = '',
        [string[]]$Modifiers = @(),
        [switch]$Display
    )

    $FgCode = ''
    $BgCode = ''
    $ModifierCode = ''
    $RawCombinedCode = ''

    # Modifier codes
    $modifierMapping = @{
        "bold"         = 1
        "dim"          = 2
        "italic"       = 3
        "underline"    = 4
        "blinking"     = 5
        "inverse"      = 7
        "invisible"    = 8
        "strikethrough" = 9
    }

    if ($Modifiers) {
        $ModifierCode = ($Modifiers | ForEach-Object { $modifierMapping[$_] }) -join ';'
    }

    if ($ForegroundHexColor) {
        $Rgb = Convert-HexToRgb -HexColor $ForegroundHexColor
        $FgTemplate = "[38;2;$($Rgb[0]);$($Rgb[1]);$($Rgb[2])"
        $FgCode = "$escapeChar" + $FgTemplate
        $RawCombinedCode = "``e" + $FgTemplate

        if ($ModifierCode) {
            $FgCode += ";$ModifierCode"
            $RawCombinedCode += ";$ModifierCode"
        }
        $FgCode += "m"
        $RawCombinedCode += "m"
    }

    if ($BackgroundHexColor) {
        $Rgb = Convert-HexToRgb -HexColor $BackgroundHexColor
        $BgTemplate = "[48;2;$($Rgb[0]);$($Rgb[1]);$($Rgb[2])m"
        $BgCode = "$escapeChar" + $BgTemplate
        $RawCombinedCode += "``e" + $BgTemplate
    }

    $CombinedCode = "$BgCode$FgCode"

    if ($Display) {
        Write-Host "Foreground: ${FgCode}${ForegroundHexColor}${Reset}"
        Write-Host "Background: ${BgCode}${BackgroundHexColor}${Reset}"
        Write-Host "Modifiers : ${Modifiers}"
        Write-Host "Ansi Code : ${RawCombinedCode}"
        Write-Host "Combined  : ${CombinedCode}Sample Text with effects${Reset}"
    } else {
        return $CombinedCode
    }
}

$CommandColor = Convert-HexToAnsiColor -ForegroundHexColor "#FDB1A2"
$ArgumentColor = Convert-HexToAnsiColor -ForegroundHexColor "#B58EE8"
$CreditsColor = Convert-HexToAnsiColor -ForegroundHexColor "#FF72B0" -Modifiers @("bold", "blinking")
$Credits = "$CreditsColor$(Format-Hyperlink -Uri "https://github.com/v-amorim" -Label ([char]0xf09b))$Reset"

function HexToAnsiColor-Example {
    $ExampleFgHex           = "#B58EE8"
    $ExampleFgCode          = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex
    $ExampleBgHex           = "#4C4C4C"
    $ExampleBgCode          = Convert-HexToAnsiColor -BackgroundHexColor $ExampleBgHex
    $ExampleModifiers       = @("italic", "blinking")
    $ExampleCombinedCode    = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -BackgroundHexColor $ExampleBgHex -Modifiers $ExampleModifiers
    $ExampleRawCombinedCode = "``e[38;2;181;142;232;3;5m``e[48;2;76;76;76m"

    $Bold                   = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("bold")
    $Dim                    = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("dim")
    $Italic                 = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("italic")
    $Underline              = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("underline")
    $Blinking               = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("blinking")
    $Inverse                = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("inverse")
    $Invisible              = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("invisible")
    $Strikethrough          = Convert-HexToAnsiColor -ForegroundHexColor $ExampleFgHex -Modifiers @("strikethrough")

    $Command                = Convert-HexToAnsiColor -ForegroundHexColor "#FDB1A2"
    $Parameter              = Convert-HexToAnsiColor -ForegroundHexColor "#B58EE8"
    $String                 = Convert-HexToAnsiColor -ForegroundHexColor "#A5CFFF"
    $Keyword                = Convert-HexToAnsiColor -ForegroundHexColor "#F97583" -Modifiers @("bold")


    @"
=======================
${Credits} Convert-HexToAnsiColor [Example]
=======================

${Command}Convert-HexToAnsiColor${Reset} ${Parameter}-ForegroundHexColor${Reset} ${String}"#B58EE8"${Reset} ${Parameter}-BackgroundHexColor${Reset} ${String}"#4C4C4C"${Reset} ${Parameter}-Modifiers${Reset} @(${String}"italic"${Reset}${Keyword},${Reset} ${String}"blinking"${Reset})

=======================
Foreground: ${ExampleFgCode}${ExampleFgHex}${Reset}
Background: ${ExampleBgCode}${ExampleBgHex}${Reset}
Modifiers : ${ExampleModifiers}
Ansi Code : ${ExampleRawCombinedCode}
Combined  : ${ExampleCombinedCode}Sample Text with effects${Reset}

=======================
Available modifiers: ${Bold}bold${Reset}, ${Dim}dim${Reset}, ${Italic}italic${Reset}, ${Underline}underline${Reset}, ${Blinking}blinking${Reset}, ${Inverse}inverse${Reset}, ${Invisible}invisible${Reset}(invisible), ${Strikethrough}strikethrough${Reset}
"@
}

function Handle-CtrlRightArrow {
    $hasPrediction = [Microsoft.PowerShell.PSConsoleReadLine]::GetPrediction -ne $null

    if ($hasPrediction) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord()
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::ForwardWord()
    }
}

Function IsAdmin {
    $currentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Get-FunctionNames {
    foreach ($category in $jsonData.PSObject.Properties.Name) {
        Write-Host "${ArgumentColor}${category}${Reset}"

        $commands = $jsonData.$category.PSObject.Properties.Name
        $formattedCommands = @()

        foreach ($command in $commands) {
            $formattedCommands += "[${CommandColor}${command}${Reset}]"
        }
        $commandsList = $formattedCommands -join ", "

        Write-Host "${commandsList}`n"
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
        Write-Host "${ArgumentColor}${category}${Reset}"
        foreach ($function in $jsonData.$category.PSObject.Properties.Name) {
            $description = $jsonData.$category.$function
            $functionName = $function
            $paddedFunctionName = $functionName.PadLeft($maxFunctionNameLength)
            $detailedInfo = "[${CommandColor}${paddedFunctionName}${Reset}]: ${description}"
            Write-Host $detailedInfo
        }
        Write-Host ""
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
            Write-Host "${Alias}: ${value}"
            return
        }
    }
    if ($args -eq "-list") {
        @"
=======================
${Credits} PowerShell Profile - Help [List]
=======================

"@
        Get-FunctionNames
    } elseif ($args -eq "-detail") {
        @"
=======================
${Credits} PowerShell Profile - Help [Detail]
=======================

"@
        Get-FunctionDetails
    } else {
        @"
=======================
${Credits} PowerShell Profile - Help
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
function credits { Write-Host "Link to my GitHub: ${Credits}" }
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
function pv     { python -V }

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
        Write-Host "Added $directory to PATH."
    } else {
        Write-Host "$directory is already in PATH."
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


#--- [PSReadLine] Configuration
if ($PSVersionTable.PSVersion.Major -ge 7) {
    $PSROptions = @{
        ContinuationPrompt = '  '
        Colors             = @{
            Command                = Convert-HexToAnsiColor -ForegroundHexColor "#FDB1A2"
            Comment                = Convert-HexToAnsiColor -ForegroundHexColor "#8B949E"
            ContinuationPrompt     = Convert-HexToAnsiColor -ForegroundHexColor "#4C4C4C"
            Default                = Convert-HexToAnsiColor -ForegroundHexColor "#F8EAF8"
            Emphasis               = Convert-HexToAnsiColor -ForegroundHexColor "#89DDFF"
            Error                  = Convert-HexToAnsiColor -ForegroundHexColor "#E83974"
            InLinePrediction       = Convert-HexToAnsiColor -ForegroundHexColor "#4C4C4C"
            Keyword                = Convert-HexToAnsiColor -ForegroundHexColor "#F97583" -Modifiers @("bold")
            ListPrediction         = Convert-HexToAnsiColor -ForegroundHexColor "#FFCB6B"
            ListPredictionSelected = Convert-HexToAnsiColor -ForegroundHexColor "#B58EE8" -BackgroundHexColor "#4C4C4C"
            ListPredictionTooltip  = Convert-HexToAnsiColor -ForegroundHexColor "#7F7F7F"
            Member                 = Convert-HexToAnsiColor -ForegroundHexColor "#F69BDC"
            Number                 = Convert-HexToAnsiColor -ForegroundHexColor "#79B8FF"
            Operator               = Convert-HexToAnsiColor -ForegroundHexColor "#F97583" -Modifiers @("bold")
            Parameter              = Convert-HexToAnsiColor -ForegroundHexColor "#B58EE8"
            Selection              = Convert-HexToAnsiColor -ForegroundHexColor "#B58EE8" -BackgroundHexColor "#4C4C4C"
            String                 = Convert-HexToAnsiColor -ForegroundHexColor "#A5CFFF"
            Type                   = Convert-HexToAnsiColor -ForegroundHexColor "#79C0FF"
            Variable               = Convert-HexToAnsiColor -ForegroundHexColor "#FF72B0"
        }
        HistoryNoDuplicates = $True
        HistorySearchCursorMovesToEnd = $False
        PredictionSource = "HistoryAndPlugin"
    }
    Set-PSReadLineOption @PSROptions
} else {
    $PSROptions = @{
        ContinuationPrompt = '  '
        Colors             = @{
            Command                = "$escapeChar[38;5;217m"
            Comment                = "$escapeChar[38;5;246m"
            ContinuationPrompt     = "$escapeChar[38;5;239m"
            Default                = "$escapeChar[38;5;255m"
            Emphasis               = "$escapeChar[38;5;153m"
            Error                  = "$escapeChar[38;5;204m"
            InLinePrediction       = "$escapeChar[38;5;239m"
            Keyword                = "$escapeChar[38;5;211m"
            ListPrediction         = "$escapeChar[38;5;222m"
            ListPredictionSelected = "$escapeChar[38;5;183m$escapeChar[48;5;239m"
            ListPredictionTooltip  = "$escapeChar[38;5;8m"
            Member                 = "$escapeChar[38;5;218m"
            Number                 = "$escapeChar[38;5;117m"
            Operator               = "$escapeChar[38;5;211m"
            Parameter              = "$escapeChar[38;5;183m"
            Selection              = "$escapeChar[38;5;183m$escapeChar[48;5;239m"
            String                 = "$escapeChar[38;5;153m"
            Type                   = "$escapeChar[38;5;117m"
            Variable               = "$escapeChar[38;5;211m"
        }
        HistoryNoDuplicates = $True
        HistorySearchCursorMovesToEnd = $False
        PredictionSource = "History"
    }
    Set-PSReadLineOption @PSROptions
}

# Navigate through history with Ctrl+Up/Down
Set-PSReadLineKeyHandler -Key Ctrl+UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+DownArrow -Function HistorySearchForward

# Bind the custom function to the Ctrl+RightArrow key chord
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -ScriptBlock ${function:Handle-CtrlRightArrow}

#--- Enter this string to test the colors
#if (1+1) CommandColor -ParameterColor "StringColor $($VariableColor.MemberColor())" {[TypeColor]} # CommentColor
