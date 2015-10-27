; http://autohotkey.com/board/topic/50154-virtual-desktops-extras-for-win7/

#NoEnv
#KeyHistory 0
#SingleInstance force
#HotkeyInterval 100
#MaxHotkeysPerInterval 255
#MaxThreadsPerHotkey 1
SetWorkingDir %A_ScriptDir%
Process, Priority,, R
SetWinDelay, -1
SetBatchLines,-1
SetKeyDelay, -1
CoordMode, Mouse, Screen
DetectHiddenWindows, Off
OnExit, CleanAndQuit

SetFormat,FLOAT, 6.2

	xMAX := A_ScreenWidth-1
	yMAX := A_ScreenHeight-1

	xWM_DeskCurrent := 0
	OnRun := "`n"

	IniRead("config.ini")

	Menu, xWM_WinMenu, Add, %Str_WinFullscr%, xWM_WinMenuExec
	Menu, xWM_WinMenu, Add, %Str_WinOntop%, xWM_WinMenuExec
	Menu, xWM_WinMenu, Add, %Str_WinSticky%, xWM_WinMenuExec

	Gdip_StartStop()

	if xWM_DeskCount {
		DllCall("SetWinEventHook", "uint", 10, "uint", 11, "uint", 0
			, "uint", RegisterCallback("xWM_OnDragWindow", "F" )
			, "uint", 0, "uint", 0, "uint", 0)
		SetTimer, xWM_CheckActive, 250
	}

Return

xWM_CheckActive()
{
Global xWM_sMinimized
	, xWM_sDesktop
	, Str_FnNotDef
	, OnRun
Static hActive, OnRunID

	hwnd := WinExist("A")
	if (hwnd=hActive)
		return
	hActive := hwnd
	WinGet, s, Style, ahk_id %hwnd%
	if not (s & 0x80000)
		return
	if InStr(xWM_sMinimized, hwnd . ",") {
		WinSet, Enable,, ahk_id %hwnd%
		a := InStr(xWM_sMinimized, ",", 1, InStr(xWM_sMinimized, hwnd . ",") )+1
		a := SubStr(xWM_sMinimized, a, InStr(xWM_sMinimized, "¤", 1, a)-a)
		StringReplace, xWM_sMinimized, xWM_sMinimized, %hwnd%`,%a%¤
		a := a = "Off" ? 255 : a
		t := 16
		Loop
		{
			t +=round(A_Index*1.7)
			if (t>a) {
				a := a = 255 ? "Off" : a
				break
			}
				WinSet,Transparent, %t%, ahk_id %hwnd%
			Sleep, 20
		}
		WinSet,Transparent, %a%, ahk_id %hwnd%
	}
	else if InStr(xWM_sDesktop, hwnd . ",") {
		t := SubStr(xWM_sDesktop, InStr(xWM_sDesktop, ",", 1, InStr(xWM_sDesktop, hwnd . ",")+1)+1, 1)
		xWM_SwitchDesk("!" . t)
	}

	WinGetClass, class, ahk_id %hwnd%

	if InStr(OnRun, "`n" . class . "=") && not InStr(OnRunID, hwnd . ",") {
		t := hwnd ","
		Loop, Parse, OnRunID, `,
		{
			IfWinExist ahk_id %A_LoopField%
				t .= A_LoopField ","
		}
		OnRunID := t
		p := InStr(OnRun, "=", 1, InStr(OnRun, "`n" . class . "="))
		t := SubStr(OnRun, p+1, InStr(OnRun, "`n", 1, p+1)-p-1 )
		if IsFunc(t)
			%t%(hwnd)
		else
			Msgbox %Str_FnNotDef% : %t%
	}

}

xWM_CheckActive:
	xWM_CheckActive()
Return

