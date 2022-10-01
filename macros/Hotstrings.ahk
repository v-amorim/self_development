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
IniRead, email_tg, %env%, Credentials, email_tg
IniRead, email_va, %env%, Credentials, email_va
IniRead, email_vd, %env%, Credentials, email_vd
IniRead, email_gcc, %env%, Credentials, email_gcc
IniRead, password_mz_riot, %env%, Credentials, password_mz_riot
IniRead, password_px_riot, %env%, Credentials, password_px_riot
IniRead, password_wf_gcc, %env%, Credentials, password_wf_gcc
IniRead, password_wf_tg, %env%, Credentials, password_wf_tg
IniRead, password_wf_vd, %env%, Credentials, password_wf_vd
IniRead, username_mz_riot, %env%, Credentials, username_mz_riot
IniRead, username_px_riot, %env%, Credentials, username_px_riot
IniRead, password_poe, %env%, Credentials, password_poe

; Hotstring
:*:...:: 
    LTrim(A_ThisHotkey,":oc?*") 
    SendInput,{raw}…
Return

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
