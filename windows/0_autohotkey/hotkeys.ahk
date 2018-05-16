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

; Replace numpad comma with dot character.
NumPadDot:: Send, .

; App runners
#p:: Run "C:\app\everything\everything.exe"
