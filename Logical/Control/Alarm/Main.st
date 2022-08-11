
PROGRAM _INIT
	(* Insert code here *)
	MpAlarmXCore_0.MpLink :=  ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXCore_0();
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpAlarmXCore_0();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpAlarmXCore_0.Enable := FALSE;
	MpAlarmXCore_0();
END_PROGRAM
