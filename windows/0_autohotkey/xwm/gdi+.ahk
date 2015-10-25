Gdip_StartStop()
{
Static pToken

	if !pToken
	{
		If !DllCall("GetModuleHandle", "Str", "gdiplus")
		DllCall("LoadLibrary", "Str", "gdiplus")
		VarSetCapacity(si, 16, 0), si := Chr(1)
		DllCall("gdiplus\GdiplusStartup", "UInt*", pToken, "UInt", &si, "UInt", 0)
		return
	}

	DllCall("gdiplus\GdiplusShutdown", "UInt", pToken)
	If hModule := DllCall("GetModuleHandle", "Str", "gdiplus")
	DllCall("FreeLibrary", "UInt", hModule)
}

;
;		WINDOWS FUNCTIONS
;

CreateWindowEx(lpWindowName="", dwExStyle=0x80080, dwStyle=0x90000000, hWndParent="", lpClassName="ObjectivShell", x=0, y=0, w=0, h=0)
; WS_POPUP			:= 0x80000000
; WS_VISIBLE			:= 0x10000000
; WS_EX_LAYERED		:= 0x00080000
; WS_EX_TOOLWINDOW	:= 0x00000080
; WS_EX_TOPMOST		:= 0x00000008

{
	hwnd := DllCall("CreateWindowEx"
	, "uInt", dwExStyle
	, "Str", lpClassName
	, "Str", lpWindowName
	, "uInt", dwStyle
	, "Int", x
	, "Int", y
	, "Int", w
	, "Int", h
	, "uInt", hWndParent
	, "uInt",hMenu
	, "uInt", hInstance
	, "uInt", lpParam)
	if (dwExStyle & 0x10)
		DllCall("shell32.dll\DragAcceptFiles", "uInt", hwnd, "uInt", True)
	return hwnd
}

UpdateLayeredWindow(hwnd, hdc, x, y, w, h, Alpha=255)
{
	return DllCall("UpdateLayeredWindow"
	, "UInt", hwnd
	, "UInt", 0
	, "UInt*", x|y<<32
	, "Int64*", w|h<<32
	, "UInt", hdc
	, "Int64*", 0
	, "UInt", 0
	, "UInt*", Alpha<<16|0x1000000
	, "UInt", 2)
}

;
;		GDI FUNCTIONS
;

BitBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, Raster="")
{
	Return, DllCall("gdi32\BitBlt"
	, "UInt", dDC
	, "Int", dx
	, "Int", dy
	, "Int", dw
	, "Int", dh
	, "UInt", sDC
	, "Int", sx
	, "Int", sy
	, "UInt", Raster ? Raster : 0x00CC0020)
}

GetDC(hwnd=0)
{
	return DllCall("GetDC", "UInt", hwnd)
}

CreateCompatibleDC(hdc=0)
{
	return DllCall("CreateCompatibleDC", "UInt", hdc)
}

ReleaseDC(hdc, hwnd=0)
{
	return DllCall("ReleaseDC", "UInt", hwnd, "UInt", hdc)
}

DeleteDC(hdc)
{
	return DllCall("DeleteDC", "UInt", hdc)
}

SelectObject(hdc, hgdiobj)
{
	return DllCall("SelectObject", "UInt", hdc, "UInt", hgdiobj)
}

DeleteObject(hObject)
{
	return DllCall("DeleteObject", "UInt", hObject)
}

CreateDIBSection(w, h, hdc, bpp=32, ByRef ppvBits=0)
{
	VarSetCapacity(bi, 40, 0)
	NumPut(w, bi, 4), NumPut(h, bi, 8), NumPut(40, bi, 0), NumPut(1, bi, 12, "UShort"), NumPut(0, bi, 16), NumPut(bpp, bi, 14, "UShort")
	Return DllCall("CreateDIBSection", "UInt" , hdc, "UInt" , &bi, "UInt" , 0, "UInt*", ppvBits, "UInt" , 0, "UInt" , 0)
}

;
;		STRUCTURE FUNCTIONS
;

CreateRectF(ByRef RectF, x, y, w, h)
; Creates a RectF object, containing the coordinates and dimensions of a rectangle
{
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "Float"), NumPut(y, RectF, 4, "Float"), NumPut(w, RectF, 8, "Float"), NumPut(h, RectF, 12, "Float")
}

