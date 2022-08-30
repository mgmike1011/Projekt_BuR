
ACTION AutomaticMode: 
	
	CASE AutoStep OF
		STEP_INIT:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := FALSE;
			TempController[2].Enable := FALSE;
			TempController[3].Enable := FALSE;
			
//			MTBasicsPID_HEAT[0].Enable := FALSE;
//			MTBasicsPID_HEAT[1].Enable := FALSE;
//			MTBasicsPID_HEAT[2].Enable := FALSE;
//			MTBasicsPID_HEAT[3].Enable := FALSE;
//			MTBasicsPID_COLD[0].Enable := FALSE;
//			MTBasicsPID_COLD[1].Enable := FALSE;
//			MTBasicsPID_COLD[2].Enable := FALSE;
//			MTBasicsPID_COLD[3].Enable := FALSE;
			
			MTBasicsPWM_HEAT[0].Enable := FALSE;
			MTBasicsPWM_HEAT[1].Enable := FALSE;
			MTBasicsPWM_HEAT[2].Enable := FALSE;
			MTBasicsPWM_HEAT[3].Enable := FALSE;
			MTBasicsPWM_COLD[0].Enable := FALSE;
			MTBasicsPWM_COLD[1].Enable := FALSE;
			MTBasicsPWM_COLD[2].Enable := FALSE;
			MTBasicsPWM_COLD[3].Enable := FALSE;
			
			TimStep1.IN := FALSE;
			TimStep2.IN := FALSE;
			TimStep3.IN := FALSE;
			TimStep4.IN := FALSE;
			TimStep5.IN := FALSE;
			IF gStart THEN
	  			AutoStep := STEP1;
			END_IF;
		STEP1:
			TempController[0].Enable := TRUE;
//			MTBasicsPID_HEAT[0].Enable := TRUE;
//			MTBasicsPID_COLD[0].Enable := TRUE;
			TimStep1.PT := TimeStep1;
			TimStep2.IN := FALSE;
			// Simulation/control zone 1
			IF SimulateZone1Enable THEN
				TempController[0].Control := TRUE;
				TempController[0].Simulate := TRUE;
				IF ((TempController[0].Info.Simulation.ActualTemperature) > (SetTemp1*0.99) AND TempController[0].Info.Simulation.ActualTemperature < (SetTemp1*1.01)) THEN
					TimStep1.IN := TRUE;
				ELSE
					TimStep1.IN := FALSE;
				END_IF;
			ELSE
				TempController[0].Control := TRUE;
				MTBasicsPWM_HEAT[0].Enable := TRUE;
				MTBasicsPWM_COLD[0].Enable := TRUE;
				TempController[0].Simulate := FALSE;
				IF (gTemp1 > (SetTemp1*0.99)) AND (gTemp1 < (SetTemp1*1.01)) THEN
					TimStep1.IN := TRUE;
				ELSE
					TimStep1.IN := FALSE;
				END_IF;
			END_IF;
			// Next step condition
			IF TimStep1.Q THEN
				AutoStep := STEP2;
			END_IF;
			
		STEP2:
			TempController[0].Enable := TRUE;
//			MTBasicsPID_HEAT[0].Enable := TRUE;
//			MTBasicsPID_COLD[0].Enable := TRUE;
			TimStep1.IN := FALSE;
			TimStep2.PT := TimeStep2;
			TimStep3.IN := FALSE;
			// Simulation/control zone 1
			IF SimulateZone1Enable THEN
				TempController[0].Control := TRUE;
				TempController[0].Simulate := TRUE;
			ELSE
				TempController[0].Control := TRUE;
				TempController[0].Simulate := FALSE;
				MTBasicsPWM_HEAT[0].Enable := TRUE;
				MTBasicsPWM_COLD[0].Enable := TRUE;
			END_IF;
			TempController[1].Enable := TRUE;
//			MTBasicsPID_HEAT[1].Enable := TRUE;
//			MTBasicsPID_COLD[1].Enable := TRUE;
			// Simulation/control zone 2
			IF SimulateZone2Enable THEN
				TempController[1].Control := TRUE;
				TempController[1].Simulate := TRUE;
				IF (TempController[1].Info.Simulation.ActualTemperature > (SetTemp2*0.99) AND TempController[1].Info.Simulation.ActualTemperature < (SetTemp2*1.01)) THEN
					TimStep2.IN := TRUE;
				ELSE
					TimStep2.IN := FALSE;
				END_IF;
			ELSE
				TempController[1].Control := TRUE;
				TempController[1].Simulate := FALSE;
				MTBasicsPWM_HEAT[1].Enable := TRUE;
				MTBasicsPWM_COLD[1].Enable := TRUE;
				IF (gTemp2 > (SetTemp2*0.99)) AND (gTemp2 < (SetTemp2*1.01))  THEN
					TimStep2.IN := TRUE;
				ELSE
					TimStep2.IN := FALSE;
				END_IF;
			END_IF;
			// Next step condition
			IF TimStep2.Q THEN
	  			AutoStep := STEP3;
			END_IF;

		STEP3:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := TRUE;
//			MTBasicsPID_HEAT[0].Enable := FALSE;
//			MTBasicsPID_COLD[0].Enable := FALSE;
			MTBasicsPWM_HEAT[0].Enable := FALSE;
			MTBasicsPWM_COLD[0].Enable := FALSE;
