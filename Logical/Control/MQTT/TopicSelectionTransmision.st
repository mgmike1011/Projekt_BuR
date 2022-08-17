
ACTION TopicSelectionTransmision: 
	IF doSend THEN
		CASE TopicCounter.CV OF
			0:
				Parser.PV := 'MQTT:Fans';
				IotMqttPublish_0.Topic:= ADR('FANS');
				Parser();
				PublishMessage := Parser.Output_string;
			1:
				Parser.PV := 'MQTT:SetPoint';
				IotMqttPublish_0.Topic:= ADR('SETPOINTS');
				Parser();
				PublishMessage := Parser.Output_string;
			2:
				Parser.PV := 'MQTT:Temps';
				IotMqttPublish_0.Topic:= ADR('TEMPERATURES');
				Parser();
				PublishMessage := Parser.Output_string;
			3:
				Parser.PV := 'MQTT:Zones';
				IotMqttPublish_0.Topic:= ADR('ZONES');
				Parser();
				PublishMessage := Parser.Output_string;
			4:
				Parser.PV := 'Alarms';
				IotMqttPublish_0.Topic:= ADR('ALARMS');
				Parser();
				PublishMessage := Parser.Output_string;
			5:
				Parser.PV := 'MQTT:Heaters';
				IotMqttPublish_0.Topic:= ADR('HEATERS');
				Parser();
				PublishMessage := Parser.Output_string;
			6:
				Parser.PV := 'OEE';
				IotMqttPublish_0.Topic:= ADR('OEE');
				Parser();
				PublishMessage := Parser.Output_string;
			7:
				Parser.PV := 'MQTT:MachineState';
				IotMqttPublish_0.Topic:= ADR('STATE');
				Parser();
				PublishMessage := Parser.Output_string;
		END_CASE
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;
		TopicCounter.CU := TRUE;
		TopicCounter.RESET := TopicCounter.Q;
		
	END_IF
	
END_ACTION
