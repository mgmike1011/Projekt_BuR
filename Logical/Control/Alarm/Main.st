
PROGRAM _INIT
	(* Insert code here *)
	MpAlarmXCore_0.MpLink :=  ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXCore_0();
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IF NOT first_module THEN
		MpAlarmXSet(gAlarmXCore,'$IAT/Alarms/ModuleMessage1');
	ELSE
		MpAlarmXReset(gAlarmXCore,'$IAT/Alarms/ModuleMessage1');
	END_IF;
	
	IF NOT second_module THEN
		MpAlarmXSet(gAlarmXCore,'$IAT/Alarms/ModuleMessage2');
	ELSE
		MpAlarmXReset(gAlarmXCore,'$IAT/Alarms/ModuleMessage2');
	END_IF;
	
	IF NOT third_module THEN
		MpAlarmXSet(gAlarmXCore,'$IAT/Alarms/ModuleMessage3');
	ELSE
		MpAlarmXReset(gAlarmXCore,'$IAT/Alarms/ModuleMessage3');
	END_IF;
	
	IF NOT fourth_module THEN
		MpAlarmXSet(gAlarmXCore,'$IAT/Alarms/ModuleMessage4');
	ELSE
		MpAlarmXReset(gAlarmXCore,'$IAT/Alarms/ModuleMessage4');
	END_IF;
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpAlarmXCore_0.Enable := FALSE;
	MpAlarmXCore_0();
END_PROGRAM
