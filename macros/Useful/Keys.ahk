; modified from:
; http://www.autohotkey.com/board/topic/30294-simple-key-stroke-recorder/
;

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
logdir = %A_AppData%\keylogger
FileCreateDir, %logdir%

doublequote = `"

getlog(logdir) {
    FormatTime, time, , yyyy-MM-dd-HH-mm-ss
    newlog = %logdir%\%time%.txt
    return %newlog%
}

keyevent(key) {
    global log
    FileAppend, %key%`n, *%log%
    ;previousnewline = 0
}

no_break_keyevent(key) {
    global log
    FileAppend, %key%, *%log%
    ;previousnewline = 0
}

mouseevent(message) {
    global log
    WinGetActiveTitle, Title
    WinGet, ProcessName, ProcessName, A
    MouseGetPos, x, y, window, controln

    logString := "[" message " | " ProcessName " | " Title "]"
    FileAppend, %logString%`n, *%log%
}
getwin() {
    global log
    FormatTime, time, , yyyy-MM-dd-HH-mm-ss
    WinGetActiveTitle, Title
    WinGet, win_proc, ProcessName, A
    WinGet, uniq_id, ID, A

    if (uniq_id) {
        logString := "[" win_proc " | " Title "]"
        FileAppend, %logString%`n, *%log%
    }
}

make_menu() {
    Menu, TRAY, NoStandard
    Menu, TRAY, add, YOU ARE BEING LOGGED - help, help_handler
    Menu, TRAY, add,
    Menu, TRAY, add, Start new logfile, newlog_handler
    Menu, TRAY, add, About Keylogger, about_handler
    Menu, TRAY, add, Exit, exit_handler
}

log := getlog(logdir)
make_menu()
getwin()

Loop {
    WinWaitNotActive, % "ahk_id " WinActive("A")
    getwin()
}

