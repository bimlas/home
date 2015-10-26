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
  ControlGetFocus, aControl, A

  h::
  {
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

#if
