#--- Variables
$escapeChar = "$([char]0x1b)"
$historyPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
$isLatestPowershell = $PSVersionTable.PSVersion.Major -ge 7
$resetStyle = $PSStyle.Reset

##--- JSON File Variables
$profilePath = Split-Path -Path $PROFILE
$jsonFilePath = "$profilePath\FunctionInfo.json"
$jsonContent = Get-Content -Path $jsonFilePath -Raw
$jsonData = $jsonContent | ConvertFrom-Json
$markerFilePath = "$env:APPDATA\Microsoft\Windows\PowerShell\Remove-DuplicateHistory.marker"

##--- Oh-My-Posh Variables
$poshDefaultThemeUrl = "https://raw.githubusercontent.com/v-amorim/self_development/main/config/oh-my-posh/themes/v-amorim.omp.json"
$poshThemesPath = "$env:userprofile\Documents\oh-my-posh\themes"
$poshCurrentThemeUrlFilePath = "$poshThemesPath\.CurrentThemeUrl.txt"
$poshPreviousThemeUrlFilePath = "$poshThemesPath\.PreviousThemeUrl.txt"


#--- Private Functions
function Save-ThemeUrl {
    param (
        [string]$url
    )
    $url = $url.Trim()
    Set-Content -Path $poshCurrentThemeUrlFilePath -Value $url -Force
}

function Save-PreviousThemeUrl {
    param (
        [string]$url
    )
    $url = $url.Trim()
    Set-Content -Path $poshPreviousThemeUrlFilePath -Value $url -Force
}

function Validate-Url {
    param (
        [string]$url
    )
    try {
        $response = Invoke-WebRequest -Uri $url -Method Head -ErrorAction Stop
        return $response.StatusCode -eq 200
    } catch {
        return $false
    }
}

function Load-UrlFromFile {
    param (
        [string]$filePath
    )
    if (Test-Path $filePath) {
        $urlContent = Get-Content -Path $filePath -Raw
        if (-not [string]::IsNullOrWhiteSpace($urlContent)) {
            $url = $urlContent.Trim()
            if ($url -match "^https://raw.githubusercontent.com/.*\.omp\.json$") {
                return $url
            }
        }
    }
    return $null
}

function Load-ThemeUrl {
    $currentUrl = Load-UrlFromFile -filePath $poshCurrentThemeUrlFilePath
    if ($currentUrl -and (Validate-Url -url $currentUrl)) {
        return $currentUrl
    }

    $previousUrl = Load-UrlFromFile -filePath $poshPreviousThemeUrlFilePath
    if ($previousUrl -and (Validate-Url -url $previousUrl)) {
        Save-ThemeUrl -url $previousUrl
        return $previousUrl
    }

    Save-ThemeUrl -url $poshDefaultThemeUrl
    Save-PreviousThemeUrl -url $poshDefaultThemeUrl
    return $poshDefaultThemeUrl
}

function Update-OhMyPoshTheme {
    param (
        [string]$ohMyPoshGitPath
    )

    if (-not (Test-Path $poshThemesPath)) {
        New-Item -Path $poshThemesPath -ItemType Directory -Force
    }

    $tempDir = [System.IO.Path]::GetTempPath()
    $themeName = [regex]::Match($ohMyPoshGitPath, "/([^/]+)\.omp\.json$").Groups[1].Value

    $currentPoshThemePath = "$poshThemesPath\$themeName.omp.json"
    $tempDownloadPath = "$tempDir\$themeName-temp.omp.json"
    $backupPath = "$poshThemesPath\$themeName-$(Get-Date -Format 'yyyyMMddHHmmss').omp.json"

    $isThemeUpdateNeeded = -not (Test-Path $currentPoshThemePath) -or (New-TimeSpan -Start (Get-Item $currentPoshThemePath).LastWriteTime).TotalHours -ge 1

    if ($isThemeUpdateNeeded) {
        try {
            Invoke-WebRequest -Uri $ohMyPoshGitPath -OutFile $tempDownloadPath -ErrorAction Stop
        } catch {
            $ohMyPoshGitPath = Load-UrlFromFile -filePath $poshPreviousThemeUrlFilePath
            if ($ohMyPoshGitPath) {
                Invoke-WebRequest -Uri $ohMyPoshGitPath -OutFile $tempDownloadPath -ErrorAction Stop
            }
        }

        $fileExists = Test-Path $currentPoshThemePath

        if ($fileExists) {
            $currentHash = (Get-FileHash -Path $currentPoshThemePath).Hash
            $newHash = (Get-FileHash -Path $tempDownloadPath).Hash
            $isThemeUpdateNeeded = $currentHash -ne $newHash
        }

        if ($isThemeUpdateNeeded) {
            if ($fileExists) {
                Rename-Item -Path $currentPoshThemePath -NewName $backupPath
            }
            Copy-Item -Path $tempDownloadPath -Destination $currentPoshThemePath -Force
        }
        Remove-Item -Path $tempDownloadPath -Force
    }
    return $currentPoshThemePath
}

