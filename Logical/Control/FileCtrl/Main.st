
PROGRAM _INIT
	
	MpFileManagerUI_0.MpLink := ADR(gFileManagerUI);
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.UISetup := MpFileMngSetup;
	MpFileManagerUI_0.UIConnect := ADR(MpFileMngConnect);
	MpFileMngConnect.DeviceList.DeviceNames[0] := MOVE('FILE');
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	MpFileManagerUI_0();
	 
END_PROGRAM

PROGRAM _EXIT
	
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	 
END_PROGRAM

