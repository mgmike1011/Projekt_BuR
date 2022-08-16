
PROGRAM	_INIT
	MpOEECore_1.MpLink := ADR(gOeeCore);
	MpOEECore_1.Enable := TRUE;
	MpOEECore_1.DeviceName := ADR('OEE');
	MpOEECore_1.Parameters := ADR(IdealCycleTime_1.IdealCycleTime);
	
	IdealCycleTimeINT := 0;
	ICTm := 0;
	ICTs := 0;
	ICTms := 0;
END_PROGRAM

PROGRAM	_CYCLIC
	MpOEECore_1.Update := FALSE;
	MpOEECore_1.Downtime := NOT(STATUS = STATE_WORKING_AUTOMATIC) ;
	MpOEECore_1.Reset := (RsetOEE);//resetowanie statystyk
	MpOEECore_1.PieceCounter := CycleNumber;
	
	IF startOEE THEN
		MpOEECore_1();
	END_IF
	
	IF RejectCycle THEN
		MpOEECore_1.RejectCounter := MpOEECore_1.RejectCounter + 1;
		RejectCycle := 0;
		CycleNumber := CycleNumber - 1;
	END_IF;
	
	IdealCycleTimeINT := ICTms + (ICTs*1000) + (ICTm*60000);
	IdealCycleTime_1.IdealCycleTime := DINT_TO_TIME(IdealCycleTimeINT);
	
	//IF OEEParChange	THEN //AKTUALIZACJA JAK JAKIES DANE BYLY ZMIENIONE
	//	MpOEECore_1.Update := TRUE;
	//	
	//	IdealCycleTime_1.IdealCycleTime	:= IdealCycleTimeChange;//update czas idealny cyklu
	//	MpOEECore_1.Parameters := ADR(IdealCycleTime_1.IdealCycleTime);
	//	OEEParChange :=	FALSE;
	//END_IF;
			
END_PROGRAM

PROGRAM	_EXIT
	MpOEECore_1.Enable := FALSE;
	 MpOEECore_1();
END_PROGRAM

