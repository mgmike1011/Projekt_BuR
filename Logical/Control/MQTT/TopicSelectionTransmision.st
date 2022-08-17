
ACTION TopicSelectionTransmision: 
	IF doSend THEN
		PublishMessage :='';
		CASE TopicCounter.CV OF
			0:
				IotMqttPublish_0.Topic:= ADR('OEE');
				JSON_PARSER_fun('MQTT:Fans',ADR(PublishMessage));
			1:
				Parser.PV := 'MQTT:SetPoint';
				IotMqttPublish_0.Topic:= ADR('SETPOINTS');
				JSON_PARSER_fun('MQTT:SetPoint',ADR(PublishMessage));
			2:
				IotMqttPublish_0.Topic:= ADR('TEMPERATURES');
				JSON_PARSER_fun('MQTT:Temps',ADR(PublishMessage));
			3:
				IotMqttPublish_0.Topic:= ADR('ZONES');
				JSON_PARSER_fun('MQTT:Zones',ADR(PublishMessage));
			4:
				IotMqttPublish_0.Topic:= ADR('ALARMS');
				JSON_PARSER_fun('Alarms',ADR(PublishMessage));
			5:
				IotMqttPublish_0.Topic:= ADR('HEATERS');
				JSON_PARSER_fun('MQTT:Heaters',ADR(PublishMessage));
			6:
				IotMqttPublish_0.Topic:= ADR('OEE');
				JSON_PARSER_fun('OEE',ADR(PublishMessage));
			7:
				IotMqttPublish_0.Topic:= ADR('STATE');
				JSON_PARSER_fun('MQTT:MachineState',ADR(PublishMessage));
		END_CASE
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;
		TopicCounter.CU := TRUE;
		TopicCounter.RESET := TopicCounter.Q;
	END_IF
END_ACTION
