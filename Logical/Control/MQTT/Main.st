
PROGRAM _INIT
	(* Insert code here *)
	Init;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IotMqttPublish_0.Trigger:=FALSE;
	TopicCounter.CU := FALSE;
	doSend := NOT doSend;
	IF NOT IotMqttPublish_0.Busy AND doSend THEN
	TopicSelectionTransmision;
	END_IF
	TopicCounter();
	IotMqttClient_0();
	IotMqttPublish_0();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
END_PROGRAM

