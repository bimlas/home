; hotkeys.ahk - sajat AutoHokey fajl
;
; https://www.autohotkey.com/docs/Hotkeys.htm
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

; Move/resize windows.
<#h:: Send, #{Left}
<#j:: Send, #{Down}
<#k:: Send, #{Up}
<#l:: Send, #{Right}

; Dexpot helper
<#1::  Send, ^{Numpad1}
<#2::  Send, ^{Numpad2}
<#3::  Send, ^{Numpad3}
<#4::  Send, ^{Numpad4}
<#+1:: Send, ^!{Numpad1}
<#+2:: Send, ^!{Numpad2}
<#+3:: Send, ^!{Numpad3}
<#+4:: Send, ^!{Numpad4}

; App runners
#p:: Run "C:\app\everything\everything.exe"
