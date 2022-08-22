PROGRAM _INIT
	//
	// Init Code
	//
	// Temp Controller-parameters:
		// Setpoints
	TempControllerPar[0].Tuning.SetPointHeat := SetTempHeatTuning1;
	TempControllerPar[0].Tuning.SetPointCool := SetTempCoolTuning1;
	TempControllerPar[1].Tuning.SetPointHeat := SetTempHeatTuning2;
	TempControllerPar[1].Tuning.SetPointCool := SetTempCoolTuning2;
	TempControllerPar[2].Tuning.SetPointHeat := SetTempHeatTuning3;
	TempControllerPar[2].Tuning.SetPointCool := SetTempCoolTuning3;
	TempControllerPar[3].Tuning.SetPointHeat := SetTempHeatTuning4;
	TempControllerPar[3].Tuning.SetPointCool := SetTempCoolTuning4;
	// Tuning mode - tuning heating and cooling controllers
	TempControllerPar[0].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	TempControllerPar[1].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	TempControllerPar[2].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	TempControllerPar[3].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	// PID Controller
	FOR iCnt := 0  TO ELEMENTS_NUMBER DO
		// Heating PID params
		TempControllerPar[iCnt].PID.Heat.ProportionalGain := PIDProportionaGainHEAT[iCnt];
		TempControllerPar[iCnt].PID.Heat.IntegrationTime := PIDIntegrationTimeHEAT[iCnt];
		TempControllerPar[iCnt].PID.Heat.FilterTime := PIDFilterTimeHEAT[iCnt];
		TempControllerPar[iCnt].PID.Heat.DerivativeTime:= PIDDerivativeTimeHEAT[iCnt];
		// Cooling PID params
		TempControllerPar[iCnt].PID.Cool.ProportionalGain := PIDProportionaGainCOOL[iCnt];
		TempControllerPar[iCnt].PID.Cool.IntegrationTime := PIDIntegrationTimeCOOL[iCnt];
		TempControllerPar[iCnt].PID.Cool.FilterTime := PIDFilterTimeCOOL[iCnt];
		TempControllerPar[iCnt].PID.Cool.DerivativeTime := PIDDerivativeTimeCOOL[iCnt];
	END_FOR;
	// Integrator preloading
