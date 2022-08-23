
PROGRAM _INIT
	MpReportCore_1.MpLink := ADR(gReport);
	MpReportCore_1.Enable := TRUE;
	MpReportCore_1.DeviceName := ADR('PDF');
	MpReportCore_1.Name := ADR('ReportOEE');
	MpReportCore_1();
END_PROGRAM

PROGRAM _CYCLIC
	IF MpReportCore_1.CommandDone THEN
		MpReportCore_1.Generate := 0;
	END_IF;
	
	
	MpReportCore_1.Language := ADR('en');

	MpReportCore_1();
END_PROGRAM

PROGRAM _EXIT
	MpReportCore_1.Enable := FALSE;
	MpReportCore_1();
	 
END_PROGRAM

