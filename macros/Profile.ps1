##--- General shorcuts
    function alias  { "Use -<command> for more description: [alias],[grep],[h],[ls],[s],[..],[...],[....],[.....],[mkdir],[wsls],[p],[pe],[peu],[pe311],[pe38],[pf],[pm],[pp],[a],[d],[pc],[pci],[pcall],[ptc],[pts],[ga],[gma],[gc],[gcl],[gco],[gd],[gf],[gforce],[gl],[glog],[gp],[gr],[greset],[gs]" }
    function -alias { "List all aliases" }
    function grep   { Select-String -Path $args }   ; function -grep   { "Search for text within files [find /i <text>]" }
    function h      { Get-History }                 ; function -h      { "List all used aliases [DOSKEY /HISTORY]" }
    function ls     { Get-ChildItem $args }         ; function -ls     { "List files and folders in the current directory [DIR <file>]" }
    function s      { Invoke-Item . }               ; function -s      { "Open File Explorer in the current directory [start .]" }
    function ..     { Set-Location .. }             ; function -..     { "Go up one directory [cd ..]" }
    function ...    { Set-Location ..\.. }          ; function -...    { "Go up two directories [cd ..\..]" }
    function ....   { Set-Location ..\..\.. }       ; function -....   { "Go up three directories [cd ..\..\..]" }
    function .....  { Set-Location ..\..\..\.. }    ; function -.....  { "Go up four directories [cd ..\..\..\..]" }
    function cls    { Clear-Host }                  ; function -cls    { "Clear the console [cls]" }
    function mkdir  { New-Item -ItemType Directory $args[0] | Set-Location } ; function -mkdir { "Create a new directory and navigate to it [mkdir <directory> && cd <directory>]" }
    function wsls    { wsl --shutdown }                  ; function -wsls    { "Shutdown the active WSL [wsl --shutdown]" }

##--- Python shortcuts
    function p      { python $args }                ; function -p      { "Run a Python script [python <script.py>]" }
    function pe     { pyenv $args }                 ; function -pe     { "Manage Python versions [pyenv <command>]" }
    function peu    { pyenv update }                ; function -peu    { "Update Pyenv version list [pyenv update]" }
    function pe311  { pyenv shell 3.11.2 }          ; function -pe311  { "Activate Python 3.11.2 on the current shell [pyenv shell 3.11.2]" }
    function pe38   { pyenv shell 3.8.10 }          ; function -pe38   { "Activate Python 3.8.10 on the current shell [pyenv shell 3.8.10]" }
    function pf     { python -m pip freeze }        ; function -pf     { "List all installed packages [python -m pip freeze]" }
    function pm     { python -m $args }             ; function -pm     { "Run a Python module [python -m <module>]" }
    function pp     { python -m pip install $args } ; function -pp     { "Install a Python package [python -m pip install <package>]" }

##--- Virtual environment shortcuts
    function a      { & .venv\Scripts\activate.ps1 }; function -a      { "Activate the virtual environment [.venv\Scripts\activate.bat]" }
    function d      { deactivate }                  ; function -d      { "Deactivate the virtual environment [deactivate]" }

##--- Pre-commit shortcuts
    function pc     { pre-commit $* }               ; function -pc     { "Run pre-commit hooks [pre-commit <command>]" }
    function pci    { pre-commit install }          ; function -pci    { "Install pre-commit hooks [pre-commit install]" }
    function pcall  { pre-commit run --all-files }  ; function -pcall  { "Run pre-commit hooks on all files [pre-commit run --all-files]" }

##--- Pip-tools shortcuts
    function ptc    { python -m piptools compile }  ; function -ptc    { "Run pip-compile on requirements.in [python -m piptools compile]" }
    function pts    { python -m piptools sync }     ; function -pts    { "Run pip-sync on requirements.txt [python -m piptools sync]" }

##--- Git shortcuts
    function ga     { git add $args }               ; function -ga     { "Stage changes for commit [git add <file>]" }
    function gma    { git merge --abort }           ; function -gma    { "Abort a merge [git merge --abort]" }
    function gc     { git commit -m "$args" }       ; function -gc     { "Commit changes with a message [git commit -m '<message>']" }
    function gcl    { git clone $args }             ; function -gcl    { "Clone a repository [git clone <url>]" }
    function gco    { git checkout $args }          ; function -gco    { "Switch to a different branch or commit [git checkout <branch>]" }
    function gd     { git diff $args }              ; function -gd     { "See the difference between the working directory and the staging area [git diff <file>]" }
    function gf     { git fetch}                    ; function -gf     { "Fetch changes from the remote repository [git fetch]" }
    function gforce { git push -f}                  ; function -gforce { "Force push to the current branch [git push -f]" }
    function gl     { git log $args }               ; function -gl     { "See the commit history of the repository [git log <file>]" }
    function glog   { git log --oneline}            ; function -glog   { "Get one-line summary of each commit [git log --oneline]" }
    function gp     { git push }                    ; function -gp     { "Push changes to the remote repository [git push]" }
    function gr     { git remote $args }            ; function -gr     { "Manage the remote repositories [git remote <command>]" }
    function greset { git reset --hard origin/main} ; function -greset { "See the current status of the repository [git status]" }
    function gs     { git status }                  ; function -gs     { "Reset the current branch to the origin/main branch [git reset --hard origin/main]" }
