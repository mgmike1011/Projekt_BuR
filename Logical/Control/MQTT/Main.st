
PROGRAM _INIT
	(* Insert code here *)

END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IotMqttParameters.ServerUri				:= 'localhost';
	IotMqttParameters.Port					:= 1883;
	IotMqttParameters.ClientID				:= 'PLC';
	
	
	IotMqttClient_0.Enable					:= TRUE;
	IotMqttClient_0.Connect					:= TRUE;
	IotMqttClient_0.IotMqttLink 			:= ADR(IotMqttLink);
	IotMqttClient_0.Parameters				:= IotMqttParameters;
	IotMqttClient_0();
	
	PublishMessage 							:= REAL_TO_STRING(gTemp1);
	IotMqttPublish_0.Enable					:= TRUE;
	IotMqttPublish_0.IotMqttLink			:= IotMqttClient_0.IotMqttLink;
	IotMqttPublish_0.Topic					:= ADR('Temps/test');
	IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
	IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
	IotMqttPublish_0();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	IotMqttClient_0(Enable := FALSE);
	IotMqttPublish_0(Enable := FALSE);
END_PROGRAM

