#--- General aliases
alias alias_edit='code ~/.bash_aliases'     ; alias h_edit_aliases='echo "Open bash aliases [code ~/.bash_aliases]"'
alias alias_update='source ~/.bashrc'       ; alias h_update_aliases='echo "Refreshes the bashrc, to update the aliases [source ~/.bashrc]"'
alias la='ls -Alh'                          ; alias h_la='echo "List all files [ls -Alh]"'
alias ls='ls -aFh --color=always'           ; alias h_ls='echo "List files with colors and file type extensions [ls -aFh --color=always]"'
alias check='ls -l'                         ; alias h_check='echo "Check permissions [ls -l <arg>]"'
alias cls='clear'                           ; alias h_cls='echo "Clear terminal [clear]"'
alias s='source'                            ; alias h_s='echo "Refreshes the file [source <arg>]"'
alias history='code ~/.bash_history'        ; alias h_history='echo "Open bash history [code ~/.bash_history]"'
alias please='sudo'                         ; alias h_please='echo "Run a command as sudo [sudo <arg>]"'
alias uomp='curl -s https://ohmyposh.dev/install.sh | sudo bash -s'                                                  ; alias h_uomp='echo "Updates Oh My Posh [curl -s https://ohmyposh.dev/install.sh | sudo bash -s]"'
alias update='sudo apt update; sudo apt upgrade; sudo apt autoremove; sudo apt autoclean'                            ; alias h_update='echo "Update and upgrade [sudo (apt update, upgrade, autoremove, autoclean)]"'
alias fixtime='sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d '\'' '\'' -f5-8)Z"' ; alias h_fixtime='echo "Fix Ubuntu time"'

function alias_help() {
echo "Bash Profile Help"
echo "================="
echo "Use h_<command> for more description on the command."
echo ""
echo "[alist], [aliases], [la], [ls], [check], [cls], [s], [update_aliases], [history], [please], [uomp], [update], [fixtime], [..], [...], [....], [.....], [bd], [home], [p], [pm], [pp], [ppu], [pr]"
echo "[processing], [cprocessing], [spark_proc], [cspark_proc]"
}

function fwhich() {
    readlink -f $(which "$1")
} ; alias h_fwhich='Full path version of a `which` command [readlink -f \$(which <arg>)]'

#--- Change directory aliases
# Go to 1st level parent directory
alias ..='cd ..'                            ; alias h_..='echo "Go to 1st level parent directory [cd ..]"'
alias ...='cd ../..'                        ; alias h_...='echo "Go to 2nd level parent directory [cd ../..]"'
alias ....='cd ../../..'                    ; alias h_....='echo "Go to 3rd level parent directory [cd ../../..]"'
alias .....='cd ../../../..'                ; alias h_.....='echo "Go to 4th level parent directory [cd ../../../..]"'
alias bd='cd "$OLDPWD"'                     ; alias h_bd='echo "Go to the last open directory [cd \$OLDPWD]"'
alias home='cd ~'                           ; alias h_home='echo "Go to home directory [cd ~]"'


#--- Python aliases
alias p='python'                            ; alias h_p='echo "Runs a `python` command [python <arg>]"'
alias pm='python -m '                       ; alias h_pm='echo "Runs a `python -m` command [python -m <arg>]"'
alias pp='python -m pip install '           ; alias h_pp='echo "Runs a `python -m pip install` command [python -m pip install <arg>]"'
alias ppu='python -m pip install -U '       ; alias h_ppu='echo "Runs a `python -m pip install -U` command [python -m pip install -U <arg>]"'
alias pr='poetry run'                       ; alias h_pr='echo "Runs a `poetry run` command [poetry run <arg>]"'


#--- Deep aliases

alias processing='cd ~/spark-proc/apps/processing/'                             ; alias h_processing='echo "Go to processing directory [cd ~/spark-proc/apps/processing/]"'
alias cprocessing='cd ~/spark-proc/apps/processing/; code .'                    ; alias h_cprocessing='echo "Go to processing directory and open on VSCode [cd ~/spark-proc/apps/processing/; code .]"'
alias spark_proc='cd ~/spark-proc'                                              ; alias h_spark_proc='echo "Go to spark-proc directory [cd ~/spark-proc]"'
alias cspark_proc='cd ~/spark-proc; code ".vscode/spark-proc.code-workspace"'   ; alias h_cspark_proc='echo "Open the spark_proc workspace [cd ~/spark-proc; code .vscode/spark-proc.code-workspace]"'
