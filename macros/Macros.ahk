#MaxHotkeysPerInterval 200
Menu, Tray, Icon, Logo.ico

#Include Gdip.ahk
#Include Hotstrings.ahk
#Include WinActive.ahk
#Include ExplorerTools.ahk
#Include Screenshot.ahk
#Include BlockKBnM.ahk
#Include VolumeControl.ahk

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
    Run C:\Users\%A_UserName%\AppData\Local\Programs\Awakened PoE Trade\Awakened PoE Trade.exe
    Run C:\Users\%A_UserName%\AppData\Local\PoeLurker\PoeLurker.exe
    Run C:\Users\%A_UserName%\AppData\Roaming\Path of Building Community\Path of Building.exe
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