;
;		BITMAP FUNCTIONS
;

Gdip_CreateBitmap(Width, Height, Format=0x26200A)
{
	DllCall("gdiplus\GdipCreateBitmapFromScan0", "Int", Width, "Int", Height, "Int", 0, "Int", Format, "UInt", 0, "UInt*", pBitmap)
	return pBitmap
}

Gdip_BitmapFromHWND(hwnd, w, h)
{
	hdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, hdc), obm := SelectObject(hdc, hbm)
	DllCall("PrintWindow", "UInt", hwnd, "UInt", hdc, "UInt", 0)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	Return, pBitmap
}

Gdip_BitmapFromScreen(x, y, w, h, Raster="")
{

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)

	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hhdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}

Gdip_CreateBitmapFromFile(sFile)
{
	VarSetCapacity(wFile, 1023)
	DllCall("kernel32\MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &sFile, "Int", -1, "UInt", &wFile, "Int", 512)
	DllCall("gdiplus\GdipCreateBitmapFromFile", "UInt", &wFile, "UInt*", pBitmap)
	return pBitmap
}

Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0)
{
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "UInt", hBitmap, "UInt", Palette, "UInt*", pBitmap)
	return pBitmap
}

Gdip_DisposeImage(pBitmap)
{
	return DllCall("gdiplus\GdipDisposeImage", "UInt", pBitmap)
}

Gdip_GetImageWidth(pBitmap)
{
	DllCall("gdiplus\GdipGetImageWidth", "UInt", pBitmap, "UInt*", Width)
	return Width
}

Gdip_GetImageHeight(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHeight", "UInt", pBitmap, "UInt*", Height)
	return Height
}

Gdip_BlurBitmap(pBitmap, Blur)
{
	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur

	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

	Gdip_DeleteGraphics(G1)
	Gdip_DisposeImage(pBitmap)

	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}

;
;		GRAPHICS FUNCTIONS
;

Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
{
	return DllCall("gdiplus\GdipSetSmoothingMode", "UInt", pGraphics, "Int", SmoothingMode)
}

Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
{
	return DllCall("gdiplus\GdipSetInterpolationMode", "UInt", pGraphics, "Int", InterpolationMode)
}

Gdip_SetCompositingMode(pGraphics, CompositingMode=0)
; CompositingModeSourceOver = 0 (blended)
; CompositingModeSourceCopy = 1 (overwrite)
{
	return DllCall("gdiplus\GdipSetCompositingMode", "UInt", pGraphics, "Int", CompositingMode)
}

Gdip_GraphicsFromHDC(hdc)
{
	DllCall("gdiplus\GdipCreateFromHDC", "UInt", hdc, "UInt*", pGraphics)
	return pGraphics
}

Gdip_GraphicsFromImage(pBitmap)
{
	DllCall("gdiplus\GdipGetImageGraphicsContext", "UInt", pBitmap, "UInt*", pGraphics)
	return pGraphics
}

Gdip_DeleteGraphics(pGraphics)
{
	return DllCall("gdiplus\GdipDeleteGraphics", "UInt", pGraphics)
}

Gdip_DrawImage(pGraphics, pBitmap, dx, dy, dw, dh, sx, sy, sw, sh, Matrix=1)
{
	If (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	Else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	DllCall("gdiplus\GdipDrawImageRectRect", "UInt", pGraphics, "UInt", pBitmap
	, "Float", dx, "Float", dy, "Float", dw, "Float", dh
	, "Float", sx, "Float", sy, "Float", sw, "Float", sh
	, "Int", 2, "UInt", ImageAttr, "UInt", 0, "UInt", 0)
	If ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
}

;MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1
Gdip_SetImageAttributesColorMatrix(Matrix)
{
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^0-9-\.]+([0-9\.])", "$1", "", 1), "[^0-9-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := Matrix%A_Index% ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "Float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", "UInt*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", "UInt", ImageAttr, "Int", 1, "Int", 1, "UInt", &ColourMatrix, "Int", 0, "Int", 0)
	VarSetCapacity(ColourMatrix, 0)
	return ImageAttr
}

