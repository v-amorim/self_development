#Include Gdip.ahk
#Include Hotstrings.ahk
#Include WinActive.ahk
#Include WindowsTerminal.ahk
#Include Screenshot.ahk
#Include BlockKBnM.ahk
#Include VolumeControl.ahk

$^+!P:: RunPoEDependencies()
$!O:: GetMousePosition()

$#F12::
    Suspend
    SoundBeep, 750, 500
Return

RunPoEDependencies(){
    Run C:\Users\%A_UserName%\AppData\Local\Programs\Awakened PoE Trade\Awakened PoE Trade.exe
    Run C:\Users\%A_UserName%\AppData\Local\PoeLurker\PoeLurker.exe
    Run C:\Users\%A_UserName%\AppData\Roaming\Path of Building Community\Path of Building.exe
    Return
}

GetMousePosition(){
    MouseGetPos, xpos, ypos
    PixelGetColor, xycolor , xpos, ypos
    msgbox, X=%xpos% Y=%ypos% XYColor=%xycolor%
    Return
}
