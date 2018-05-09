; highlight_mouse_click.ahk: Show mouse click (for screencast making)
;
; https://autohotkey.com/boards/viewtopic.php?t=19235

; Turns on "Show mouse on pressing Ctrl button feature
DllCall("SystemParametersInfo", UInt, 0x101D, UInt, 0, UInt, 1, UInt, 0)
#Persistent
OnExit, ExitSub

; Emulates pressing of Ctrl button on mouse click
~LButton UP::
Send {Ctrl}

return

; Turns off "Show mouse on pressing Ctrl button feature
ExitSub:
{
    DllCall("SystemParametersInfo", UInt, 0x101D, UInt, 0, UInt, 0, UInt, 0)
    ExitApp
}
