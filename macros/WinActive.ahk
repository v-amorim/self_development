#IfWinActive ahk_exe Illustrator.exe
    XButton1::
        Send, {F3}
    Return

    XButton2::
        Send, !^{Numpad0}
        Sleep, 100
        Send, ^{Tab}
    Return
#IfWinActive

#IfWinActive ahk_exe inDesign.exe
    WheelUp::
        BlockInput, On
        SendInput !{PGUP}
        BlockInput, Off
    Return

    WheelDown::
        BlockInput, On
        SendInput !{PGDN}
        BlockInput, Off
    Return

    !+WheelDown::AutoLeftClicks()

    !+WheelUp::AutoLeftClicks()
#IfWinActive

#IfWinActive ahk_exe Photoshop.exe
    XButton1::
        Send, {F10}
    Return

    XButton2::
        Send, {u}
    Return

    MButton::
        Send, ^{0}
        Sleep, 333
        Send, ^{Tab}
    Return
#IfWinActive

#IfWinActive ahk_exe Warframe.x64.exe
    ^Numpad1::
        Sendinput, {Text}%email_tg%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Sendinput, {Text}%password_wf_tg%
    Return

    ^Numpad2::
        Sendinput, {Text}%email_vd%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Send, {Text}%password_wf_vd%
    Return

    ^Numpad3::
        Sendinput, {Text}%email_gcc%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Sendinput, {Text}%password_wf_gcc%
    Return

    XButton1::
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

    !XButton1::
        Send, {Ctrl down}
        Sleep, 1
        Send, {Wheelup down}
        Sleep, 1
        Send, {Ctrl up}
        Sleep 300
    Return

    !XButton2::
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
#IfWinActive

#IfWinActive ahk_exe RiotClientUx.exe
    ^Numpad1::
        Sendinput, {Text}%username_px_riot%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Send, {Text}%password_px_riot%
    Return

    ^Numpad2::
        Sendinput, {Text}%username_mz_riot%
        Sleep, 100
        Send {Tab}
        Sleep, 50
        Send, {Text}%password_mz_riot%
    Return
#IfWinActive

#IfWinActive ahk_exe Diablo III64.exe
    ^!LButton::
        Send, {LButton}{Enter}
    Return

    ^WheelDown::AutoRightClicks()

    ^WheelUp::AutoRightClicks()
#IfWinActive

#IfWinActive ahk_exe PathOfExile.exe
    ^Numpad1::
        Sendinput, {Text}%password_poe%
    Return

    MButton::
        Send, {LButton}{Enter}
    Return

    ; $!S::POTSpam() ; Alt+S for 5 times will press 3,4,5 in fast seqvence 
    $XButton1::POTSpam() ; Xbutton1 for 5 times will press 3,4,5 in fast seqvence 

    !WheelUp::Send {Left} ; ALT+WheelUp: Stash scroll
    ^WheelUp::AutoLeftClicks() ; CTRL+WheelDown -> Spam CTRL+CLICK
    +WheelUp::AutoLeftClicks() ; SHIFT+WheelDown -> Spam SHIFT+CLICK   

    !WheelDown::Send {Right} ; ALT+WheelDown: Stash scroll
    ^WheelDown::AutoLeftClicks() ; CTRL+WheelDown -> Spam CTRL+CLICK
    +WheelDown::AutoLeftClicks() ; SHIFT+WheelDown -> Spam SHIFT+CLICK   
#IfWinActive

AutoLeftClicks(){
    BlockInput On 
    Send {Blind}{LButton down}{LButton up} 
    BlockInput Off
}

AutoRightClicks(){
    BlockInput On 
    Send {Blind}{RButton down}{RButton up} 
    BlockInput Off
}

POTSpam(){
    BlockInput On
    global Flask
    Send %Flask%
    Flask += 1
    BlockInput Off
    If Flask > 5
        Flask = 3
    return
}

; ^ Ctrl
; ! Alt
; + Shift
; # Win
