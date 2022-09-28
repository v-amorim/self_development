#T::
    ToggleTerminal()
Return

ToggleTerminal() {
    matcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
    DetectHiddenWindows, On
    if WinExist(matcher) {

        if !WinActive(matcher) {
            ; Hide it first to alow raising it later on a different workspace
            HideTerminal()
            ShowTerminal()
        } else if WinExist(matcher) {
            HideTerminal()
        }

    } else {
        OpenNewTerminal()
    }
}

OpenNewTerminal() {
    Run C:\Users\%A_UserName%\AppData\Local\Microsoft\WindowsApps\wt.exe
    Sleep, 500
    ShowTerminal()
}

ShowTerminal() {
    WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}

HideTerminal() {
    WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}