CleanAndQuit()
{
Local s, s0, s1, s2, s3, s4, d

	DetectHiddenWindows, On
	if (A_ExitReason="Reload") {
		d := ""
		Loop, Parse, xWM_sDesktop, ¤
		{
			if not A_LoopField
				continue
			StringSplit, s, A_LoopField, `,
			if WinExist("ahk_id" . s1) {
				s2 := s2<xWM_DeskCurrent ? s2-xWM_DeskCurrent+xWM_DeskCount+1 : s2-xWM_DeskCurrent
				d .= s1 "," s2 "," s3 "," s4 "¤"
				}
			}
		xWM_sDesktop := d
	}
	else {
		xWM_WinRestore()
		Loop, Parse, xWM_sDesktop, ¤
		{
			StringSplit, s, A_LoopField, `,
			WinShow, ahk_id %s1%
			WinSet, Enable,, ahk_id %s1%
			WinSet, Transparent, %s3%, ahk_id %s1%
		}
		xWM_sDesktop := ""
		xWM_sMinimized := ""
	}

	IniWrite, %xWM_sDesktop%, config.ini, xWM, sDesktop
	IniWrite, %xWM_sMinimized%, config.ini, xWM, sMinimized

	Gdip_StartStop()
	if Opt_OnExitClearRecents {
		EnvGet,s, USERPROFILE
		FileDelete, %s%\Recent\*.*
	}
	if Opt_OnExitClearTemp {
		Loop, %A_Temp%\*.*, 1, 1
		{
			FileSetAttrib, -RS, %A_LoopFileLongPath%
			if Instr(FileExist(A_LoopFileLongPath), "D")
				FileRemoveDir, %A_LoopFileLongPath%, 1
			else
				FileDelete, %A_LoopFileLongPath%
		}
	}
	ExitApp
}

CleanAndQuit:
	CleanAndQuit()
Return

IniRead(f)
; Read a whole .ini file and creates variables like this:
; %Section%%Key% = %value%
{
Local s, c, p, key, k

	FileRead, s, %f%
	Loop, Parse, s, `n`r, %A_Space%%A_Tab%
	{
		c := SubStr(A_LoopField, 1, 1)
		if (c="[")
			key := SubStr(A_LoopField, 2, -1)
		else if (c=";")
			continue
		else if (key="OnRun")
			OnRun .= A_LoopField "`n"
		else {
			p := InStr(A_LoopField, "=")
			if p {
				k := SubStr(A_LoopField, 1, p-1)
				%key%_%k% := SubStr(A_LoopField, p+1)
			}
		}
	}
}

;
;	DESKTOP FUNCTIONS
;

Dwm_RegisterThumbnail(source, target, sx, sy, sw, sh, dx, dy, dw, dh, alpha=255)
{

	dwFlags:=0X7
;	DWM_TNP_RECTDESTINATION (0x00000001)		Indicates a value for rcDestination has been specified.
;	DWM_TNP_RECTSOURCE (0x00000002)			Indicates a value for rcSource has been specified.
;	DWM_TNP_OPACITY (0x00000004)				Indicates a value for opacity has been specified.
;	DWM_TNP_VISIBLE (0x00000008)				Indicates a value for fVisible has been specified.
;	DWM_TNP_SOURCECLIENTAREAONLY (0x00000010)	Indicates a value for fSourceClientAreaOnly has been specified.
	fVisible:=1
	fSourceClientAreaOnly:=1

	VarSetCapacity(struct,45,0)
	VarSetCapacity(thumbnail,4,0)

	;struct _DWM_THUMBNAIL_PROPERTIES
	NumPut(dwFlags,struct,0,"UInt")
	NumPut(dx,struct,4,"Int")
	NumPut(dy,struct,8,"Int")
	NumPut(dw,struct,12,"Int")
	NumPut(dh,struct,16,"Int")
	NumPut(sx,struct,20,"Int")
	NumPut(sy,struct,24,"Int")
	NumPut(sw,struct,28,"Int")
	NumPut(sh,struct,32,"Int")
	NumPut(alpha,struct,36,"UChar")
	NumPut(fVisible,struct,37,"Int")
	NumPut(fSourceClientAreaOnly,struct,41,"Int")

	DllCall("dwmapi.dll\DwmRegisterThumbnail","UInt",target,"UInt",source,"UInt",&thumbnail)
	thumbnail:=NumGet(thumbnail)
	DllCall("dwmapi.dll\DwmUpdateThumbnailProperties","UInt",thumbnail,"UInt",&struct)

	Return thumbnail
}

Dwm_UnregisterThumbnail(thumbnail)
{
	return DllCall("dwmapi.dll\DwmUnregisterThumbnail","UInt",thumbnail)
}

