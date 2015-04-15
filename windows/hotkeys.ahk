!F5::   Run firefox.exe
!F6::   Run thunderbird.exe
!F9::   Run totalcmd.exe
!F12::  Run conemu64.exe
!F10::  Run calc.exe

; Capslock -> Ctrl remap.
SetCapsLockState AlwaysOff
Capslock::Ctrl

; Virtuawin-ben a Win+w lett beallitva, hogy a kovetkezo asztalra valtson, az
; autohotkey pedig a Win+Tab-ot alakitja Win+w-re.
Lwin & Tab::Send, #w
