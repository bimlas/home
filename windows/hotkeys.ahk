; !F5 = Alt+F5
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

;                   VIM KEYBINDINGS IN TOTAL COMMANDER                    {{{1
; ============================================================================
;
; The codes can be found in TOTALCMD.INC.

#ifWinActive ahk_class TTOTAL_CMD
  ^g::  Send, {Esc}

  h::   PostMessage, 1075, 2002, , , ahk_class TTOTAL_CMD ; cm_GoToParent=2002;Go to parent directory
  j::   Send, {Down}
  k::   Send, {Up}
  l::   PostMessage, 1075, 2003, , , ahk_class TTOTAL_CMD ; cm_GoToDir=2003;Open dir or zip under cursor

  ^j::  Send, {Enter}

  :::   PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line

  ^u::  Send, {PgUp}
  ^d::  Send, {PgDn}

  ^o::  PostMessage, 1075, 570,  , , ahk_class TTOTAL_CMD ; cm_GotoPreviousDir=570;Go back
  ^i::  PostMessage, 1075, 571,  , , ahk_class TTOTAL_CMD ; cm_GotoNextDir=571;Go forward

  */::  PostMessage, 1075, 2001, , , ahk_class TTOTAL_CMD ; cm_GoToRoot=2001

  i::   PostMessage, 1075, 2915, , , ahk_class TTOTAL_CMD ; cm_ShowQuickSearch=2915;Show name search window

  ^e::  PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
  ^y::  PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
  ^h::  PostMessage, 1075, 3007, , , ahk_class TTOTAL_CMD ; cm_CloseCurrentTab=3007;Close tab

  ; Go to home.
  *Home::
    PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
    SendInput, cd %USERPROFILE%{Enter}
    return

  ; Open terminal.
  F2::
    PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
    SendInput, conemu64.exe{Enter}
    return
#ifWinActive

#ifWinActive ahk_class TQUICKSEARCH
  ^j::  Send, {Enter}
  ^n::  Send, {Down}
  ^p::  Send, {Up}
  ^u::  Send, {PgUp}
  ^d::  Send, {PgDn}
  ^g::  Send, {Esc}
#ifWinActive

;                  LINUX-OS ABLAK ATMERETEZES/ATHELYEZES                  {{{1
; ============================================================================
