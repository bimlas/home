; tcmd_conemu.ahk: Persistent console for Total Commander via ConEmu
;
; Press Ctrl-Space to switch between Tcmd and ConEmu (automatically synced
; path). Ctrl-Space opens Tcmd from anywhere!
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

#if WinActive("ahk_class TTOTAL_CMD")
  ^Space::
  {
    ; Get the active window's pos.
    WinGetPos, X, Y, , , A

    ; Save the contents of the clipboard.
    ClipSaved := ClipboardAll
    ; Copy Tcmd source path to clipboard.
    PostMessage, 1075, 2029, , , ahk_class TTOTAL_CMD ; cm_CopySrcPathToClip=2029;Copy source path to clipboard

    ; Create new ConEmu instance (with the size of Tcmd window) or switch to it
    ; if it's exists.
    IfWinNotExist, ahk_class VirtualConsoleClass
    {
      Run, C:\Program Files\ConEmu\ConEmu64.exe /WndX %X% /WndY %Y% /WndW 100`% /WndH 33 /cmd powershell.exe
      WinWait, ahk_class VirtualConsoleClass
    }
    WinActivate

    ; CD to Tcmd path.
    Send, cd +{Insert}{Enter}
    ; Restore the clipboard.
    Clipboard := ClipSaved
    ; Free the memory in case the clipboard was very large.
    ClipSaved =

    Return
  }
#if

; #if WinActive("ahk_class VirtualConsoleClass")
  ^Space::
  {
    ; Create new Tcmd instance or switch to it if it's exists.
    IfWinNotExist, ahk_class TTOTAL_CMD
    {
      Run "c:\totalcmd\totalcmd64.exe"
      WinWait ahk_class TTOTAL_CMD
    }
    WinActivate
    Return
  }
; #if
