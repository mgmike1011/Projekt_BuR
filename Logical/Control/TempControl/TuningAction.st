
ACTION TuningAction: 
	TempGroup.Tune := FALSE;
	TuneEnable := FALSE;
	FOR iCnt := 0  TO ELEMENTS_NUMBER DO
		// Heating PID params
		PIDProportionaGainHEAT[iCnt] := TempController[iCnt].Info.Tuning.PIDParameters.Heat.ProportionalGain;
		TempControllerPar[iCnt].PID.Heat.ProportionalGain := PIDProportionaGainHEAT[iCnt];
		PIDIntegrationTimeHEAT[iCnt] := TempController[iCnt].Info.Tuning.PIDParameters.Heat.IntegrationTime;
		TempControllerPar[iCnt].PID.Heat.IntegrationTime := PIDIntegrationTimeHEAT[iCnt];
		PIDFilterTimeHEAT[iCnt] := TempController[iCnt].Info.Tuning.PIDParameters.Heat.FilterTime;
		TempControllerPar[iCnt].PID.Heat.FilterTime := PIDFilterTimeHEAT[iCnt];
		PIDDerivativeTimeHEAT[iCnt] :=  TempController[iCnt].Info.Tuning.PIDParameters.Heat.DerivativeTime;
		TempControllerPar[iCnt].PID.Heat.DerivativeTime:= PIDDerivativeTimeHEAT[iCnt];
		// Cooling PID params
		PIDProportionaGainCOOL[iCnt] := TempController[iCnt].Info.Tuning.PIDParameters.Cool.ProportionalGain;
		TempControllerPar[iCnt].PID.Cool.ProportionalGain := PIDProportionaGainCOOL[iCnt];
		PIDIntegrationTimeCOOL[iCnt] := TempController[iCnt].Info.Tuning.PIDParameters.Cool.IntegrationTime;
		TempControllerPar[iCnt].PID.Cool.IntegrationTime := PIDIntegrationTimeCOOL[iCnt];
		PIDFilterTimeCOOL[iCnt] :=  TempController[iCnt].Info.Tuning.PIDParameters.Cool.FilterTime;
		TempControllerPar[iCnt].PID.Cool.FilterTime := PIDFilterTimeCOOL[iCnt];
		PIDDerivativeTimeCOOL[iCnt] := TempController[iCnt].Info.Tuning.PIDParameters.Cool.DerivativeTime;
		TempControllerPar[iCnt].PID.Cool.DerivativeTime := PIDDerivativeTimeCOOL[iCnt];
	END_FOR;
END_ACTION
