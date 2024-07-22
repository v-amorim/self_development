##--- Oh My Posh settings
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/v-amorim/self_development/main/config/oh-my-posh/themes/viniam_bubblesextra.omp.json' | Invoke-Expression
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

##--- General shorcuts
function alias_help {
@"
PowerShell Profile Help
=======================
Use -<command> for more description on the command.

[.....], [....], [...], [..], [a], [add_to_path], [alias_edit], [alias_help], [alias_update], [cls], [d], [flushdns], [ga], [gc], [gcl], [gco], [gd], [getip], [gf], [gforce], [gl], [glog], [gma], [gp], [gr], [grep], [greset], [gs], [h], [hist], [ls], [mkdir], [p], [pc], [pcall], [pci], [pe311], [pe38], [pe], [peu], [pf], [pm], [pp], [ptc], [pts], [s], [sysinfo], [uomp], [uptime], [which], [winutil], [wsls], [y], [ys]
"@
}                                                ; function -alias_help   { "List all aliases" }
function alias_update { . $PROFILE }             ; function -alias_update { "Updates the PowerShell profile file [. $PROFILE]" }
function alias_edit   { code $PROFILE }          ; function -alias_edit   { "Edit the PowerShell profile file [code $PROFILE]" }
function h       { Get-History }                 ; function -h      { "List all used aliases [DOSKEY /HISTORY]" }
function ls      { Get-ChildItem $args }         ; function -ls     { "List files and folders in the current directory [DIR <file>]" }
function s       { Invoke-Item . }               ; function -s      { "Open File Explorer in the current directory [start .]" }
function ..      { Set-Location .. }             ; function -..     { "Go up one directory [cd ..]" }
function ...     { Set-Location ..\.. }          ; function -...    { "Go up two directories [cd ..\..]" }
function ....    { Set-Location ..\..\.. }       ; function -....   { "Go up three directories [cd ..\..\..]" }
function .....   { Set-Location ..\..\..\.. }    ; function -.....  { "Go up four directories [cd ..\..\..\..]" }
function cls     { Clear-Host }                  ; function -cls    { "Clear the console [cls]" }
function wsls    { wsl --shutdown }              ; function -wsls   { "Shutdown the active WSL [wsl --shutdown]" }
function mkdir   { New-Item -ItemType Directory $args[0] | Set-Location } ; function -mkdir     { "Create a new directory and navigate to it [mkdir <directory> && cd <directory>]" }
function uomp    { winget upgrade JanDeDobbeleer.OhMyPosh -s winget }     ; function -uomp      { "Update Oh My Posh [winget upgrade JanDeDobbeleer.OhMyPosh -s winget]" }
function y       { yt-dlp $args }                                         ; function -y         { "Downloads youtube video [yt-dlp <url>]" }
function ys      { yt-dlp --sponsorblock-mark all,-filler $args }         ; function -ys        { "Downloads youtube video with SponsorBlock chapters [yt-dlp args <url>]" }
function hist    { code $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt } ; function -hist { "Opens the Powershell command history file [code ConsoleHost_history.txt]" }
function winutil { iwr -useb https://christitus.com/win | iex }           ; function -winutil   { "Run Chris Titus's Windows Utility [iwr -useb https://christitus.com/win | iex]" }

##--- Python Functions
function p      { python $args }                    ; function -p      { "Run a Python script [python <script.py>]" }
function pe     { pyenv $args }                     ; function -pe     { "Manage Python versions [pyenv <command>]" }
function peu    { pyenv update }                    ; function -peu    { "Update Pyenv version list [pyenv update]" }
function pe311  { pyenv shell 3.11.2 }              ; function -pe311  { "Activate Python 3.11.2 on the current shell [pyenv shell 3.11.2]" }
function pe38   { pyenv shell 3.8.10 }              ; function -pe38   { "Activate Python 3.8.10 on the current shell [pyenv shell 3.8.10]" }
function pf     { python -m pip freeze }            ; function -pf     { "List all installed packages [python -m pip freeze]" }
function pm     { python -m $args }                 ; function -pm     { "Run a Python module [python -m <module>]" }
function pp     { python -m pip install $args }     ; function -pp     { "Install a Python package [python -m pip install <package>]" }
function ppu    { python -m pip install -U $args }  ; function -ppu    { "Updates a Python package [python -m pip install -U <package>]" }

##--- Virtual environment Functions
function a      { & .venv\Scripts\activate.ps1 } ; function -a      { "Activate the virtual environment [.venv\Scripts\activate.bat]" }
function d      { deactivate }                   ; function -d      { "Deactivate the virtual environment [deactivate]" }

##--- Pre-commit Functions
function pc     { pre-commit $* }                ; function -pc     { "Run pre-commit hooks [pre-commit <command>]" }
function pci    { pre-commit install }           ; function -pci    { "Install pre-commit hooks [pre-commit install]" }
function pcall  { pre-commit run --all-files }   ; function -pcall  { "Run pre-commit hooks on all files [pre-commit run --all-files]" }

##--- Pip-tools Functions
function ptc    { python -m piptools compile }   ; function -ptc    { "Run pip-compile on requirements.in [python -m piptools compile]" }
function pts    { python -m piptools sync }      ; function -pts    { "Run pip-sync on requirements.txt [python -m piptools sync]" }

##--- Git Functions
function ga     { git add $args }                ; function -ga     { "Stage changes for commit [git add <file>]" }
function gc     { git commit -m "$args" }        ; function -gc     { "Commit changes with a message [git commit -m '<message>']" }
function gcl    { git clone $args }              ; function -gcl    { "Clone a repository [git clone <url>]" }
function gco    { git checkout $args }           ; function -gco    { "Switch to a different branch or commit [git checkout <branch>]" }
function gd     { git diff $args }               ; function -gd     { "See the difference between the working directory and the staging area [git diff <file>]" }
function gf     { git fetch}                     ; function -gf     { "Fetch changes from the remote repository [git fetch]" }
function gforce { git push -f}                   ; function -gforce { "Force push to the current branch [git push -f]" }
function gl     { git log $args }                ; function -gl     { "See the commit history of the repository [git log <file>]" }
function glog   { git log --oneline}             ; function -glog   { "Get one-line summary of each commit [git log --oneline]" }
function gma    { git merge --abort }            ; function -gma    { "Abort a merge [git merge --abort]" }
function gp     { git push }                     ; function -gp     { "Push changes to the remote repository [git push]" }
function gr     { git remote $args }             ; function -gr     { "Manage the remote repositories [git remote <command>]" }
function greset { git reset --hard origin/main}  ; function -greset { "See the current status of the repository [git status]" }
function gs     { git status }                   ; function -gs     { "Reset the current branch to the origin/main branch [git reset --hard origin/main]" }

##--- Multi-line Functions
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
} ; function -add_to_path { "Add a directory to the PATH [add_to_path <directory>]" }

##--- Functions adapted/retrieved from: https://github.com/ChrisTitusTech/powershell-profile

function getip { (Invoke-WebRequest http://ifconfig.me/ip).Content } ; function -getip { "Get your public IP address" }

function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
} ; function -uptime { "Get the system uptime" }

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
} ; function -grep { "Search for a regex pattern in a file or directory [grep <regex> <dir>]" }

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
} ; function -which { "Locate a command [which <command>]" }

# Quick Access to System Information
function sysinfo { Get-ComputerInfo } ; function -sysinfo { "Get system information" }

# Networking Utilities
function flushdns {
	Clear-DnsClientCache
	Write-Host "DNS has been flushed"
} ; function -flushdns { "Flush the DNS cache" }

# Enhanced PowerShell Experience
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
    }
    Set-PSReadLineOption @PSROptions
} else {
    Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    InLinePrediction = 'Gray'
    Parameter = 'Green'
    String = 'DarkCyan'
    ContinuationPrompt = 'Gray'
    }
}
