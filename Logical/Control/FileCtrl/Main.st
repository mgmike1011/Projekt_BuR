
PROGRAM _INIT
	
	MpFileManagerUI_0.MpLink := ADR(gFileManagerUI);
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.UISetup := MpFileMngSetup;
	MpFileManagerUI_0.UIConnect := ADR(MpFileMngConnect);
	MpFileMngConnect.DeviceList.DeviceNames[0] := 'DISK';
	
	StartValue := 0;
	StopValue := 49;
	Step := 1;
	
END_PROGRAM


PROGRAM _CYCLIC
	
//	FOR i := StartValue TO StopValue BY Step DO
//		MpFileMngConnect.File.List.Items[i].Name;
//	END_FOR	
	
	MpFileManagerUI_0();
	 
END_PROGRAM


PROGRAM _EXIT
	
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	 
END_PROGRAM

