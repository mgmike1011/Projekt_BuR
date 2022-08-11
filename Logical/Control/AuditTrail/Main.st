
PROGRAM _INIT
	
	MpAuditTrail_0.MpLink := ADR(gAuditTrail);
	MpAuditTrail_0.Enable := TRUE;
	MpAuditTrail_0.DeviceName := ADR('CF');
	MpAuditTrail_0();
	
END_PROGRAM


PROGRAM _CYCLIC
	
	IF TriggerEvent THEN
		CustomEventStatus := MpAuditCustomEvent(gAuditTrail, TypeVar, MessageVar, CommentVar);
	END_IF
	
	MpAuditTrail_0();
	 
END_PROGRAM


PROGRAM _EXIT
	
	MpAuditTrail_0.Enable := FALSE;
	MpAuditTrail_0();
	 
END_PROGRAM

