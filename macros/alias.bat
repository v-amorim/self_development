::  DOSKEY shortcuts, https://stackoverflow.com/questions/20530996/aliases-in-windows-command-prompt
::  To add to Windows Terminal, add a `/k path/to/alias.bat` to the end of the `commandline` property on the [Settings>Profiles>Command Prompt] (Ctrl+,) page.

::  General shortcuts
    DOSKEY alias=   echo "Use -<command> for more description: [alias],[grep],[h],[ls],[s],[..],[...],[....],[.....],[mkdir],[p],[pe311],[pe38],[pe],[pf],[pm],[pp],[a],[d],[ga],[gc],[gcl],[gco],[gd],[gf],[gforce],[gl],[glog],[gp],[gr],[gs],[greset]"
    DOSKEY -alias=  echo "List all available aliases"
    DOSKEY grep=find /i "$*"                    & DOSKEY -grep=     echo "Search for text within files [find /i <text>]"
    DOSKEY h=DOSKEY /HISTORY                    & DOSKEY -h=        echo "List all used aliases [DOSKEY /HISTORY]"
    DOSKEY ls=DIR $*                            & DOSKEY -ls=       echo "List files and folders in the current directory [DIR <file>]"
    DOSKEY s=start .                            & DOSKEY -s=        echo "Open File Explorer in the current directory [start .]"
    DOSKEY ..=cd ..                             & DOSKEY -..=       echo "Go up one directory [cd ..]"
    DOSKEY ...=cd ..\..                         & DOSKEY -...=      echo "Go up two directories [cd ..\..]"
    DOSKEY ....=cd ..\..\..                     & DOSKEY -....=     echo "Go up three directories [cd ..\..\..]"
    DOSKEY .....=cd ..\..\..\..                 & DOSKEY -.....=    echo "Go up four directories [cd ..\..\..\..]"
    DOSKEY mkdir=mkdir $* && cd $*              & DOSKEY -mkdir=    echo "Create a new directory and navigate to it [mkdir <directory> && cd <directory>]"

:: Python shortcuts
    DOSKEY p=python $*                          & DOSKEY -p=        echo "Run a Python script [python <script.py>]"
    DOSKEY pe311=pyenv shell 3.11.2             & DOSKEY -pe311=    echo "Activate Python 3.11.2 on the current shell [pyenv shell 3.11.2]"
    DOSKEY pe38=pyenv shell 3.8.10              & DOSKEY -pe38=     echo "Activate Python 3.8.10 on the current shell [pyenv shell 3.8.10]"
    DOSKEY pe=pyenv $*                          & DOSKEY -pe=       echo "Manage Python versions [pyenv <command>]"
    DOSKEY pf=python -m pip freeze              & DOSKEY -pf=       echo "List all installed packages [python -m pip freeze]"
    DOSKEY pm=python -m $*                      & DOSKEY -pm=       echo "Run a Python module [python -m <module>]"
    DOSKEY pp=python -m pip install $*          & DOSKEY -pp=       echo "Install a Python package [python -m pip install <package>]"

:: Virtual environment shortcuts
    DOSKEY a=.venv\Scripts\activate.bat         & DOSKEY -a=        echo "Activate the virtual environment [.venv\Scripts\activate.bat]"
    DOSKEY d=deactivate                         & DOSKEY -d=        echo "Deactivate the virtual environment [deactivate]"

:: Pre-commit shortcut
    DOSKEY pc=pre-commit $*                     & DOSKEY -pc=       echo "Run pre-commit hooks [pre-commit <command>]"
    DOSKEY pci=pre-commit install               & DOSKEY -pci=      echo "Install pre-commit hooks [pre-commit install]"
    DOSKEY pcall=pre-commit run --all-files     & DOSKEY -pcall=    echo "Run pre-commit hooks on all files [pre-commit run --all-files]"


:: Git shortcuts
    DOSKEY ga=git add $*                        & DOSKEY -ga=       echo "Stage changes for commit [git add <file>]"
    DOSKEY gc=git commit -m "$*"                & DOSKEY -gc=       echo "Commit changes with a message [git commit -m '<message>']"
    DOSKEY gcl=git clone $*                     & DOSKEY -gcl=      echo "Clone a repository [git clone <url>]"
    DOSKEY gco=git checkout $*                  & DOSKEY -gco=      echo "Switch to a different branch or commit [git checkout <branch>]"
    DOSKEY gd=git diff $*                       & DOSKEY -gd=       echo "See the difference between the working directory and the staging area [git diff <file>]"
    DOSKEY gf=git fetch                         & DOSKEY -gf=       echo "Fetch changes from the remote repository [git fetch]"
    DOSKEY gforce=git push -f                   & DOSKEY -gforce=   echo "Force push to the current branch [git push -f]"
    DOSKEY gl=git log $*                        & DOSKEY -gl=       echo "See the commit history of the repository [git log <file>]"
    DOSKEY glog=git log --oneline               & DOSKEY -glog=     echo "Get one-line summary of each commit [git log --oneline]"
    DOSKEY gp=git push                          & DOSKEY -gp=       echo "Push changes to the remote repository [git push]"
    DOSKEY gr=git remote $*                     & DOSKEY -gr=       echo "Manage the remote repositories [git remote <command>]"
    DOSKEY gs=git status                        & DOSKEY -gs=       echo "See the current status of the repository [git status]"
    DOSKEY greset=git reset --hard origin/main  & DOSKEY -greset=   echo "Reset the current branch to the origin/main branch [git reset --hard origin/main]"

cls