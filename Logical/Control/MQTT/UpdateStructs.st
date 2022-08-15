
ACTION UpdateStructs: 
	Fans.Fan1 := TempController[0].CoolValue;
	Fans.Fan2 := TempController[1].CoolValue;
	Fans.Fan3 := TempController[2].CoolValue;
	Fans.Fan4 := TempController[3].CoolValue;

	Temps.Temp1 := gTemp1;
	Temps.Temp2 := gTemp2;
	Temps.Temp3 := gTemp3;
	Temps.Temp4 := gTemp4;
	
	SetPoint.SetPoint1 := SetTemp1;
	SetPoint.SetPoint2 := SetTemp2;
	SetPoint.SetPoint3 := SetTemp3;
	SetPoint.SetPoint4 := SetTemp4;
	
	Zones.Zone1 := ZoneStatus[0];
	Zones.Zone2 := ZoneStatus[1];
	Zones.Zone3 := ZoneStatus[2];
	Zones.Zone4 := ZoneStatus[3];
	
END_ACTION
