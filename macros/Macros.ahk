#Include Gdip.ahk
#Include Hotstrings.ahk
#Include WinActive.ahk
#Include WindowsTerminal.ahk
#Include Saveclipboard.ahk

_auto := true
F12::
    Suspend
    SoundBeep, 750, 500
Return

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

