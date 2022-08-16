
PROGRAM _INIT
	MpReportCore_1.MpLink := ADR(gReport);
	MpReportCore_1.Enable := TRUE;
	MpReportCore_1.DeviceName := ADR('OEEReport');
	MpReportCore_1.Name := ADR('ReportOEE');
	MpReportCore_1();
END_PROGRAM

PROGRAM _CYCLIC
	
	MpReportCore_1.Language := ADR('en');

	MpReportCore_1();
END_PROGRAM

PROGRAM _EXIT
	MpReportCore_1.Enable := FALSE;
	MpReportCore_1();
	 
END_PROGRAM

