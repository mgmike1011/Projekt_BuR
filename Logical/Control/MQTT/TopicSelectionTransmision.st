
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
			8:
				PublishMessage := REAL_TO_STRING(TempController[0].CoolValue);
				IotMqttPublish_0.Topic:= ADR('Fans/Fan1');
			9:
				PublishMessage := REAL_TO_STRING(TempController[1].CoolValue);
				IotMqttPublish_0.Topic:= ADR('Fans/Fan2');
			10:
				PublishMessage := REAL_TO_STRING(TempController[2].CoolValue);
				IotMqttPublish_0.Topic:= ADR('Fans/Fan3');
			11:
				PublishMessage := REAL_TO_STRING(TempController[3].CoolValue);
				IotMqttPublish_0.Topic:= ADR('Fans/Fan4');
			12:
				Enum_to_Dint :=ZoneStatus[0];
				PublishMessage := DINT_TO_STRING(Enum_to_Dint);
				IotMqttPublish_0.Topic:= ADR('Zones/Zone1');
			13:
				Enum_to_Dint :=ZoneStatus[1];
				PublishMessage := DINT_TO_STRING(Enum_to_Dint);
				IotMqttPublish_0.Topic:= ADR('Zones/Zone2');
			14:
				Enum_to_Dint :=ZoneStatus[2];
				PublishMessage := DINT_TO_STRING(Enum_to_Dint);
				IotMqttPublish_0.Topic:= ADR('Zones/Zone3');
			15:
				Enum_to_Dint :=ZoneStatus[3];
				PublishMessage := DINT_TO_STRING(Enum_to_Dint);
				IotMqttPublish_0.Topic:= ADR('Zones/Zone4');
		END_CASE
		IotMqttPublish_0.Buffer					:= ADR(PublishMessage);
		IotMqttPublish_0.BufferLength			:= brsstrlen(ADR(PublishMessage));
		IotMqttPublish_0.Send :=TRUE;
		
		TopicCounter.CU := TRUE;
		TopicCounter.RESET := TopicCounter.Q;
		
	END_IF
	
END_ACTION