function Remove-DuplicateHistory {
    # Check if marker file exists and if it was last modified more than 5 minutes ago
    $shouldProcess = -not (Test-Path $markerFilePath) -or (New-TimeSpan -Start (Get-Item $markerFilePath).LastWriteTime).TotalMinutes -ge 5

    if ($shouldProcess) {
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

                # Create or update marker file
                New-Item -Path $markerFilePath -ItemType File -Force | Out-Null
                (Get-Item $markerFilePath).LastWriteTime = Get-Date
            } catch {
                Write-Error "Failed to process the history file. Error details: $_"
            }
        } else {
            Write-Error "History file does not exist at path: $historyFilePath"
        }
    }
} Remove-DuplicateHistory

Function IsAdmin {
    $currentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Handle-CtrlRightArrow {
    $hasPrediction = [Microsoft.PowerShell.PSConsoleReadLine]::GetPrediction -ne $null

    if ($hasPrediction) {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord()
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::ForwardWord()
    }
}

function Format-Hyperlink { # Credits: https://stackoverflow.com/a/78366066/7977183
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
        [switch]$Display,
        [string]$DisplayText
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
        Write-Host "Foreground: ${FgCode}${ForegroundHexColor}${resetStyle}"
        Write-Host "Background: ${BgCode}${BackgroundHexColor}${resetStyle}"
        Write-Host "Modifiers : ${Modifiers}"
        Write-Host "Ansi Code : ${RawCombinedCode}"
        Write-Host "Combined  : ${CombinedCode}Sample Text with effects${resetStyle}"
    } elseif ($DisplayText){
        Return "${CombinedCode}${DisplayText}${resetStyle}"
    }
    else {
        return $CombinedCode
    }
} Set-Alias -Name HexToAnsi -Value Convert-HexToAnsiColor

##--- Color Palette
function CCommand                { HexToAnsi "#FDB1A2" "" ("") $args }
function CComment                { HexToAnsi "#8B949E" "" ("") $args }
function CContinuationPrompt     { HexToAnsi "#4C4C4C" "" ("") $args }
function CDefault                { HexToAnsi "#F8EAF8" "" ("") $args }
function CEmphasis               { HexToAnsi "#89DDFF" "" ("") $args }
function CError                  { HexToAnsi "#E83974" "" ("") $args }
function CInLinePrediction       { HexToAnsi "#4C4C4C" "" ("") $args }
function CKeyword                { HexToAnsi "#F97583" "" ("bold") $args }
function CListPrediction         { HexToAnsi "#FFCB6B" "" ("") $args }
function CListPredictionSelected { HexToAnsi "#B58EE8" "#4C4C4C" $args }
function CListPredictionTooltip  { HexToAnsi "#7F7F7F" "" ("") $args }
function CMember                 { HexToAnsi "#F69BDC" "" ("") $args }
function CNumber                 { HexToAnsi "#79B8FF" "" ("") $args }
function COperator               { HexToAnsi "#F97583" "" ("bold") $args }
function CParameter              { HexToAnsi "#B58EE8" "" ("") $args }
function CSelection              { HexToAnsi "#B58EE8" "#4C4C4C" ("") $args }
function CString                 { HexToAnsi "#A5CFFF" "" ("") $args }
function CType                   { HexToAnsi "#79C0FF" "" ("") $args }
function CVariable               { HexToAnsi "#FF72B0" "" ("") $args }

function CCredits                { HexToAnsi "#FF72B0" "" ("bold", "blinking") $args }
$Credits = CCredits $(Format-Hyperlink -Uri "https://github.com/v-amorim" -Label ([char]0xf09b)) # \uf09b is the GitHub icon


#--- Public Function
function Initialize-OhMyPosh {
    param (
        [string]$PoshThemeUrl = (Load-ThemeUrl)
    )

    $currentUrl = Load-ThemeUrl
    if ($currentUrl -ne $PoshThemeUrl) {
        Save-ThemeUrl -url $PoshThemeUrl
        Save-PreviousThemeUrl -url $currentUrl
    }

    $PoshThemePath = Update-OhMyPoshTheme -ohMyPoshGitPath $PoshThemeUrl
    oh-my-posh init pwsh --config "$PoshThemePath" | Invoke-Expression
    $env:VIRTUAL_ENV_DISABLE_PROMPT = 1
}

