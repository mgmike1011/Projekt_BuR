
TYPE
	AUTOMATIC_MODE_STATE : 
		( (*Step of automatic mode*)
		STEP_INIT,
		STEP1,
		STEP2,
		STEP3,
		STEP4,
		STEP5
		);
	ZONE_WORKING_STATE : 
		( (*Working state of each zone*)
		STATE_IDLE_ZONE,
		STATE_HEATING,
		STATE_COOLING
		);
	MACHINE_WORKING_STATE : 
		( (*Working state of whole machine*)
		STATE_IDLE,
		STATE_TUNING,
		STATE_WORKING_MANUAL,
		STATE_WORKING_AUTOMATIC,
		STATE_ERROR,
		STATE_STOP
		);
	MACHINE_PARAMETERS : 	STRUCT  (*Machine parameters - structed*)
		Temp1 : REAL;
		Temp2 : REAL;
		Temp3 : REAL;
		Temp4 : REAL;
		Time1 : TIME;
		Time2 : TIME;
		Time3 : TIME;
		Time4 : TIME;
		Time5 : TIME;
	END_STRUCT;
END_TYPE
