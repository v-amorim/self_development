#IfWinActive ahk_exe Illustrator.exe
    $XButton1:: ; XButton1
        SendInput, {F3}
    Return

    $XButton2:: ; XButton2
        SendInput, !^{Numpad0}
        Sleep, 100
        SendInput, ^{Tab}
    Return
#IfWinActive

#IfWinActive ahk_exe inDesign.exe
    $WheelUp:: ; WheelUp
        BlockInput, On
        SendInput !{PGUP}
        BlockInput, Off
    Return

    $WheelDown:: ; WheelDown
        BlockInput, On
        SendInput !{PGDN}
        BlockInput, Off
    Return

    $!+WheelDown::SpamLeftClicks() ; Alt + Shift + WheelDown

    $!+WheelUp::SpamLeftClicks() ; Alt + Shift + WheelUp
#IfWinActive

#IfWinActive ahk_exe Photoshop.exe
    $XButton1:: ; XButton1
        SendInput, {F10}
    Return

    $XButton2:: ; XButton2
        SendInput, {u}
    Return

    $MButton:: ; Middle mouse button
        SendInput, ^{0}
        Sleep, 333
        SendInput, ^{Tab}
    Return

    $+WheelUp:: ; Shift + WheelUp
        BlockInput On
        SendInput, {LControl down}{Tab}{LControl up}
        BlockInput Off
    Return

    $+WheelDown:: ; Shift + WheelDown
        BlockInput On
        SendInput, {LControl down}{LShift down}{Tab}{LControl up}{LShift up}
        BlockInput Off
    Return
#IfWinActive

#IfWinActive ahk_exe Warframe.x64.exe
    $^Numpad1:: ; Ctrl + Numpad1
        Sendinput, {Text}%email_tg%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        Sendinput, {Text}%pass_wf_tg%
    Return

    $^Numpad2:: ; Ctrl + Numpad2
        Sendinput, {Text}%email_vd%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_wf_vd%
    Return

    $^Numpad3:: ; Ctrl + Numpad3
        Sendinput, {Text}%email_gcc%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        Sendinput, {Text}%pass_wf_gcc%
    Return

    $XButton1:: ; XButton1
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

    $!XButton1:: ; Alt + XButton1
        SendInput, {Ctrl down}
        Sleep, 1
        SendInput, {Wheelup down}
        Sleep, 1
        SendInput, {Ctrl up}
        Sleep 300
    Return

    $!XButton2:: ; Alt + XButton2
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

#If (WinActive("ahk_exe RiotClientUx.exe") || WinActive("ahk_exe Riot Client.exe"))
    $^Numpad1:: ; Ctrl + Numpad1
        Sendinput, {Text}%user_riot_px%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_riot_px%
    Return

    $^Numpad2:: ; Ctrl + Numpad2
        Sendinput, {Text}%user_riot_mz%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_riot_mz%
    Return

    $^Numpad3:: ; Ctrl + Numpad3
        Sendinput, {Text}%user_riot_lmz%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_riot_lmz%
    Return

    $^Numpad4:: ; Ctrl + Numpad4
        Sendinput, {Text}%user_riot_4g%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_riot_4g%
    Return

    $^Numpad5:: ; Ctrl + Numpad5
        Sendinput, {Text}%user_riot_kt4%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_riot_kt4%
    Return
#IfWinActive

; #IfWinActive ahk_exe League of Legends.exe
;     $+c:: ; Toggle C (to show range indicators)
;         If GetKeyState("c")
;             Send {c Up}
;         Else
;             Send {c Down}
;     Return
; #IfWinActive

#IfWinActive ahk_exe Diablo III64.exe
    $^!LButton::EnterClick() ; Ctrl+Alt+LButton hotkey

    ^LButton::SpamClick("LButton") ; Ctrl+LButton hotkey

    ^RButton::SpamClick("RButton") ; Ctrl+RButton hotkey

    ^XButton2:: UrshiEnchant() ; Ctrl+XButton2 hotkey

    ^XButton1:: SpeedEnchant() ; Ctrl+XButton1 hotkey

    $^WheelDown::SpamRightClicks() ; Ctrl+WheelDown hotkey

    $^WheelUp::SpamRightClicks() ; Ctrl+WheelUp hotkey
#IfWinActive

