; Adapted from https://www.autohotkey.com/board/topic/10240-very-nice-simple-but-good-looking-volume-control/
#NoEnv
#SingleInstance force
#Persistent
#UseHook
#WheelUp::
    BlockInput On
    Send {Volume_Up}
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

+#WheelUp::
    BlockInput On
    Send {Volume_Up}{Volume_Down}
    SoundSet, +10
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

#WheelDown::
    BlockInput On
    Send {Volume_Down}
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

+#WheelDown::
    BlockInput On
    Send {Volume_Down}{Volume_Up}
    SoundSet, -10
    toggle_icon = 0
    Gosub, vmeter
    BlockInput Off
Return

#MButton::
    BlockInput On
    Send {Volume_Mute}
    toggle_icon = 1
    Gosub, vmeter
Return

vmeter: ; show volume meter
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

vmeterclose:
    SetTimer,vmeterclose, off
    Gui, destroy
Return