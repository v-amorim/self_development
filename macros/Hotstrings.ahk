env := A_ScriptDir "\env.ini"

; Info envs
IniRead, campus, %env%, Info, campus
IniRead, course, %env%, Info, course
IniRead, email, %env%, Info, email
IniRead, name, %env%, Info, name
IniRead, nickname, %env%, Info, nickname
IniRead, period, %env%, Info, period
IniRead, ra, %env%, Info, ra
IniRead, telephone, %env%, Info, telephone
IniRead, university, %env%, Info, university

; Credential envs
IniRead, email_gcc, %env%, Credentials, email_gcc
IniRead, email_tg, %env%, Credentials, email_tg
IniRead, email_va, %env%, Credentials, email_va
IniRead, email_vd, %env%, Credentials, email_vd

IniRead, user_riot_px, %env%, Credentials, user_riot_px
IniRead, user_riot_mz, %env%, Credentials, user_riot_mz
IniRead, user_riot_lmz, %env%, Credentials, user_riot_lmz

IniRead, pass_riot_px, %env%, Credentials, pass_riot_px
IniRead, pass_riot_mz, %env%, Credentials, pass_riot_mz
IniRead, pass_riot_lmz, %env%, Credentials, pass_riot_lmz

IniRead, pass_poe_va, %env%, Credentials, pass_poe_va
IniRead, pass_poe_gcc, %env%, Credentials, pass_poe_gcc

IniRead, pass_wf_tg, %env%, Credentials, pass_wf_tg
IniRead, pass_wf_vd, %env%, Credentials, pass_wf_vd
IniRead, pass_wf_gcc, %env%, Credentials, pass_wf_gcc

; Hotstring
:*:>bot::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}bot com %nickname%
Return

:*:>campus::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%campus%
Return

:*:>course::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%course%
Return

:*:>email::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email%
Return

:*:>gcc::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_gcc%
Return

:*:>name::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%name%
Return

:*:>period::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%period%
Return

:*:>ra::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%ra%
Return

:*:>tel::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%telephone%
Return

:*:>tg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_tg%
Return

:*:>top::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}top com %nickname%
Return

:*:>uni::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%university%
Return

:*:>va::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_va%
Return

:*:>vd::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_vd%
Return
