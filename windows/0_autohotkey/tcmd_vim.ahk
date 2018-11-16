; tcmdvim.ahk: vim key bindings in total commander
;
; Does not works with Capslock::Ctrl remap.
;
; The codes can be found in TOTALCMD.INC.
;
; ==================== BimbaLaszlo (.github.io|gmail.com) ====================

;                               MAIN WINDOW                               {{{1
; ============================================================================

#if WinActive("ahk_class TTOTAL_CMD")

  ; Values of aControl:
  ;   (TMy|LCL)ListBox\d+   left/right panel
  ;   (TMy|LCL)ComboBox\d+  list of drives
  ;   Edit1                 text entry
  ;   Edit2                 command line

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

  h::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "Edit\d+"))
    {
      Send, {Backspace}
    }
    Else
    {
      Send, ^h
    }
    Return
  }

  +h::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  131, , , ahk_class TTOTAL_CMD ; cm_LeftOpenDrives=131;Left: Open drive list
    }
    Else
    {
      Send, +h
    }
    Return
  }

  j::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    Send, {Enter}
    Return
  }

  k::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    Send, {Esc}
    Return
  }

  l::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "Edit\d+"))
    {
      Send, {Delete}
    }
    Else
    {
      Send, ^l
    }
    Return
  }

  +l::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  231, , , ahk_class TTOTAL_CMD ; cm_RightOpenDrives=231;Right: Open drive list
    }
    Else
    {
      Send, +l
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      Send, {PgUp}
    }
    Else If(RegExMatch(aControl, "Edit\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 571,  , , ahk_class TTOTAL_CMD ; cm_GotoNextDir=571;Go forward
    }
    Else
    {
      Send, ^i
    }
    Return
  }

  e::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  904, , , ahk_class TTOTAL_CMD ; cm_Edit=904;Edit (Notepad)
    }
    Else
    {
      Send, e
    }
    Return
  }

  ^e::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 3005, , , ahk_class TTOTAL_CMD ; cm_SwitchToNextTab=3005;Switch to next Tab (as Ctrl+Tab)
    }
    Else
    {
      Send, ^e
    }
    Return
  }

  +e::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      ; TODO: What's the code of new file?
      Send, +{F4}{Right}
    }
    Else
    {
      Send, +e
    }
    Return
  }

  ^y::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 3006, , , ahk_class TTOTAL_CMD ; cm_SwitchToPreviousTab=3006;Switch to previous Tab (Ctrl+Shift+Tab)
    }
    Else
    {
      Send, ^y
    }
    Return
  }

  r::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 1002, , , ahk_class TTOTAL_CMD ; cm_RenameOnly=1002;Rename (Shift+F6)
      Send, {Right}
    }
    Else
    {
      Send, r
    }
    Return
  }

  +r::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 2400, , , ahk_class TTOTAL_CMD ; cm_MultiRenameFiles=2400;Rename multiple files
    }
    Else
    {
      Send, +r
    }
    Return
  }

  y::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 3101, , , ahk_class TTOTAL_CMD ; cm_CopyOtherpanel=3101;Copy to other
      Send, {Right}
    }
    Else
    {
      Send, y
    }
    Return
  }

  x::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  906, , , ahk_class TTOTAL_CMD ; cm_RenMov=906;Rename/Move files
      Send, {Right}
    }
    Else
    {
      Send, x
    }
    Return
  }

  d::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      If(A_PriorKey = "d")
      {
        PostMessage, 1075,  908, , , ahk_class TTOTAL_CMD ; cm_Delete=908;Delete files
      }
      ; Disabled in normal mode, because it opens quicksearch, thus the Else
      ; branch is missing.
    }
    Else
    {
      Send, d
    }
    Return
  }

  w::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  903, , , ahk_class TTOTAL_CMD ; cm_List=903;View with Lister
    }
    Else
    {
      Send, w
    }
    Return
  }

  ^w::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      If(A_PriorKey = "w")
      {
        Send, {Tab}
      }
      ; Disabled in normal mode, because it opens quicksearch, thus the Else
      ; branch is missing.
    }
    Else If(RegExMatch(aControl, "Edit\d+"))
    {
      Send, ^+{Left}{Delete}
    }
    Else
    {
      Send, ^w
    }
    Return
  }

  +w::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  907, , , ahk_class TTOTAL_CMD ; cm_MkDir=907;Make directory
      Send, {Right}
    }
    Else
    {
      Send, +w
    }
    Return
  }

  ^q::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      If(A_PriorKey = "w")
      {
        PostMessage, 1075, 3007, , , ahk_class TTOTAL_CMD ; cm_CloseCurrentTab=3007;Close tab
      }
      ; Disabled in normal mode, because it opens quicksearch, thus the Else
      ; branch is missing.
    }
    Else
    {
      Send, ^q
    }
    Return
  }

  g::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
  ; TODO: language specific
  <^>!q::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
  ; TODO: language specific
  <^>!1::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
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
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      Send, {AppsKey}
    }
    Else
    {
      Send, a
    }
    Return
  }

  +a::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075,  523, , , ahk_class TTOTAL_CMD ; cm_SelectAll=523;Select all (files or both, as configured)
    }
    Else
    {
      Send, +a
    }
    Return
  }

  ; Open terminal.
  s::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      PostMessage, 1075, 4003, , , ahk_class TTOTAL_CMD ; cm_FocusCmdLine=4003;Focus on command line
      SendInput, c:\app\git\git-bash.exe{Enter}
    }
    Else
    {
      Send, s
    }
    Return
  }

  ^s::
  {
    ControlGetFocus, aControl, A
    If(RegExMatch(aControl, "(TMy|LCL)ListBox\d+"))
    {
      If(A_PriorKey = "w")
      {
        PostMessage, 1075, 3001, , , ahk_class TTOTAL_CMD ; cm_OpenNewTab=3001;Open new tab
      }
      ; Disabled in normal mode, because it opens quicksearch, thus the Else
      ; branch is missing.
    }
    Else
    {
      Send, ^s
    }
    Return
  }

#if

;                              QUICKSEARCH                                {{{1
; ============================================================================

#if WinActive("ahk_class TQUICKSEARCH")

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

;                             FILE COMPARISON                             {{{1
; ============================================================================

#if WinActive("ahk_class TFileCompForm")

  ^n::
  {
    ; TODO: language specific
    Send, !k
    Return
  }

  ^p::
  {
    ; TODO: language specific
    Send, !e
    Return
  }

#if

;                             VIEWER WINDOWS                              {{{1
; ============================================================================
;
; Have to be after the specialized mappings (if there are multiply maps, then
; the first one will be accepted).

#if WinActive("ahk_class TLister")       ; preview window
or  WinActive("ahk_class TFileCompForm") ; file comparison

  j::
  {
    Send, ^{Down}
    Return
  }

  k::
  {
    Send, ^{Up}
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

;                           DIALOGS WITH INPUT                            {{{1
; ============================================================================
;
; Have to be after the specialized mappings (if there are multiply maps, then
; the first one will be accepted).

#if WinActive("ahk_class TInpComboDlg")  ; copy/move
or  WinActive("ahk_class TCheckEditBox") ; new file
or  WinActive("ahk_class TCOMBOINPUT")   ; new dir
or  WinActive("ahk_class TQUICKSEARCH")  ; quicksearch
or  WinActive("ahk_class TMultiRename")  ; rename multiply files
or  WinActive("ahk_class TFileCompForm") ; file comparison
or  WinActive("ahk_class #32770")        ; delete file prompt

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
    Send, {Delete}
    Return
  }

  ^u::
  {
    Send, +{Home}{Delete}
    Return
  }

#if
