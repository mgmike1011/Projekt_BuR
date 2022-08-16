
PROGRAM _INIT
	(* Insert code here *)
	MpAlarmXCore_0.MpLink :=  ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXCore_0();
	//mpAlarmXlist.MpLink :=ADR(gAlarmXCore);
	//mpAlarmXlist.Enable := TRUE;
	//mpAlarmXlist.UIConnect := ADR(mpAlarmXlistConnect);
	//mpAlarmXlist.UISetup := MpAlarmXlistSetup;
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
//	mpAlarmXlist();
	Alarms.Pending := MpAlarmXCore_0.PendingAlarms;
	Alarms.Active :=  MpAlarmXCore_0.ActiveAlarms;
//	Alarms.ActiveAlarms := '"';
//	FOR i:=0 TO Alarms.Pending BY 1 DO
//		stringBuffer := UDINT_TO_STRING(mpAlarmXlistConnect.AlarmList.Code[i]);
//		brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
//		stringBuffer := ' ';
//		brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
//		stringBuffer := WSTRING_TO_STRING(mpAlarmXlistConnect.AlarmList.Message[i]);
//		brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
//		IF NOT (i = Alarms.Pending) THEN
//			stringBuffer :=',';
//			brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
//		END_IF
//		stringBuffer := '"';
//		brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
//	END_FOR
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpAlarmXCore_0.Enable := FALSE;
	MpAlarmXCore_0();
END_PROGRAM