#IfWinActive ahk_exe PathOfExile.exe ; Some stuff were adapted from: https://github.com/nidark/Poe-Companion/blob/master/PoeCompanion.ahk
    $^Numpad1:: ; Ctrl + Numpad1
        Sendinput, {Text}%pass_poe_va%
    Return

    $^Numpad4:: ; Ctrl + Shift + Numpad1
        Sendinput, {Text}%email_va%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_poe_va%
    Return

    $^Numpad2:: ; Ctrl + Numpad2
        Sendinput, {Text}%pass_poe_gcc%
    Return

    $^Numpad5:: ; Ctrl + Shift + Numpad2
        Sendinput, {Text}%email_gcc%
        Sleep, 100
        SendInput, {Tab}
        Sleep, 50
        SendInput, {Text}%pass_poe_gcc%
    Return

    $+F11:: ; Shift + F11 ("DPI UP" button)
        SendInput, {LButton}{Enter}
    Return

    ; $MButton::GoHome() ; Middle mouse button
    ; $XButton1::GoHome() ; XButton1

    ; $XButton1::SpamPots() ; XButton1
    $!W::Send, {W down} ; Alt + W

    $!WheelUp::SendInput, {Left} ; Alt + WheelUp
    $^WheelUp::SpamLeftClicks() ; Ctrl + WheelUp
    $+WheelUp::SpamLeftClicks() ; Shift + WheelUp

    $!WheelDown::SendInput, {Right} ; Alt + WheelDown
    $^WheelDown::SpamLeftClicks() ; Ctrl + WheelDown
    $+WheelDown::SpamLeftClicks() ; Shift + WheelDown
#IfWinActive

#IfWinActive ahk_exe dotnet.exe ; TModLoader
    #^LButton::SpamClick("LButton") ; Win + Ctrl + LButton [Spam Left Clicks]
    #+LButton::SpamClick("LButton") ; Win + Shift + LButton [Spam Left Clicks]
    #!LButton::SpamClick("LButton") ; Win + Alt + LButton [Spam Left Clicks]

    ^RButton::SpamClick("RButton") ; Ctrl + RButton [Spam Right Clicks]
#IfWinActive

#If (WinActive("ahk_exe opera.exe") || WinActive("ahk_exe chrome.exe"))
    SetKeyDelay, 50 ; Set a delay of 50 milliseconds between each keystroke

    $!WheelUp:: ; Ctrl + WheelUp [Cicle Up a tab]
        BlockInput, On
        SendInput, {LControl down}{LShift down}{Tab}{LControl up}{LShift up}
        BlockInput, Off
    Return

    $!WheelDown:: ; Ctrl + WheelDown [Cicle Down a tab]
        BlockInput, On
        SendInput, {LControl down}{Tab}{LControl up}
        BlockInput, Off
    Return

    $+WheelUp:: ; Shift + WheelUp [Add +1, for numeric input fields]
        BlockInput, On
        SendInput, {Up}
        BlockInput, Off
    Return

    $+WheelDown:: ; Shift + WheelDown [Subtract -1, for numeric input fields]
        BlockInput, On
        SendInput, {Down}
        BlockInput, Off
    Return

    ~$Alt:: ; Disable Alt
        BlockInput, On
        KeyWait, Alt
        BlockInput, Off
    Return
#IfWinActive

#IfWinActive ahk_exe Code.exe
    SetKeyDelay, 50 ; Set a delay of 50 milliseconds between each keystroke
    $!WheelUp:: ; Alt + WheelUp [Cicle Up a tab]
        BlockInput, On
        SendInput, {LControl down}{LShift down}{Tab}{LControl up}{LShift up}
        BlockInput, Off
    Return

    $!WheelDown:: ; Alt + WheelDown [Cicle Down a tab]
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

#IfWinActive ahk_exe explorer.exe
    #x:: ; Win + X [Toggle file extensions]
        ToggleExplorerSetting("HideFileExt", 1, 0)
    Return

    #h:: ; Win + H [Toggle hidden files]
        ToggleExplorerSetting("Hidden", 2, 1)
    Return

    ToggleExplorerSetting(regValue, offValue, onValue) {
        explorerRegPath := "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        explorerEhClass := "CabinetWClass"

        RegRead, currentValue, %explorerRegPath%, %regValue% ; Read current setting

        If (currentValue = offValue) {
            RegWrite, REG_DWORD, %explorerRegPath%, %regValue%, %onValue% ; Toggle on
        } Else {
            RegWrite, REG_DWORD, %explorerRegPath%, %regValue%, %offValue% ; Toggle off
        }

        WinGetClass, eh_Class, A
        If (eh_Class = explorerEhClass)
            Send, {F5}
        Else
            PostMessage, 0x111, 28931, 0 , A
    }
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
            Return ; Exit function if invalid key is provided
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
        Sleep 1500
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
