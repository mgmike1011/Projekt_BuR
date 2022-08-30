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
	TempControllerPar[0].PID.IntegratorPreloading := -0.2;
	TempControllerPar[1].PID.IntegratorPreloading := -0.2;
	TempControllerPar[2].PID.IntegratorPreloading := -0.2;
	TempControllerPar[3].PID.IntegratorPreloading := -0.2;
	// Hysteresis
	TempControllerPar[0].Hysteresis.Band.CoolToHeat := 5;
	TempControllerPar[0].Hysteresis.Band.HeatToCool := 5;
	TempControllerPar[1].Hysteresis.Band.CoolToHeat := 5;
	TempControllerPar[1].Hysteresis.Band.HeatToCool := 5;
	TempControllerPar[2].Hysteresis.Band.CoolToHeat := 5;
	TempControllerPar[2].Hysteresis.Band.HeatToCool := 5;
	TempControllerPar[3].Hysteresis.Band.CoolToHeat := 5;
	TempControllerPar[3].Hysteresis.Band.HeatToCool := 5;
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
	
	
	//PID & PWM BLOCK
	FOR iCnt := 0  TO ELEMENTS_NUMBER DO
		// Heating PID params
		ParameterTypePIDHEAT[iCnt].Gain := PIDProportionaGainHEAT[iCnt];
		ParameterTypePIDHEAT[iCnt].IntegrationTime := PIDIntegrationTimeHEAT[iCnt];
		ParameterTypePIDHEAT[iCnt].FilterTime := PIDFilterTimeHEAT[iCnt];
		ParameterTypePIDHEAT[iCnt].DerivativeTime := PIDDerivativeTimeHEAT[iCnt];
		// Cooling PID params
		ParameterTypePIDCOLD[iCnt].Gain := PIDProportionaGainCOOL[iCnt];
		ParameterTypePIDCOLD[iCnt].IntegrationTime := PIDIntegrationTimeCOOL[iCnt];
		ParameterTypePIDCOLD[iCnt].FilterTime := PIDFilterTimeCOOL[iCnt];
		ParameterTypePIDCOLD[iCnt].DerivativeTime := PIDDerivativeTimeCOOL[iCnt];
	END_FOR;
	//HEAT PID
	MTBasicsPID_HEAT[0].PIDParameters := ParameterTypePIDHEAT[0];
	MTBasicsPID_HEAT[1].PIDParameters := ParameterTypePIDHEAT[1];
	MTBasicsPID_HEAT[2].PIDParameters := ParameterTypePIDHEAT[2];
	MTBasicsPID_HEAT[3].PIDParameters := ParameterTypePIDHEAT[3];
	MTBasicsPID_HEAT[0].MinOut := 0.0;
	MTBasicsPID_HEAT[1].MinOut := 0.0;
	MTBasicsPID_HEAT[2].MinOut := 0.0;
	MTBasicsPID_HEAT[3].MinOut := 0.0;
	MTBasicsPID_HEAT[0].MaxOut := 100.0;
	MTBasicsPID_HEAT[1].MaxOut := 100.0;
	MTBasicsPID_HEAT[2].MaxOut := 100.0;
	MTBasicsPID_HEAT[3].MaxOut := 100.0;
	MTBasicsPID_HEAT[0].Enable := TRUE;
	MTBasicsPID_HEAT[1].Enable := TRUE;
	MTBasicsPID_HEAT[2].Enable := TRUE;
	MTBasicsPID_HEAT[3].Enable := TRUE;
	//COLD PID
	MTBasicsPID_COLD[0].PIDParameters := ParameterTypePIDCOLD[0];
	MTBasicsPID_COLD[1].PIDParameters := ParameterTypePIDCOLD[1];
	MTBasicsPID_COLD[2].PIDParameters := ParameterTypePIDCOLD[2];
	MTBasicsPID_COLD[3].PIDParameters := ParameterTypePIDCOLD[3];
	MTBasicsPID_COLD[0].MinOut := 0.0;
	MTBasicsPID_COLD[1].MinOut := 0.0;
	MTBasicsPID_COLD[2].MinOut := 0.0;
	MTBasicsPID_COLD[3].MinOut := 0.0;
	MTBasicsPID_COLD[0].MaxOut := 100.0;
	MTBasicsPID_COLD[1].MaxOut := 100.0;
	MTBasicsPID_COLD[2].MaxOut := 100.0;
	MTBasicsPID_COLD[3].MaxOut := 100.0;
	MTBasicsPID_COLD[0].Enable := TRUE;
	MTBasicsPID_COLD[1].Enable := TRUE;
	MTBasicsPID_COLD[2].Enable := TRUE;
	MTBasicsPID_COLD[3].Enable := TRUE;
	//HEAT
	MTBasicsPWM_HEAT[0].Period := 1;
	MTBasicsPWM_HEAT[1].Period := 1;
	MTBasicsPWM_HEAT[2].Period := 1;
	MTBasicsPWM_HEAT[3].Period := 1;
	MTBasicsPWM_HEAT[0].Enable :=TRUE;
	MTBasicsPWM_HEAT[1].Enable :=TRUE;
	MTBasicsPWM_HEAT[2].Enable :=TRUE;
	MTBasicsPWM_HEAT[3].Enable :=TRUE;
	//COLD
	MTBasicsPWM_COLD[0].Period := 0.05;
	MTBasicsPWM_COLD[1].Period := 0.05;
	MTBasicsPWM_COLD[2].Period := 0.05;
	MTBasicsPWM_COLD[3].Period := 0.05;
	MTBasicsPWM_COLD[0].Enable :=TRUE;
	MTBasicsPWM_COLD[1].Enable :=TRUE;
	MTBasicsPWM_COLD[2].Enable :=TRUE;
	MTBasicsPWM_COLD[3].Enable :=TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	// Mapping inputs:
		// Mapping temperature sensors
	TempController[0].ActualTemperature := gTemp1;
	TempController[1].ActualTemperature := gTemp2;
	TempController[2].ActualTemperature := gTemp3;
	TempController[3].ActualTemperature := gTemp4;
	MTBasicsPID_HEAT[0].ActValue := gTemp1;
	MTBasicsPID_HEAT[1].ActValue := gTemp2;
	MTBasicsPID_HEAT[2].ActValue := gTemp3;
	MTBasicsPID_HEAT[3].ActValue := gTemp4;
	MTBasicsPID_COLD[0].ActValue := SetTemp1;
	MTBasicsPID_COLD[1].ActValue := SetTemp2;
	MTBasicsPID_COLD[2].ActValue := SetTemp3;
	MTBasicsPID_COLD[3].ActValue := SetTemp4;
	
	// Mapping set temperature
	TempController[0].SetTemperature := SetTemp1;
	TempController[1].SetTemperature := SetTemp2;
	TempController[2].SetTemperature := SetTemp3;
	TempController[3].SetTemperature := SetTemp4;
	MTBasicsPID_HEAT[0].SetValue :=  SetTemp1;
	MTBasicsPID_HEAT[1].SetValue :=  SetTemp2;
	MTBasicsPID_HEAT[2].SetValue :=  SetTemp3;
	MTBasicsPID_HEAT[3].SetValue :=  SetTemp4;
	MTBasicsPID_COLD[0].SetValue :=  gTemp1;
	MTBasicsPID_COLD[1].SetValue :=  gTemp2;
	MTBasicsPID_COLD[2].SetValue :=  gTemp3;
	MTBasicsPID_COLD[3].SetValue :=  gTemp4;
	
	MTBasicsPWM_HEAT[0].DutyCycle := MTBasicsPID_HEAT[0].Out;
	MTBasicsPWM_HEAT[1].DutyCycle := MTBasicsPID_HEAT[1].Out;  
	MTBasicsPWM_HEAT[2].DutyCycle := MTBasicsPID_HEAT[2].Out;
	MTBasicsPWM_HEAT[3].DutyCycle := MTBasicsPID_HEAT[3].Out;
	
	MTBasicsPWM_COLD[0].DutyCycle := MTBasicsPID_COLD[0].Out;
	MTBasicsPWM_COLD[1].DutyCycle := MTBasicsPID_COLD[1].Out;
	MTBasicsPWM_COLD[2].DutyCycle := MTBasicsPID_COLD[2].Out;
	MTBasicsPWM_COLD[3].DutyCycle := MTBasicsPID_COLD[3].Out;
	
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
			
			MTBasicsPID_HEAT[0].Enable := FALSE;
			MTBasicsPID_HEAT[1].Enable := FALSE;
			MTBasicsPID_HEAT[2].Enable := FALSE;
			MTBasicsPID_HEAT[3].Enable := FALSE;
			MTBasicsPID_COLD[0].Enable := FALSE;
			MTBasicsPID_COLD[1].Enable := FALSE;
			MTBasicsPID_COLD[2].Enable := FALSE;
			MTBasicsPID_COLD[3].Enable := FALSE;
			
			MTBasicsPWM_HEAT[0].Enable := FALSE;
			MTBasicsPWM_HEAT[1].Enable := FALSE;
			MTBasicsPWM_HEAT[2].Enable := FALSE;
			MTBasicsPWM_HEAT[3].Enable := FALSE;
			MTBasicsPWM_COLD[0].Enable := FALSE;
			MTBasicsPWM_COLD[1].Enable := FALSE;
			MTBasicsPWM_COLD[2].Enable := FALSE;
			MTBasicsPWM_COLD[3].Enable := FALSE;
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
				MTBasicsPID_HEAT[0].Enable := TRUE;
				MTBasicsPID_COLD[0].Enable := TRUE;
				// Simulation zone 1
				IF SimulateZone1Enable THEN
					TempController[0].Control := TRUE;
					TempController[0].Simulate := TRUE;
				ELSE
					MTBasicsPWM_HEAT[0].Enable := TRUE;
					MTBasicsPWM_COLD[0].Enable := TRUE;
					//TempController[0].Control := TRUE;
					TempController[0].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[0].Enable := FALSE;
				MTBasicsPID_HEAT[0].Enable := FALSE;
				MTBasicsPID_COLD[0].Enable := FALSE;
				MTBasicsPWM_HEAT[0].Enable := FALSE;
				MTBasicsPWM_COLD[0].Enable := FALSE;
				ZoneStatus[0] := STATE_IDLE_ZONE;	
			END_IF;
			// Zone 2
			IF EnableZone2 THEN
				TempController[1].Enable := TRUE;
				MTBasicsPID_HEAT[1].Enable := TRUE;
				MTBasicsPID_COLD[1].Enable := TRUE;
				// Simulation zone 2
				IF SimulateZone2Enable THEN
					TempController[1].Control := TRUE;
					TempController[1].Simulate := TRUE;
				ELSE
					MTBasicsPWM_HEAT[1].Enable := TRUE;
					MTBasicsPWM_COLD[1].Enable := TRUE;
					//TempController[1].Control := TRUE;
					TempController[1].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[1].Enable := FALSE;
				MTBasicsPID_HEAT[1].Enable := FALSE;
				MTBasicsPID_COLD[1].Enable := FALSE;
				MTBasicsPWM_HEAT[1].Enable := FALSE;
				MTBasicsPWM_COLD[1].Enable := FALSE;
				ZoneStatus[1] := STATE_IDLE_ZONE;	
			END_IF;
			// Zone 3
			IF EnableZone3 THEN
				TempController[2].Enable := TRUE;
				MTBasicsPID_HEAT[2].Enable := TRUE;
				MTBasicsPID_COLD[2].Enable := TRUE;
				// Simulation zone 3
				IF SimulateZone3Enable THEN
					TempController[2].Control := TRUE;
					TempController[2].Simulate := TRUE;
				ELSE
					MTBasicsPWM_HEAT[2].Enable := TRUE;
					MTBasicsPWM_COLD[2].Enable := TRUE;
					//TempController[2].Control := TRUE;
					TempController[2].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[2].Enable := FALSE;
				
				MTBasicsPWM_HEAT[2].Enable := FALSE;
				MTBasicsPWM_COLD[2].Enable := FALSE;
				ZoneStatus[2] := STATE_IDLE_ZONE;	
			END_IF;
			// Zone 4
			IF EnableZone4 THEN
				TempController[3].Enable := TRUE;
				MTBasicsPID_HEAT[3].Enable := TRUE;
				MTBasicsPID_COLD[3].Enable := TRUE;
				// Simulation zone 4
				IF SimulateZone4Enable THEN
					TempController[3].Control := TRUE;
					TempController[3].Simulate := TRUE;
				ELSE
					MTBasicsPWM_HEAT[3].Enable := TRUE;
					MTBasicsPWM_COLD[3].Enable := TRUE;
					//TempController[3].Control := TRUE;
					TempController[3].Simulate := FALSE;
				END_IF;
			ELSE
				TempController[3].Enable := FALSE;
				MTBasicsPID_HEAT[3].Enable := FALSE;
				MTBasicsPID_COLD[3].Enable := FALSE;
				MTBasicsPWM_HEAT[3].Enable := FALSE;
				MTBasicsPWM_COLD[3].Enable := FALSE;
				ZoneStatus[3] := STATE_IDLE_ZONE;	
			END_IF;
			
		STATE_WORKING_AUTOMATIC:
			EnableZone1 := TRUE;
			EnableZone2 := TRUE;
			EnableZone3 := TRUE;
			EnableZone4 := TRUE;
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
			
			MTBasicsPID_HEAT[0].Enable := FALSE;
			MTBasicsPID_HEAT[1].Enable := FALSE;
			MTBasicsPID_HEAT[2].Enable := FALSE;
			MTBasicsPID_HEAT[3].Enable := FALSE;
			MTBasicsPID_COLD[0].Enable := FALSE;
			MTBasicsPID_COLD[1].Enable := FALSE;
			MTBasicsPID_COLD[2].Enable := FALSE;
			MTBasicsPID_COLD[3].Enable := FALSE;
			
			MTBasicsPWM_HEAT[0].Enable := FALSE;
			MTBasicsPWM_HEAT[1].Enable := FALSE;
			MTBasicsPWM_HEAT[2].Enable := FALSE;
			MTBasicsPWM_HEAT[3].Enable := FALSE;
			MTBasicsPWM_COLD[0].Enable := FALSE;
			MTBasicsPWM_COLD[1].Enable := FALSE;
			MTBasicsPWM_COLD[2].Enable := FALSE;
			MTBasicsPWM_COLD[3].Enable := FALSE;
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
			
			MTBasicsPID_HEAT[0].Enable := FALSE;
			MTBasicsPID_HEAT[1].Enable := FALSE;
			MTBasicsPID_HEAT[2].Enable := FALSE;
			MTBasicsPID_HEAT[3].Enable := FALSE;
			MTBasicsPID_COLD[0].Enable := FALSE;
			MTBasicsPID_COLD[1].Enable := FALSE;
			MTBasicsPID_COLD[2].Enable := FALSE;
			MTBasicsPID_COLD[3].Enable := FALSE;
			
			MTBasicsPWM_HEAT[0].Enable := FALSE;
			MTBasicsPWM_HEAT[1].Enable := FALSE;
			MTBasicsPWM_HEAT[2].Enable := FALSE;
			MTBasicsPWM_HEAT[3].Enable := FALSE;
			MTBasicsPWM_COLD[0].Enable := FALSE;
			MTBasicsPWM_COLD[1].Enable := FALSE;
			MTBasicsPWM_COLD[2].Enable := FALSE;
			MTBasicsPWM_COLD[3].Enable := FALSE;
			
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
		MTBasicsPID_HEAT[iCnt]();
		MTBasicsPID_COLD[iCnt]();
		MTBasicsPWM_HEAT[iCnt]();
		MTBasicsPWM_COLD[iCnt]();
	END_FOR;
	TempGroup();
	// Mapping outputs
	IF SimulateZone1Enable OR SimulateZone2Enable OR SimulateZone3Enable OR SimulateZone4Enable THEN
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
	END_IF;
	// Mapping Cooling outputs
	gFan1 := MTBasicsPWM_COLD[0].Out;
	gFan2 := MTBasicsPWM_COLD[1].Out;
	gFan3 := MTBasicsPWM_COLD[2].Out;
	gFan4 := MTBasicsPWM_COLD[3].Out;
	// Mapping heating outputs
	gHeater1 := MTBasicsPWM_HEAT[0].Out;
	gHeater2 := MTBasicsPWM_HEAT[1].Out;
	gHeater3 := MTBasicsPWM_HEAT[2].Out;
	gHeater4 := MTBasicsPWM_HEAT[3].Out;
END_PROGRAM

PROGRAM _EXIT
	//
	// Exit Code
	//
	FOR iCnt := 0 TO ELEMENTS_NUMBER DO
		TempController[iCnt].Enable := FALSE;
		TempController[iCnt]();
		MTBasicsPID_HEAT[iCnt].Enable := FALSE;
		MTBasicsPID_HEAT[iCnt]();
		MTBasicsPID_COLD[iCnt].Enable := FALSE;
		MTBasicsPID_COLD[iCnt]();
		MTBasicsPWM_HEAT[iCnt].Enable := FALSE;
		MTBasicsPWM_HEAT[iCnt]();
		MTBasicsPWM_COLD[iCnt].Enable := FALSE;
		MTBasicsPWM_COLD[iCnt]();
	END_FOR;
	TempGroup.Enable := FALSE;
	TempGroup(); 
END_PROGRAM

