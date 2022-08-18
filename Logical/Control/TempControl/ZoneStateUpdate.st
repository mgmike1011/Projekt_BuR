
ACTION ZoneStateUpdate: 
	// Zone1
	IF SimulateZone1Enable THEN
		// Simulation Enable
		IF TempController[0].Info.Simulation.HeatValue > TempController[0].Info.Simulation.CoolValue THEN
			ZoneStatus[0] := STATE_HEATING;
		ELSIF TempController[0].Info.Simulation.HeatValue < TempController[0].Info.Simulation.CoolValue THEN
			ZoneStatus[0] := STATE_COOLING;
		ELSE
			ZoneStatus[0] := STATE_IDLE_ZONE;	
		END_IF;
	ELSE
		// Simulation disable - real object
		IF TempController[0].HeatValue > TempController[0].CoolValue THEN
			ZoneStatus[0] := STATE_HEATING;
		ELSIF TempController[0].HeatValue < TempController[0].CoolValue THEN
			ZoneStatus[0] := STATE_COOLING;
		ELSE
			ZoneStatus[0] := STATE_IDLE_ZONE;	
		END_IF;
	END_IF;
	
	// Zone 2
	IF SimulateZone2Enable THEN
		// Simulation enable
		IF TempController[1].Info.Simulation.HeatValue > TempController[1].Info.Simulation.CoolValue THEN
			ZoneStatus[1] := STATE_HEATING;
		ELSIF TempController[1].Info.Simulation.HeatValue < TempController[1].Info.Simulation.CoolValue THEN
			ZoneStatus[1] := STATE_COOLING;
		ELSE
			ZoneStatus[1] := STATE_IDLE_ZONE;	
		END_IF;
	ELSE
		// Simulation disable - real object
		IF TempController[1].HeatValue > TempController[1].CoolValue THEN
			ZoneStatus[1] := STATE_HEATING;
		ELSIF TempController[1].HeatValue < TempController[1].CoolValue THEN
			ZoneStatus[1] := STATE_COOLING;
		ELSE
			ZoneStatus[1] := STATE_IDLE_ZONE;	
		END_IF;
	END_IF;
	
	// Zone 3
	IF SimulateZone3Enable THEN
		// Simualtion enable
		IF TempController[2].Info.Simulation.HeatValue > TempController[2].Info.Simulation.CoolValue THEN
			ZoneStatus[2] := STATE_HEATING;
		ELSIF TempController[2].Info.Simulation.HeatValue < TempController[2].Info.Simulation.CoolValue THEN
			ZoneStatus[2] := STATE_COOLING;
		ELSE
			ZoneStatus[2] := STATE_IDLE_ZONE;	
		END_IF;
	ELSE
		// Simulation disable - real object
		IF TempController[2].HeatValue > TempController[2].CoolValue THEN
			ZoneStatus[2] := STATE_HEATING;
		ELSIF TempController[2].HeatValue < TempController[2].CoolValue THEN
			ZoneStatus[2] := STATE_COOLING;
		ELSE
			ZoneStatus[2] := STATE_IDLE_ZONE;	
		END_IF;
	END_IF;

	// Zone 4
	IF SimulateZone4Enable THEN
		IF TempController[3].Info.Simulation.HeatValue > TempController[3].Info.Simulation.CoolValue THEN
			ZoneStatus[3] := STATE_HEATING;
		ELSIF TempController[3].Info.Simulation.HeatValue < TempController[3].Info.Simulation.CoolValue THEN
			ZoneStatus[3] := STATE_COOLING;
		ELSE
			ZoneStatus[3] := STATE_IDLE_ZONE;	
		END_IF;
	ELSE
		IF TempController[3].HeatValue > TempController[3].CoolValue THEN
			ZoneStatus[3] := STATE_HEATING;
		ELSIF TempController[3].HeatValue < TempController[3].CoolValue THEN
			ZoneStatus[3] := STATE_COOLING;
		ELSE
			ZoneStatus[3] := STATE_IDLE_ZONE;	
		END_IF;	
	END_IF;
	
END_ACTION
