#--- Bindings
bind '"\e[1;5A":history-search-backward'    # [Alt+Up/Down] to search history
bind '"\e[1;5B":history-search-forward'     # [Alt+Up/Down] to search history
bind '"\e[1;5C":forward-word'               # [Alt+Left/Right] to move between words
bind '"\e[1;5D":backward-word'              # [Alt+Left/Right] to move between words
bind '"\e[3;3~": "\C-e\C-u"'                # [Alt+Delete] to delete entire forward line
bind '"\e[3;2~": "\C-u"'                    # [Shift+Delete] to delete backward
bind 'set completion-ignore-case on'        # Ignore case when completing
bind 'set show-all-if-ambiguous on'         # Immediately display all possible completions
bind 'set completion-query-items 100'       # Show all possible completions without asking


#--- Bash History config, credits to: https://unix.stackexchange.com/a/419779
shopt -s histappend                         # append to the history file, don't overwrite it
export HISTCONTROL=ignoreboth:erasedups     # do not store duplicates in history
export PROMPT_COMMAND="history -n; history -w; history -c; history -r"              # reload and cleanup history after each command
tac "$HISTFILE" | awk '!x[$0]++' > /tmp/tmpfile && tac /tmp/tmpfile > "$HISTFILE"   # remove duplicates from history
rm /tmp/tmpfile


#--- General aliases
function alias_help() {
echo "Bash Profile Help"
echo "================="
echo "Use h_<command> for more description on the command."
echo ""
echo "[.....], [....], [...], [..], [a], [aliases], [alist], [bd], [check], [cls], [d], [fixtime], [hist], [home], [la], [ls], [p], [please], [pm], [pp], [ppu], [pr], [pv], [s], [uomp], [update], [update_aliases]"
}                                           ; alias h_alias_help='echo "List all aliases"'
alias alias_edit='code ~/.bash_aliases'     ; alias h_edit_aliases='echo "Edit the .bash_aliases file [code ~/.bash_aliases]"'
alias alias_update='source ~/.bashrc'       ; alias h_update_aliases='echo "Refreshes the .bashrc file [source ~/.bashrc]"'
alias check='ls -l'                         ; alias h_check='echo "Check permissions [ls -l <arg>]"'
alias cls='clear'                           ; alias h_cls='echo "Clears the console [clear]"'
alias fixtime='sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d '\'' '\'' -f5-8)Z"' ; alias h_fixtime='echo "Fix Ubuntu time"'
alias hist='code ~/.bash_history'           ; alias h_hist='echo "Opens the Bash command history file [code ~/.bash_history]"'
alias la='ls -Alh'                          ; alias h_la='echo "List all files [ls -Alh]"'
alias ls='ls -aFh --color=always'           ; alias h_ls='echo "List files with colors and file type extensions [ls -aFh --color=always]"'
alias please='sudo'                         ; alias h_please='echo "Run a command as an administrator [sudo <command>]"'
alias uomp='curl -s https://ohmyposh.dev/install.sh | sudo bash -s'                         ; alias h_uomp='echo "Updates Oh My Posh [curl -s https://ohmyposh.dev/install.sh | sudo bash -s]"'
alias update='sudo apt update; sudo apt upgrade; sudo apt autoremove; sudo apt autoclean'   ; alias h_update='echo "Update and upgrade [sudo (apt update, upgrade, autoremove, autoclean)]"'

#--- Directory Navigation aliases
alias ..='cd ..'                            ; alias h_..='echo "Go up one directory [cd ..]"'
alias ...='cd ../..'                        ; alias h_...='echo "Go up two directories [cd ../..]"'
alias ....='cd ../../..'                    ; alias h_....='echo "Go up three directories [cd ../../..]"'
alias .....='cd ../../../..'                ; alias h_.....='echo "Go up four directories [cd ../../../..]"'
alias bd='cd "$OLDPWD"'                     ; alias h_bd='echo "Go to the last open directory [cd \$OLDPWD]"'
alias home='cd ~'                           ; alias h_home='echo "Go to the user home directory [cd ~]"'


