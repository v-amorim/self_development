; https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c

$#T::ToggleTerminal()
$#V::RunVSCode()
$^#T::ToggleTerminal(true)
$^#V::RunVSCode(true)

RunVSCode(isAdmin := false){
    if (isAdmin)
        Run *RunAs C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe
    else
        Run, C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe
}


ToggleTerminal(isAdmin := false) {
    matcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
    DetectHiddenWindows, On
    if (WinExist(matcher)) {
        if (!WinActive(matcher)) {
            ShowTerminal()
        } else if (WinExist(matcher)) {
            HideTerminal()
        }
    } else {
        OpenNewTerminal(isAdmin)
    }
}

OpenNewTerminal(isAdmin := false) {
    if (isAdmin)
        Run *RunAs wt.exe
    else
        Run, wt.exe
    Sleep, 500
    ShowTerminal()
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
