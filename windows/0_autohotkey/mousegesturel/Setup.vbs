'===============================================================================
'
'		MouseGestureL.ahk Setup Script
'
'																	   Pyonkichi
'===============================================================================
Option Explicit

Dim strCap, strMsg

Call SetLanguage
if MsgBox(strMsg, vbYesNo, strCap) = vbYes then
	Call SetupMGL
end if

Sub SetLanguage()
	if GetLocale()=1041 then
		strCap	= "MouseGestureL.ahk�̃Z�b�g�A�b�v"
		strMsg	= "�����p����Windows�ɓK������MouseGestureL�̎��s�t�@�C�����쐬���܂��B" & vbCrLf & "����AutoHotkey���C���X�g�[������Ă���ꍇ�A���̏����͕s�v�ł��B" & vbCrLf & vbCrLf & "���s���܂����H"
	else
		strCap	= "MouseGestureL.ahk Setup"
		strMsg	= "This will create an executable file of MouseGestureL that is suitable for your operating system. If AutoHotkey is already installed, this operation is not necessary." & vbCrLf & vbCrLf & "Do you want to continue setup?"
	end if
End Sub

Sub SetupMGL()
	'Copy suitable AutoHotkey.exe to MouseGestureL.exe
	Dim objFileSys, strAhkExe, strMglExe
	Set objFileSys = CreateObject("Scripting.FileSystemObject")
	strAhkExe = "AutoHotkeyU" + GetOSArchitecture() + ".exe"
	strMglExe = "MouseGestureL.exe"
	objFileSys.CopyFile "AutoHotkey\" + strAhkExe, strMglExe, true

	'Run MouseGestureL.exe
	dim objWShell
	Set objWShell = WScript.CreateObject("WScript.Shell")
	objWShell.Run(strMglExe)
	Set objWShell = Nothing
End Sub

Function GetOSArchitecture()
	GetOSArchitecture = ""

	On Error Resume Next
	Dim objLocator, objServer, objClasses, objClass, strOS
	Set objLocator = WScript.CreateObject("WbemScripting.SWbemLocator")
	Set objServer = WScript.CreateObject("WbemScripting.SWbemLocator").ConnectServer
	Set objClasses = objServer.ExecQuery("Select * From Win32_OperatingSystem")
	strOS = ""
	For Each objClass In objClasses
		strOS = CStr(objClass.OSArchitecture)
		GetOSArchitecture = Left(strOS, 2)
	Next
	Set objLocator = Nothing
	Set objServer = Nothing
	Set objClasses = Nothing
	Set objClass = Nothing
End Function

