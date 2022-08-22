
PROGRAM _INIT
	
	MpAuditTrail_0.MpLink := ADR(gAuditTrail);
	MpAuditTrail_0.Enable := TRUE;
	MpAuditTrail_0.DeviceName := ADR('AUDIT');
	MpAuditTrail_0();
	
END_PROGRAM


PROGRAM _CYCLIC
	String_bufer :='';
	IF TriggerEvent THEN
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail, TypeVar, MessageVar, CommentVar);
		TriggerEvent:=FALSE;
	END_IF
	
	IF LOGIN THEN
		String_bufer :='Loged in as: ';
		brsstrcat(ADR(String_bufer),ADR(User_name));
		MessageVar:=STRING_TO_WSTRING(String_bufer);
		TypeVar :=STRING_TO_WSTRING('LOGIN');
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail,TypeVar ,MessageVar , CommentVar);
		LOGIN :=FALSE;
	END_IF
	IF LOGOUT AND (NOT (User_name = 'Anonymous')) THEN
		String_bufer :='Loged out';
		TypeVar :=STRING_TO_WSTRING('LOGOUT');
		MessageVar:=STRING_TO_WSTRING(String_bufer);
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail,TypeVar ,MessageVar , CommentVar);
	END_IF
	LOGOUT :=FALSE;
	MpAuditTrail_0();
	 
END_PROGRAM


PROGRAM _EXIT
	
	MpAuditTrail_0.Enable := FALSE;
	MpAuditTrail_0();
	 
END_PROGRAM

