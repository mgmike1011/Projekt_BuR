
PROGRAM _INIT
	//
	// Init code
	//
	SetTemp1 := 30;
	SetTemp2 := 30;
	SetTemp3 := 30;
	SetTemp4 := 30;
END_PROGRAM


PROGRAM _CYCLIC
	//
	// Cyclic code - automatic mode
	//
	IF Auto_mode AND NOT Manual_mode THEN
		
		IF Start = 1 THEN
			Step := 1;
		ELSIF Stop = 1 THEN
			Step := 0;
			gHeater1 := 0;
			gHeater2 := 0;
			gHeater3 := 0;
			gHeater4 := 0;
		END_IF
	
		CASE Step OF
			1:
				Start := 0;
				gHeater1 := 1;
				
				IF gTemp1 = SetTemp1 THEN
					Step := 2;
				END_IF
				
			2:
				gHeater2 := 1;
				
				IF gTemp2 = SetTemp2 THEN
					Step := 3;
				END_IF
				
			3:
				gHeater1 := 0;
				gHeater3 := 1;
				
				IF gTemp3 = SetTemp3 THEN
					Step := 4;
				END_IF
				
			4:
				gHeater2 := 0;
				gHeater4 := 1;
				
				IF gTemp4 = SetTemp4 THEN
					Step := 5;
				END_IF
				
			5:
				gHeater3 := 0;
				
				IF TON_0.Q = 0 THEN
					TON_0(IN := gHeater4, PT := T#5s);
					TON_0.Q;
				ELSE
					gHeater4 := 0;
					Step := 0;
				END_IF
		END_CASE
		
	END_IF
	 
END_PROGRAM

				
PROGRAM _EXIT		
	//
	// Exit code
	//
END_PROGRAM

