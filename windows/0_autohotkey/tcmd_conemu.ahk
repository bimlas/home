; tcmd_conemu.ahk: Persistent console for Total Commander via ConEmu
;
; Press Ctrl-Space to switch between Tcmd and ConEmu (automatically sync path).
; Ctrl-Space opens Tcmd from anywhere!
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

#if WinActive("ahk_class TTOTAL_CMD")
  ^Space::
  {
    PostMessage, 1075, 2029, , , ahk_class TTOTAL_CMD ; cm_CopySrcPathToClip=2029;Copy source path to clipboard
    IfWinNotExist, ahk_class VirtualConsoleClass
    {
      Run, "C:\Program Files\ConEmu\ConEmu64.exe" "/cmd powershell.exe"
      WinWait, ahk_class VirtualConsoleClass
    }
    WinActivate
    Send, cd +{Insert}{Enter}
    Return
  }
#if
; #if WinActive("ahk_class VirtualConsoleClass")
  ^Space::
  {
    IfWinNotExist, ahk_class TTOTAL_CMD
    {
      Run "c:\totalcmd\totalcmd64.exe"
      WinWait ahk_class TTOTAL_CMD
    }
    WinActivate
    Return
  }
; #if
