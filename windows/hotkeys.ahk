; hotkeys.ahk - sajat AutoHokey fajl
;
; https://www.autohotkey.com/docs/Hotkeys.htm
;
; ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.06.25 09:01 ==

; CapsLock -> Ctrl remap.
SetCapsLockState AlwaysOff
CapsLock::Ctrl

; !F5 = Alt+F5
!F5::  Run firefox.exe
!F6::  Run thunderbird.exe
!F9::  Run totalcmd64.exe
!F12:: Run conemu64.exe
!F10:: Run calc.exe

; Virtuawin-ben a Win+w lett beallitva, hogy a kovetkezo asztalra valtson, az
; autohotkey pedig a Win+Tab-ot alakitja Win+w-re.
Lwin & Tab::Send, #w
