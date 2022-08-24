
PROGRAM _INIT
	
	MpAuditTrail_0.MpLink := ADR(gAuditTrail);
	MpAuditTrail_0.Enable := TRUE;
	MpAuditTrail_0.DeviceName := ADR('AUDIT');
	MpAuditTrail_0();
	export_timer.PT := EXPORT_PERIOD;
END_PROGRAM


PROGRAM _CYCLIC
	export_timer.IN := NOT(export_timer.Q);
	String_bufer :='';
	MpAuditTrail_0.Export := FALSE;
	IF LOGIN THEN
		String_bufer:=User_name;
		TypeVar :=STRING_TO_WSTRING('LOGIN');
		MessageVar:=STRING_TO_WSTRING(String_bufer);
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail,TypeVar ,MessageVar , CommentVar);
		LOGIN :=FALSE;
	END_IF
	IF LOGOUT AND (NOT (User_name = 'Anonymous')) THEN
		String_bufer :=User_name;
		TypeVar :=STRING_TO_WSTRING('LOGOUT');
		MessageVar:=STRING_TO_WSTRING(String_bufer);
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail,TypeVar ,MessageVar , CommentVar);
	END_IF
	IF NOT (prev_machine_state=STATUS) THEN
		TypeVar :=STRING_TO_WSTRING('STATE_CHANGED');
		CASE STATUS OF
			STATE_IDLE:
				String_bufer :='IAT/AutomaticControlPage/StateIdletxt';
			STATE_TUNING:
				String_bufer :='IAT/AutomaticControlPage/StateTuningtxt';
			STATE_WORKING_MANUAL:
				String_bufer :='IAT/AutomaticControlPage/StateManualWorktxt';
			STATE_WORKING_AUTOMATIC:
				String_bufer :='IAT/AutomaticControlPage/StateAutoWorktxt';
			STATE_ERROR:
				String_bufer :='IAT/AutomaticControlPage/StateErrortxt';
			STATE_STOP:
				String_bufer :='IAT/AutomaticControlPage/StateStoptxt';
		END_CASE
		MessageVar:=STRING_TO_WSTRING(String_bufer);
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail,TypeVar ,MessageVar , CommentVar);
	END_IF
	IF Export THEN
		MpAuditTrail_0.Export := TRUE;
		Export := FALSE;
	END_IF
	IF Clear THEN
		MpAuditClearBuffer(gAuditTrail);
		Clear := FALSE;
	END_IF
	LOGOUT :=FALSE;
	prev_machine_state :=STATUS;
	MpAuditTrail_0();
END_PROGRAM


PROGRAM _EXIT
	
	MpAuditTrail_0.Enable := FALSE;
	MpAuditTrail_0();
	 
END_PROGRAM