xWM_DoesWinReact(hwnd=0)
{
; Original code by Lexikos: http://www.autohotkey.com/forum/viewtopic.php?p=331659#331659
    static WM_KEYDOWN=0x100, WM_KEYUP=0x101, vk_to_use=7
    ; Test whether we can send keystrokes to this window.
    ; Use a virtual keycode which is unlikely to do anything:
    PostMessage, WM_KEYDOWN, vk_to_use, 0,, ahk_id %hwnd%
    if !ErrorLevel
    {   ; Seems best to post key-up, in case the window is keeping track.
        PostMessage, WM_KEYUP, vk_to_use, 0xC0000000,, ahk_id %hwnd%
        return true
    }
    return false
}

xWM_WinRestore()
; restore all minimized windows
{
Global xWM_sMinimized

	Loop, Parse, xWM_sMinimized, ¤
	{
		if not A_LoopField
			continue
		StringSplit, s, A_LoopField, `,
		WinSet, Enable,, ahk_id %s1%
		WinSet, Transparent, %s2%, ahk_id %s1%
	}
	xWM_sMinimized :=
}

xWM_WinToggle()
; hide or show windows of the current desktop
{
Global xWM_sMinimized

	w := A_ScreenWidth
	h := A_ScreenHeight

	pBitmap := Gdip_BitmapFromScreen(0, 0, w, h, 0x40CC0020)

	hdc := CreateCompatibleDC()
	hbm := CreateDIBSection(w, h, hdc)
	obm := SelectObject(hdc, hbm)
	G := Gdip_GraphicsFromHDC(hdc)
	Gdip_SetSmoothingMode(G, 1)
	Gdip_SetInterpolationMode(G, 1)
	Gdip_DrawImage(G, pBitmap, 0, 0, w, h, 0, 0, w, h)
	Gdip_DisposeImage(pBitmap)

	hwnd := CreateWindowEx("", 0x80800A8, 0x90000000, 0, "Static")
	UpdateLayeredWindow(hwnd, hdc, 0, 0, w, h)

	if xWM_sMinimized
		xWM_WinRestore()
	else {
		WinGet, id, List
		Loop, %id%
		{
			id := id%A_Index%
			WinGet, s, Style, ahk_id %id%
			WinGet, t, MinMax, ahk_id %id%
			WinGet, a, Transparent, ahk_id %id%
			if a is not Integer
				a := "Off"
			if xWM_DoesWinReact(id) && a && (t>=0) && (s & 0x80000) {
				xWM_sMinimized .= id "," a "¤"
				WinSet, Transparent, 0, ahk_id %id%
				WinSet, Disable,, ahk_id %id%
			}
		}
		WinActivate, Program Manager
	}
	a := 255
	Loop
	{
		a -=round(A_Index*1.7)
		if (a<16)
			break
		UpdateLayeredWindow(hwnd, hdc, 0, 0, w, h, a)
		Sleep, 20
	}
	Gdip_DeleteGraphics(G)
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	WinClose, ahk_id %hwnd%
}

xWM_HideOthersToggle()
{
Global xWM_DeskCurrent
	, xWM_HideOtherDesks
	, xWM_sDesktop

	xWM_ActivateTopmost()
	xWM_HideOtherDesks := xWM_HideOtherDesks ? 0 : 1

	DetectHiddenWindows, On
	Loop, Parse, xWM_sDesktop, ¤
	{
		StringSplit, s, A_LoopField, `,
		if xWM_HideOtherDesks && (s2<>xWM_DeskCurrent)
			WinHide, ahk_id %s1%
		else
			WinShow, ahk_id %s1%
	}
	DetectHiddenWindows, Off
	IniWrite, %xWM_HideOtherDesks%, config.ini, xWM, HideOtherDesks
}

