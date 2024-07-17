$^#T::ToggleTerminal(true) ; Ctrl + Win + T
$^#V::OpenNewVSCode(true) ; Ctrl + Win + V

$#T:: ; Win + T
    path := GetActiveExplorerPath()
    OpenNewTerminal(false, path)
return

$#V:: ; Win + V [Opens the current file explorer's folder in VSCode]
    path := GetActiveExplorerPath()
    OpenNewVSCode(false, path)
return

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
                return path
            }
        }
    }
}

; Original Idea from: https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c
ToggleTerminal(isAdmin := false, path := "") {
    matcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
    DetectHiddenWindows, On
    if (WinExist(matcher)) {
        if (!WinActive(matcher)) {
            ShowTerminal()
        } else if (WinExist(matcher)) {
            HideTerminal()
        }
    } else {
        OpenNewTerminal(isAdmin, path)
    }
}

ShowTerminal() {
    WinShow, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}

HideTerminal() {
    WinActivateBottom, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    SendInput, !{Tab}
    WinHide, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
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
