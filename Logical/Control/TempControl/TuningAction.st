
ACTION TuningAction: 
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
END_ACTION
