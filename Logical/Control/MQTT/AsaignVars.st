
ACTION AsaignVars: 

	Temps.Temp1 :=gTemp1;
	Temps.Temp1 :=gTemp2;
	Temps.Temp1 :=gTemp3;
	Temps.Temp1 :=gTemp4;
	Fans.Fan1 := TempController[0].CoolValue;
	Fans.Fan2 := TempController[1].CoolValue;
	Fans.Fan3 := TempController[2].CoolValue;
	Fans.Fan4 := TempController[3].CoolValue;
	SetPoints.SetPoint1 := SetTemp1;
	SetPoints.SetPoint2 := SetTemp2;
	SetPoints.SetPoint3 := SetTemp3;
	SetPoints.SetPoint4 := SetTemp4;
END_ACTION

