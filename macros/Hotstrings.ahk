; Hotstring
:*:>_::
    ListHotstrings()
Return

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

; Miscelaneous
:*:>wame::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}wa.me/55
Return

:*:>inf::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}∞
Return

:*:>emd::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}—
Return

:*:>eli::
    LTrim(A_ThisHotkey,":oc?*")
    SendInput,{raw}…
Return

:*:>code::
    backticks_unicode := "{U+0060}{U+0060}{U+0060}"
    Clipboard := ClipboardAll
    StringReplace, Clipboard, Clipboard, `r`n, `n, All ; Remove CRLF (Carriage Return + Line Feed)
    StringLen, ClipLength, Clipboard
    LeftMoves := ClipLength + 5

    LTrim(A_ThisHotkey,":oc?*")
    Send, %backticks_unicode%
    Send, {Shift down}{Enter}{Shift up}
    Send, ^v
    Send, {Shift down}{Enter}{Shift up}
    Send, %backticks_unicode%
    SendInput, {Left %LeftMoves%}
Return

:*:>gpt::
    prompt = Abide to these rules when answering questions: ["Provide clear and concise explanations", "Respond using the terminology and context you're given", "Avoid repeating information unless necessary, only output changed code", "Break down complex tasks into smaller, manageable steps", "Adhere to standard practices and conventions", "Favor simplicity in explanations", "Ensure code is self-explanatory without relying on comments", "Maintain consistency in coding practices", "Use descriptive variable names that clarify their purpose", "Minimize dependencies between code components", "Avoid using negative conditionals where possible", "Use descriptive and clear variable names", "Ensure names are pronounceable and searchable", "Replace numerical constants with named constants where appropriate", "Write functions that focus on a single task", "Use descriptive names for functions", "Prefer fewer function arguments where feasible", "Ensure functions have no unintended side effects", "Avoid mentioning being an AI", "Refrain from language suggesting remorse, apology, or regret", "Keep responses unique and concise", "Always focus on the intent behind questions", "Seek clarification if questions are ambiguous", "Support answers with credible sources where applicable"]`n===`n

    LTrim(A_ThisHotkey,":oc?*")
    Clipboard = %prompt%
    Send ^v
Return

!c:: ; Alt + C [Surrounds the selected text with backticks]
    backtick_char := Chr(96)

    ClipSaved := ClipboardAll
    Clipboard :=
    Send, ^c
    ClipWait, 1

    if (Clipboard != "")
    {
        Clipboard := backtick_char . Clipboard . backtick_char
        Sleep, 50
        Send, ^v
    }

    Sleep, 50
    Clipboard := ClipSaved
    ClipSaved := ""
Return

^!c:: ; Ctrl + Alt + C [Surrounds the selected text with 3 backticks]
    backticks_char := Chr(96) Chr(96) Chr(96)

    ClipSaved := ClipboardAll
    Clipboard :=
    Send, ^c
    ClipWait, 1

    if (Clipboard != "")
    {
        Clipboard := backticks_char . Clipboard . backticks_char
        Sleep, 50
        Send, ^v
    }

    Sleep, 50
    Clipboard := ClipSaved
    ClipSaved := ""
Return

; Open a message box with a list of hotstrings
ListHotstrings() {
    HotkeyList := "va, vd, tg, gcc, gcg, vnam, vtel, vcpf, vrg, vcnpj, vpix, coreg, caqua, gnam, gtel, gcpf, grg, bot, top, wame, code"
    Loop {
        Hotkey := HotkeyList . A_Index . ": " . HotkeyList . A_Index . "`n"
        if A_Index = 20
            break
    }
    MsgBox, % "List of Hotstrings:`n`n" . HotkeyList
}