xWM_SwitchDesk(d, st=0)
; switch to the desired desktop
; if d is integer, it's an offset from the current desk
; if d starts with "!", it's an absolute desktop number
; st is the handle of a sticky window
{
Global xWM_sDesktop
	, xWM_DeskCurrent
	, xWM_DeskCount
	, xWM_DeskSpeed
	, xWM_HideOtherDesks
	, xWM_Sticky
	, xMAX

	if not xWM_DeskCount
		return

	SetTimer, xWM_CheckActive, Off

	if d is not integer
	{
		n := SubStr(d, 2)-xWM_DeskCurrent
		m := abs(n)
		if (m>xWM_DeskCount//2) {
			if (n<0)
				n := (xWM_DeskCount+1)+n
			else
				n := n-(xWM_DeskCount+1)
			m := abs(n)
		}
		d := n//m
		n := m
	}
	else
		n := 1
	speed := d*xWM_DeskSpeed

	Loop, %n%
	{
		x := d>0 ? 0 : -A_ScreenWidth
		hwnd := CreateWindowEx("", 0x80800A8, 0x90000000, 0, "Static", x, 0, A_ScreenWidth*2, A_ScreenHeight)
		DllCall("SetWindowPos", "UInt", hWnd, "UInt", st, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x53)

		WinGet, id, List
		list := ""
		Loop, %id%
		{
			id := id%A_Index%
			list := id "," list
		}
		Loop, Parse, list, `,
		{
			if not A_LoopField
				continue
			WinGet, s, Style, ahk_id %A_LoopField%
			WinGet, t, MinMax, ahk_id %A_LoopField%
			WinGet, a, Transparent, ahk_id %A_LoopField%
			WinGetClass, c, ahk_id %A_LoopField%
			if a is not Integer
				a := "255"
			if xWM_DoesWinReact(A_LoopField) && a && (t>=0) && (s & 0x80000) && (A_LoopField<>st) {
				if not InStr(xWM_Sticky, c "¤") {
					xWM_sDesktop .= A_LoopField "," xWM_DeskCurrent "," a "¤"
					WinSet, Disable,, ahk_id %A_LoopField%
					WinGetPos, x, y, w, h, ahk_id %A_LoopField%
					x := d>0 ? x : x+A_ScreenWidth
					Dwm_RegisterThumbnail(A_LoopField, hwnd, 0, 0, w, h, x, y, x+w, y+h, a)
				}
				WinGet, x, ExStyle, ahk_id %A_LoopField%
				if (x & 8)
					DllCall("SetWindowPos", "UInt", hWnd, "UInt", A_LoopField, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x13)
			}
		}
		deskcur := xWM_DeskCurrent
		xWM_DeskCurrent += d
		if (xWM_DeskCurrent<0)
			xWM_DeskCurrent := xWM_DeskCount
		else if (xWM_DeskCurrent>xWM_DeskCount)
			xWM_DeskCurrent := 0

		DetectHiddenWindows, On
		Loop, Parse, xWM_sDesktop, ¤
		{
			if not A_LoopField
				continue
			StringSplit, s, A_LoopField, `,
			if WinExist("ahk_id" . s1) {
				if (s2=xWM_DeskCurrent) {
					WinShow, ahk_id %s1%
					WinGetPos, x, y, w, h, ahk_id %s1%
					x := d>0 ? x+A_ScreenWidth : x
					Dwm_RegisterThumbnail(s1, hwnd, 0, 0, w, h, x, y, x+w, y+h, s3)
				}
			}
			else
				StringReplace, xWM_sDesktop, xWM_sDesktop, %A_LoopField%¤
		}
		DetectHiddenWindows, Off
		Loop, Parse, xWM_sDesktop, ¤
		{
			if not A_LoopField
				continue
			StringSplit, s, A_LoopField, `,
			if (s2=deskcur)
				WinSet, Transparent, 0, ahk_id %s1%
		}
		x := d>0 ? 0 : -A_ScreenWidth
		Loop
		{
			x -= speed
			if ((d<0) && (x>0)) or ((d>0) && (x<-A_ScreenWidth))
				break
			WinMove, ahk_id %hwnd%, , x, 0
			if st {
				MouseGetPos, w, h
				w -= speed
				w := w<32 ? 32 : ( w>A_ScreenWidth-32 ? A_ScreenWidth-32 : w )
				MouseMove, %w%, %h%, 0
			}
			else
				Sleep, 10
		}

		Loop, Parse, xWM_sDesktop, ¤
		{
			if not A_LoopField
				continue
			StringSplit, s, A_LoopField, `,
			if (s2=xWM_DeskCurrent) {
				StringReplace, xWM_sDesktop, xWM_sDesktop, %A_LoopField%¤
				s3 := s3=255 ? "Off" : s3
				WinSet, Transparent, %s3%, ahk_id %s1%
				WinSet, Enable,, ahk_id %s1%
			}
			else if xWM_HideOtherDesks && (s2=deskcur)
				WinHide, ahk_id %s1%
		}
		WinClose, ahk_id %hwnd%
	}

	if not st
		xWM_ActivateTopmost()
	SetTimer, xWM_CheckActive, 250
}