~a::no_break_keyevent("a")
~#a::no_break_keyevent("a")
~!a::no_break_keyevent("a")
~^a::no_break_keyevent("a")
~b::no_break_keyevent("b")
~#b::no_break_keyevent("b")
~!b::no_break_keyevent("b")
~^b::no_break_keyevent("b")
~c::no_break_keyevent("c")
~#c::no_break_keyevent("c")
~!c::no_break_keyevent("c")
~^c::no_break_keyevent("c")
~d::no_break_keyevent("d")
~#d::no_break_keyevent("d")
~!d::no_break_keyevent("d")
~^d::no_break_keyevent("d")
~e::no_break_keyevent("e")
~#e::no_break_keyevent("e")
~!e::no_break_keyevent("e")
~^e::no_break_keyevent("e")
~f::no_break_keyevent("f")
~#f::no_break_keyevent("f")
~!f::no_break_keyevent("f")
~^f::no_break_keyevent("f")
~g::no_break_keyevent("g")
~#g::no_break_keyevent("g")
~!g::no_break_keyevent("g")
~^g::no_break_keyevent("g")
~h::no_break_keyevent("h")
~#h::no_break_keyevent("h")
~!h::no_break_keyevent("h")
~^h::no_break_keyevent("h")
~i::no_break_keyevent("i")
~#i::no_break_keyevent("i")
~!i::no_break_keyevent("i")
~^i::no_break_keyevent("i")
~j::no_break_keyevent("j")
~#j::no_break_keyevent("j")
~!j::no_break_keyevent("j")
~^j::no_break_keyevent("j")
~k::no_break_keyevent("k")
~#k::no_break_keyevent("k")
~!k::no_break_keyevent("k")
~^k::no_break_keyevent("k")
~l::no_break_keyevent("l")
~#l::no_break_keyevent("l")
~!l::no_break_keyevent("l")
~^l::no_break_keyevent("l")
~m::no_break_keyevent("m")
~#m::no_break_keyevent("m")
~!m::no_break_keyevent("m")
~^m::no_break_keyevent("m")
~n::no_break_keyevent("n")
~#n::no_break_keyevent("n")
~!n::no_break_keyevent("n")
~^n::no_break_keyevent("n")
~o::no_break_keyevent("o")
~#o::no_break_keyevent("o")
~!o::no_break_keyevent("o")
~^o::no_break_keyevent("o")
~p::no_break_keyevent("p")
~#p::no_break_keyevent("p")
~!p::no_break_keyevent("p")
~^p::no_break_keyevent("p")
~q::no_break_keyevent("q")
~#q::no_break_keyevent("q")
~!q::no_break_keyevent("q")
~^q::no_break_keyevent("q")
~r::no_break_keyevent("r")
~#r::no_break_keyevent("r")
~!r::no_break_keyevent("r")
~^r::no_break_keyevent("r")
~s::no_break_keyevent("s")
~#s::no_break_keyevent("s")
~!s::no_break_keyevent("s")
~^s::no_break_keyevent("s")
~t::no_break_keyevent("t")
~#t::no_break_keyevent("t")
~!t::no_break_keyevent("t")
~^t::no_break_keyevent("t")
~u::no_break_keyevent("u")
~#u::no_break_keyevent("u")
~!u::no_break_keyevent("u")
~^u::no_break_keyevent("u")
~v::no_break_keyevent("v")
~#v::no_break_keyevent("v")
~!v::no_break_keyevent("v")
~^v::no_break_keyevent("v")
~w::no_break_keyevent("w")
~#w::no_break_keyevent("w")
~!w::no_break_keyevent("w")
~^w::no_break_keyevent("w")
~x::no_break_keyevent("x")
~#x::no_break_keyevent("x")
~!x::no_break_keyevent("x")
~^x::no_break_keyevent("x")
~y::no_break_keyevent("y")
~#y::no_break_keyevent("y")
~!y::no_break_keyevent("y")
~^y::no_break_keyevent("y")
~z::no_break_keyevent("z")
~#z::no_break_keyevent("z")
~!z::no_break_keyevent("z")
~^z::no_break_keyevent("z")
~+A::no_break_keyevent("A")
~#+A::no_break_keyevent("A")
~!+A::no_break_keyevent("A")
~^+A::no_break_keyevent("A")
~+B::no_break_keyevent("B")
~#+B::no_break_keyevent("B")
~!+B::no_break_keyevent("B")
~^+B::no_break_keyevent("B")
~+C::no_break_keyevent("C")
~#+C::no_break_keyevent("C")
~!+C::no_break_keyevent("C")
~^+C::no_break_keyevent("C")
~+D::no_break_keyevent("D")
~#+D::no_break_keyevent("D")
~!+D::no_break_keyevent("D")
~^+D::no_break_keyevent("D")
~+E::no_break_keyevent("E")
~#+E::no_break_keyevent("E")
~!+E::no_break_keyevent("E")
~^+E::no_break_keyevent("E")
~+G::no_break_keyevent("G")
~#+G::no_break_keyevent("G")
~!+G::no_break_keyevent("G")
~^+G::no_break_keyevent("G")
~+H::no_break_keyevent("H")
~#+H::no_break_keyevent("H")
~!+H::no_break_keyevent("H")
~^+H::no_break_keyevent("H")
~+I::no_break_keyevent("I")
~#+I::no_break_keyevent("I")
~!+I::no_break_keyevent("I")
~^+I::no_break_keyevent("I")
~+J::no_break_keyevent("J")
~#+J::no_break_keyevent("J")
~!+J::no_break_keyevent("J")
~^+J::no_break_keyevent("J")
~+K::no_break_keyevent("K")
~#+K::no_break_keyevent("K")
~!+K::no_break_keyevent("K")
~^+K::no_break_keyevent("K")
~+L::no_break_keyevent("L")
~#+L::no_break_keyevent("L")
~!+L::no_break_keyevent("L")
~^+L::no_break_keyevent("L")
~+M::no_break_keyevent("M")
~#+M::no_break_keyevent("M")
~!+M::no_break_keyevent("M")
~^+M::no_break_keyevent("M")
~+N::no_break_keyevent("N")
~#+N::no_break_keyevent("N")
~!+N::no_break_keyevent("N")
~^+N::no_break_keyevent("N")
~+O::no_break_keyevent("O")
~#+O::no_break_keyevent("O")
~!+O::no_break_keyevent("O")
~^+O::no_break_keyevent("O")
~+P::no_break_keyevent("P")
~#+P::no_break_keyevent("P")
~!+P::no_break_keyevent("P")
~^+P::no_break_keyevent("P")
~+Q::no_break_keyevent("Q")
~#+Q::no_break_keyevent("Q")
~!+Q::no_break_keyevent("Q")
~^+Q::no_break_keyevent("Q")
~+R::no_break_keyevent("R")
~#+R::no_break_keyevent("R")
~!+R::no_break_keyevent("R")
~^+R::no_break_keyevent("R")
~+S::no_break_keyevent("S")
~#+S::no_break_keyevent("S")
~!+S::no_break_keyevent("S")
~^+S::no_break_keyevent("S")
~+T::no_break_keyevent("T")
~#+T::no_break_keyevent("T")
~!+T::no_break_keyevent("T")
~^+T::no_break_keyevent("T")
~+U::no_break_keyevent("U")
~#+U::no_break_keyevent("U")
~!+U::no_break_keyevent("U")
~^+U::no_break_keyevent("U")
~+V::no_break_keyevent("V")
~#+V::no_break_keyevent("V")
~!+V::no_break_keyevent("V")
~^+V::no_break_keyevent("V")
~+W::no_break_keyevent("W")
~#+W::no_break_keyevent("W")
~!+W::no_break_keyevent("W")
~^+W::no_break_keyevent("W")
~+X::no_break_keyevent("X")
~#+X::no_break_keyevent("X")
~!+X::no_break_keyevent("X")
~^+X::no_break_keyevent("X")
~+Y::no_break_keyevent("Y")
~#+Y::no_break_keyevent("Y")
~!+Y::no_break_keyevent("Y")
~^+Y::no_break_keyevent("Y")
~+Z::no_break_keyevent("Z")
~#+Z::no_break_keyevent("Z")
~!+Z::no_break_keyevent("Z")
~^+Z::no_break_keyevent("Z")
~`::no_break_keyevent("``")
~#`::no_break_keyevent("``")
~!`::no_break_keyevent("``")
~^`::no_break_keyevent("``")
~!::no_break_keyevent("{!}")
~#!::no_break_keyevent("{!}")
~!!::no_break_keyevent("{!}")
~^!::no_break_keyevent("{!}")
~@::no_break_keyevent("@")
~#@::no_break_keyevent("@")
~!@::no_break_keyevent("@")
~^@::no_break_keyevent("@")
~#::no_break_keyevent("{#}")
~##::no_break_keyevent("{#}")
~!#::no_break_keyevent("{#}")
~^#::no_break_keyevent("{#}")
~$::no_break_keyevent("$")
~#$::no_break_keyevent("$")
~!$::no_break_keyevent("$")
~^$::no_break_keyevent("$")
~^::no_break_keyevent("{^}")
~#^::no_break_keyevent("{^}")
~!^::no_break_keyevent("{^}")
~^^::no_break_keyevent("{^}")
~&::no_break_keyevent("&")
~#&::no_break_keyevent("&")
~!&::no_break_keyevent("&")
~^&::no_break_keyevent("&")
~*::no_break_keyevent("*")
~#*::no_break_keyevent("*")
~!*::no_break_keyevent("*")
~^*::no_break_keyevent("*")
~(::no_break_keyevent("(")
~#(::no_break_keyevent("(")
~!(::no_break_keyevent("(")
~^(::no_break_keyevent("(")
~)::no_break_keyevent(")")
~#)::no_break_keyevent(")")
~!)::no_break_keyevent(")")
~^)::no_break_keyevent(")")
~-::no_break_keyevent("-")
~#-::no_break_keyevent("-")
~!-::no_break_keyevent("-")
~^-::no_break_keyevent("-")
~_::no_break_keyevent("_")
~#_::no_break_keyevent("_")
~!_::no_break_keyevent("_")
~^_::no_break_keyevent("_")
~=::no_break_keyevent("=")
~#=::no_break_keyevent("=")
~!=::no_break_keyevent("=")
~^=::no_break_keyevent("=")
~+::no_break_keyevent("{+}")
~#+::no_break_keyevent("{+}")
~!+::no_break_keyevent("{+}")
~^+::no_break_keyevent("{+}")
~[::no_break_keyevent("[")
~#[::no_break_keyevent("[")
~![::no_break_keyevent("[")
~^[::no_break_keyevent("[")
~{::no_break_keyevent("{{}")
    ~#{::no_break_keyevent("{{}")
        ~!{::no_break_keyevent("{{}")
            ~^{::no_break_keyevent("{{}")
                ~]::no_break_keyevent("]")
                ~#]::no_break_keyevent("]")
                ~!]::no_break_keyevent("]")
                ~^]::no_break_keyevent("]")
            ~}::no_break_keyevent("{}}")
        ~#}::no_break_keyevent("{}}")
    ~!}::no_break_keyevent("{}}")
~^}::no_break_keyevent("{}}")
~\::no_break_keyevent("\")
~#\::no_break_keyevent("\")
~!\::no_break_keyevent("\")
~^\::no_break_keyevent("\")
~|::no_break_keyevent("|")
~#|::no_break_keyevent("|")
~!|::no_break_keyevent("|")
~^|::no_break_keyevent("|")
~+;::no_break_keyevent(":")
~#+;::no_break_keyevent(":")
~!+;::no_break_keyevent(":")
~^+;::no_break_keyevent(":")
~;::no_break_keyevent("`;")
~#;::no_break_keyevent("`;")
~!;::no_break_keyevent("`;")
~^;::no_break_keyevent("`;")
~SC028::no_break_keyevent("'")
~#SC028::no_break_keyevent("'")
~!SC028::no_break_keyevent("'")
~^SC028::no_break_keyevent("'")
~+SC028::no_break_keyevent(doublequote)
~#+SC028::no_break_keyevent(doublequote)
~!+SC028::no_break_keyevent(doublequote)
~^+SC028::no_break_keyevent(doublequote)
~,::no_break_keyevent(",")
~#,::no_break_keyevent(",")
~!,::no_break_keyevent(",")
~^,::no_break_keyevent(",")
~.::no_break_keyevent(".")
~#.::no_break_keyevent(".")
~!.::no_break_keyevent(".")
~^.::no_break_keyevent(".")
~<::no_break_keyevent("<")
~#<::no_break_keyevent("<")
~!<::no_break_keyevent("<")
~^<::no_break_keyevent("<")
~>::no_break_keyevent(">")
~#>::no_break_keyevent(">")
~!>::no_break_keyevent(">")
~^>::no_break_keyevent(">")
~/::no_break_keyevent("/")
~#/::no_break_keyevent("/")
~!/::no_break_keyevent("/")
~^/::no_break_keyevent("/")
~?::no_break_keyevent("?")
~#?::no_break_keyevent("?")
~!?::no_break_keyevent("?")
~^?::no_break_keyevent("?")
~1::no_break_keyevent("1")
~#1::no_break_keyevent("1")
~!1::no_break_keyevent("1")
~^1::no_break_keyevent("1")
~2::no_break_keyevent("2")
~#2::no_break_keyevent("2")
~!2::no_break_keyevent("2")
~^2::no_break_keyevent("2")
~3::no_break_keyevent("3")
~#3::no_break_keyevent("3")
~!3::no_break_keyevent("3")
~^3::no_break_keyevent("3")
~4::no_break_keyevent("4")
~#4::no_break_keyevent("4")
~!4::no_break_keyevent("4")
~^4::no_break_keyevent("4")
~5::no_break_keyevent("5")
~#5::no_break_keyevent("5")
~!5::no_break_keyevent("5")
~^5::no_break_keyevent("5")
~6::no_break_keyevent("6")
~#6::no_break_keyevent("6")
~!6::no_break_keyevent("6")
~^6::no_break_keyevent("6")
~7::no_break_keyevent("7")
~#7::no_break_keyevent("7")
~!7::no_break_keyevent("7")
~^7::no_break_keyevent("7")
~8::no_break_keyevent("8")
~#8::no_break_keyevent("8")
~!8::no_break_keyevent("8")
~^8::no_break_keyevent("8")
~9::no_break_keyevent("9")
~#9::no_break_keyevent("9")
~!9::no_break_keyevent("9")
~^9::no_break_keyevent("9")
~0::no_break_keyevent("0")
~#0::no_break_keyevent("0")
~!0::no_break_keyevent("0")
~^0::no_break_keyevent("0")
~Space::no_break_keyevent(A_Space)
~#Space::no_break_keyevent(A_Space)
~!Space::no_break_keyevent(A_Space)
~^Space::no_break_keyevent(A_Space)
~Tab::keyevent("{Tab}")
~#Tab::keyevent("{Tab}")
~!Tab::keyevent("{Tab}")
~^Tab::keyevent("{Tab}")
~Enter::keyevent("{Enter}")
~#Enter::keyevent("{Enter}")
~!Enter::keyevent("{Enter}")
~^Enter::keyevent("{Enter}")
~Esc::keyevent("{Esc}")
~#Esc::keyevent("{Esc}")
~!Esc::keyevent("{Esc}")
~^Esc::keyevent("{Esc}")
~SC00E::keyevent("{BS}")
~#SC00E::keyevent("{BS}")
~!SC00E::keyevent("{BS}")
~^SC00E::keyevent("{BS}")
~Pause::keyevent("{Pause}")
~#Pause::keyevent("{Pause}")
~!Pause::keyevent("{Pause}")
~^Pause::keyevent("{Pause}")
~ScrollLock::keyevent("{ScrollLock}")
~#ScrollLock::keyevent("{ScrollLock}")
~!ScrollLock::keyevent("{ScrollLock}")
~^ScrollLock::keyevent("{ScrollLock}")
~Delete::keyevent("{Delete}")
~#Delete::keyevent("{Delete}")
~!Delete::keyevent("{Delete}")
~^Delete::keyevent("{Delete}")
~Insert::keyevent("{Insert}")
~#Insert::keyevent("{Insert}")
~!Insert::keyevent("{Insert}")
~^Insert::keyevent("{Insert}")
~Home::keyevent("{Home}")
~#Home::keyevent("{Home}")
~!Home::keyevent("{Home}")
~^Home::keyevent("{Home}")
~End::keyevent("{End}")
~#End::keyevent("{End}")
~!End::keyevent("{End}")
~^End::keyevent("{End}")
~PgUp::keyevent("{PgUp}")
~#PgUp::keyevent("{PgUp}")
~!PgUp::keyevent("{PgUp}")
~^PgUp::keyevent("{PgUp}")
~PgDn::keyevent("{PgDn}")
~#PgDn::keyevent("{PgDn}")
~!PgDn::keyevent("{PgDn}")
~^PgDn::keyevent("{PgDn}")
~Up::keyevent("{Up}")
~#Up::keyevent("{Up}")
~!Up::keyevent("{Up}")
~^Up::keyevent("{Up}")
~Down::keyevent("{Down}")
~#Down::keyevent("{Down}")
~!Down::keyevent("{Down}")
~^Down::keyevent("{Down}")
~Left::keyevent("{Left}")
~#Left::keyevent("{Left}")
~!Left::keyevent("{Left}")
~^Left::keyevent("{Left}")
~Right::keyevent("{Right}")
~#Right::keyevent("{Right}")
~!Right::keyevent("{Right}")
~^Right::keyevent("{Right}")
~CapsLock::keyevent("{CapsLock}")
~#CapsLock::keyevent("{CapsLock}")
~!CapsLock::keyevent("{CapsLock}")
~^CapsLock::keyevent("{CapsLock}")
~NumLock::keyevent("{NumLock}")
~#NumLock::keyevent("{NumLock}")
~!NumLock::keyevent("{NumLock}")
~^NumLock::keyevent("{NumLock}")
~Numpad0::keyevent("{Numpad0}")
~#Numpad0::keyevent("{Numpad0}")
~!Numpad0::keyevent("{Numpad0}")
~^Numpad0::keyevent("{Numpad0}")
~Numpad1::keyevent("{Numpad1}")
~#Numpad1::keyevent("{Numpad1}")
~!Numpad1::keyevent("{Numpad1}")
~^Numpad1::keyevent("{Numpad1}")
~Numpad2::keyevent("{Numpad2}")
~#Numpad2::keyevent("{Numpad2}")
~!Numpad2::keyevent("{Numpad2}")
~^Numpad2::keyevent("{Numpad2}")
~Numpad3::keyevent("{Numpad3}")
~#Numpad3::keyevent("{Numpad3}")
~!Numpad3::keyevent("{Numpad3}")
~^Numpad3::keyevent("{Numpad3}")
~Numpad4::keyevent("{Numpad4}")
~#Numpad4::keyevent("{Numpad4}")
~!Numpad4::keyevent("{Numpad4}")
~^Numpad4::keyevent("{Numpad4}")
~Numpad5::keyevent("{Numpad5}")
~#Numpad5::keyevent("{Numpad5}")
~!Numpad5::keyevent("{Numpad5}")
~^Numpad5::keyevent("{Numpad5}")
~Numpad6::keyevent("{Numpad6}")
~#Numpad6::keyevent("{Numpad6}")
~!Numpad6::keyevent("{Numpad6}")
~^Numpad6::keyevent("{Numpad6}")
~Numpad7::keyevent("{Numpad7}")
~#Numpad7::keyevent("{Numpad7}")
~!Numpad7::keyevent("{Numpad7}")
~^Numpad7::keyevent("{Numpad7}")
~Numpad8::keyevent("{Numpad8}")
~#Numpad8::keyevent("{Numpad8}")
~!Numpad8::keyevent("{Numpad8}")
~^Numpad8::keyevent("{Numpad8}")
~Numpad9::keyevent("{Numpad9}")
~#Numpad9::keyevent("{Numpad9}")
~!Numpad9::keyevent("{Numpad9}")
~^Numpad9::keyevent("{Numpad9}")
~NumpadAdd::keyevent("{NumpadAdd}")
~#NumpadAdd::keyevent("{NumpadAdd}")
~!NumpadAdd::keyevent("{NumpadAdd}")
~^NumpadAdd::keyevent("{NumpadAdd}")
~NumpadClear::keyevent("{NumpadClear}")
~#NumpadClear::keyevent("{NumpadClear}")
~!NumpadClear::keyevent("{NumpadClear}")
~^NumpadClear::keyevent("{NumpadClear}")
~NumpadDel::keyevent("{NumpadDel}")
~#NumpadDel::keyevent("{NumpadDel}")
~!NumpadDel::keyevent("{NumpadDel}")
~^NumpadDel::keyevent("{NumpadDel}")
~NumpadDiv::keyevent("{NumpadDiv}")
~#NumpadDiv::keyevent("{NumpadDiv}")
~!NumpadDiv::keyevent("{NumpadDiv}")
~^NumpadDiv::keyevent("{NumpadDiv}")
~NumpadDot::keyevent("{NumpadDot}")
~#NumpadDot::keyevent("{NumpadDot}")
~!NumpadDot::keyevent("{NumpadDot}")
~^NumpadDot::keyevent("{NumpadDot}")
~NumpadDown::keyevent("{NumpadDown}")
~#NumpadDown::keyevent("{NumpadDown}")
~!NumpadDown::keyevent("{NumpadDown}")
~^NumpadDown::keyevent("{NumpadDown}")
~NumpadEnd::keyevent("{NumpadEnd}")
~#NumpadEnd::keyevent("{NumpadEnd}")
~!NumpadEnd::keyevent("{NumpadEnd}")
~^NumpadEnd::keyevent("{NumpadEnd}")
~NumpadEnter::keyevent("{NumpadEnter}")
~#NumpadEnter::keyevent("{NumpadEnter}")
~!NumpadEnter::keyevent("{NumpadEnter}")
~^NumpadEnter::keyevent("{NumpadEnter}")
~NumpadHome::keyevent("{NumpadHome}")
~#NumpadHome::keyevent("{NumpadHome}")
~!NumpadHome::keyevent("{NumpadHome}")
~^NumpadHome::keyevent("{NumpadHome}")
~NumpadIns::keyevent("{NumpadIns}")
~#NumpadIns::keyevent("{NumpadIns}")
~!NumpadIns::keyevent("{NumpadIns}")
~^NumpadIns::keyevent("{NumpadIns}")
~NumpadLeft::keyevent("{NumpadLeft}")
~#NumpadLeft::keyevent("{NumpadLeft}")
~!NumpadLeft::keyevent("{NumpadLeft}")
~^NumpadLeft::keyevent("{NumpadLeft}")
~NumpadMult::keyevent("{NumpadMult}")
~#NumpadMult::keyevent("{NumpadMult}")
~!NumpadMult::keyevent("{NumpadMult}")
~^NumpadMult::keyevent("{NumpadMult}")
~NumpadPgDn::keyevent("{NumpadPgDn}")
~#NumpadPgDn::keyevent("{NumpadPgDn}")
~!NumpadPgDn::keyevent("{NumpadPgDn}")
~^NumpadPgDn::keyevent("{NumpadPgDn}")
~NumpadPgUp::keyevent("{NumpadPgUp}")
~#NumpadPgUp::keyevent("{NumpadPgUp}")
~!NumpadPgUp::keyevent("{NumpadPgUp}")
~^NumpadPgUp::keyevent("{NumpadPgUp}")
~NumpadRight::keyevent("{NumpadRight}")
~#NumpadRight::keyevent("{NumpadRight}")
~!NumpadRight::keyevent("{NumpadRight}")
~^NumpadRight::keyevent("{NumpadRight}")
~NumpadSub::keyevent("{NumpadSub}")
~#NumpadSub::keyevent("{NumpadSub}")
~!NumpadSub::keyevent("{NumpadSub}")
~^NumpadSub::keyevent("{NumpadSub}")
~NumpadUp::keyevent("{NumpadUp}")
~#NumpadUp::keyevent("{NumpadUp}")
~!NumpadUp::keyevent("{NumpadUp}")
~^NumpadUp::keyevent("{NumpadUp}")
~F1::keyevent("{F1}")
~#F1::keyevent("{F1}")
~!F1::keyevent("{F1}")
~^F1::keyevent("{F1}")
~F2::keyevent("{F2}")
~#F2::keyevent("{F2}")
~!F2::keyevent("{F2}")
~^F2::keyevent("{F2}")
~F3::keyevent("{F3}")
~#F3::keyevent("{F3}")
~!F3::keyevent("{F3}")
~^F3::keyevent("{F3}")
~F4::keyevent("{F4}")
~#F4::keyevent("{F4}")
~!F4::keyevent("{F4}")
~^F4::keyevent("{F4}")
~F5::keyevent("{F5}")
~#F5::keyevent("{F5}")
~!F5::keyevent("{F5}")
~^F5::keyevent("{F5}")
~F6::keyevent("{F6}")
~#F6::keyevent("{F6}")
~!F6::keyevent("{F6}")
~^F6::keyevent("{F6}")
~F7::keyevent("{F7}")
~#F7::keyevent("{F7}")
~!F7::keyevent("{F7}")
~^F7::keyevent("{F7}")
~F8::keyevent("{F8}")
~#F8::keyevent("{F8}")
~!F8::keyevent("{F8}")
~^F8::keyevent("{F8}")
~F9::keyevent("{F9}")
~#F9::keyevent("{F9}")
~!F9::keyevent("{F9}")
~^F9::keyevent("{F9}")
~F10::keyevent("{F10}")
~#F10::keyevent("{F10}")
~!F10::keyevent("{F10}")
~^F10::keyevent("{F10}")
~F11::keyevent("{F11}")
~#F11::keyevent("{F11}")
~!F11::keyevent("{F11}")
~^F11::keyevent("{F11}")
~F12::keyevent("{F12}")
~#F12::keyevent("{F12}")
~!F12::keyevent("{F12}")
~^F12::keyevent("{F12}")
~F13::keyevent("{F13}")
~#F13::keyevent("{F13}")
~!F13::keyevent("{F13}")
~^F13::keyevent("{F13}")
~F14::keyevent("{F14}")
~#F14::keyevent("{F14}")
~!F14::keyevent("{F14}")
~^F14::keyevent("{F14}")
~F15::keyevent("{F15}")
~#F15::keyevent("{F15}")
~!F15::keyevent("{F15}")
~^F15::keyevent("{F15}")
~F16::keyevent("{F16}")
~#F16::keyevent("{F16}")
~!F16::keyevent("{F16}")
~^F16::keyevent("{F16}")
~F17::keyevent("{F17}")
~#F17::keyevent("{F17}")
~!F17::keyevent("{F17}")
~^F17::keyevent("{F17}")
~F18::keyevent("{F18}")
~#F18::keyevent("{F18}")
~!F18::keyevent("{F18}")
~^F18::keyevent("{F18}")
~F19::keyevent("{F19}")
~#F19::keyevent("{F19}")
~!F19::keyevent("{F19}")
~^F19::keyevent("{F19}")
~F20::keyevent("{F20}")
~#F20::keyevent("{F20}")
~!F20::keyevent("{F20}")
~^F20::keyevent("{F20}")
~F21::keyevent("{F21}")
~#F21::keyevent("{F21}")
~!F21::keyevent("{F21}")
~^F21::keyevent("{F21}")
~F22::keyevent("{F22}")
~#F22::keyevent("{F22}")
~!F22::keyevent("{F22}")
~^F22::keyevent("{F22}")
~F23::keyevent("{F23}")
~#F23::keyevent("{F23}")
~!F23::keyevent("{F23}")
~^F23::keyevent("{F23}")
~F24::keyevent("{F24}")
~#F24::keyevent("{F24}")
~!F24::keyevent("{F24}")
~^F24::keyevent("{F24}")
~AppsKey::keyevent("{AppsKey}")
~#AppsKey::keyevent("{AppsKey}")
~!AppsKey::keyevent("{AppsKey}")
~^AppsKey::keyevent("{AppsKey}")

~PrintScreen::keyevent("{PrintScreen}")
~#PrintScreen::keyevent("{PrintScreen}")
~!PrintScreen::keyevent("{PrintScreen}")
~^PrintScreen::keyevent("{PrintScreen}")

~LWin::keyevent("{LWin}")
~RWin::no_break_keyevent("{RWin}")
~LControl::no_break_keyevent("{LControl}")
~RControl::no_break_keyevent("{RControl}")
~LShift::no_break_keyevent("{LShift}")
~RShift::no_break_keyevent("{RShift}")
~LAlt::no_break_keyevent("{LAlt}")
~RAlt::no_break_keyevent("{RAlt}")

~LButton::mouseevent("LButton")
~#LButton::mouseevent("LButton")
~!LButton::mouseevent("LButton")
~^LButton::mouseevent("LButton")
~MButton::mouseevent("MButton")
~#MButton::mouseevent("MButton")
~!MButton::mouseevent("MButton")
~^MButton::mouseevent("MButton")
~RButton::mouseevent("RButton")
~#RButton::mouseevent("RButton")
~!RButton::mouseevent("RButton")
~^RButton::mouseevent("RButton")
~WheelDown::mouseevent("WheelDown")
~#WheelDown::mouseevent("WheelDown")
~!WheelDown::mouseevent("WheelDown")
~^WheelDown::mouseevent("WheelDown")
~WheelUp::mouseevent("WheelUp")
~#WheelUp::mouseevent("WheelUp")
~!WheelUp::mouseevent("WheelUp")
~^WheelUp::mouseevent("WheelUp")
~WheelLeft::mouseevent("WheelLeft")
~#WheelLeft::mouseevent("WheelLeft")
~!WheelLeft::mouseevent("WheelLeft")
~^WheelLeft::mouseevent("WheelLeft")
~WheelRight::mouseevent("WheelRight")
~#WheelRight::mouseevent("WheelRight")
~!WheelRight::mouseevent("WheelRight")
~^WheelRight::mouseevent("WheelRight")

newlog_handler:
    log := getlog(logdir)
return

about_handler:
    aboutmsg =
    (
        keylogger Copyright 2013 Noah Birnel (nbirnel at gmail dot com)
        This program is not intended for spying.
        You are licensed to use it for capturing your own keystrokes.
    )
    MsgBox %aboutmsg%
return

exit_handler:
ExitApp
return

help_handler:
    helpmsg =
    (
        All of your mouse clicks and key presses are being logged to %log%
    )
    MsgBox %helpmsg%
return
