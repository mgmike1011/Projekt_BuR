
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
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	TONtimer.IN := TRUE;
	IotMqttPublish_0.Send :=FALSE;
	IF TONtimer.Q THEN
		TONtimer.IN := FALSE;
		PublishMessage 							:= REAL_TO_STRING(gTemp1);
		IotMqttPublish_0.Topic					:= ADR('Temps/test');
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;
	END_IF
	IotMqttClient_0();
	IotMqttPublish_0();
	TONtimer();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
END_PROGRAM

