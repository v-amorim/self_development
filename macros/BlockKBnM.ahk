; https://www.autohotkey.com/boards/viewtopic.php?t=33925
#SingleInstance force

;lockKeyboard_arg .... Disable/enable keyboard [true/false]
;mouse=1 ............. Disable all mouse buttons
;mouse=2 ............. Disable right mouse button only
;message_arg ......... Display a message
;timeout_arg ......... How long to display the message in sec
;displayOnce_arg ..... Display a message only once or always [true/false]
;hideScreen_arg ...... Hide or show everything [true/false]
;screenColor_arg ..... RGB Hex background color for the hiding GUI 

#XButton2::
!F1::
    lockKeyboard:= true
    hideScreen:= false
    displayOnce:= false
    lockMouseMode:= 1
    message:= "Keyboard & Mouse`nLocked"
    Lock(lockKeyboard, hideScreen, displayOnce, lockMouseMode, message) ; Disable all keyboard keys and mouse buttons
Return

#XButton1::
!F2::
    lockKeyboard:= false
    hideScreen:= false
    displayOnce:= false
    lockMouseMode:= 0
    message:= "Keyboard & Mouse`nUnlocked"
    Lock(lockKeyboard, hideScreen, displayOnce, lockMouseMode, message) ; Enable all keyboard keys and mouse buttons
Return

!F3::
    lockKeyboard:= true
    hideScreen:= true
    displayOnce:= false
    lockMouseMode:= 1
    message:= "Keyboard, Mouse & Screen`nLocked`n!F1 to Unlock"
    Lock(lockKeyboard, hideScreen, displayOnce, lockMouseMode, message) ; Disable keyboard mouse and screen
Return

Lock(lockKeyboard_arg:=false, hideScreen_arg:=false, displayOnce_arg:=false, mouse:=0, message_arg:="", timeout_arg:=0.5, screenColor_arg:="black") { 
    static AllKeys, message_var, displayOnce_var, lockKeyboard_var, lockMouse_var, hideScreen_var
    message_var:= message_arg
    displayOnce_var:= displayOnce_arg
    lockKeyboard_var:= lockKeyboard_arg
    lockMouse_var:= mouse
    hideScreen_var:= hideScreen_arg
    numberOfKeys:= 254

    For key,value in AllKeys {
        Hotkey, *%value%, Block_Input, off ; initialisation
    }
    if !AllKeys {
        functionKeys := "||NumpadEnter|Home|End|PgUp|PgDn|Left|Right|Up|Down|Del|Ins|"
        Loop, %numberOfKeys%
            key := GetKeyName(Format("VK{:0X}", A_Index))
        , functionKeys .= InStr(functionKeys, "|" key "|") ? "" : key "|"
        For key, value in {Control:"Ctrl", Escape:"Esc"}
            AllKeys := StrReplace(functionKeys, key, value)
        AllKeys := StrSplit(Trim(AllKeys, "|"), "|")
    }
    ;------------------
    if (mouse != 2) ; if mouse=1 disable right and left mouse buttons  if mouse=0 don't disable mouse buttons
    {
        For key, value in AllKeys {
            IsMouseButton := Instr(value, "Wheel") || Instr(value, "Button")
            Hotkey, *%value%, Block_Input, % (lockKeyboard_arg && !IsMouseButton) || (mouse && IsMouseButton) ? "On" : "Off"
        }
    }
    if (mouse = 2) ;disable right mouse button only
    { 
        ExcludeKeys:= "LButton"
        For key, value in AllKeys {
            IsMouseButton := Instr(value, "Wheel") || Instr(value, "Button")
            if value not in %ExcludeKeys%
                Hotkey, *%value%, Block_Input, % (lockKeyboard_arg && !IsMouseButton) || (mouse && IsMouseButton) ? "On" : "Off"
        }
    }
    ;------------------
    if displayOnce_var
    {
        if (message_var != "") {
            Progress, +AlwaysOnTop b1 zh0 fm14,, %message_var%
            SetTimer, TimeoutTimer, % -timeout_arg*1000
        }
        else
            Progress, Off
    }
Block_Input:
    if (displayOnce_var != 1)
    {
        if (message_var != "") {
            if (lockKeyboard_var || lockMouse_var)
                Progress, b1 zh0 fm14,, %message_var%
            else
                Progress, b1 zh0 fm14,, %message_var%
            SetTimer, TimeoutTimer, % -timeout_arg*1000
        }
        else
            Progress, Off
    }
    ;------------------
    if (hideScreen_var = 1)
    { 
        Gui screen: -Caption
        Gui screen: Color, % screenColor_arg
        Gui screen: Show, x0 y0 h74 w%a_screenwidth% h%a_screenheight%, New GUI Window
    }
    else
        gui screen: Hide

Return
TimeoutTimer:
    Progress, Off
Return
}