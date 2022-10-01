#Include Gdip.ahk
#Include Hotstrings.ahk
#Include WinActive.ahk
#Include WindowsTerminal.ahk
#Include Saveclipboard.ahk
#Include BlockKBnM.ahk

_auto := true
F12::
    Suspend
    SoundBeep, 750, 500
Return

^Printscreen::
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
    Screenshot("C:\Users\%A_UserName%\Pictures\AHK Screenshots\" CurrentDate "_" CurrentTime ".png")
Return

^+!P::
    Run C:\Users\%A_UserName%\AppData\Local\Programs\Awakened PoE Trade\Awakened PoE Trade.exe
    Run C:\Users\%A_UserName%\AppData\Local\PoeLurker\PoeLurker.exe
    Run C:\Users\%A_UserName%\AppData\Roaming\Path of Building Community\Path of Building.exe
Return

$!O::GetMousePosition()

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

GetMousePosition(){
    MouseGetPos, xpos, ypos
    PixelGetColor, xycolor , xpos, ypos
    msgbox, X=%xpos% Y=%ypos% XYColor=%xycolor%
return
}
