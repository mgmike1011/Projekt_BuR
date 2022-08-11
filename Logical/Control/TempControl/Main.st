PROGRAM _INIT
	//
	// Init Code
	//
	// Temp Controller
	TempControllerPar[0].Tuning.SetPointHeat := 100;
	TempControllerPar[0].Tuning.SetPointCool := 30;
	TempControllerPar[1].Tuning.SetPointHeat := 100;
	TempControllerPar[1].Tuning.SetPointCool := 30;
	TempControllerPar[2].Tuning.SetPointHeat := 100;
	TempControllerPar[2].Tuning.SetPointCool := 30;
	TempControllerPar[3].Tuning.SetPointHeat := 100;
	TempControllerPar[3].Tuning.SetPointCool := 30;
	TempControllerPar[0].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	TempControllerPar[1].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	TempControllerPar[2].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
	TempControllerPar[3].Tuning.Mode := mpTEMP_TUNING_MODE_HEAT_COOL;
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
	// Mapping inputs
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
	// Tuning Parameters
	IF TuneEnable THEN
		IF EDGEPOS(TempGroup.TuningDone) THEN
			TempGroup.Tune := FALSE;
			TuneEnable := FALSE;
			FOR iCnt := 0  TO ELEMENTS_NUMBER DO
				// Heating PID params
	  			TempControllerPar[iCnt].PID.Heat.ProportionalGain := TempController[iCnt].Info.Tuning.PIDParameters.Heat.ProportionalGain;
				TempControllerPar[iCnt].PID.Heat.IntegrationTime := TempController[iCnt].Info.Tuning.PIDParameters.Heat.IntegrationTime;
				TempControllerPar[iCnt].PID.Heat.FilterTime := TempController[iCnt].Info.Tuning.PIDParameters.Heat.FilterTime;
				TempControllerPar[iCnt].PID.Heat.DerivativeTime:= TempController[iCnt].Info.Tuning.PIDParameters.Heat.DerivativeTime;
				// Cooling PID params
				TempControllerPar[iCnt].PID.Cool.ProportionalGain := TempController[iCnt].Info.Tuning.PIDParameters.Cool.ProportionalGain;
				TempControllerPar[iCnt].PID.Cool.IntegrationTime := TempController[iCnt].Info.Tuning.PIDParameters.Cool.IntegrationTime;
				TempControllerPar[iCnt].PID.Cool.FilterTime := TempController[iCnt].Info.Tuning.PIDParameters.Cool.FilterTime;
				TempControllerPar[iCnt].PID.Cool.DerivativeTime:= TempController[iCnt].Info.Tuning.PIDParameters.Cool.DerivativeTime;
			END_FOR;
		ELSE
			TempGroup.Tune := TRUE;
		END_IF;
	END_IF;
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

