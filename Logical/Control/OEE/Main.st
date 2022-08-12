
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
		
	//MpOEECore_1.PieceCounter //DODAC LICZBE CYKLI Z CONTROL VARIABLES INT
	
	//MpOEECore_1.RejectCounter jako int
	
	IF step = 0 THEN //ZAMIENIC STEP NA TEN Z CONTROL VARIABLES 
		MpOEECore_1.Downtime := TRUE;//DAJE INFO CZY MASZYNA DZIALA DO BLOKU
	ELSE
		MpOEECore_1.Downtime := FALSE;
	END_IF;

	MpOEECore_1.Reset := (RsetOEE);//resetowanie statystyk
	
END_PROGRAM

PROGRAM	_EXIT
	MpOEECore_1.Enable := FALSE;
	 
END_PROGRAM

