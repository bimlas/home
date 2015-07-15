; tcmdvim.ahk: vim key bindings in total commander
; (using CapsLock instead of Ctrl)
;
; The codes can be found in TOTALCMD.INC.
;
; ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.07.15 10:18 ==

#if WinActive("ahk_class TTOTAL_CMD")

  ; Disable CapsLock to Ctrl remap, check for GetKeyState("CapsLock", "P")
  ; instead, because it behaves weird.
  CapsLock::Return

  ; Template for maps:
  ;
  ; ControlGetFocus, aControl, A
  ; ; Left/right panel is active.
  ; If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
  ; {
  ;   If GetKeyState("CapsLock", "P")
  ;     ; ...
  ;   Else
  ;     ; ...
  ; }
  ; ; Text entry is active.
  ; Else If(RegExMatch(aControl, "Edit1"))
  ; {
  ;   If GetKeyState("CapsLock", "P")
  ;     ; ...
  ;   Else
  ;     ; ...
  ; }
  ; Return

  h::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3007, , , ahk_class TTOTAL_CMD ; cm_CloseCurrentTab=3007;Close tab
      Else
        PostMessage, 1075, 2002, , , ahk_class TTOTAL_CMD ; cm_GoToParent=2002;Go to parent directory
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Backspace}
      Else
        Send, h
    }
    Return
  }

  j::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Enter}
      Else
        Send, {Down}
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Enter}
      Else
        Send, j
    }
    Return
  }

  k::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Esc}
      Else
        Send, {Up}
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Esc}
      Else
        Send, k
    }
    Return
  }

  l::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Tab}
      Else
        PostMessage, 1075, 2003, , , ahk_class TTOTAL_CMD ; cm_GoToDir=2003;Open dir or zip under cursor
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {Delete}
      Else
        Send, l
    }
    Return
  }

  u::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        Send, {PgUp}
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, u
    }
    Return
  }

  d::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      Send, {PgDn}
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, d
    }
    Return
  }

  o::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 570,  , , ahk_class TTOTAL_CMD ; cm_GotoPreviousDir=570;Go back
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, o
    }
    Return
  }

  i::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 571,  , , ahk_class TTOTAL_CMD ; cm_GotoNextDir=571;Go forward
      Else
        PostMessage, 1075, 2915, , , ahk_class TTOTAL_CMD ; cm_ShowQuickSearch=2915;Show name search window
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, i
    }
    Return
  }

  e::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, e
    }
    Return
  }

  y::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, y
    }
    Return
  }

  t::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3001, , , ahk_class TTOTAL_CMD ; cm_OpenNewTab=3001;Open new tab
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, t
    }
    Return
  }

  +r::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      PostMessage, 1075, 1002, , , ahk_class TTOTAL_CMD ; cm_RenameOnly=1002;Rename (Shift+F6)
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, R
    }
    Return
  }

  :::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, :
    }
    Return
  }

  g::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 540,  , , ahk_class TTOTAL_CMD ; cm_RereadSource=540;Reread source
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, g
    }
    Return
  }

  +g::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      Send, {End}
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, G
    }
    Return
  }

  z::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 903, , , ahk_class TTOTAL_CMD ; cm_List=903;View with Lister
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 903, , , ahk_class TTOTAL_CMD ; cm_List=903;View with Lister
      Else
        Send, z
    }
    Return
  }

  f::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, j
    }
    Return
  }

  m::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 2400, , , ahk_class TTOTAL_CMD ; cm_MultiRenameFiles=2400;Rename multiple files
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, m
    }
    Return
  }

  ; AltGr+Q, because \ not works.
  <^>!q::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      PostMessage, 1075, 2001, , , ahk_class TTOTAL_CMD ; cm_GoToRoot=2001
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, \
    }
    Return
  }

  ; Go to home. (AltGr+1, because ~ not works)
  <^>!1::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, cd %USERPROFILE%{Enter}
    }
    ; Text entry is active.
    Else If(RegExMatch(aControl, "Edit1"))
    {
      Send, ~
    }
    Return
  }

  ; Open terminal.
  F2::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[1-2]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, conemu64.exe{Enter}
    }
    Return
  }
#if

#if WinActive("ahk_class TQUICKSEARCH")

  ; Disable CapsLock to Ctrl remap, check for GetKeyState("CapsLock", "P")
  ; instead, because it behaves weird.
  CapsLock::Return

  k::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Esc}
    Else
      SendInput, k
    Return
  }

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

  h::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Backspace}
    Else
      SendInput, h
    Return
  }

  l::
  {
    If GetKeyState("CapsLock", "P")
      Send, {Delete}
    Else
      SendInput, l
    Return
  }

  s::
  {
    If GetKeyState("CapsLock", "P")
      Send, ^s
    Else
      SendInput, s
    Return
  }
#if

#if WinActive("ahk_class TLister")

  ; Disable CapsLock to Ctrl remap, check for GetKeyState("CapsLock", "P")
  ; instead, because it behaves weird.
  CapsLock::Return

  k::
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

  d::
  {
    If GetKeyState("CapsLock", "P")
      Send, {PgDn}
    Return
  }

  /::
  {
    Send, {F7} ; Search for text.
    Return
  }

  f::
  {
    If GetKeyState("CapsLock", "P")
      Send, {F7} ; Search for text.
    Return
  }
#if