Initialize-OhMyPosh


##--- Example Functions
function HexToAnsiExample {
    function ExampleFg   { HexToAnsi $ExampleFgHex "" ("") $args }
    function ExampleBg   { HexToAnsi "" $ExampleBgHex $args }
    $ExampleModifiers       = @("italic", "blinking")
    $ExampleCombinedCode    = HexToAnsi $ExampleFgHex $ExampleBgHex $ExampleModifiers
    $ExampleRawCombinedCode = "``e[38;2;181;142;232;3;5m``e[48;2;76;76;76m"

    function CBold          { HexToAnsi $ExampleFgHex "" ("bold") $args }
    function CDim           { HexToAnsi $ExampleFgHex "" ("dim") $args }
    function CItalic        { HexToAnsi $ExampleFgHex "" ("italic") $args }
    function CUnderline     { HexToAnsi $ExampleFgHex "" ("underline") $args }
    function CBlinking      { HexToAnsi $ExampleFgHex "" ("blinking") $args }
    function CInverse       { HexToAnsi $ExampleFgHex "" ("inverse") $args }
    function CInvisible     { HexToAnsi $ExampleFgHex "" ("invisible") $args }
    function CStrikethrough { HexToAnsi $ExampleFgHex "" ("strikethrough") $args }

    @"
======================================
${Credits} Convert-HexToAnsiColor [Example]
======================================

$(CCommand 'Convert-HexToAnsiColor') $(CParameter '-ForegroundHexColor') $(CString '"#B58EE8"') $(CParameter '-BackgroundHexColor') $(CString '"#4C4C4C"') $(CParameter '-Modifiers') ($(CString '"italic"') $(CKeyword ',') $(CString '"blinking"'))
$(CCommand 'Convert-HexToAnsiColor') $(CString '"#B58EE8"') $(CString '"#4C4C4C"') ($(CString '"italic"') $(CKeyword ',') $(CString '"blinking"'))

======================================
Foreground : $(ExampleFg '#B58EE8')
Background : $(ExampleBg '#4C4C4C')
Modifiers  : ("italic", "blinking")
Ansi Code  : ${ExampleRawCombinedCode} "``e[38;2;181;142;232;3;5m``e[48;2;76;76;76m"
Combined   : ${ExampleCombinedCode}Sample Text with effects${resetStyle}


======================================
Available modifiers (can be combined)
======================================

[$(CBold 'bold')], [$(CDim 'dim')], [$(CItalic 'italic')], [$(CUnderline 'underline')], [$(CBlinking 'blinking')], [$(CInverse 'inverse')], [$(CInvisible 'invisible')], [$(CStrikethrough 'strikethrough')]


======================================
Ansi TrueColor Detail
======================================
[$(CCommand '\e[38')], [$(CCommand '\e[48')]: 38 = ForegroundColor,  48 = BackgroundColor
[$(CCommand ';2')]            : Set style to ANSI TrueColor
[$(CCommand ';181;142;232')]  : RGB Color
[$(CCommand ';3;5')]          : Modifiers
[$(CCommand 'm')]             : End of ANSI code
"@
}

function Get-FunctionsList {
    foreach ($category in $jsonData.PSObject.Properties.Name) {
        Write-Host "$(CParameter ${category})"

        $commands = $jsonData.$category.PSObject.Properties.Name
        $formattedCommands = @()

        foreach ($command in $commands) {
            $formattedCommands += "[$(CCommand ${command})]"
        }
        $commandsList = $formattedCommands -join ", "

        Write-Host "${commandsList}`n"
    }
}

function Get-FunctionsDetails {
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
        Write-Host "$(CParameter ${category})"
        foreach ($function in $jsonData.$category.PSObject.Properties.Name) {
            $description = $jsonData.$category.$function
            $functionName = $function
            $paddedFunctionName = $functionName.PadRight($maxFunctionNameLength)
            $detailedInfo = "[$(CCommand ${paddedFunctionName})]: ${description}"
            Write-Host $detailedInfo
        }
        Write-Host ""
    }
}

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
======================================
${Credits} PowerShell Profile - Help [List]
======================================

