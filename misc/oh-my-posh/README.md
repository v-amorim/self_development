# Setup

## Windows

1. Install [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
2. Install [Oh My Posh](https://ohmyposh.dev/docs/installation/windows):

   ```powershell
   winget install JanDeDobbeleer.OhMyPosh -s winget
   ```

3. Go to your WindowsPowerShell folder and paste the contents of `Microsoft.PowerShell_profile.ps1` in the beginning of the file:

   ```powershell
   cd ~\Documents\WindowsPowerShell\
   code Microsoft.PowerShell_profile.ps1
   ```

4. Paste these lines at the start of the file:

   ```powershell
   oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/v-amorim/self-development/main/misc/oh-my-posh/themes/viniam_bubblesextra.omp.json' | Invoke-Expression
   $env:VIRTUAL_ENV_DISABLE_PROMPT = 1
   ```

5. Reload your profile:

   ```powershell
   . $PROFILE
   ```

6. To get the latest versions whenever there's an update, run:

   ```powershell
      winget upgrade JanDeDobbeleer.OhMyPosh -s winget
      winget upgrade --all # Or this, to update all
   ```

## Linux

1. Install [Oh My Posh](https://ohmyposh.dev/docs/installation/linux):

   ```bash
   curl -s https://ohmyposh.dev/install.sh | sudo bash -s
   ```

2. Go to your `.bashrc` file:

   ```bash
   code ~/.bashrc
   ```

3. Paste this line at the end:

   ```bash
   eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/v-amorim/self-development/main/misc/oh-my-posh/themes/viniam_bubblesextra.omp.json')"
   ```

4. To get the latest versions whenever there's an update, run:

   ```bash
      curl -s https://ohmyposh.dev/install.sh | sudo bash -s
   ```
