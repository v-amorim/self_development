# Setup

1. Install [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
2. Install [Oh My Posh](https://ohmyposh.dev/docs/windows):

```powershell
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
```

3. Go to your WindowsPowerShell folder and paste the contents of `Microsoft.PowerShell_profile.ps1` in the beginning of the file:

```powershell
cd ~\Documents\WindowsPowerShell\
start .
```

4. Reload your profile:

```powershell
. $PROFILE
```
