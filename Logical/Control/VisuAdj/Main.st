
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
	// Zone 1
	IF SimulateZone1Enable THEN
		CurrentZone1Temp := TempController[0].Info.Simulation.ActualTemperature;
		CoolPWMZone1 := TempController[0].Info.Simulation.CoolValue;
		HeatPWMZone1 := TempController[0].Info.Simulation.HeatValue;
	ELSE
		CurrentZone1Temp := gTemp1;
		CoolPWMZone1 := TempController[0].CoolValue;
		HeatPWMZone1 := TempController[0].HeatValue;
	END_IF;
	// Zone 2
	IF SimulateZone2Enable THEN
		CurrentZone2Temp := TempController[1].Info.Simulation.ActualTemperature;
		CoolPWMZone2 := TempController[1].Info.Simulation.CoolValue;
		HeatPWMZone2 := TempController[1].Info.Simulation.HeatValue;
	ELSE
		CurrentZone2Temp := gTemp2;
		CoolPWMZone2 := TempController[1].CoolValue;
		HeatPWMZone2 := TempController[1].HeatValue;
	END_IF;
	// Zone 3
	IF SimulateZone3Enable THEN
		CurrentZone3Temp := TempController[2].Info.Simulation.ActualTemperature;
		CoolPWMZone3 := TempController[2].Info.Simulation.CoolValue;
		HeatPWMZone3 := TempController[2].Info.Simulation.HeatValue;
	ELSE
		CurrentZone3Temp := gTemp3;
		CoolPWMZone3 := TempController[2].CoolValue;
		HeatPWMZone3 := TempController[2].HeatValue;
	END_IF;
	// Zone 4
	IF SimulateZone4Enable THEN
		CurrentZone4Temp := TempController[3].Info.Simulation.ActualTemperature;
		CoolPWMZone4 := TempController[3].Info.Simulation.CoolValue;
		HeatPWMZone4 := TempController[3].Info.Simulation.HeatValue;
	ELSE
		CurrentZone4Temp := gTemp4;
		CoolPWMZone4 := TempController[3].CoolValue;
		HeatPWMZone4 := TempController[3].HeatValue;
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

