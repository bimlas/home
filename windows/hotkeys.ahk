; hotkeys.ahk - sajat AutoHokey fajl
;
; https://www.autohotkey.com/docs/Hotkeys.htm
;
; ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.04.23 10:30 ==

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

;                   VIM KEYBINDINGS IN TOTAL COMMANDER                    {{{1
; ============================================================================
;
; The codes can be found in TOTALCMD.INC.

#if WinActive("ahk_class TTOTAL_CMD")
  ; Disable CapsLock::Ctrl, check for GetKeyState("CapsLock", "P") instead.
  CapsLock::Return

  ; ControlGetFocus, ClassNN, ahk_class TTOTAL_CMD
  ; If ClassNN = Edit1

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
      Send, {Enter}
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

  l::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 540,  , , ahk_class TTOTAL_CMD ; cm_RereadSource=540;Reread source
    Else
      PostMessage, 1075, 2003, , , ahk_class TTOTAL_CMD ; cm_GoToDir=2003;Open dir or zip under cursor
    Return
  }

  ::: PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line

  i::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 571,  , , ahk_class TTOTAL_CMD ; cm_GotoNextDir=571;Go forward
      Else
      {
        PostMessage, 1075, 2915, , , ahk_class TTOTAL_CMD ; cm_ShowQuickSearch=2915;Show name search window
        SendInput, +{Home}*
      }
    Return
  }

  g::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Esc}
    Return
  }

  u::
  {
    If GetKeyState("CapsLock", "P")
      Send, {PgUp}
    Return
  }

  +g:: Send, {End}

  d::
  {
    If GetKeyState("CapsLock", "P")
      Send, {PgDn}
    Return
  }

  o::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 570,  , , ahk_class TTOTAL_CMD ; cm_GotoPreviousDir=570;Go back
    Return
  }

  e::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
    Return
  }

  y::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
    Return
  }

  f::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
    Return
  }

  m::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 2400, , , ahk_class TTOTAL_CMD ; cm_MultiRenameFiles=2400;Rename multiple files
    Return
  }

  t::
  {
    If GetKeyState("CapsLock", "P")
      PostMessage, 1075, 3001, , , ahk_class TTOTAL_CMD ; cm_OpenNewTab=3001;Open new tab
    Return
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
#if

#if WinActive("ahk_class TQUICKSEARCH")
  ; Disable CapsLock::Ctrl, check for GetKeyState("CapsLock", "P") instead.
  CapsLock::Return

  j::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Enter}
    Else
      SendInput, j
    Return
  }

  n::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Down}
    Else
      SendInput, n
    Return
  }

  p::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Up}
    Else
      SendInput, p
    Return
  }

  g::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Esc}
    Else
      SendInput, g
    Return
  }
#if
