#NoEnv
#SingleInstance force
#Persistent
#UseHook

$#T:: ; Win + T [Opens a new terminal in the current file explorer's folder]
    path := GetActiveExplorerPath()
    OpenNewTerminal(false, path)
return

$^#T:: ; Ctrl + Win + T [Opens a new terminal in the current file explorer's folder as Admin]
    path := GetActiveExplorerPath()
    OpenNewTerminal(true, path)
return

$#V:: ; Win + V [Opens the current file explorer's folder in VSCode]
    path := GetActiveExplorerPath()
    OpenNewVSCode(false, path)
return

$^#V:: ; Ctrl + Win + V [Opens the current file explorer's folder in VSCode as Admin]
    path := GetActiveExplorerPath()
    OpenNewVSCode(true, path)
Return

#WheelUp:: ; Windows + WheelUp [Volume Up +2]
    BlockInput On
    SendInput, {Volume_Up}
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

+#WheelUp:: ; Shift + Windows + WheelUp [Volume Up +10]
    BlockInput On
    SendInput, {Volume_Up}{Volume_Down}
    SoundSet, +10
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

!#WheelUp:: ; Alt + Windows + WheelUp [Window Transparency Up]
    BlockInput On
    WinGet, currentTransparency, Transparent, A

    if (currentTransparency = "")
        currentTransparency := 255

    newTransparency := currentTransparency + 10

    if (newTransparency > 255)
        newTransparency := 255

    WinSet, Transparent, %newTransparency%, A
    BlockInput Off
Return

$^!#WheelUp:: ; Ctrl + Alt + Windows + WheelUp [Go to next desktop]
    Send, ^#{Right}
Return

#WheelDown:: ; Windows + WheelDown [Volume Down -2]
    BlockInput On
    SendInput, {Volume_Down}
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

+#WheelDown:: ; Shift + Windows + WheelDown [Volume Down -10]
    BlockInput On
    SendInput, {Volume_Down}{Volume_Up}
    SoundSet, -10
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

!#WheelDown:: ; Alt + Windows + WheelDown [Window Transparency Down]
    BlockInput On
    WinGet, currentTransparency, Transparent, A

    if (currentTransparency = "")
        currentTransparency := 255

    newTransparency := currentTransparency - 10

    if (newTransparency < 0)
        newTransparency := 0

    WinSet, Transparent, %newTransparency%, A
    BlockInput Off
Return

$^!#WheelDown:: ; Ctrl + Alt + Windows + WheelDown [Go to previous desktop]
    Send, ^#{Left}
Return

#Pause:: ; Windows + Pause [Volume Mute]
    BlockInput On
    SendInput, {Volume_Mute}
    toggle_icon = 1
    Gosub, vmeter
Return

!#Pause:: ; Alt+ Windows + Pause button [Reset Window Transparency]
    WinGet, windows, List
    Loop, %windows%
    {
        WinID := windows%A_Index%
        WinSet, Transparent, 255, ahk_id %WinID%
    }
    ToolTip, Windows's transparency reset
    SetTimer, RemoveToolTip, 1000
Return

RemoveToolTip:
    ToolTip
    SetTimer, RemoveToolTip, Off
Return

vmeter: ; show volume meter, adapted from: https://www.autohotkey.com/board/topic/10240-very-nice-simple-but-good-looking-volume-control/
    SoundGet, master_volume
    SoundGet, volume_mute, master, mute
    IfWinExist, ahkvolume
    {
        GuiControl,, MP, %master_volume%
        if toggle_icon = 1
        {
            if volume_mute = On
                GuiControl,, Pic1, *Icon40 %a_windir%\system32\mmsys.cpl
            else
                GuiControl,, Pic1, *Icon1 %a_windir%\system32\mmsys.cpl
        }
    }
    SetTimer,vmeterclose, 2000
Return

vmeterclose: ; close volume meter
    SetTimer,vmeterclose, off
    Gui, destroy
Return

; Adapted from: https://stackoverflow.com/questions/72077329/how-do-i-add-a-keyboard-shortcut-to-open-vs-code-on-the-folder-from-file-explore
GetActiveExplorerPath()
{
    path := ""

    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (explorerHwnd)
    {
        for window in ComObjCreate("Shell.Application").Windows
        {
            if (window.hwnd==explorerHwnd)
            {
                path := window.Document.Folder.Self.Path
                Return path
            }
        }
    }
}

OpenNewTerminal(isAdmin := false, path := "") {
    if (isAdmin)
        Run *RunAs wt.exe -d "%path%"
    else
        Run, wt.exe -d "%path%"
}

OpenNewVSCode(isAdmin := false, path := ""){
    if (isAdmin)
        Run *RunAs "C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%path%"
    else
        Run, "C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%path%"
}
