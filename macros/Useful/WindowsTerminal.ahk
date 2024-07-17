$#T::ToggleTerminal() ; Win + T
$^#T::ToggleTerminal(true) ; Ctrl + Win + T

; Original Idea from: https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c
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

ShowTerminal() {
    WinShow, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}

HideTerminal() {
    WinActivateBottom, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    SendInput, !{Tab}
    WinHide, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}

OpenNewTerminal(isAdmin := false) {
    if (isAdmin)
        Run *RunAs wt.exe
    else
        Run, wt.exe
}
