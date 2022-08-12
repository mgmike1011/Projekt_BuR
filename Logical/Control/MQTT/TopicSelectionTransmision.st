
ACTION TopicSelectionTransmision: 
	IF doSend THEN
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
			4:
				PublishMessage := REAL_TO_STRING(SetTemp1);
				IotMqttPublish_0.Topic:= ADR('SetPoints/setPoint1');
			5:
				PublishMessage := REAL_TO_STRING(SetTemp2);
				IotMqttPublish_0.Topic:= ADR('SetPoints/setPoint2');
			6:
				PublishMessage := REAL_TO_STRING(SetTemp3);
				IotMqttPublish_0.Topic:= ADR('SetPoints/setPoint3');
			7:
				PublishMessage := REAL_TO_STRING(SetTemp4);
				IotMqttPublish_0.Topic:= ADR('SetPoints/setPoint4');
		END_CASE
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;
		
		TopicCounter.CU := TRUE;
		TopicCounter.RESET := TopicCounter.Q;
		
	END_IF
	
END_ACTION
