; tcmdvim.ahk: vim key bindings in total commander
;
; Does not works with Capslock::Ctrl remap.
;
; The codes can be found in TOTALCMD.INC.
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

; Main window.
#if WinActive("ahk_class TTOTAL_CMD")

  ; Values of aControl:
  ;   (TMy|LCL)ListBox[12]  left/right panel
  ;   (TMy|LCL)ComboBox\d+  list of drives
  ;   Edit1                 text entry
  ;   Edit2                 command line

  h::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2002, , , ahk_class TTOTAL_CMD ; cm_GoToParent=2002;Go to parent directory
    }
    Else
    {
      Send, h
    }
    Return
  }

  ^h::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 3007, , , ahk_class TTOTAL_CMD ; cm_CloseCurrentTab=3007;Close tab
    }
    Else If(RegExMatch(aControl, "Edit[12]"))
    {
      Send, {Backspace}
    }
    Else
    {
      Send, ^h
    }
    Return
  }

  j::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {Down}
    }
    Else
    {
      Send, j
    }
    Return
  }

  ^j::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]|Edit[12]"))
    {
      Send, {Enter}
    }
    Else
    {
      Send, ^j
    }
    Return
  }

  k::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {Up}
    }
    Else
    {
      Send, k
    }
    Return
  }

  ^k::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]|Edit[12]"))
    {
      Send, {Esc}
    }
    Else
    {
      Send, ^k
    }
    Return
  }

  l::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2003, , , ahk_class TTOTAL_CMD ; cm_GoToDir=2003;Open dir or zip under cursor
    }
    Else
    {
      Send, l
    }
    Return
  }

  ^l::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {Tab}
    }
    Else If(RegExMatch(aControl, "Edit[12]"))
    {
      Send, {Delete}
    }
    Else
    {
      Send, ^l
    }
    Return
  }

  ^n::
  {
    Send, {Down}
    Return
  }

  ^p::
  {
    Send, {Up}
    Return
  }

  ^u::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {PgUp}
    }
    Else If(RegExMatch(aControl, "Edit[12]"))
    {
      Send, ^+{Home}{Delete}
    }
    Else
    {
      Send, ^u
    }
    Return
  }

  ^d::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {PgDn}
    }
    Else
    {
      Send, ^d
    }
    Return
  }

  ^o::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 570,  , , ahk_class TTOTAL_CMD ; cm_GotoPreviousDir=570;Go back
    }
    Else
    {
      Send, ^o
    }
    Return
  }

  i::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2915, , , ahk_class TTOTAL_CMD ; cm_ShowQuickSearch=2915;Show name search window
    }
    Else
    {
      Send, i
    }
    Return
  }

  ^i::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 571,  , , ahk_class TTOTAL_CMD ; cm_GotoNextDir=571;Go forward
    }
    Else
    {
      Send, ^i
    }
    Return
  }

  ^e::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
    }
    Else
    {
      Send, ^e
    }
    Return
  }

  ^y::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
    }
    Else
    {
      Send, ^y
    }
    Return
  }

  ^t::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 3001, , , ahk_class TTOTAL_CMD ; cm_OpenNewTab=3001;Open new tab
    }
    Else
    {
      Send, ^t
    }
    Return
  }

  +r::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 1002, , , ahk_class TTOTAL_CMD ; cm_RenameOnly=1002;Rename (Shift+F6)
      Send, {Right}
    }
    Else
    {
      Send, +r
    }
    Return
  }

  ^w::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "Edit[12]"))
    {
      Send, ^+{Left}{Delete}
    }
    Else
    {
      Send, ^w
    }
    Return
  }

  :::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      Send, {Space}{Backspace}                          ; Make it visible.
    }
    Else
    {
      Send, :
    }
    Return
  }

  g::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If(A_PriorKey = "g")
      {
        Send, {Home}
      }
      ; Disabled in normal mode, because it opens quicksearch, thus the Else
      ; branch is missing.
    }
    Else
    {
      Send, g
    }
    Return
  }

  ^g::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 540,  , , ahk_class TTOTAL_CMD ; cm_RereadSource=540;Reread source
    }
    Else
    {
      Send, ^g
    }
    Return
  }

  +g::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {End}
    }
    Else
    {
      Send, +g
    }
    Return
  }

  ^z::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 903, , , ahk_class TTOTAL_CMD ; cm_List=903;View with Lister
    }
    Else
    {
      Send, ^z
    }
    Return
  }

  ^f::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
    }
    Else
    {
      Send, ^f
    }
    Return
  }

  ^m::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2400, , , ahk_class TTOTAL_CMD ; cm_MultiRenameFiles=2400;Rename multiple files
    }
    Else
    {
      Send, ^m
    }
    Return
  }

  ; AltGr+Q, because \ not works.
  <^>!q::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2001, , , ahk_class TTOTAL_CMD ; cm_GoToRoot=2001
    }
    Else
    {
      Send, \
    }
    Return
  }

  ; Go to home. (AltGr+1, because ~ not works)
  <^>!1::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, cd %USERPROFILE%{Enter}
    }
    Else
    {
      Send, ~
    }
    Return
  }

  ; Open right-click (context) menu.
  a::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {AppsKey}
    }
    Else
    {
      Send, a
    }
    Return
  }

  ; Open terminal.
  F2::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, conemu64.exe /cmd powershell{Enter}
    }
    Else
    {
      Send, {F2}
    }
    Return
  }

#if

; Quicksearch.
#if WinActive("ahk_class TQUICKSEARCH")

  ^k::
  {
    Send, {Esc}
    Return
  }

  ^j::
  {
    Send, {Enter}
    Return
  }

  ^n::
  {
    Send, {Down}
    Return
  }

  ^p::
  {
    Send, {Up}
    Return
  }

  ^h::
  {
    Send, {Backspace}
    Return
  }

  ^w::
  {
    Send, ^+{Left}{Delete}
    Return
  }

  ^l::
  {
    Send, {Tab}
    Return
  }

  ; Press space to search for other part of filename.
  Space::
  {
    Send, *
    Return
  }

  ^f::
  {
    PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
    Return
  }

#if

; Preview window.
#if WinActive("ahk_class TLister")

  j::
  {
    Send, ^{Down}
    Return
  }

  ^k::
  {
    Send, {Esc}
    Return
  }

  ^u::
  {
    Send, {PgUp}
    Return
  }

  ^d::
  {
    Send, {PgDn}
    Return
  }

  g::
  {
    If(A_PriorKey = "g")
    {
      Send, ^{Home}
    }
    Return
  }

  +g::
  {
    Send, ^{End}
    Return
  }

  /::
  {
    Send, {F7} ; Search for text.
    Return
  }

  ^f::
  {
    Send, {F7} ; Search for text.
    Return
  }

#if
