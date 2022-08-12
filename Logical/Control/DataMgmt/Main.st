
PROGRAM _INIT
	
	MpDataRecorder_0.MpLink := ADR(gDataRecorder);
	MpDataRecorder_0.Enable := TRUE;
	MpDataRecorder_0.DeviceName := ADR('HD');
	MpDataRecorder_0.RecordMode := mpDATA_RECORD_MODE_VALUE;
	
	MpDataRegPar_0.MpLink := ADR(gDataRecorder);
	MpDataRegPar_0.Enable := TRUE;
	MpDataRegPar_1.MpLink := ADR(gDataRecorder);
	MpDataRegPar_1.Enable := TRUE;
	MpDataRegPar_2.MpLink := ADR(gDataRecorder);
	MpDataRegPar_2.Enable := TRUE;
	MpDataRegPar_3.MpLink := ADR(gDataRecorder);
	MpDataRegPar_3.Enable := TRUE;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	MpDataRegPar_0.PVName := ADR('gTemp1');
	MpDataRegPar_1.PVName := ADR('gTemp2');
	MpDataRegPar_2.PVName := ADR('gTemp3');
	MpDataRegPar_3.PVName := ADR('gTemp4');
	
	MpDataRecorder_0();
	
	MpDataRegPar_0();
	MpDataRegPar_1();
	MpDataRegPar_2();
	MpDataRegPar_3();
	 
END_PROGRAM

PROGRAM _EXIT
	
	MpDataRecorder_0.Enable := FALSE;
	MpDataRecorder_0();
	
	MpDataRegPar_0.Enable := FALSE;
	MpDataRegPar_0();
	MpDataRegPar_1.Enable := FALSE;
	MpDataRegPar_1();
	MpDataRegPar_2.Enable := FALSE;
	MpDataRegPar_2();
	MpDataRegPar_3.Enable := FALSE;
	MpDataRegPar_3();
	 
END_PROGRAM