"@
        Get-FunctionsList
    } elseif ($args -eq "-detail") {
        @"
======================================
${Credits} PowerShell Profile - Help [Detail]
======================================

"@
        Get-FunctionsDetails
    } else {
        @"
======================================
${Credits} PowerShell Profile - Help
======================================

$(CCommand "alias_help") $(CParameter 'command'): to get the detailed help for a command
$(CCommand "alias_help") $(CParameter '-list')  : to list all available commands
$(CCommand "alias_help") $(CParameter '-detail'): to get the detailed help for all commands

"@
    }
}


##--- General Functions
function alias_edit   { code $PROFILE }
function alias_update { . $PROFILE }
function cls          { Clear-Host }
function credits      { Write-Host "Link to my GitHub: ${Credits}" }
function hist         { code $historyPath }
function ls           { Get-ChildItem $args }
function mkdir        { New-Item -ItemType Directory $args[0] | Set-Location }
function print        { Write-Host $args }
function s            { Invoke-Item . }
function uomp         { winget upgrade JanDeDobbeleer.OhMyPosh -s winget }
function update       { winget upgrade }
function winutil      { iwr -useb https://christitus.com/win | iex }
function wsls         { wsl --shutdown }
function y            { yt-dlp $args }
function ys           { yt-dlp --sponsorblock-mark all,-filler $args }


##--- Directory Navigation Functions
function ..           { Set-Location .. }
function ...          { Set-Location ..\.. }
function ....         { Set-Location ..\..\.. }
function .....        { Set-Location ..\..\..\.. }
function home         { Set-Location $env:USERPROFILE }
function dir {
    $TerminalIconsUnloaded = -not (Get-Module -Name Terminal-Icons)
    if ($TerminalIconsUnloaded) {
        Import-Module -Name Terminal-Icons
    }

    # List directory contents
    Get-ChildItem
}

##--- Python Functions
function p            { python $args }
function pf           { python -m pip freeze }
function pm           { python -m $args }
function pp           { python -m pip install $args }
function ppu          { python -m pip install -U $args }
function pv           { python -V }

##--- Pyenv Functions
function pe           { pyenv $args }
function pev          { pyenv versions }
function pes          { pyenv shell $args }
function peu          { pyenv update }

###--- Poetry Functions
function poi          { poetry install }
function por          { poetry run $args }
function pos          { poetry shell }

###--- Pre-commit Functions
function pc           { pre-commit $* }
function pcall        { pre-commit run --all-files }
function pci          { pre-commit install }

###--- Pip-tools Functions
function ptc          { python -m piptools compile }
function pts          { python -m piptools sync }

###--- Virtual Environment Functions
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

##--- General Multi-line Functions
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

    $shell = if ($isLatestPowershell) { "pwsh" } else { "powershell.exe" }

    if (IsAdmin) {
        & $shell -NoExit -ExecutionPolicy Bypass -Command "$command"
    } else {
        Start-Process wt.exe -ArgumentList "new-tab $shell -NoExit -ExecutionPolicy Bypass -Command $command" -Verb RunAs
    }
}


##--- Functions adapted/retrieved from: https://github.com/ChrisTitusTech/powershell-profile
function getip    { (Invoke-WebRequest http://ifconfig.me/ip).Content }
function sysinfo  { Get-ComputerInfo }
function flushdns {
	Clear-DnsClientCache
	Write-Host "DNS has been flushed"
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function uptime {
    if ($isLatestPowershell) {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    } else {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    }
}


#--- [PSReadLine] Configuration
if ($isLatestPowershell) {
    $PSROptions = @{
        ContinuationPrompt = '  '
        Colors             = @{
            Command                = CCommand
            Comment                = CComment
            ContinuationPrompt     = CContinuationPrompt
            Default                = CDefault
            Emphasis               = CEmphasis
            Error                  = CError
            InLinePrediction       = CInLinePrediction
            Keyword                = CKeyword
            ListPrediction         = CListPrediction
            ListPredictionSelected = CListPredictionSelected
            ListPredictionTooltip  = CListPredictionTooltip
            Member                 = CMember
            Number                 = CNumber
            Operator               = COperator
            Parameter              = CParameter
            Selection              = CSelection
            String                 = CString
            Type                   = CType
            Variable               = CVariable
        }
        HistoryNoDuplicates = $True
        HistorySearchCursorMovesToEnd = $False
        PredictionSource = "HistoryAndPlugin"
    }
    Set-PSReadLineOption @PSROptions

    # Remove existing alias for dir if it exists
    Remove-Alias dir -ErrorAction SilentlyContinue

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
