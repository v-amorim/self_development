; https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c

$#T:: ToggleTerminal()
$#V:: RunVSCode()

RunVSCode(){
    Run C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe
}

ToggleTerminal() {
    matcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
    DetectHiddenWindows, On
    if WinExist(matcher) {
        if !WinActive(matcher) {
            ShowTerminal()
        } else if WinExist(matcher) {
            HideTerminal()
        }
    } else {
        OpenNewTerminal()
    }
}

OpenNewTerminal() {
    Run *RunAs wt.exe
    Sleep, 500
    ShowTerminal()
}

ShowTerminal() {
    WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}

HideTerminal() {
    WinActivateBottom, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    SendInput, !{Tab}
    WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}
