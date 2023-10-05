# Oh My Posh
# https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/bubblesextra.omp.json

oh-my-posh init pwsh --config '%USERPROFILE%\Documents\GitHub\self-development\misc\oh-my-posh\themes\viniam_bubblesextra.omp.json' | Invoke-Expression

# remove repeated ".venv": https://github.com/JanDeDobbeleer/oh-my-posh/discussions/390

$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