Gdip_DisposeImageAttributes(ImageAttr)
{
	Return, DllCall("gdiplus\GdipDisposeImageAttributes", "UInt", ImageAttr)
}

Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
{
	return DllCall("gdiplus\GdipFillRectangle", "UInt", pGraphics, "Int", pBrush, "Float", x, "Float", y, "Float", w, "Float", h)
}

Gdip_GraphicsClear(pGraphics, ARGB=0x00ffffff)
{
	return DllCall("gdiplus\GdipGraphicsClear", "UInt", pGraphics, "Int", ARGB)
}

;
;		RESOURCES
;

Gdip_BrushCreateSolid(ARGB=0xff000000)
{
	DllCall("gdiplus\GdipCreateSolidFill", "Int", ARGB, "UInt*", pBrush)
	return pBrush
}

Gdip_DeleteBrush(pBrush)
{
	return DllCall("gdiplus\GdipDeleteBrush", "UInt", pBrush)
}

;
;		TEXT FUNCTIONS
;

Gdip_DrawText(pGraphics, Text, Font="", x=0, y=0, w=128, h=128)
{
	StringSplit, s, Font, `,
	; s1 = Font
	; s2 = Size
	; s3 = Color
	; s4 = Style
	; s5 = Align
	; s6 = vAlign
	; s7 = rendering type

  	nSize := DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &s1, "Int", -1, "UInt", 0, "Int", 0)
	VarSetCapacity(wFont, nSize*2)
	DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &s1, "Int", -1, "UInt", &wFont, "Int", nSize)
	DllCall("gdiplus\GdipCreateFontFamilyFromName", "UInt", &wFont, "UInt", 0, "UInt*", hFamily)
	DllCall("gdiplus\GdipCreateFont", "UInt", hFamily, "Float", s2, "Int", s4, "Int", 0, "UInt*", hFont)

	CreateRectF(RC, 0, 0, w, h)
	DllCall("gdiplus\GdipSetTextRenderingHint", "UInt", pGraphics, "Int", s7)
	DllCall("gdiplus\GdipCreateStringFormat", "Int", 0x4000, "Int", 0, "UInt*", hFormat)

	nSize := DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &Text, "Int", -1, "UInt", 0, "Int", 0)
	VarSetCapacity(wString, nSize*2)
	DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "UInt", &Text, "Int", -1, "UInt", &wString, "Int", nSize)
	VarSetCapacity(ReturnRC, 16)
	DllCall("gdiplus\GdipMeasureString", "UInt", pGraphics, "UInt", &wString, "Int", -1, "UInt", hFont, "UInt", &RC, "UInt", hFormat, "UInt", &ReturnRC, "UInt*", Chars, "UInt*", Lines)

	if (s6=1)
		y := y
	else If (s6=2)
		y := h-NumGet(ReturnRC, 12, "Float")
	else
		y := (h-NumGet(ReturnRC, 12, "Float"))//2
	CreateRectF(RC, x, y, w, NumGet(ReturnRC, 12, "Float"))

	pBrush := Gdip_BrushCreateSolid(s3)
	DllCall("gdiplus\GdipSetStringFormatAlign", "UInt", hFormat, "Int", s5)
	DllCall("gdiplus\GdipDrawString", "UInt", pGraphics, "UInt", &wString, "Int", -1, "UInt", hFont, "UInt", &RC, "UInt", hFormat, "UInt", pBrush)

	Gdip_DeleteBrush(pBrush)
	DllCall("gdiplus\GdipDeleteStringFormat", "UInt", hFormat)
	DllCall("gdiplus\GdipDeleteFont", "UInt", hFont)
	DllCall("gdiplus\GdipDeleteFontFamily", "UInt", hFamily)
}

Gdip_SetFontStyle(font)
{
	StringSplit, s, Font, `,, %A_Space%
	if s5 is not Integer
		s5 := 4

	s := "bold italic underline strikeout"
	Loop, Parse, s, %A_Space%
	{
		if InStr(s4, A_LoopField)
			style += 2**(A_Index-1)
	}
	s := "left center right"
	Loop, Parse, s, %A_Space%
	{
		if InStr(s4, A_LoopField)
			align := A_Index-1
	}
	s := "top bottom"
	Loop, Parse, s, %A_Space%
	{
		if InStr(s4, A_LoopField)
			valign := A_Index
	}
	s := s1 "," s2 "," s3 "," style "," align "," valign "," s5
	return s
}
