; hotkeys.ahk - sajat AutoHokey fajl
;
; https://www.autohotkey.com/docs/Hotkeys.htm
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

<#h::
{
  IfWinNotExist, ahk_class TTOTAL_CMD
  {
    Run, totalcmd64.exe
    WinWait, ahk_class TTOTAL_CMD
  }
  WinActivate
  Return
}

<#j::
{
  IfWinNotExist, ahk_class Vim
  {
    Run, gvim
    WinWait, ahk_class Vim
  }
  WinActivate
  Return
}

<#k::
{
  IfWinNotExist, ahk_class MozillaWindowClass
  {
    Run, firefox.exe
    WinWait, ahk_class MozillaWindowClass
  }
  WinActivate
  Return
}

<#l::
{
  IfWinNotExist, ahk_class VirtualConsoleClass
  {
    Run, conemu64.exe /cmd powershell
    WinWait, ahk_class VirtualConsoleClass
  }
  WinActivate
  Return
}

<#i::
{
  IfWinNotExist, ahk_class CalcFrame
  {
    Run, calc.exe
    WinWait, ahk_class CalcFrame
  }
  WinActivate
  Return
}

; Dexpot helper
<#Tab:: Send, ^{Tab}
