
PROGRAM _INIT
	(* Insert code here *)
	Init;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here	*)
	//doSend := NOT doSend;
	Dint :=ADR(Test.New_Member2);
	real ACCESS Dint;
	IotMqttPublish_0.Send :=FALSE;
	IF	NOT	doSend THEN
		IotMqttPublish_0.Send :=TRUE;
		Parser(PV := 'MQTT:Test');
		Parser();
		PublishMessage := Parser.Output_string;
		IotMqttPublish_0.Topic:= ADR('TEST');
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;
	END_IF
	
	

//	TopicCounter.CU := FALSE;
	//	TopicSelectionTransmision;
//	TopicCounter();
	IotMqttClient_0();
	IotMqttPublish_0();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
END_PROGRAM

