;https://www.autohotkey.com/boards/viewtopic.php?t=63872
#NoEnv
#SingleInstance, Force

^Printscreen:: ScreenPrintScreen()
#Printscreen:: SnipPrintScreen()
!+F11::
    BlockInput, On
    SnipPrintScreen()
    BlockInput, Off
Return

ScreenPrintScreen(){
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
    Screenshot("C:\Users\Amorim\Pictures\AHK Screenshots\" CurrentDate "_" CurrentTime ".png")
    Return
}

SnipPrintScreen(){
    Critical, OnA
    hBM := 0
    HotKey, %A_ThisHotKey%, Off
    hBM := CB_hBMP_Get()
    Critical, Off

    If ( hBM )
    {
        CurrentDate := A_YYYY "-" A_MM "-" A_DD
        CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
        sFile := "C:\Users\Amorim\Pictures\AHK Screenshots\Clipboard\" CurrentDate "_" CurrentTime ".png"
        dFile := "C:\Users\Amorim\Desktop\" CurrentDate "_" CurrentTime ".png"
        GDIP("Startup")
        SavePicture(hBM, sFile)
        SavePicture(hBM, dFile)
        GDIP("Shutdown")
        DllCall( "DeleteObject", "Ptr",hBM )
        ; If FileExist(sFile)
        ; {
        ;     SoundBeep
        ;     Run %sFile%
        ; }
    }
    HotKey, %A_ThisHotKey%, On
    Return
}

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

CB_hBMP_Get() { ; By SKAN on D297 @ bit.ly/2L81pmP
    Local OK := [0,0,0,0]
    OK.1 := DllCall( "OpenClipboard", "Ptr",0 )
    OK.2 := OK.1 ? DllCall( "IsClipboardFormatAvailable", "UInt",8 ) : 0 ; CF_BITMAP
    OK.3 := OK.2 ? DllCall( "GetClipboardData", "UInt", 2, "Ptr" ) : 0
    OK.4 := OK.1 ? DllCall( "CloseClipboard" ) : 0
    Return OK.3 ? DllCall( "CopyImage", "Ptr",OK.3, "Int",0, "Int",0, "Int",0, "UInt",0x200C, "Ptr" )
        + ( ErrorLevel := 0 ) : ( ErrorLevel := !OK.2 ? 1 : 2 ) >> 2
}

SavePicture(hBM, sFile) { ; By SKAN on D293 @ bit.ly/2L81pmP
    Local V, pBM := VarSetCapacity(V,16,0)>>8, Ext := LTrim(SubStr(sFile,-3),"."), E := [0,0,0,0]
    Local Enc := 0x557CF400 | Round({"bmp":0, "jpg":1,"jpeg":1,"gif":2,"tif":5,"tiff":5,"png":6}[Ext])
    E[1] := DllCall("gdi32\GetObjectType", "Ptr",hBM ) <> 7
    E[2] := E[1] ? 0 : DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Ptr",hBM, "UInt",0, "PtrP",pBM)
    NumPut(0x2EF31EF8,NumPut(0x0000739A,NumPut(0x11D31A04,NumPut(Enc+0,V,"UInt"),"UInt"),"UInt"),"UInt")
    E[3] := pBM ? DllCall("gdiplus\GdipSaveImageToFile", "Ptr",pBM, "WStr",sFile, "Ptr",&V, "UInt",0) : 1
    E[4] := pBM ? DllCall("gdiplus\GdipDisposeImage", "Ptr",pBM) : 1
    Return E[1] ? 0 : E[2] ? -1 : E[3] ? -2 : E[4] ? -3 : 1
}

GDIP(C:="Startup") { ; By SKAN on D293 @ bit.ly/2L81pmP
    Static SI:=Chr(!(VarSetCapacity(Si,24,0)>>16)), pToken:=0, hMod:=0, Res:=0, AOK:=0
    If (AOK := (C="Startup" and pToken=0) Or (C<>"Startup" and pToken<>0)) {
        If (C="Startup") {
            hMod := DllCall("LoadLibrary", "Str","gdiplus.dll", "Ptr")
            Res := DllCall("gdiplus\GdiplusStartup", "PtrP",pToken, "Ptr",&SI, "UInt",0)
        } Else {
            Res := DllCall("gdiplus\GdiplusShutdown", "Ptr",pToken )
            DllCall("FreeLibrary", "Ptr",hMod), hMod:=0, pToken:=0
    }}
    Return (AOK ? !Res : Res:=0)
}
