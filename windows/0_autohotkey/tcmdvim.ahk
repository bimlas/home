; Main window.
#if WinActive("ahk_class TTOTAL_CMD")

  e::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
      Return
    }
    Send, e
    Return
  }

  y::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
      Return
    }
    Send, y
    Return
  }

  t::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 3001, , , ahk_class TTOTAL_CMD ; cm_OpenNewTab=3001;Open new tab
      Return
    }
    Send, t
    Return
  }

  +r::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 1002, , , ahk_class TTOTAL_CMD ; cm_RenameOnly=1002;Rename (Shift+F6)
      Send, {Right}
      Return
    }
    Send, R
    Return
  }

  w::
  {
    ControlGetFocus, aControl, A
    ; Text entry or command line is active.
    If(RegExMatch(aControl, "Edit[12]"))
    {
      If GetKeyState("CapsLock", "P")
        Send, ^+{Left}{Delete}
      Else
        Send, w
      Return
    }
    Send, w
    Return
  }

  :::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      Send, {Space}{Backspace}
      Return
    }
    Send, :
    Return
  }

  g::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
      {
        PostMessage, 1075, 540,  , , ahk_class TTOTAL_CMD ; cm_RereadSource=540;Reread source
        Return
      }
      If(A_PriorKey = "g")
      {
        Send, {Home}
        Return
      }
    }
    ; Disabled in normal mode, because it opens quicksearch.
    If(RegExMatch(aControl, "(TMy|LCL)ComboBox\d|Edit[12]"))
    {
      Send, g
      Return
    }
    Return
  }

  +g::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {End}
      Return
    }
    Send, G
    Return
  }

  z::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 903, , , ahk_class TTOTAL_CMD ; cm_List=903;View with Lister
      Return
    }
    Send, z
    Return
  }

  f::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
      Return
    }
    Send, f
    Return
  }

  m::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      If GetKeyState("CapsLock", "P")
        PostMessage, 1075, 2400, , , ahk_class TTOTAL_CMD ; cm_MultiRenameFiles=2400;Rename multiple files
      Return
    }
    Send, m
    Return
  }

  ; AltGr+Q, because \ not works.
  <^>!q::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 2001, , , ahk_class TTOTAL_CMD ; cm_GoToRoot=2001
      Return
    }
    Send, \
    Return
  }

  ; Go to home. (AltGr+1, because ~ not works)
  <^>!1::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, cd %USERPROFILE%{Enter}
      Return
    }
    Send, ~
    Return
  }

  ; Open right-click (context) menu.
  a::
  {
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      Send, {AppsKey}
      Return
    }
    ; Disabled in normal mode, because it opens quicksearch.
    Else If(RegExMatch(aControl, "(TMy|LCL)ComboBox\d|Edit[12]"))
    {
      Send, a
      Return
    }
    Return
  }

  ; Open terminal.
  F2::
  {
    ControlGetFocus, aControl, A
    ; Left/right panel is active.
    If(RegExMatch(aControl, "(TMy|LCL)ListBox[12]"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, conemu64.exe /cmd powershell{Enter}
      Return
    }
    Send, {F2}
    Return
  }
#if

; Quicksearch.
#if WinActive("ahk_class TQUICKSEARCH")

  ; Disable CapsLock to Ctrl remap, check for GetKeyState("CapsLock", "P")
  ; instead, because it behaves weird.
  CapsLock::Return

  k::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Esc}
      Return
    }
    SendInput, k
    Return
  }

  j::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Enter}
      Return
    }
    SendInput, j
    Return
  }

  n::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Down}
      Return
    }
    SendInput, n
    Return
  }

  p::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Up}
      Return
    }
    SendInput, p
    Return
  }

  h::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Backspace}
      Return
    }
    SendInput, h
    Return
  }

  l::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Tab}
      Return
    }
    SendInput, l
    Return
  }

  ; Press space to search for other part of filename.
  Space::
  {
    SendInput, *
    Return
  }

  w::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, ^+{Left}{Delete}
      Return
    }
    SendInput, w
    Return
  }

  s::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, ^s
      Return
    }
    SendInput, s
    Return
  }

  f::
  {
    If GetKeyState("CapsLock", "P")
    {
      PostMessage, 1075, 2022, , , ahk_class TTOTAL_CMD ; cm_CompareFilesByContent=2022;File comparison
      Return
    }
    Send, f
    Return
  }
#if

; Preview window.
#if WinActive("ahk_class TLister")

  ; Disable CapsLock to Ctrl remap, check for GetKeyState("CapsLock", "P")
  ; instead, because it behaves weird.
  CapsLock::Return

  j::
  {
    Send, ^{Down}
    Return
  }

  k::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {Esc}
      Return
    }
    Send, ^{Up}
    Return
  }

  u::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {PgUp}
      Return
    }
    Return
  }

  d::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {PgDn}
      Return
    }
    Return
  }

  g::
  {
    If(A_PriorKey = "g")
    {
      Send, ^{Home}
      Return
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

  f::
  {
    If GetKeyState("CapsLock", "P")
    {
      Send, {F7} ; Search for text.
      Return
    }
    Return
  }
#if