xWM_OnDragWindow(hWinEventHook, event, hWnd, idObject, idChild, dwEventThread, dwmsEventTime )
{

	if (event & 1) {
		SetTimer, xWM_OnDragWindow, Off
		return
	}
	MouseGetPos, x, y, hwnd
	SendMessage, 0x84,, x|y<<16,, ahk_id %hwnd%
	if (ErrorLevel=2)
		SetTimer, xWM_OnDragWindow, 20
}

xWM_OnDragWindow:
	MouseGetPos, x
	if not x {
		Sleep, xWM_WndSwitchDelay
		MouseGetPos, x
		if x
			return
		SetTimer, xWM_OnDragWindow, Off
		xWM_SwitchDesk(-1, WinExist("A"))
		Sleep, 500
		SetTimer, xWM_OnDragWindow, 20
	}
	else if (x=xMAX) {
		Sleep, xWM_WndSwitchDelay
		MouseGetPos, x
		if (x<>A_ScreenWidth-1)
			return
		SetTimer, xWM_OnDragWindow, Off
		xWM_SwitchDesk(1, WinExist("A"))
		Sleep, 500
		SetTimer, xWM_OnDragWindow, 20
	}
return

;
;	WINDOWS FUNCTIONS
;

xWM_ActivateTopmost()
; activate the topmost captioned window
; from the current desktop
{
Global xWM_Sticky

	WinGet, id, List
	Loop, %id%
	{
		id := id%A_Index%
		WinGet, s, Style, ahk_id %id%
		WinGet, xs, ExStyle, ahk_id %id%
		WinGet, t, MinMax, ahk_id %id%
		WinGet, a, Transparent, ahk_id %id%
		WinGetClass, c, ahk_id %id%
		if a is not Integer
			a := "255"
		if not (InStr(xWM_Sticky, c "¤") or (xs & 8)) && a && (t>=0) && (s & 0x80000)
			break
	}
	WinActivate, ahk_id %id%
}