//	TempControllerPar[0].PID.IntegratorPreloading := 0;
//	TempControllerPar[1].PID.IntegratorPreloading := 0;
//	TempControllerPar[2].PID.IntegratorPreloading := 0;
//	TempControllerPar[3].PID.IntegratorPreloading := 0;
	// Temperature Controller 
	TempController[0].MpLink := ADR(gTempController_1);
	TempController[0].Parameters := ADR(TempControllerPar[0]);
	TempController[0].Enable := TRUE;
	TempController[1].MpLink := ADR(gTempController_2);
	TempController[1].Parameters := ADR(TempControllerPar[1]);
	TempController[1].Enable := TRUE;
	TempController[2].MpLink := ADR(gTempController_3);
	TempController[2].Parameters := ADR(TempControllerPar[2]);
	TempController[2].Enable := TRUE;
	TempController[3].MpLink := ADR(gTempController_4);
	TempController[3].Parameters := ADR(TempControllerPar[3]);
	TempController[3].Enable := TRUE;
	// Temp Group
	TempGroup.MpLink := ADR(gTempGroup_1);
	TempGroup.Parameters := ADR(TempGroupPar);
	TempGroup.Enable := TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	// Mapping inputs:
		// Mapping temperature sensors
	TempController[0].ActualTemperature := gTemp1;
	TempController[1].ActualTemperature := gTemp2;
	TempController[2].ActualTemperature := gTemp3;
	TempController[3].ActualTemperature := gTemp4;
	// Mapping set temperature
	TempController[0].SetTemperature := SetTemp1;
	TempController[1].SetTemperature := SetTemp2;
	TempController[2].SetTemperature := SetTemp3;
	TempController[3].SetTemperature := SetTemp4;
	// Machine working status
	CASE STATUS OF
		STATE_IDLE:
			TempGroup.Control := FALSE;
			TempGroup.Tune := FALSE;
			AutoStep := STEP_INIT;
			TempController[0].Enable := FALSE;
			TempController[1].Enable := FALSE;
			TempController[2].Enable := FALSE;
			TempController[3].Enable := FALSE;
			TempController[0].Simulate := FALSE;
			TempController[1].Simulate := FALSE;
			TempController[2].Simulate := FALSE;
			TempController[3].Simulate := FALSE;
			// Switch state conditions
			IF TuneEnable AND gStart AND NOT gSTOP AND NOT (Automatic_work OR Manual_work) THEN
				STATUS := STATE_TUNING;
			ELSIF Manual_work AND gStart AND NOT gSTOP AND NOT (TuneEnable OR Automatic_work) THEN
				STATUS := STATE_WORKING_MANUAL;
			ELSIF Automatic_work AND gStart AND NOT gSTOP AND NOT (TuneEnable OR Manual_work) THEN
				STATUS := STATE_WORKING_AUTOMATIC;
			ELSIF gSTOP THEN
				STATUS := STATE_STOP;
			ELSIF TuneEnable AND (Automatic_work OR Manual_work) AND gStart THEN
				STATUS := STATE_ERROR;
				gError := TRUE;
			END_IF;
			
		STATE_TUNING:
			TempGroup.Control := FALSE;
			TempController[0].Enable := TRUE;
			TempController[1].Enable := TRUE;
			TempController[2].Enable := TRUE;
			TempController[3].Enable := TRUE;
			TempController[0].Simulate := FALSE;
			TempController[1].Simulate := FALSE;
			TempController[2].Simulate := FALSE;
			TempController[3].Simulate := FALSE;
			// Tuning Parameters
			IF EDGEPOS(TempGroup.TuningDone) THEN
				TuningAction; // Getting the data
				TuneEnable := FALSE; // Tune off
				STATUS := STATE_IDLE;
				gStart := FALSE;
			ELSE
				TempGroup.Tune := TRUE;
				IF gSTOP THEN
					STATUS := STATE_STOP;
				END_IF;
			END_IF;
			IF NOT TuneEnable THEN
				STATUS := STATE_IDLE;
				gStart := FALSE;
			END_IF;
			
		STATE_WORKING_MANUAL:
			TempGroup.Control := TRUE;
			// Switch state conditions
			IF NOT Manual_work THEN
				STATUS := STATE_IDLE;
			ELSIF gSTOP THEN
				STATUS := STATE_STOP;
			ELSIF Manual_work AND (TuneEnable OR Automatic_work) AND gStart THEN
				STATUS := STATE_ERROR;
				gError := TRUE;
			END_IF;
			// Zone 1
			IF EnableZone1 THEN
				TempController[0].Enable := TRUE;
				// Simulation zone 1
				IF SimulateZone1Enable THEN
					TempController[0].Control := TRUE;
					TempController[0].Simulate := TRUE;
				ELSE
					TempController[0].Control := TRUE;
					TempController[0].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[0].Enable := FALSE;
				ZoneStatus[0] := STATE_IDLE_ZONE;	
			END_IF;
			// Zone 2
			IF EnableZone2 THEN
				TempController[1].Enable := TRUE;
				// Simulation zone 2
				IF SimulateZone2Enable THEN
					TempController[1].Control := TRUE;
					TempController[1].Simulate := TRUE;
				ELSE
					TempController[1].Control := TRUE;
					TempController[1].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[1].Enable := FALSE;
				ZoneStatus[1] := STATE_IDLE_ZONE;	
			END_IF;
			// Zone 3
			IF EnableZone3 THEN
				TempController[2].Enable := TRUE;
				// Simulation zone 3
				IF SimulateZone3Enable THEN
					TempController[2].Control := TRUE;
					TempController[2].Simulate := TRUE;
				ELSE
					TempController[2].Control := TRUE;
					TempController[2].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[2].Enable := FALSE;
				ZoneStatus[2] := STATE_IDLE_ZONE;	
			END_IF;
			// Zone 4
			IF EnableZone4 THEN
				TempController[3].Enable := TRUE;
				// Simulation zone 4
				IF SimulateZone4Enable THEN
					TempController[3].Control := TRUE;
					TempController[3].Simulate := TRUE;
				ELSE
					TempController[3].Control := TRUE;
					TempController[3].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[3].Enable := FALSE;
				ZoneStatus[3] := STATE_IDLE_ZONE;	
			END_IF;
			
		STATE_WORKING_AUTOMATIC:
			TempGroup.Control := TRUE;
			AutomaticMode;
			// Switch state conditions
			IF NOT Automatic_work THEN
				STATUS := STATE_IDLE;
				AutoStep := STEP_INIT;
			ELSIF gSTOP THEN
				STATUS := STATE_STOP;
			ELSIF Automatic_work AND (TuneEnable OR Manual_work) AND gStart THEN
				STATUS := STATE_ERROR;
				gError := TRUE;
			END_IF;
			
		STATE_STOP:
			TempGroup.Control := FALSE;
			TempGroup.Tune := FALSE;
			Automatic_work := FALSE;
			TuneEnable := FALSE;
			gStart := FALSE;
			Manual_work := FALSE;
			TempController[0].Enable := FALSE;
			TempController[1].Enable := FALSE;
			TempController[2].Enable := FALSE;
			TempController[3].Enable := FALSE;
			TempController[0].Simulate := FALSE;
			TempController[1].Simulate := FALSE;
			TempController[2].Simulate := FALSE;
			TempController[3].Simulate := FALSE;
			// Switch state conditions
			IF NOT gSTOP THEN
				STATUS := STATE_IDLE;
			END_IF;
			
		STATE_ERROR:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := FALSE;
			TempController[2].Enable := FALSE;
			TempController[3].Enable := FALSE;
			TempController[0].Simulate := FALSE;
			TempController[1].Simulate := FALSE;
			TempController[2].Simulate := FALSE;
			TempController[3].Simulate := FALSE;
			TempGroup.Control := FALSE;
			TempGroup.Tune := FALSE;
			Automatic_work := FALSE;
			Manual_work := FALSE;
			TuneEnable := FALSE;
			gStart := FALSE;
			// Switch state conditions
			IF NOT gError AND NOT gStart AND NOT gSTOP AND NOT (Manual_work OR Automatic_work) AND NOT TuneEnable THEN
				STATUS := STATE_IDLE;
			END_IF;
	END_CASE;
	// Update info about zone state
	ZoneStateUpdate;
	// Calling functionblocks
	FOR iCnt := 0 TO ELEMENTS_NUMBER DO
		TempController[iCnt]();
	END_FOR;
	TempGroup();
	// Mapping outputs
	// Mapping Cooling outputs
	gFan1 := TempController[0].Cool;
	gFan2 := TempController[1].Cool;
	gFan3 := TempController[2].Cool;
	gFan4 := TempController[3].Cool;
	// Mapping heating outputs
	gHeater1 := TempController[0].Heat;
	gHeater2 := TempController[1].Heat;
	gHeater3 := TempController[2].Heat;
	gHeater4 := TempController[3].Heat;
END_PROGRAM

PROGRAM _EXIT
	//
	// Exit Code
	//
	FOR iCnt := 0 TO ELEMENTS_NUMBER DO
		TempController[iCnt].Enable := FALSE;
		TempController[iCnt]();
	END_FOR;
	TempGroup.Enable := FALSE;
	TempGroup(); 
END_PROGRAM

