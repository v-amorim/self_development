#MaxHotkeysPerInterval 200
Menu, Tray, Icon, Logo.ico

#Include Gdip.ahk

#Include LoadEnv.ahk
#Include Hotstrings.ahk
#Include WinActive.ahk
#Include WindowsTools.ahk
#Include Screenshot.ahk
#Include BlockKeyboardMouse.ahk

global awakened_poe_trade_path, poe_lurker_path, path_of_building_path

$^+!P:: RunPoEDependencies() ; Ctrl + Shift + Alt + P [Runs necessary Path of Exile (PoE) related applications]
$!O:: GetMousePosition() ; Alt + O [Gets the current mouse position and color]

+#F12:: ; Shift + Win + F12 [Reloads the script]
    Reload
    SoundBeep, 100, 500
Return

$#F12:: ; Win + F12 [Suspends the script]
    Suspend
    SoundBeep, 750, 500
Return

; Runs necessary Path of Exile (PoE) related applications.
RunPoEDependencies(){
    Run, %awakened_poe_trade_path%
    Run, %poe_lurker_path%
    Run, %path_of_building_path%
    Return
}

; Gets the current mouse position and color.
GetMousePosition(){
    MouseGetPos, xpos, ypos
    PixelGetColor, xycolor , xpos, ypos
    msgbox, X=%xpos% Y=%ypos% XYColor=%xycolor%
    Return
}

; ^ Ctrl
; ! Alt
; + Shift
; # Win
