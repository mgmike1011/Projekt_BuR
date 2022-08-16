
PROGRAM _INIT
	(* Insert code here *)
	MpAlarmXCore_0.MpLink :=  ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXHistory_0.MpLink :=  ADR(gAlarmXHistory);
	MpAlarmXHistory_0.Enable := TRUE;
	MpAlarmXCore_0();
	MpAlarmXHistory_0();
	//initialization
	first_module;
	second_module;
	third_module;
	fourth_module;
	HeaterAlarm1;
	HeaterAlarm2;
	HeaterAlarm3;
	HeaterAlarm4;
	FanAlarm1;
	FanAlarm2;
	FanAlarm3;
	FanAlarm4;
	TempAlarmLimit;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpAlarmXCore_0();
	MpAlarmXHistory_0();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpAlarmXCore_0.Enable := FALSE;
	MpAlarmXHistory_0.Enable := FALSE;
	MpAlarmXCore_0();
	MpAlarmXHistory_0();
END_PROGRAM
