# Self Development

[Home][README_self_development] | [Indesign Scripts][README_indesign_scripts] | [Macros][README_macros] | [Misc][README_misc] | [Python][README_python] | [Ruby][README_ruby] | [LaTeX][README_tex]

## Macros

The macros are written in AHK. The macros are written for various purposes such as automation, hotkeys, text shortcuts, and window management. The macros are written for Windows.

### [`./BlockKeyboardMouse.ahk`][BlockKeyboardMouse]

As the name suggests, this script blocks the keyboard and mouse. The script is useful when you want to clean the keyboard or mouse, or even for security reasons. It has two modes:

- Block Keyboard and Mouse
- Block Keyboard, Mouse and Screen

Also includes a macro to toggle auto locking based on the idle time.

### [`./Hotstrings.ahk`][Hotstrings]

Contains various hotstrings. It uses `env.ini` to store sensitive information as variables. Hotstrings usually are personal, but here are some useful ones:

- `>_`: Lists all the hotstrings in a message box
- `>code`: Pastes the selected text inside a markdown code block, it also moves the cursor back to the first `` quotes, can be slow if clipboard is large
- `(Ctrl +) Alt + C`: Surrounds the selected text with markdown code block quotes

### [`./LoadEnv.ahk`][LoadEnv]

Loads the environment variables from `env.ini` file.

### [`./Macros.ahk`][Macros]

The orquestration script that includes all the other scripts. It also includes some additional macros:

- Suspend/Reload the script
- Get the current mouse position and Hex color

### [`./Screenshot.ahk`][Screenshot]

Has two main usages:

- Prints the current monitor screen only (when multiple monitors are present)
- Sends the current clipboard printscreen to a desired folder

### [`./WinActive.ahk`][WinActive]

Various WinActive macros containing hotkeys and hotstrings that are useful to the particular window that is active.

### [`./WindowsTools.ahk`][WindowsTools]

Provides various tools that interact with Windows as such:

- Modify the Volume
- Modify the Window's Transparency
- Open VSCode with(out) Admin permissions, in two modes:
  - New empty Window
  - New current directory Window, when focused on File Explorer
- Open Windows Terminal with(out) Admin permissions, in two modes:
  - New empty Window
  - New current directory Window, when focused on File Explorer

### Useful

We don't talk about the useful scripts, but they are useful.

## Terminal

Terminal shortcuts are useful for quick access to various commands. The aliases are written for Windows.

### [`./alias.bat`][alias]

Contains various aliases that are useful for the command prompt (CMD).

To add to Windows Terminal, add a `/k path/to/alias.bat` to the end of the `commandline` property on the [Settings>Profiles>Command Prompt] (Ctrl+,) page.

### [`./Profile.ps1`][Profile]

Contains various aliases that are useful for the PowerShell.

You can add it to your PowerShell profile by running the following command, in an elevated (Administrator) PowerShell:

```powershell
irm "https://raw.githubusercontent.com/v-amorim/self_development/main/macros/Terminal/PowershellSetup.ps1" | iex
```

If it didn't work, run the `Profile.bat` and copy the `Profile.ps1` to the folder it opens.

<!-- URLS -->

[README_self_development]: ../README.md
[README_indesign_scripts]: ../indesign_scripts/README.md
[README_macros]: README.md
[README_misc]: ../misc/README.md
[README_python]: ../python/README.md
[README_ruby]: ../ruby/README.md
[README_tex]: ../tex/README.md

<!-- URLS -->

[BlockKeyboardMouse]: ./BlockKeyboardMouse.ahk
[Hotstrings]: ./Hotstrings.ahk
[LoadEnv]: ./LoadEnv.ahk
[Macros]: ./Macros.ahk
[Screenshot]: ./Screenshot.ahk
[WinActive]: ./WinActive.ahk
[WindowsTools]: ./WindowsTools.ahk
[alias]: ./alias.bat
[Profile]: ./Profile.ps1
