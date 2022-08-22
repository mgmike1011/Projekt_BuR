
PROGRAM _INIT
	//
	// Init code
	//
	 
END_PROGRAM

PROGRAM _CYCLIC
	//
	// Cyclic code - variables adjustment to visualization.
	//
	// Current temperature - switch between real values and simulation.
	//Zone 1
	IF SimulateZone1Enable THEN
		CurrentZone1Temp := TempController[0].Info.Simulation.ActualTemperature;
	ELSE
		CurrentZone1Temp := gTemp1;
	END_IF;
	
	IF SimulateZone2Enable THEN
		CurrentZone2Temp := TempController[1].Info.Simulation.ActualTemperature;
	ELSE
		CurrentZone2Temp := gTemp2;
	END_IF;
	// Zone 3
	IF SimulateZone3Enable THEN
		CurrentZone3Temp := TempController[2].Info.Simulation.ActualTemperature;
	ELSE
		CurrentZone3Temp := gTemp3;
	END_IF;
	// Zone 4
	IF SimulateZone4Enable THEN
		CurrentZone4Temp := TempController[3].Info.Simulation.ActualTemperature;
	ELSE
		CurrentZone4Temp := gTemp4;
	END_IF;
	// Step time  - timer for each step visualization
	TimeStep1Int := TIME_TO_UINT(TimeStep1)/1000;
	TimeStep2Int := TIME_TO_UINT(TimeStep2)/1000;
	TimeStep3Int := TIME_TO_UINT(TimeStep3)/1000;
	TimeStep4Int := TIME_TO_UINT(TimeStep4)/1000;
	TimeStep5Int := TIME_TO_UINT(TimeStep5)/1000;
	// Machine working state
	CASE STATUS OF
		STATE_IDLE:
			isIDLE_ := TRUE;
			isManual := FALSE;
			isAutomatic := FALSE;
			isTuning := FALSE;
			isSTOP := FALSE;
			isERROR := FALSE;
		STATE_TUNING:
			isIDLE_ := FALSE;
			isManual := FALSE;
			isAutomatic := FALSE;
			isTuning := TRUE;
			isSTOP := FALSE;
			isERROR := FALSE;
		STATE_WORKING_MANUAL:
			isIDLE_ := FALSE;
			isManual := TRUE;
			isAutomatic := FALSE;
			isTuning := FALSE;
			isSTOP := FALSE;
			isERROR := FALSE;
		STATE_WORKING_AUTOMATIC:
			isIDLE_ := FALSE;
			isManual := FALSE;
			isAutomatic := TRUE;
			isTuning := FALSE;
			isSTOP := FALSE;
			isERROR := FALSE;
		STATE_ERROR:
			isIDLE_ := FALSE;
			isManual := FALSE;
			isAutomatic := FALSE;
			isTuning := FALSE;
			isSTOP := FALSE;
			isERROR := TRUE;
		STATE_STOP:
			isIDLE_ := FALSE;
			isManual := FALSE;
			isAutomatic := FALSE;
			isTuning := FALSE;
			isSTOP := TRUE;
			isERROR := FALSE;
	END_CASE;
END_PROGRAM

PROGRAM _EXIT
	//
	// Exit code
	//
	 
END_PROGRAM