//			MTBasicsPID_HEAT[1].Enable := TRUE;
//			MTBasicsPID_COLD[1].Enable := TRUE;
			TimStep2.IN := FALSE;
			TimStep3.PT := TimeStep3;
			TimStep4.IN := FALSE;
			// Simulation/Control zone 2
			IF SimulateZone2Enable THEN
				TempController[1].Control := TRUE;
				TempController[1].Simulate := TRUE;
			ELSE
				TempController[1].Control := TRUE;
				TempController[1].Simulate := FALSE;
				MTBasicsPWM_HEAT[1].Enable := TRUE;
				MTBasicsPWM_COLD[1].Enable := TRUE;
			END_IF;
			TempController[2].Enable := TRUE;
//			MTBasicsPID_HEAT[2].Enable := TRUE;
//			MTBasicsPID_COLD[2].Enable := TRUE;
			// Simulation/Control zone 3
			IF SimulateZone3Enable THEN
				TempController[2].Control := TRUE;
				TempController[2].Simulate := TRUE;
				IF TempController[2].Info.Simulation.ActualTemperature > (SetTemp3*0.99) AND TempController[2].Info.Simulation.ActualTemperature < (SetTemp3*1.01) THEN
					TimStep3.IN := TRUE;
				ELSE
					TimStep3.IN := FALSE;
				END_IF;
			ELSE
				TempController[2].Control := TRUE;
				TempController[2].Simulate := FALSE;
				MTBasicsPWM_HEAT[2].Enable := TRUE;
				MTBasicsPWM_COLD[2].Enable := TRUE;
				IF (gTemp3 > (SetTemp3*0.99)) AND (gTemp3 < (SetTemp3*1.01)) THEN
					TimStep3.IN := TRUE;
				ELSE
					TimStep3.IN := FALSE;
				END_IF;
			END_IF;
			// Next step condition
			IF TimStep3.Q THEN
	  			AutoStep := STEP4;
			END_IF;
			
		STEP4:
			TempController[1].Enable := FALSE;
			TempController[2].Enable := TRUE;
//			MTBasicsPID_HEAT[1].Enable := FALSE;
//			MTBasicsPID_COLD[1].Enable := FALSE;
			MTBasicsPWM_HEAT[1].Enable := FALSE;
			MTBasicsPWM_COLD[1].Enable := FALSE;
//			MTBasicsPID_HEAT[2].Enable := TRUE;
//			MTBasicsPID_COLD[2].Enable := TRUE;
			TimStep3.IN := FALSE;
			TimStep4.PT := TimeStep4;
			TimStep5.IN := FALSE;
			// Simulation/control zone 3
			IF SimulateZone3Enable THEN
				TempController[2].Control := TRUE;
				TempController[2].Simulate := TRUE;
			ELSE
				TempController[2].Control := TRUE;
				TempController[2].Simulate := FALSE;
				MTBasicsPWM_HEAT[2].Enable := TRUE;
				MTBasicsPWM_COLD[2].Enable := TRUE;
			END_IF;
			TempController[3].Enable := TRUE;
//			MTBasicsPID_HEAT[3].Enable := TRUE;
//			MTBasicsPID_COLD[3].Enable := TRUE;
			// Simulation/Control zone 4
			IF SimulateZone4Enable THEN
				TempController[3].Control := TRUE;
				TempController[3].Simulate := TRUE;
				IF TempController[3].Info.Simulation.ActualTemperature > (SetTemp4*0.99) AND TempController[3].Info.Simulation.ActualTemperature < (SetTemp4*1.01) THEN
					TimStep4.IN := TRUE;
				ELSE
					TimStep4.IN := FALSE;
				END_IF;
			ELSE
				TempController[3].Control := TRUE;
				TempController[3].Simulate := FALSE;
				MTBasicsPWM_HEAT[3].Enable := TRUE;
				MTBasicsPWM_COLD[3].Enable := TRUE;
				IF (gTemp4 > (SetTemp4*0.99)) AND (gTemp4 < (SetTemp4*1.01)) THEN
					TimStep4.IN := TRUE;
				ELSE
					TimStep4.IN := FALSE;
				END_IF;
			END_IF;
			//Next step condition
			IF TimStep4.Q THEN
	  			AutoStep := STEP5;
			END_IF;
			
		STEP5:
			TempController[2].Enable := FALSE;
			TempController[3].Enable := TRUE;
//			MTBasicsPID_HEAT[2].Enable := FALSE;
//			MTBasicsPID_COLD[2].Enable := FALSE;
			MTBasicsPWM_HEAT[2].Enable := FALSE;
			MTBasicsPWM_COLD[2].Enable := FALSE;
//			MTBasicsPID_HEAT[3].Enable := TRUE;
//			MTBasicsPID_COLD[3].Enable := TRUE;
			TimStep4.IN := FALSE;
			TimStep5.PT := TimeStep5;
			TimStep5.IN := TRUE;
			IF TimStep5.Q THEN
				AutoStep := STEP_INIT;
				CycleNumber := CycleNumber + 1;
			END_IF;
	END_CASE;
	// Call timer functionblock
	TimStep1();
	TimStep2();
	TimStep3();
	TimStep4();
	TimStep5();
END_ACTION
