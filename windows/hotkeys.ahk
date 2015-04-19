; hotkeys.ahk - sajat AutoHokey fajl
;
; https://www.autohotkey.com/docs/Hotkeys.htm
;
; ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.04.19 20:54 ==

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

;                             HJKL EVERYWHERE                             {{{1
; ============================================================================
;
; LeftWin+hjkl to move the cursor.
; Don't forget to disable screen lock through Win+L.
; RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
*<#h::  Send, {Left}
*<#j::  Send, {Down}
*<#k::  Send, {Up}
*<#l::  Send, {Right}
*^<#j:: Send, {Enter}

*<#u::  Send, {PgUp}
*<#d::  Send, {PgDn}

;                   VIM KEYBINDINGS IN TOTAL COMMANDER                    {{{1
; ============================================================================
;
; The codes can be found in TOTALCMD.INC.

#ifWinActive ahk_class TTOTAL_CMD

  ; Disable CapsLock::Ctrl, check fo GetKeyState("CapsLock", "P") instead.
  CapsLock::Return

  h::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 3007, , , ahk_class TTOTAL_CMD ; cm_CloseCurrentTab=3007;Close tab
    Else
      PostMessage, 1075, 2002, , , ahk_class TTOTAL_CMD ; cm_GoToParent=2002;Go to parent directory
    Return
  }

  j::
  {
    If GetKeyState("CapsLock", "P")
      Send, {CapsLock Up}{Enter}
    Else
      Send, {Down}
    Return
  }

  k::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Tab}
    Else
      Send, {Up}
    Return
  }

  l:: PostMessage, 1075, 2003, , , ahk_class TTOTAL_CMD ; cm_GoToDir=2003;Open dir or zip under cursor

  ::: PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line

  i::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 571,  , , ahk_class TTOTAL_CMD ; cm_GotoNextDir=571;Go forward
      Else
      {
        PostMessage, 1075, 2915, , , ahk_class TTOTAL_CMD ; cm_ShowQuickSearch=2915;Show name search window
        SendInput, *
      }
    Return
  }

  If GetKeyState("CapsLock", "P")
  {
    g:: Send, {Esc}
    u:: Send, {PgUp}
    d:: Send, {PgDn}
    o:: PostMessage, 1075, 570,  , , ahk_class TTOTAL_CMD ; cm_GotoPreviousDir=570;Go back
    e:: PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
    y:: PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
    f:: PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
    m:: PostMessage, 1075, 2400, , , ahk_class TTOTAL_CMD ; cm_MultiRenameFiles=2400;Rename multiple files
  }

  ; AltGr+Q, because \ not works.
  <^>!q:: PostMessage, 1075, 2001, , , ahk_class TTOTAL_CMD ; cm_GoToRoot=2001

  ; Go to home. (AltGr+1, because ~ not works)
  <^>!1::
  {
    PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
    SendInput, cd %USERPROFILE%{Enter}
    Return
  }

  ; Open terminal.
  F2::
  {
    PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
    SendInput, conemu64.exe{Enter}
    Return
  }
#ifWinActive

#ifWinActive ahk_class TQUICKSEARCH
  ; Disable CapsLock::Ctrl, check fo GetKeyState("CapsLock", "P") instead.
  CapsLock::Return

  If GetKeyState("CapsLock", "P")
  {
    j:: Send, {Enter}
    n:: Send, {Down}
    p:: Send, {Up}
    g:: Send, {Esc}
  }
#ifWinActive

;                  LINUX-OS ABLAK ATMERETEZES/ATHELYEZES                  {{{1
; ============================================================================
