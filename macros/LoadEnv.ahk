env := A_ScriptDir "\env.ini"

; Path envs
IniRead, awakened_poe_trade_path, %env%, Paths, awakened_poe_trade_path
IniRead, poe_lurker_path, %env%, Paths, poe_lurker_path
IniRead, path_of_building_path, %env%, Paths, path_of_building_path
IniRead, ahk_screenshot_path, %env%, Paths, ahk_screenshot_path
IniRead, ahk_screenshot_clipboard_path, %env%, Paths, ahk_screenshot_clipboard_path
IniRead, desktop_path, %env%, Paths, desktop_path

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
