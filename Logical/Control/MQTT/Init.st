
ACTION Init: 
	IotMqttParameters.ServerUri				:= '192.168.20.1';
	IotMqttParameters.Port					:= 1883;
	IotMqttParameters.ClientID				:= 'PLC';
	
	
	IotMqttClient_0.Enable					:= TRUE;
	IotMqttClient_0.Connect					:= TRUE;
	IotMqttClient_0.IotMqttLink 			:= ADR(IotMqttLink);
	IotMqttClient_0.Parameters				:= IotMqttParameters;
	

	IotMqttPublish_0.Enable					:= TRUE;
	IotMqttPublish_0.IotMqttLink			:= ADR(IotMqttLink);
	
	
	TopicCounter.PV := NR_OF_TOPICS-1;
END_ACTION
