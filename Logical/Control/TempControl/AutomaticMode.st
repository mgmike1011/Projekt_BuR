
ACTION AutomaticMode: 
	
	CASE AutoStep OF
		STEP_INIT:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := FALSE;
			TempController[2].Enable := FALSE;
			TempController[3].Enable := FALSE;
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
			TimStep1.PT := TimeStep1;
			TimStep1.IN := TRUE;
			TimStep2.IN := FALSE;
			// Simulation/control zone 1
			IF SimulateZone1Enable THEN
				TempController[0].Control := TRUE;
				TempController[0].Simulate := TRUE;
				IF ((TempController[0].Info.Simulation.ActualTemperature) > (SetTemp1*0.99) AND TempController[0].Info.Simulation.ActualTemperature < (SetTemp1*1.01)) AND TimStep1.Q THEN
					AutoStep := STEP2;
				END_IF;
			ELSE
				TempController[0].Control := TRUE;
				TempController[0].Simulate := FALSE;
				IF gTemp1 = SetTemp1 AND TimStep1.Q THEN
					AutoStep := STEP2;
				END_IF;
			END_IF;
			
		STEP2:
			TempController[0].Enable := TRUE;
			TimStep1.IN := FALSE;
			TimStep2.PT := TimeStep2;
			TimStep2.IN := TRUE;
			TimStep3.IN := FALSE;
			// Simulation/control zone 1
			IF SimulateZone1Enable THEN
				TempController[0].Control := TRUE;
				TempController[0].Simulate := TRUE;
			ELSE
				TempController[0].Control := TRUE;
				TempController[0].Simulate := FALSE;
			END_IF;
			TempController[1].Enable := TRUE;
			// Simulation/control zone 2
			IF SimulateZone2Enable THEN
				TempController[1].Control := TRUE;
				TempController[1].Simulate := TRUE;
				IF (TempController[1].Info.Simulation.ActualTemperature > (SetTemp2*0.99) AND TempController[1].Info.Simulation.ActualTemperature < (SetTemp2*1.01)) AND TimStep2.Q THEN
					AutoStep := STEP3;
				END_IF;
			ELSE
				TempController[1].Control := TRUE;
				TempController[1].Simulate := FALSE;
				IF gTemp2 = SetTemp2 AND TimStep2.Q THEN
					AutoStep := STEP3;
				END_IF;
			END_IF;

		STEP3:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := TRUE;
			TimStep2.IN := FALSE;
			TimStep3.PT := TimeStep3;
			TimStep3.IN := TRUE;
			TimStep4.IN := FALSE;
			// Simulation/Control zone 2
			IF SimulateZone2Enable THEN
				TempController[1].Control := TRUE;
				TempController[1].Simulate := TRUE;
			ELSE
				TempController[1].Control := TRUE;
				TempController[1].Simulate := FALSE;
			END_IF;
			TempController[2].Enable := TRUE;
			// Simulation/Control zone 3
			IF SimulateZone3Enable THEN
				TempController[2].Control := TRUE;
				TempController[2].Simulate := TRUE;
				IF TimStep3.Q AND TempController[2].Info.Simulation.ActualTemperature > (SetTemp3*0.99) AND TempController[2].Info.Simulation.ActualTemperature < (SetTemp3*1.01) THEN
					AutoStep := STEP4;
				END_IF;
			ELSE
				TempController[2].Control := TRUE;
				TempController[2].Simulate := FALSE;
				IF gTemp3 = SetTemp3 AND TimStep3.Q THEN
					AutoStep := STEP4;
				END_IF;
			END_IF;

			
		STEP4:
			TempController[1].Enable := FALSE;
			TempController[2].Enable := TRUE;
			TimStep3.IN := FALSE;
			TimStep4.PT := TimeStep4;
			TimStep4.IN := TRUE;
			TimStep5.IN := FALSE;
			// Simulation/control zone 3
			IF SimulateZone3Enable THEN
				TempController[2].Control := TRUE;
				TempController[2].Simulate := TRUE;
			ELSE
				TempController[2].Control := TRUE;
				TempController[2].Simulate := FALSE;
			END_IF;
			TempController[3].Enable := TRUE;
			// Simulation/Control zone 4
			IF SimulateZone4Enable THEN
				TempController[3].Control := TRUE;
				TempController[3].Simulate := TRUE;
				IF TimStep4.Q AND TempController[3].Info.Simulation.ActualTemperature > (SetTemp4*0.99) AND TempController[3].Info.Simulation.ActualTemperature < (SetTemp4*1.01) THEN
					AutoStep := STEP5;
				END_IF;
			ELSE
				TempController[3].Control := TRUE;
				TempController[3].Simulate := FALSE;
				IF gTemp4 = SetTemp4 AND TimStep4.Q THEN
					AutoStep := STEP5;
				END_IF;
			END_IF;

		STEP5:
			TempController[2].Enable := FALSE;
			TempController[3].Enable := TRUE;
			TimStep4.IN := FALSE;
			TimStep5.PT := TimeStep5;
			TimStep5.IN := TRUE;
			IF gTemp4 = SetTemp4 AND TimStep5.Q THEN
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
