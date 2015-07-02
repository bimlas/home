; http://lifehacker.com/i-call-this-script-transparentwindow-if-you-press-c-507682980
; C-S-T to make window transparent

;Init
{
#Persistent
#SingleInstance force
  CoordMode, Mouse, Screen
    SetTitleMatchMode, 2

    SetupTrayMenu()

    GUI_HIDE_TIME = 3000
    FADE_STEP_AMT = 10
    Return
}

SetupTrayMenu()
{
  Menu, Tray, NoStandard

    Menu, Tray, Add, Remove transparency from all windows, ShowAll
    Menu, Tray, Add

    Menu, Tray, Standard

    Return
}

ShowAll:
{
  WinGet, id, list

    Loop, %id%
    {
      WinSet, Transparent, Off, % "ahk_id" id%A_Index%
    }

  Return
}

^+T::
{
  GetTransInfo(true)
    Return
}

GetTransInfo(bUseWinUnderMouse)
{
  global g_iPosX
    global g_iPosY
    global g_iActiveWinID
    global g_bWinOnTop

    IfWinExist, TransGui
    {
      Gui, Destroy
    }
  Else
  {
    If( bUseWinUnderMouse )
    {
      MouseGetPos, g_iPosX, g_iPosY, g_iActiveWinID
    }

    WinGet, hWinExStyle, ExStyle, ahk_id %g_iActiveWinID%

      ; 0x8 is WS_EX_TOPMOST.
      g_bWinOnTop := (hWinExStyle & 0x8) > 0

      CreateGui()
  }
  Return
}

CreateGui()
{
  global g_iTransAmt
    global g_iTransText
    global g_iActiveWinID
    global g_bWinOnTop
    global g_iPosX
    global g_iPosY
    global GUI_HIDE_TIME

    Gui, Destroy

    WinGet, g_iTransAmt, Transparent, ahk_id %g_iActiveWinID%

    If(g_iTransAmt == "")
    {
      g_iTransAmt = 255
    }

g_iTransAmt := Round( g_iTransAmt / 2.55 )

               Gui, +ToolWindow -Caption +Border +AlwaysOnTop

               Gui, Add, Text, w25 vg_iTransText, %g_iTransAmt%`%

               Gui, Add, Slider, Vertical Invert NoTicks AltSubmit Center Line5 Page100 Buddy1g_iTransText Buddy2g_bWinOnTop gChangeWinTrans vg_iTransAmt, %g_iTransAmt%

               Gui, Add, Checkbox, vg_bWinOnTop gChangeWinTop Checked%g_bWinOnTop%, Top

               Gui, Margin, 0

               GetGuiPos()

               Gui, Show, x%g_iPosX% y%g_iPosY%, TransGui

               SetTimer, CheckToHide, %GUI_HIDE_TIME%

               Return
}

GetGuiPos()
{
  global g_iPosY
    global g_iPosX
    global g_iTransAmt

    SysGet, iVirtualScreenHeight, 79
    SysGet, iVirtualScreenWidth, 78

    If( g_iPosX < 22 )
    {
      g_iPosX = 0
    }
  Else If( g_iPosX > iVirtualScreenWidth - 29 )
  {
g_iPosX := iVirtualScreenWidth - 51
  }
  Else
  {
    g_iPosX -= 22
  }

  If( g_iPosY < 40 )
  {
    g_iPosY = 0
  }
  Else If( g_iPosY > iVirtualScreenHeight - 77 )
  {
g_iPosY := iVirtualScreenHeight - 115
  }
  Else
  {
    g_iPosY -= (78 - (Round(g_iTransAmt/2.63)))

  }

  Return
}

CheckToHide:
{
  MouseGetPos,,,iCurWinId
    WinGet, iTransGuiID,,TransGui

    If( iCurWinId == iTransGuiID )
    {
      SetTimer, CheckToHide, %GUI_HIDE_TIME%
    }
  Else
  {
    HideGui()
  }
  Return
}

HideGui()
{
  global g_iHideFadeAmt

    g_iHideFadeAmt = 255
    SetTimer, MiniLoop, 1

    SetTimer, CheckToHide, Off
    Return
}

MiniLoop:
{
  If( g_iHideFadeAmt <= 0)
  {
    Gui, Destroy
      SetTimer, MiniLoop, Off
  }
  Else
  {
    WinSet, Transparent, %g_iHideFadeAmt%, TransGui
      g_iHideFadeAmt -= %FADE_STEP_AMT%
  }

  Return
}

ChangeWinTop:
{
  SetTimer, CheckToHide, %GUI_HIDE_TIME%
    SetTimer, MiniLoop, Off
    WinSet, Transparent, 255, TransGui

    GuiControlGet, g_bWinOnTop
    If( g_bWinOnTop )
    {
      WinSet, AlwaysOnTop, On, ahk_id %g_iActiveWinID%
        WinSet, AlwaysOnTop, On, TransGui
    }
  Else
  {
    WinSet, AlwaysOnTop, Off, ahk_id %g_iActiveWinID%
  }

  Return
}

ChangeWinTrans:
{
  Sleep 100

    GuiControlGet, g_iTransAmt

    SetTimer, CheckToHide, %GUI_HIDE_TIME%
    SetTimer, MiniLoop, Off

    WinSet, Transparent, 255, TransGui

    If(g_iTransAmt == 100)
    {
      WinSet, Transparent, Off, ahk_id %g_iActiveWinID%
    }
  Else
  {
iRealTransAmt := Round( g_iTransAmt * 2.55 )
                 WinSet, Transparent, %iRealTransAmt%, ahk_id %g_iActiveWinID%
  }

  GuiControl,, g_iTransText, %g_iTransAmt%`%
    iRealTransAmt =
    Return
}
