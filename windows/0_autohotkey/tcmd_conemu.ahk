; tcmd_conemu.ahk: Persistent console for Total Commander via ConEmu
;
; Press Ctrl-Space to switch between Tcmd and ConEmu (the path is
; automatically synced).
;
; INSTALL
;   AutoHotkey       https://autohotkey.com/
;   Total Commander  http://www.ghisler.com/download.htm
;   ConEmu           https://conemu.github.io/en/Downloads.html
;
; USAGE
;   Set up the correct paths in the variables bellow and run the script
;   (double click on it). Open Total Commander and press Ctrl-Space to
;   focus on ConEmu; inside it pressing Ctrl-Space again switching back to
;   Tcmd.
;
;   If You want to open 'cmd.exe' instead of 'powershell.exe' then change the
;   CdCommand to 'cd /d'.
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

Terminal  := "c:\app\conemu\conemu64.exe /cmd powershell.exe"
Tcmd      := "c:\app\tcmd\totalcmd64.exe"
CdCommand := "cd"

#if WinActive("ahk_class TTOTAL_CMD")
  ^Space::
  {
    ; Save the contents of the clipboard.
    ClipSaved := ClipboardAll
    ; Copy Tcmd source path to clipboard.
    PostMessage, 1075, 2029, , , ahk_class TTOTAL_CMD ; cm_CopySrcPathToClip=2029;Copy source path to clipboard

    ; Create new ConEmu instance or switch to it if it's exists.
    IfWinNotExist, ahk_class VirtualConsoleClass
    {
      Run, %Terminal%
      WinWait, ahk_class VirtualConsoleClass
    }
    WinActivate

    ; CD to Tcmd path.
    Send, %CdCommand% "+{Insert}"{Enter}
    ; Restore the clipboard.
    Clipboard := ClipSaved
    ; Free the memory in case the clipboard was very large.
    ClipSaved =

    Return
  }
#if

#if WinActive("ahk_class VirtualConsoleClass")
  ^Space::
  {
    ; Create new Tcmd instance or switch to it if it's exists.
    IfWinNotExist, ahk_class TTOTAL_CMD
    {
      Run, %Tcmd%
      WinWait, ahk_class TTOTAL_CMD
    }
    WinActivate
    Return
  }
#if
