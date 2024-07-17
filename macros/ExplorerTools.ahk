$#T:: ; Win + T [Opens a new terminal in the current file explorer's folder]
    path := GetActiveExplorerPath()
    OpenNewTerminal(false, path)
return

$^#T:: ; Ctrl + Win + T [Opens a new terminal in the current file explorer's folder as Admin]
    path := GetActiveExplorerPath()
    OpenNewTerminal(true, path)
return

$#V:: ; Win + V [Opens the current file explorer's folder in VSCode]
    path := GetActiveExplorerPath()
    OpenNewVSCode(false, path)
return

$^#V:: ; Ctrl + Win + V [Opens the current file explorer's folder in VSCode as Admin]
    path := GetActiveExplorerPath()
    OpenNewVSCode(true, path)
Return

; Thanks to: https://stackoverflow.com/questions/72077329/how-do-i-add-a-keyboard-shortcut-to-open-vs-code-on-the-folder-from-file-explore
GetActiveExplorerPath()
{
    path := ""

    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (explorerHwnd)
    {
        for window in ComObjCreate("Shell.Application").Windows
        {
            if (window.hwnd==explorerHwnd)
            {
                path := window.Document.Folder.Self.Path
                Return path
            }
        }
    }
}

OpenNewTerminal(isAdmin := false, path := "") {
    if (isAdmin)
        Run *RunAs wt.exe -d "%path%"
    else
        Run, wt.exe -d "%path%"
}

OpenNewVSCode(isAdmin := false, path := ""){
    if (isAdmin)
        Run *RunAs "C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%path%"
    else
        Run, "C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%path%"
}
