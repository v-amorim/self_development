# Oh My Posh: https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/bubblesextra.omp.json
# remove repeated ".venv": https://github.com/JanDeDobbeleer/oh-my-posh/discussions/390
# Parameters https://learn.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.4#parameters
# Copy only the commands, not the comments

oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/v-amorim/self_development/main/config/oh-my-posh/themes/v-amorim.omp.json' | Invoke-Expression
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
Set-PSReadLineOption -PredictionSource History
