
PROGRAM _INIT
	(* Insert code here *)
	MpAlarmXCore_0.MpLink :=  ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXHistory_0.MpLink :=  ADR(gAlarmXHistory);
	MpAlarmXHistory_0.Enable := TRUE;
	MpAlarmXCore_0();
	MpAlarmXHistory_0();
	mpAlarmXlist.MpLink :=ADR(gAlarmXCore);
	mpAlarmXlist.Enable := TRUE;
	mpAlarmXlist.UIConnect := ADR(mpAlarmXlistConnect);
	mpAlarmXlist.UISetup := MpAlarmXlistSetup;
	//initialization
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpAlarmXCore_0();
	MpAlarmXHistory_0();
	mpAlarmXlist();
	Alarms.Pending := MpAlarmXCore_0.PendingAlarms;
	Alarms.Active :=  MpAlarmXCore_0.ActiveAlarms;
	Alarms.ActiveAlarms := '';
	IF NOT(Alarms.Active=0) THEN
		FOR i:=0 TO 49 BY 1 DO
			IF mpAlarmXlistConnect.AlarmList.StateActive[i] THEN
				stringBuffer := UDINT_TO_STRING(mpAlarmXlistConnect.AlarmList.Code[i]);
				brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
				stringBuffer := ';';
				brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
				stringBuffer := WSTRING_TO_STRING(mpAlarmXlistConnect.AlarmList.Message[i]);
				brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
				IF NOT (i = Alarms.Active) THEN
					stringBuffer :=',';
					brsstrcat(ADR(Alarms.ActiveAlarms),ADR(stringBuffer));
				END_IF
			END_IF
		END_FOR
	END_IF
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpAlarmXCore_0.Enable := FALSE;
	MpAlarmXHistory_0.Enable := FALSE;
	mpAlarmXlist.Enable := FALSE;
	mpAlarmXlist();
	MpAlarmXCore_0();
	MpAlarmXHistory_0();
END_PROGRAM
