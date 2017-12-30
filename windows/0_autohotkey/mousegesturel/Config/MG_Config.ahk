MG_IniFileVersion=1.31
MG_8Dir=0
MG_ActiveAsTarget=0
MG_Interval=20
MG_Threshold=10
MG_LongThresholdX=800
MG_LongThresholdY=600
MG_LongThreshold=700
MG_TimeoutThreshold=12
MG_Timeout=400
MG_DGInterval=0
MG_ORangeDefault=3
MG_ORangeA=3
MG_ORangeB=3
MG_EdgeInterval=20
MG_EdgeIndiv=0
MG_CornerX=1
MG_CornerY=1
MG_DisableDefMB=0
MG_DisableDefX1B=0
MG_DisableDefX2B=0
MG_UseNavi=1
MG_UseExNavi=3
MG_NaviInterval=10
MG_NaviPersist=0
MG_ExNaviTransBG=1
MG_ExNaviFG=000000
MG_ExNaviBG=FFFFFF
MG_ExNaviTranspcy=255
MG_ExNaviSize=24
MG_ExNaviSpacing=2
MG_ExNaviPadding=4
MG_ExNaviMargin=8
MG_AdNaviFG=FFFFFF
MG_AdNaviNI=7F7F7F
MG_AdNaviBG=000000
MG_AdNaviTranspcy=220
MG_AdNaviSize=12
MG_AdNaviFont=Meiryo
MG_AdNaviPosition=0
MG_AdNaviPaddingL=6
MG_AdNaviPaddingR=6
MG_AdNaviPaddingT=3
MG_AdNaviPaddingB=3
MG_AdNaviRound=1
MG_AdNaviMargin=14
MG_AdNaviSpaceX=2
MG_AdNaviSpaceY=2
MG_AdNaviOnClick=0
MG_ShowTrail=0
MG_DrawTrailWnd=1
MG_TrailColor=0000FF
MG_TrailTranspcy=255
MG_TrailWidth=3
MG_TrailStartMove=3
MG_TrailInterval=10
MG_ShowLogs=0
MG_LogPosition=4
MG_LogPosX=0
MG_LogPosY=0
MG_LogMax=20
MG_LogSizeW=400
MG_LogInterval=500
MG_LogFG=FFFFFF
MG_LogBG=000000
MG_LogTranspcy=100
MG_LogFontSize=10
MG_LogFont=MS UI Gothic
MG_HotkeyEnable=
MG_HotkeyNavi=
MG_ScriptEditor=
MG_TraySubmenu=0
MG_AdjustDlg=0
MG_DlgHeightLimit=800
MG_EditCommand=
MG_FoldTarget=0
MG_MaxLength=7
MG_Triggers=RB
MG_SubTriggers=LB


Goto,MG_RB_End

MG_RB_Enable:
	Hotkey,*RButton,MG_RB_DownHotkey,On
	Hotkey,*RButton up,MG_RB_UpHotkey,On
	MG_RB_Enabled := 1
return

MG_RB_Disable:
	Hotkey,*RButton,MG_RB_DownHotkey,Off
	Hotkey,*RButton up,MG_RB_UpHotkey,Off
	MG_RB_Enabled := 0
return

MG_RB_DownHotkey:
	MG_TriggerDown("RB")
return

MG_RB_UpHotkey:
	MG_TriggerUp("RB")
return

MG_RB_Down:
	MG_SendButton("RB", "RButton", "Down")
return

MG_RB_Up:
	MG_SendButton("RB", "RButton", "Up")
return

MG_RB_Check:
	MG_CheckButton("RB", "RButton")
return

MG_RB_End:


Goto,MG_LB_End

MG_LB_Enable:
	Hotkey,*LButton,MG_LB_DownHotkey,On
	Hotkey,*LButton up,MG_LB_UpHotkey,On
	MG_LB_Enabled := 1
return

MG_LB_Disable:
	Hotkey,*LButton,MG_LB_DownHotkey,Off
	Hotkey,*LButton up,MG_LB_UpHotkey,Off
	MG_LB_Enabled := 0
return

MG_LB_DownHotkey:
	MG_TriggerDown("LB")
return

MG_LB_UpHotkey:
	MG_TriggerUp("LB")
return

MG_LB_Down:
	MG_SendButton("LB", "LButton", "Down")
return

MG_LB_Up:
	MG_SendButton("LB", "LButton", "Up")
return

MG_LB_Check:
	MG_CheckButton("LB", "LButton")
return

MG_LB_End:


Goto,MG_Config_End


MG_IsDisable(){
	global
	return ((MG_Exe="TOTALCMD64.EXE") || (MG_Exe="TOTALCMD.EXE"))
}

MG_IsTarget1(){
	global
	return ((MG_Exe="iexplore.exe") || (MG_Exe="chrome.exe") || (MG_Exe="firefox.exe"))
}

MG_IsTarget2(){
	global
	return ((MG_WClass="CabinetWClass") || (MG_WClass="ExploreWClass") || (MG_WClass="Progman") || (MG_WClass="WorkerW"))
}

MG_Gesture_RB_:
	
return

MG_GetAction_RB_:
	
return

MG_Gesture_RB_LB__:
	
return

MG_GetAction_RB_LB__:
	
return

MG_Gesture_RB_L_:
	;Back
	Send, !{Left}
return

MG_GetAction_RB_L_:
	MG_ActionStr := "Back"
return

MG_Gesture_RB_R_:
	;Forward
	Send, !{Right}
return

MG_GetAction_RB_R_:
	MG_ActionStr := "Forward"
return

MG_Gesture_RB_U_:
	;Jump to Top
	Send, ^{Home}
return

MG_GetAction_RB_U_:
	MG_ActionStr := "Jump to Top"
return

MG_Gesture_RB_D_:
	;Jump to Bottom
	Send, ^{End}
return

MG_GetAction_RB_D_:
	MG_ActionStr := "Jump to Bottom"
return

MG_Gesture_RB_LU_:
	
return

MG_GetAction_RB_LU_:
	
return

MG_Gesture_RB_LD_:
	
return

MG_GetAction_RB_LD_:
	
return

MG_Gesture_RB_RU_:
	
return

MG_GetAction_RB_RU_:
	
return

MG_Gesture_RB_RD_:
	
return

MG_GetAction_RB_RD_:
	
return

MG_Gesture_RB_UL_:
	
return

MG_GetAction_RB_UL_:
	
return

MG_Gesture_RB_UR_:
	
return

MG_GetAction_RB_UR_:
	
return

MG_Gesture_RB_DL_:
	
return

MG_GetAction_RB_DL_:
	
return

MG_Gesture_RB_DR_:
	
return

MG_GetAction_RB_DR_:
	
return


MG_Config_end: