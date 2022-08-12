
PROGRAM	_INIT
	MpOEECore_1.MpLink := ADR(gOeeCore);
	MpOEECore_1.Enable := TRUE;
	MpOEECore_1.DeviceName := ADR('OEE');
	
	IdealCycleTime_1.IdealCycleTime	:= T#10s;
	MpOEECore_1.Parameters := ADR(IdealCycleTime_1.IdealCycleTime);
END_PROGRAM

PROGRAM	_CYCLIC
	MpOEECore_1.Update := FALSE;
	IF startOEE THEN
		MpOEECore_1();
	END_IF
	
	IF OEEParChange	THEN //AKTUALIZACJA JAK JAKIES DANE BYLY ZMIENIONE
		MpOEECore_1.Update := TRUE;
		
		IdealCycleTime_1.IdealCycleTime	:= IdealCycleTimeChange;//update czas idealny cyklu
		MpOEECore_1.Parameters := ADR(IdealCycleTime_1.IdealCycleTime);
		OEEParChange :=	FALSE;
	END_IF;
		
	MpOEECore_1.PieceCounter := CycleNumber;
	
	IF RejectCycle THEN
		MpOEECore_1.RejectCounter := MpOEECore_1.RejectCounter + 1;
		RejectCycle := 0;
		CycleNumber := CycleNumber - 1;
	END_IF;

	MpOEECore_1.Downtime := NOT(STATUS = STATE_WORKING_AUTOMATIC) ;

	MpOEECore_1.Reset := (RsetOEE);//resetowanie statystyk
	
END_PROGRAM

PROGRAM	_EXIT
	MpOEECore_1.Enable := FALSE;
	 
END_PROGRAM

