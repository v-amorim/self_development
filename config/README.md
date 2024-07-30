![][waves_top]

<div  align="center">
   <h1>🎴Self Development - Config🎴</h1>

[Home][README_self_development] | [Config][README_config] | [Indesign Scripts][README_indesign_scripts] | [Macros][README_macros] | [Python][README_python] | [Ruby][README_ruby] | [LaTeX][README_tex]

</div>

## Config

The Config folder contains a collection of scripts or configurations that I use or have written for various purposes.

### [bash][bash]

Contains my bash configurations, aliases and useful guides.

### [mpv64][mpv64]

Where I keep my MPV scripts and configurations. Also contains my SVP configurations.

### [oh-my-posh][oh-my-posh]

Contains my oh-my-posh theme configurations, together with a guide on how to install and configure it.

### [powershell][powershell]

Terminal shortcuts are useful for quick access to various commands. The aliases are written for Windows.

Contains various aliases that are useful for the PowerShell.

<p align="center">
  <img alt="terminal" src="https://github.com/user-attachments/assets/cbd1e637-5c87-44e7-8469-51012c7f623b" width="100%"/>
</p>

You can add it to your PowerShell profile by running the following command, in an elevated (Administrator) PowerShell:

```powershell
irm "https://raw.githubusercontent.com/v-amorim/self_development/main/config/powershell/SetupPowershell.ps1" | iex
```

If for some reason the command above doesn't work, download the `SetupPowershell.ps1` and enter its path on the following command in the PowerShell:

```powershell
Invoke-Expression -Command (Get-Content -Path "./SetupPowershell.ps1" -Raw)
```

### [wterminal][wterminal]

Contains my Windows Terminal configurations and theme.

### [yt-dlp][yt-dlp]

Contains my yt-dlp configurations and guide on how to install it.

### [winutil_config.json][winutil_config]

Contains my Chris Titus Tech Windows Utilities configurations.

### [config.jsonc][fastfetch_config]

Contains my FastFetch configurations.

Save it to `C:/ProgramData/fastfetch/`

### [WaleGeneral.conf][wale_general]

Contains my WaleAudioControl configurations.

Save it on `AppData\Roaming\WaleAudioControl\WaleGeneral.conf`

<!-- URLS -->

[README_self_development]: ../README.md
[README_indesign_scripts]: ../indesign_scripts/README.md
[README_macros]: ../macros/README.md
[README_config]: README.md
[README_python]: ../python/README.md
[README_ruby]: ../ruby/README.md
[README_tex]: ../tex/README.md
[waves_top]: https://raw.githubusercontent.com/v-amorim/v-amorim/main/svg/Top.svg

<!-- URLS -->

[bash]: ./bash/README.md
[mpv64]: ./mpv64/README.md
[oh-my-posh]: https://github.com/v-amorim/oh-my-posh
[wterminal]: ./wterminal/README.md
[yt-dlp]: ./yt-dlp/README.md
[winutil_config]: ./winutil_config.json
[fastfetch_config]: ./config.jsonc
[powershell]: ./powershell
[wale_general]: ./WaleGeneral.conf
