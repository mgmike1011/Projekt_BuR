
ACTION AutomaticMode: 
	
	CASE AutoStep OF
		STEP_INIT:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := FALSE;
			TempController[2].Enable := FALSE;
			TempController[3].Enable := FALSE;
			IF gStart THEN
	  			AutoStep := STEP1;
			END_IF;
		STEP1:
			TempController[0].Enable := TRUE;
			IF gTemp1 = SetTemp1 THEN
				AutoStep := STEP2;
			END_IF;
		STEP2:
			TempController[0].Enable := TRUE;
			TempController[1].Enable := TRUE;
			IF gTemp2 = SetTemp2 THEN
				AutoStep := STEP3;
			END_IF;
		STEP3:
			TempController[0].Enable := FALSE;
			TempController[1].Enable := TRUE;
			TempController[2].Enable := TRUE;
			IF gTemp3 = SetTemp3 THEN
				AutoStep := STEP4;
			END_IF;
		STEP4:
			TempController[1].Enable := FALSE;
			TempController[2].Enable := TRUE;
			TempController[3].Enable := TRUE;
			IF gTemp4 = SetTemp4 THEN
				AutoStep := STEP5;
			END_IF;
		STEP5:
			TempController[2].Enable := FALSE;
			TempController[3].Enable := TRUE;
			IF gTemp4 = SetTemp4 THEN
				AutoStep := STEP_INIT;
				CycleNumber := CycleNumber + 1;
			END_IF;
	END_CASE;
END_ACTION
