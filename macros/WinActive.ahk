#IfWinActive ahk_exe Illustrator.exe
    $XButton1::
        SendInput, {F3}
    Return

    $XButton2::
        SendInput, !^{Numpad0}
        Sleep, 100
        SendInput, ^{Tab}
    Return
#IfWinActive

#IfWinActive ahk_exe inDesign.exe
    $WheelUp::
        BlockInput, On
        SendInput !{PGUP}
        BlockInput, Off
    Return

    $WheelDown::
        BlockInput, On
        SendInput !{PGDN}
        BlockInput, Off
    Return

    $!+WheelDown::SpamLeftClicks()

    $!+WheelUp::SpamLeftClicks()
#IfWinActive

#IfWinActive ahk_exe Photoshop.exe
    $XButton1::
        SendInput, {F10}
    Return

    $XButton2::
        SendInput, {u}
    Return

    $MButton::
        SendInput, ^{0}
        Sleep, 333
        SendInput, ^{Tab}
    Return

    $+WheelUp::
        BlockInput On
        SendInput, {LControl down}{Tab}{LControl up}
        BlockInput Off
    Return

    $+WheelDown::
        BlockInput On
        SendInput, {LControl down}{LShift down}{Tab}{LControl up}{LShift up}
        BlockInput Off
    Return
#IfWinActive

#IfWinActive ahk_exe Warframe.x64.exe
    $^Numpad1::
        Sendinput, {Text}%email_tg%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        Sendinput, {Text}%password_wf_tg%
    Return

    $^Numpad2::
        Sendinput, {Text}%email_vd%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%password_wf_vd%
    Return

    $^Numpad3::
        Sendinput, {Text}%email_gcc%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        Sendinput, {Text}%password_wf_gcc%
    Return

    $XButton1::
        SendInput, {Ctrl down}
        Sleep, 1
        SendInput, {Space down}
        Sleep, 1
        SendInput, {Space up}
        SendInput, {Ctrl up}
        Sleep, 100
        ; Roll after Bullet Jump
        SendInput, {Shift down}
        Sleep, 1
        SendInput, {Space down}
        Sleep, 1
        SendInput, {Space up}
        SendInput, {Shift up}
        Sleep 400
    Return

    $!XButton1::
        SendInput, {Ctrl down}
        Sleep, 1
        SendInput, {Wheelup down}
        Sleep, 1
        SendInput, {Ctrl up}
        Sleep 300
    Return

    $!XButton2::
        SendInput, 5
        Sleep, 200
        SendInput, {Ctrl Down}
        Sleep, 200
        SendInput, {Space}
        Sleep, 200
        SendInput, {Ctrl Up}
        Sleep, 200
        SendInput, 5
    Return
#IfWinActive

#IfWinActive ahk_exe RiotClientUx.exe
    $^Numpad1::
        Sendinput, {Text}%username_px_riot%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%password_px_riot%
    Return

    $^Numpad2::
        Sendinput, {Text}%username_mz_riot%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%password_mz_riot%
    Return
#IfWinActive

#IfWinActive ahk_exe Diablo III64.exe
    $^!LButton::EnterClick() ; Bind function to Ctrl+Alt+LButton hotkey

    ^LButton::SpamClick("LButton") ; Bind function to Ctrl+LButton hotkey

    ^RButton::SpamClick("RButton") ; Bind function to Ctrl+RButton hotkey

    ^XButton2:: UrshiEnchant() ; Bind function to Ctrl+XButton2 hotkey

    !XButton2:: SpeedEnchant() ; Bind function to Alt+XButton2 hotkey

    $^WheelDown::SpamRightClicks() ; Bind function to Ctrl+WheelDown hotkey

    $^WheelUp::SpamRightClicks() ; Bind function to Ctrl+WheelUp hotkey
#IfWinActive

#IfWinActive ahk_exe PathOfExile.exe ; https://github.com/nidark/Poe-Companion/blob/master/PoeCompanion.ahk
    $^Numpad1::
        Sendinput, {Text}%password_poe%
    Return

    $+F11::
        SendInput, {LButton}{Enter}
    Return

    $MButton::GoHome()

    $XButton1::SpamPots()

    $!WheelUp::SendInput, {Left}
    $^WheelUp::SpamLeftClicks()
    $+WheelUp::SpamLeftClicks()

    $!WheelDown::SendInput, {Right}
    $^WheelDown::SpamLeftClicks()
    $+WheelDown::SpamLeftClicks()
