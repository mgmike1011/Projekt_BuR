
PROGRAM _INIT
	(* Insert code here *)
	IotMqttParameters.ServerUri				:= 'localhost';
	IotMqttParameters.Port					:= 1883;
	IotMqttParameters.ClientID				:= 'PLC';
	
	
	IotMqttClient_0.Enable					:= TRUE;
	IotMqttClient_0.Connect					:= TRUE;
	IotMqttClient_0.IotMqttLink 			:= ADR(IotMqttLink);
	IotMqttClient_0.Parameters				:= IotMqttParameters;
	

	IotMqttPublish_0.Enable					:= TRUE;
	IotMqttPublish_0.IotMqttLink			:= ADR(IotMqttLink);
	
	
	TONtimer.PT := t#1s;
	TopicCounter.PV := NR_OF_TOPICS-1;

END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	TONtimer.IN := TRUE;
	IotMqttPublish_0.Send :=FALSE;
	TopicCounter.CU := FALSE;
	IF TONtimer.Q THEN
		CASE TopicCounter.CV OF
			0:
				PublishMessage := REAL_TO_STRING(gTemp1);
				IotMqttPublish_0.Topic:= ADR('Temps/Temp1');
			1:
				PublishMessage := REAL_TO_STRING(gTemp2);
				IotMqttPublish_0.Topic:= ADR('Temps/Temp2');
			2:
				PublishMessage := REAL_TO_STRING(gTemp3);
				IotMqttPublish_0.Topic:= ADR('Temps/Temp3');
			3:
				PublishMessage := REAL_TO_STRING(gTemp4);
				IotMqttPublish_0.Topic:= ADR('Temps/Temp4');
		END_CASE
		
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;

		TONtimer.IN := FALSE;
		TopicCounter.CU := TRUE;
		TopicCounter.RESET := TopicCounter.Q;
	END_IF
	IotMqttClient_0();
	IotMqttPublish_0();
	TONtimer();
	TopicCounter();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
END_PROGRAM

