
ACTION Update_mqtt_struct: 
	OEE.Availability := MpOEECore_1.Availability;
	OEE.Performance := MpOEECore_1.Performance;
	OEE.Quality := MpOEECore_1.Quality;
	OEE.OEE := MpOEECore_1.OEE;
	OEE.IdealCycleTime := TIME_TO_STRING(IdealCycleTime_1.IdealCycleTime);
	OEE.PieceCounter := MpOEECore_1.PieceCounter;
	OEE.RejectCounter :=MpOEECore_1.RejectCounter;
END_ACTION
