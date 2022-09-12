; #IfWinActive, ahk_exe Warframe.x64.exe
#Include Gdip.ahk
env := A_ScriptDir "\env.ini"
IniRead, email_va, %env%, Login, email_va
IniRead, email_vd, %env%, Login, email_vd
IniRead, email_tg, %env%, Login, email_tg
IniRead, password_wf_tg, %env%, Login, password_wf_tg
IniRead, password_wf_vd, %env%, Login, password_wf_vd
IniRead, password_wf_gcc, %env%, Login, password_wf_gcc
IniRead, username_px_riot, %env%, Login, username_px_riot
IniRead, password_px_riot, %env%, Login, password_px_riot
IniRead, username_mz_riot, %env%, Login, username_mz_riot
IniRead, password_mz_riot, %env%, Login, password_mz_riot
IniRead, wt_path, %env%, Path, wt_path
IniRead, name, %env%, Info, name
IniRead, ra, %env%, Info, ra
IniRead, email, %env%, Info, email
IniRead, course, %env%, Info, course
IniRead, period, %env%, Info, period
IniRead, campus, %env%, Info, campus
IniRead, university, %env%, Info, university
IniRead, telephone, %env%, Info, telephone

_auto := true
F12::
    Suspend
    SoundBeep, 750, 500
Return

#T::
#Enter::
    ToggleTerminal()

^Numpad1::
    ; First Login
    If WinActive("ahk_exe Warframe.x64.exe"){
        Sendinput, {Text}%email_tg%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Sendinput, {Text}%password_wf_tg%
        Return
    }If WinActive("ahk_exe RiotClientUx.exe"){
        Sendinput, {Text}%username_px_riot%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Send, {Text}%password_px_riot%
        Return
    }Else{
        Send, {^Numpad1}
        Return
    }

^Numpad2::
    ; Second Login 
    If WinActive("ahk_exe Warframe.x64.exe"){
        Sendinput, {Text}%email_vd%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Send, {Text}%password_wf_vd%
        Return
    }If WinActive("ahk_exe RiotClientUx.exe"){
        Sendinput, {Text}%username_mz_riot%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Send, {Text}%password_mz_riot%
        Return
    }Else{
        Send, {^Numpad2}
        Return
    }

^Numpad3::
    ; Love Login
    If WinActive("ahk_exe Warframe.x64.exe"){
        Sendinput, {Text}%email_gcc%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Sendinput, {Text}%password_wf_gcc%
        Return
    }Else{
        Send, {^Numpad3}
        Return
    }

XButton1::
    ; Bullet Jump + Roll
    If WinActive("ahk_exe Warframe.x64.exe"){
        ; Bullet Jump
        Send, {Ctrl down}
        Sleep, 1
        Send, {Space down}
        Sleep, 1
        Send, {Space up}
        Send, {Ctrl up}
        Sleep, 100
        ; Roll after Bullet Jump
        Send, {Shift down}
        Sleep, 1
        Send, {Space down}
        Sleep, 1
        Send, {Space up}
        Send, {Shift up}
        Sleep 400
        Return
    }Else If WinActive("ahk_exe Illustrator.exe"){
        Send, {F3}
        Return
    }Else If WinActive("ahk_exe Photoshop.exe"){
        Send, {F10}
        Return
    }Else{
        Send, {XButton1}
        Return
    }

!XButton1::
    ; Slide + Sword
    If WinActive("ahk_exe Warframe.x64.exe"){
        Send, {Ctrl down}
        Sleep, 1
        Send, {Wheelup down}
        Sleep, 1
        Send, {Ctrl up}
        Sleep 300
        Return
    }Else{
        Send, {!XButton1}
        Return
    }

XButton2::
    If WinActive("ahk_exe Illustrator.exe"){
        Send, !^{Numpad0}
        Sleep, 100
        Send, ^{Tab}
        Return
    }Else If WinActive("ahk_exe Photoshop.exe"){
        Send, {u}
        Return
    }Else{
        Send, {XButton2}
        Return
    }

!XButton2::
    ; Void Dash
    If WinActive("ahk_exe Warframe.x64.exe"){
        Send, 5
        Sleep, 200
        Send, {Ctrl Down}
        Sleep, 200
        Send, {Space}
        Sleep, 200
        Send {Ctrl Up}
        Sleep, 200
        Send, 5
        Return
    }Else{
        Send, {!XButton2}
        Return
    }

WheelUp::
    If WinActive("ahk_exe inDesign.exe"){
        BlockInput, On
        SendInput !{PGUP}
        BlockInput, Off
        Return
    }Else{
        Send, {WheelUp}
        Return
    }

WheelDown::
    If WinActive("ahk_exe inDesign.exe"){
        BlockInput, On
        SendInput !{PGDN}
        BlockInput, Off
        Return
    }Else{
        Send, {WheelDown}
        Return
    }

MButton::
    If WinActive("ahk_exe Photoshop.exe"){
        Send, ^{0}
        Sleep, 333
        Send, ^{Tab}
        Return
    }Else{
        Send, {MButton}
        Return
    }

^Printscreen::
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec

    Screenshot("C:\Users\Amorim\Pictures\AHK Screenshots\" CurrentDate "_" CurrentTime ".png")
Return

Screenshot(OutFile)
{
    pToken := Gdip_Startup()

    screen=0|0|%A_ScreenWidth%|%A_ScreenHeight%
    pBitmap := Gdip_BitmapFromScreen(screen)
    Gdip_SetBitmapToClipboard(pBitmap)
    Gdip_SaveBitmapToFile(pBitmap, OutFile, 100)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
}

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
    Run %wt_path%
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

; Hotstring
:*:>vd::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_vd%
Return

:*:>va::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_va%
Return

:*:>tg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_tg%
Return

:oc?*:>bot::bot com LilithMz
:oc?*:>top::top com LilithMz

:*:>name::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%name%
Return

:*:>ra::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%ra%
Return

:*:>email::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email%
Return

:*:>course::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%course%
Return

:*:>period::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%period%
Return

:*:>campus::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%campus%
Return

:*:>uni::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%university%
Return

:*:>tel::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%telephone%
Return
