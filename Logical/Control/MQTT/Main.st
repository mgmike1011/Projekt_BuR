
PROGRAM _INIT
	(* Insert code here *)
	Init;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here	*)
	//doSend := NOT doSend;
	
//	IF	NOT	doSend THEN
//		IotMqttPublish_0.Send :=TRUE;
//		Parser(PV := 'MQTT:Test');
//		Parser();
//		PublishMessage := Parser.Output_string;
//		IotMqttPublish_0.Topic:= ADR('TEST');
//		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
//		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
//		IotMqttPublish_0.Send :=TRUE;
//	END_IF
	IF run THEN
	UpdateStructs;
	doSend := NOT doSend;
	IotMqttPublish_0.Send :=FALSE;
	TopicCounter.CU := FALSE;
	
	TopicSelectionTransmision;
	
	TopicCounter();
	IotMqttClient_0();
	IotMqttPublish_0();
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
	IotMqttClient_0();
	IotMqttPublish_0();
END_PROGRAM

