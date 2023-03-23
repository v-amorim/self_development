# List all used aliases.
function h { Get-History }

# List all available aliases.
function alias { Get-Alias }

# General shortcuts
# List files and folders in the current directory.
function ls { Get-ChildItem $args }

# Create a new directory and navigate to it.
function mkdir { New-Item -ItemType Directory $args[0] | Set-Location }

# Search for text within files.
function grep { Select-String -Path $args }

# Open File Explorer in the current directory.
function s { Invoke-Item . }

# Go up N directories.
function ..     { Set-Location .. }
function ...    { Set-Location ..\.. }
function ....   { Set-Location ..\..\.. }
function .....  { Set-Location ..\..\..\.. }

# Go to / directory
function / { Set-Location / }

# Python shortcuts
function p      { python $args }
function pe     { pyenv $args }
function pe311  { pyenv shell 3.11.2 }
function pe38   { pyenv shell 3.8.10 }
function pm     { python -m $args }
function pp     { python -m pip install $args }


# Activate the virtual environment.
function a  { & .venv\Scripts\activate.ps1 }

# Deactivate the virtual environment.
function d { deactivate }

# Git shortcuts
# Clone a repository.
function gcl { git clone $args }

# Stage changes for commit.
function ga { git add $args }

# Commit changes with a message.
function gc { git commit -m "$args" }

# Push changes to the remote repository.
function gp { git push }

# Switch to a different branch or commit.
function gco { git checkout $args }

# See the current status of the repository.
function gs { git status }

# See the difference between the working directory and the staging area.
function gd { git diff $args }

# See the commit history of the repository.
function gl { git log $args }

# Manage the remote repositories.
function gr { git remote $args }

# Open the Git repository visualizer in a separate window.
function gitk { Start-Process gitk -ArgumentList "--all" }

# Fetch changes from the remote repository.
function gf {git fetch}

# Reset the current branch to the origin/main branch.
function greset {git reset --hard origin/main}

# Force push to the current branch.
function gforce {git push -f}

# Clear the screen.
function cls { Clear-Host }
