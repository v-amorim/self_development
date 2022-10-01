; https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c

$#T::
    ToggleTerminal()
Return

$#V::
    Run C:\Users\Amorim\AppData\Local\Programs\Microsoft VS Code\Code.exe
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
            Send, {LButton}
        }

    } else {
        OpenNewTerminal()
    }
Return
}

OpenNewTerminal() {
    Run C:\Users\%A_UserName%\AppData\Local\Microsoft\WindowsApps\wt.exe
    Sleep, 500
    ShowTerminal()
Return
}

ShowTerminal() {
    WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS
Return
}

HideTerminal() {
    WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
Return
}
