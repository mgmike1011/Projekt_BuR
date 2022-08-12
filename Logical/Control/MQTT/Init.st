
ACTION Init: 
	MessagePointer := 'MQTT:Temps';
	IotMqttParameters.ServerUri				:= 'localhost';
	IotMqttParameters.Port					:= 1883;
	IotMqttParameters.ClientID				:= 'PLC';
	
	
	IotMqttClient_0.Enable					:= TRUE;
	IotMqttClient_0.Connect					:= TRUE;
	IotMqttClient_0.IotMqttLink 			:= ADR(IotMqttLink);
	IotMqttClient_0.Parameters				:= IotMqttParameters;
	

	IotMqttPublish_0.Enable					:= TRUE;
	IotMqttPublish_0.IotMqttLink			:= ADR(IotMqttLink);
	IotMqttPublish_0.PvName			:= ADR(MessagePointer);
	IotMqttPublish_0.PublishMode		:= IOTMQTT_PUB_MODE_TRIGGER;
	IotMqttPublish_0.DataFormat		:= IOTMQTT_VAR_JSON;

	TopicCounter.PV := NR_OF_TOPICS-1;
END_ACTION
