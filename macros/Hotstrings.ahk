env := A_ScriptDir "\env.ini"

; Infos Sun envs
IniRead, name_sun, %env%, Infos_Sun, name_sun
IniRead, telephone_sun, %env%, Infos_Sun, telephone_sun
IniRead, cpf_sun, %env%, Infos_Sun, cpf_sun
IniRead, rg_sun, %env%, Infos_Sun, rg_sun
IniRead, cnpj_sun, %env%, Infos_Sun, cnpj_sun
IniRead, pix_sun, %env%, Infos_Sun, pix_sun
IniRead, cep_oregon, %env%, Infos_Sun, cep_oregon
IniRead, cep_aquarius, %env%, Infos_Sun, cep_aquarius

; Infos Shine envs
IniRead, name_shine, %env%, Infos_Shine, name_shine
IniRead, telephone_shine, %env%, Infos_Shine, telephone_shine
IniRead, cpf_shine, %env%, Infos_Shine, cpf_shine
IniRead, rg_shine, %env%, Infos_Shine, rg_shine
IniRead, nickname_shine, %env%, Infos_Shine, nickname_shine

; Emails envs
IniRead, email_va, %env%, Emails, email_va
IniRead, email_vd, %env%, Emails, email_vd
IniRead, email_tg, %env%, Emails, email_tg
IniRead, email_gcc, %env%, Emails, email_gcc
IniRead, email_cgc, %env%, Emails, email_cgc

; Game envs
IniRead, user_riot_px, %env%, Credentials, user_riot_px
IniRead, pass_riot_px, %env%, Credentials, pass_riot_px

IniRead, user_riot_mz, %env%, Credentials, user_riot_mz
IniRead, pass_riot_mz, %env%, Credentials, pass_riot_mz

IniRead, user_riot_lmz, %env%, Credentials, user_riot_lmz
IniRead, pass_riot_lmz, %env%, Credentials, pass_riot_lmz

IniRead, user_riot_4g, %env%, Credentials, user_riot_4g
IniRead, pass_riot_4g, %env%, Credentials, pass_riot_4g

IniRead, user_riot_kt4, %env%, Credentials, user_riot_kt4
IniRead, pass_riot_kt4, %env%, Credentials, pass_riot_kt4

IniRead, pass_poe_va, %env%, Credentials, pass_poe_va
IniRead, pass_poe_gcc, %env%, Credentials, pass_poe_gcc

IniRead, pass_wf_tg, %env%, Credentials, pass_wf_tg
IniRead, pass_wf_vd, %env%, Credentials, pass_wf_vd
IniRead, pass_wf_gcc, %env%, Credentials, pass_wf_gcc

; Hotstring
; Emails
:*:>va::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_va%
Return

:*:>vd::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_vd%
Return

:*:>tg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_tg%
Return

:*:>gcc::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_gcc%
Return

:*:>gcg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%email_cgc%
Return

; Info Sun
:*:>vnam::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%name_sun%
Return

:*:>vtel::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%telephone_sun%
Return

:*:>vcpf::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%cpf_sun%
Return

:*:>vrg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%rg_sun%
Return

:*:>vcnpj::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%cnpj_sun%
Return

:*:>vpix::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%pix_sun%
Return

:*:>coreg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%cep_oregon%
Return

:*:>caqua::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%cep_aquarius%
Return

; Info Shine
:*:>gnam::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%name_shine%
Return

:*:>gtel::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%telephone_shine%
Return

:*:>gcpf::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%cpf_shine%
Return

:*:>grg::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}%rg_shine%
Return

; Games
:*:>bot::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}bot com %nickname_shine%
Return

:*:>top::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}top com %nickname_shine%
Return

:*:>wame::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}https://web.whatsapp.com/send?phone=55
Return

:*:>code::
    Clipboard := ClipboardAll
    StringReplace, Clipboard, Clipboard, `r`n, `n, All ; Remove CRLF (Carriage Return + Line Feed)
    StringLen, ClipLength, Clipboard
    LeftMoves := ClipLength + 5

    LTrim(A_ThisHotkey,":oc?*")
    Send, {U+0060}{U+0060}{U+0060}
    Send, {Shift down}{Enter}{Shift up}
    Send, ^v
    Send, {Shift down}{Enter}{Shift up}
    Send, {U+0060}{U+0060}{U+0060}
    SendInput, {Left %LeftMoves%}
Return
