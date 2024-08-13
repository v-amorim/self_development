# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


##--- User defined settings ---##
# Defines the oh-my-posh theme
eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/v-amorim/oh-my-posh/main/themes/Moonlight.omp.json')"

# General configuration
cdpath=(/ $HOME) # Sets the search paths for the `cd` command, allowing shortcuts for changing directories

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Java SDK configuration
export PATH="$JAVA_HOME/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PYSPARK_SUBMIT_ARGS="--master local[*] pyspark-shell"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/amorim/google-cloud-sdk/path.bash.inc' ]; then . '/home/amorim/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/amorim/google-cloud-sdk/completion.bash.inc' ]; then . '/home/amorim/google-cloud-sdk/completion.bash.inc'; fi

# Custom prompt colors
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '

# BLESH configuration
source ~/.local/share/blesh/ble.sh