#IfWinActive

#IfWinActive ahk_exe opera.exe
    SetKeyDelay, 50 ; Set a delay of 50 milliseconds between each keystroke

    $!WheelUp::
        BlockInput, On
        SendInput, {LControl down}{LShift down}{Tab}{LControl up}{LShift up}
        BlockInput, Off
    return

    $!WheelDown::
        BlockInput, On
        SendInput, {LControl down}{Tab}{LControl up}
        BlockInput, Off
    return

    ~$Alt:: ; Disable Alt
        BlockInput, On
        KeyWait, Alt
        BlockInput, Off
    return
#IfWinActive

#IfWinActive ahk_exe Code.exe
    SetKeyDelay, 50 ; Set a delay of 50 milliseconds between each keystroke
    $!WheelUp:: ; Cicle Up a tab
        BlockInput, On
        SendInput, {LControl down}{LShift down}{Tab}{LControl up}{LShift up}
        BlockInput, Off
    Return

    $!WheelDown:: ; Cicle Down a tab
        BlockInput, On
        SendInput, {LControl down}{Tab}{LControl up}
        BlockInput, Off
    Return

    ~$Alt:: ; Disable Alt
        BlockInput, On
        KeyWait, Alt
        BlockInput, Off
    Return
#IfWinActive

; Function to spam Left clicks
SpamLeftClicks(){
    BlockInput On
    SendInput, {Blind}{LButton down}{LButton up}
    BlockInput Off
}

; Function to spam right clicks
SpamRightClicks(){
    BlockInput On
    SendInput, {Blind}{RButton down}{RButton up}
    BlockInput Off
}

; Function to press LButton and Enter
EnterClick(){
    SendInput, {LButton}{Enter}
}

; Function to spam the key while holding
SpamClick(key) {
    while (GetKeyState(key, "P")) {
        if (key = "LButton") {
            MouseClick, Left
        } else if (key = "RButton") {
            MouseClick, Right
        } else {
            return ; Exit function if invalid key is provided
        }
    }
}

; Function to enchant on Mystic faster
SpeedEnchant() {
    MouseGetPos, PosX, PosY ; Save current mouse position
    MouseMove, 265, 785, 0 ; Move mouse to the Enchant button location
    Sleep, 50
    MouseClick, Left
    MouseMove, %PosX%, %PosY% ; Move mouse back to the original position
}

; Function to perform the Urshi Enchants
UrshiEnchant() {
    EnchantLoop(2) ; Perform two enchant loops for the first two enchants
    Sleep, 50
    SendInput, {T} ; Start returning to town
    EnchantLoop(3) ; Perform three enchant loops for the last three enchants
    MouseMove, 900, 500 ; Move mouse to the middle of the screen
}

; Helper function to perform a single Enchant loop
EnchantLoop(n) {
    Loop, %n% {
        MouseMove, 270, 545, 0 ; Move mouse to the enchant button location
        MouseClick, Left
        Sleep 1550
    }
}

; Function to spam pots one at the time
SpamPots(){
    BlockInput On

    global Flask
    SendInput, %Flask%
    Flask += 1

    BlockInput Off

    If Flask > 5
        Flask = 3
    Return
}

; Function to open a Portal Scroll
GoHome(){
    BlockInput On

    RandomSleep(110, 220)

    MouseGetPos xx, yy
    SendInput, {'}
    RandomSleep(50, 70)

    MouseMove, 1871, 820, 0
    RandomSleep(50, 150)

    Click Right
    RandomSleep(50, 150)

    SendInput, {'}
    MouseMove, xx, yy, 0

    BlockInput Off
    Return
}

; Function to generate a random number between min and max
RandomSleep(min, max){
    Random, r, %min%, %max%
    r:=floor(r/Speed)
    Sleep %r%
    Return
}
; ^ Ctrl
; ! Alt
; + Shift
; # Win
