; conemu.ahk: Persistent console for various apps
;
; Press Ctrl-Space to switch between (Tcmd|Vim) and ConEmu (the path is
; automatically synced).
;
; INSTALL
;   AutoHotkey       https://autohotkey.com/
;   ConEmu           https://conemu.github.io/en/Downloads.html
;
; USAGE
;   Set up the correct paths in the variables bellow and run the script
;   (double click on it). Open the app and press Ctrl-Space to focus on
;   ConEmu; inside it pressing Ctrl-Space again switching back to the caller.
;
;   If You want to open 'cmd.exe' instead of 'powershell.exe' then change the
;   CdCommand to 'cd /d'.
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

Terminal  := "c:\app\conemu\conemu64.exe /cmd powershell.exe"
CdCommand := "cd"

Caller    := False

#if WinActive("ahk_class TTOTAL_CMD") or WinActive("ahk_class Vim")
  ^Space::
  {
    ; Save the contents of the clipboard.
    ClipSaved := ClipboardAll
    ; Copy the app's actual path to clipboard.
    If WinActive("ahk_class TTOTAL_CMD")
    {
      Caller := "TTOTAL_CMD"
      PostMessage, 1075, 2029, , , ahk_class TTOTAL_CMD ; cm_CopySrcPathToClip=2029;Copy source path to clipboard
    }
    If WinActive("ahk_class Vim")
    {
      Caller := "Vim"
      Send, :^ulet @{+} = expand('`%:p:h'){Enter}
    }

    ; Create new ConEmu instance or switch to it if it's exists.
    IfWinNotExist, ahk_class VirtualConsoleClass
    {
      Run, %Terminal%
      WinWait, ahk_class VirtualConsoleClass
    }
    WinActivate

    ; CD to the path of the app.
    Send, ^u%CdCommand% "+{Insert}"{Enter}
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
    If Caller != False
    {
      If Caller = TTOTAL_CMD
      {
        ; Save the contents of the clipboard.
        ClipSaved := ClipboardAll
        ; Copy the app's actual path to clipboard.
        Send, (pwd).Path | CLIP{Enter}

        WinActivate, ahk_class TTOTAL_CMD

        ; CD to the path of the app.
        Send, ^{Down}%CdCommand% "+{Insert}"{Enter}
        ; Restore the clipboard.
        Clipboard := ClipSaved
        ; Free the memory in case the clipboard was very large.
        ClipSaved =
      }
      If Caller = Vim
      {
        WinActivate, ahk_class Vim
      }
    }
    Return
  }
#if
