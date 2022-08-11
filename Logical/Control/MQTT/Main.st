
PROGRAM _INIT
	(* Insert code here *)
	Init;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IotMqttPublish_0.Send :=FALSE;
	TopicCounter.CU := FALSE;
	doSend := NOT doSend;
	
	TopicSelectionTransmision;

	TopicCounter();
	IotMqttClient_0();
	IotMqttPublish_0();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
END_PROGRAM