#--- Python aliases
alias p='python'                            ; alias h_p='echo "Runs a Python script [python <arg>]"'
alias pf='python -m pip freeze'             ; alias h_pf='echo "List all installed packages [python -m pip freeze]"'
alias pm='python -m '                       ; alias h_pm='echo "Run a Python module [python -m <module>]"'
alias pp='python -m pip install '           ; alias h_pp='echo "Install a Python package [python -m pip install <package>]"'
alias ppu='python -m pip install -U '       ; alias h_ppu='echo "Updates a Python package [python -m pip install -U <package>]"'
alias pv='python -V'                        ; alias h_pv='echo "Checks the Python version [python -V]"'

##--- Virtualenv aliases
alias a='source .venv/bin/activate'         ; alias h_a='echo "Activate the virtual environment [source .venv/bin/activate]"'
alias d='deactivate'                        ; alias h_d='echo "Deactivate the virtual environment [deactivate]"'

##--- Pyenv aliases
alias pe='pyenv'                            ; alias h_pe='echo "Run a Pyenv command [pyenv <command>]"'
alias pev='pyenv versions'                  ; alias h_pev='echo "List all Pyenv Python versions [pyenv versions <arg>]"'
alias pes='pyenv shell'                     ; alias h_pes='echo "Set the Pyenv shell-specific Python version [pyenv shell <version>]"'
alias peu='pyenv update'                    ; alias h_peu='echo "Update Pyenv version list [pyenv update]"'

##--- Poetry aliases
alias poi='poetry install'                  ; alias h_poi='echo "Install dependencies from the lock file [poetry install]"'
alias por='poetry run'                      ; alias h_por='echo "Run a command in the Poetry virtual environment [poetry run <command>]"'
alias pos='poetry shell'                    ; alias h_pos='echo "Activate the Poetry virtual environment [poetry shell]"'

##--- Pre-commit aliases
alias pc='pre-commit'                       ; alias h_pc='echo "Run selected pre-commit hooks [pre-commit <command>]"'
alias pcall='pre-commit run --all-files'    ; alias h_pcall='echo "Run all pre-commit hooks on all files [pre-commit run --all-files]"'
alias pci='pre-commit install'              ; alias h_pci='echo "Install pre-commit hooks [pre-commit install]"'

##--- Pip-tools aliases
alias ptc='python -m piptools compile'      ; alias h_ptc='echo "Run pip-compile on requirements.in [python -m piptools compile]"'
alias pts='python -m piptools sync'         ; alias h_pts='echo "Run pip-sync on requirements.txt [python -m piptools sync]"'


#--- Multi-line Functions
function fwhich() {
    readlink -f $(which "$1")
} ; alias h_fwhich='echo "Full path version of a `which` command [readlink -f \$(which <arg>)]"'


#--- Work aliases
alias spark_proc='cd ~/spark-proc'                                              ; alias h_spark_proc='echo "Go to spark-proc directory [cd ~/spark-proc]"'
alias cspark_proc='cd ~/spark-proc; code ".vscode/spark-proc.code-workspace"'   ; alias h_cspark_proc='echo "Open the spark_proc workspace [cd ~/spark-proc; code .vscode/spark-proc.code-workspace]"'

alias processing='cd ~/spark-proc/apps/processing/'                             ; alias h_processing='echo "Go to processing directory [cd ~/spark-proc/apps/processing/]"'
alias cprocessing='cd ~/spark-proc/apps/processing/; code .'                    ; alias h_cprocessing='echo "Go to processing directory and open on VSCode [cd ~/spark-proc/apps/processing/; code .]"'

alias datawarehouse='cd ~/spark-proc/apps/datawarehouse/'                       ; alias h_datawarehouse='echo "Go to datawarehouse directory [cd ~/spark-proc/apps/datawarehouse/]"'
alias cdatawarehouse='cd ~/spark-proc/apps/datawarehouse/; code .'              ; alias h_cdatawarehouse='echo "Go to datawarehouse directory [cd ~/spark-proc/apps/datawarehouse/; code .]"'
