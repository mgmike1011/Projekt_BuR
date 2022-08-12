
ACTION TopicSelectionTransmision: 
	CASE TopicCounter.CV OF
		0:
			MessagePointer := 'MQTT:Temps';
			IotMqttPublish_0.Topic := ADR('Temps');
		1:
			MessagePointer := 'MQTT:Fans';
			IotMqttPublish_0.Topic := ADR('Fans');
		2:
			MessagePointer := 'MQTT:SetPoints';
			IotMqttPublish_0.Topic := ADR('SetPoints');
	END_CASE
	IotMqttPublish_0.Update;
	IotMqttPublish_0.Trigger :=TRUE;
	TopicCounter.CU := TRUE;
	TopicCounter.RESET := TopicCounter.Q;	
END_ACTION