xWM_FullScrToggle(hwnd)
{
Global xWM_sFullScr

	if Instr(xWM_sFullScr, hwnd . ",") {
		s := SubStr(xWM_sFullScr, InStr(xWM_sFullScr, hwnd . ","))
		StringSplit, s, s, `,
		if s7
			DllCall("SetMenu", "UInt", hwnd, "UInt", s7)
		WinSet, Style, %s6%, ahk_id %hwnd%
		WinMove, ahk_id %hwnd%,, %s2%, %s3%, %s4%, %s5%
		StringReplace, xWM_sFullScr, xWM_sFullScr, %s1%`,%s2%`,%s3%`,%s4%`,%s5%`,%s6%`,%s7%
	}
	else {
		WinGetPos, x, y, w, h, ahk_id %hwnd%
		WinGet, s, Style, ahk_id %hwnd%
		m := DllCall("GetMenu", "UInt", hwnd)
		if m
			DllCall("SetMenu", "UInt", hwnd, "UInt", 0)
		WinSet, Style, -0x40000, ahk_id %hwnd%
		xWM_sFullScr .= hwnd . "," x "," y "," w "," h "," s "," m "*"
		WinMove, ahk_id %hwnd%,, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%
	}
}

;
;	MOUSE FUNCTIONS
;

EasyWheel(d)
; if xWM_ActivateOnWheel if set, check which window is under the mouse and gives it focus if it hasn't already
; then send scroll event to the control under the mouse
; if the mouse is over the titlebar then change the transparency level of the window
; original "Accelerate Wheel" code from Shimanov: http://www.autohotkey.com/forum/viewtopic.php?t=6772#54821
{
Global xWM_WheelAccel
	, xWM_WheelMaxSpeed
	, xWM_ActivateOnWheel
	, Str_WinOpacity

Static t, s, title, title_id

	if not d {
		if title
			WinSetTitle, ahk_id %title_id%,, %title%
		title := 0
		return
	}
	if (A_TickCount>500+t) {
		t := A_TickCount
		s :=0x780000
	}
	else if (s<xWM_WheelMaxSpeed)
		s += xWM_WheelAccel*A_EventInfo

	MouseGetPos x, y, hwnd, a, 1
	if InStr(a, "ComboLBox") {
		if (d=1)
			Mouseclick, WU
		else if (d=-1)
			MouseClick, WD
		return
	}
	SendMessage, 0x84,, x|y<<16,, ahk_id %hwnd%
	if (ErrorLevel=2) {
		if not title {
			WinGetTitle, title, ahk_id %hwnd%
			title_id := hwnd
		}
		WinGet, a, Transparent, ahk_id %hwnd%
		if not a
			a := 255
		a += d*5
		if (a<27)
			a := 27
		else if (a>255)
			a := "Off"
		WinSet, Transparent, %a%, ahk_id %hwnd%
		if (a<>"Off") {
			a := 100*a//255 . "%"
			WinSetTitle, ahk_id %hwnd%,, %Str_WinOpacity%: %a%
		}
		SetTimer, EasyWheel, Off
		SetTimer, EasyWheel, -500
		return
	}
	h := DllCall("WindowFromPoint", "int", x, "int", y)
	if xWM_ActivateOnWheel && (hwnd<>WinExist("A"))
		WinActivate, ahk_id %hwnd%
	SendMessage, 0x20A, d*s,(y<<16)|x,, ahk_id %h%
}

EasyWheel:
	EasyWheel(0)
return

RButton()
{
Global xMAX
	, xWM_WinMenu
	, xWM_sFullScr
	, xWM_Sticky
	, Str_WinOnTop
	, Str_WinSticky
	, Str_WinFullscr

	MouseGetPos, x, y, hwnd
	WinGet, s, Style, ahk_id %hwnd%
	if y {
		SendMessage, 0x84,, x|y<<16,, ahk_id %hwnd%
		if not ((ErrorLevel & 2)  && (s & 0x80000)) {
			MouseClick, R,,,, 0, D
			return
		}
	}
	WinActivate, ahk_id %hwnd%
	KeyWait, RButton
	xWM_WinMenu := hwnd
	WinGet, s, ExStyle, ahk_id %hwnd%
	WinGetClass, c, ahk_id %hwnd%
	f := InStr(xWM_sFullScr, hwnd . ",") ? "Check" : "UnCheck"
	c := InStr(xWM_Sticky, c . "¤") ? "Check" : "UnCheck"
	s := (s & 8) ? "Check" : "UnCheck"
	Menu, xWM_WinMenu, %s%, %Str_WinOnTop%
	Menu, xWM_WinMenu, %c%, %Str_WinSticky%
	Menu, xWM_WinMenu, %f%, %Str_WinFullscr%
	Menu, xWM_WinMenu, Show
	Sleep, 500
	xWM_WinMenu := 0
}

xWM_WinMenuExec()
{
Global Str_WinOntop
	, Str_WinSticky
	, Str_WinFullscr
	, xWM_WinMenu
	, xWM_Sticky

	if (A_ThisMenuItem=Str_WinOntop)
		WinSet, AlwaysOnTop, Toggle, ahk_id %xWM_WinMenu%
	else if (A_ThisMenuItem=Str_WinSticky) {
		WinGetClass, class, ahk_id %xWM_WinMenu%
		if InStr(xWM_Sticky, class . "¤")
			StringReplace, xWM_Sticky, xWM_Sticky, %class%¤
		else
			xWM_Sticky .= class . "¤"
		IniWrite, %xWM_Sticky%, config.ini, xWM, Sticky
	}
	else if (A_ThisMenuItem=Str_WinFullscr)
		xWM_FullScrToggle(xWM_WinMenu)
}

xWM_WinMenuExec:
	xWM_WinMenuExec()
return

#Include, %A_ScriptDir%\gdi+.ahk

test(hwnd)
{
MsgBox, Explorer will be move to the 2nd desktop.
xWM_SwitchDesk("!1", hwnd)
}

;
;	HOTKEYS AND REMAPING
;

; Ctrl+Win+L = debug
^#L:: Listvars
; Control+Alt+Escape = Reload
^!ESC::Reload

; WIN+D = minimize/restore windows
#D:: xWM_WinToggle()
; virtual desktop switching
; #Left:: xWM_SwitchDesk(-1)
; #Right:: xWM_SwitchDesk(1)
#Tab::   xWM_SwitchDesk(1)
; ^#Left:: xWM_SwitchDesk(-1, WinExist("A"))
; ^#Right:: xWM_SwitchDesk(1, WinExist("A"))
^#Tab::   xWM_SwitchDesk(1, WinExist("A"))

; Hide other desks windows toggle
^#H::xWM_HideOthersToggle()

; EasyWheel
WheelUp:: EasyWheel(1)
WheelDown:: EasyWheel(-1)

RButton:: RButton()
RButton Up::
	if GetKeyState("RButton")
		MouseClick, R,,,, 0, U
return

!Enter::
	xWM_FullScrToggle(WinExist("A"))
return
