
ACTION PathFinder: 
	Path := '';//œcie¿ka podstawowa, to samo ni¿ej.
		slesz := '/';
		brsstrcat(ADR(Path),ADR(MpFileMngConnect.File.PathInfo.CurrentDir));
	
		FOR i:=0 TO 50 BY 1 DO
			IF MpFileMngConnect.File.List.Items[i].IsSelected = TRUE THEN
				FileName := MpFileMngConnect.File.List.Items[i].Name;
			END_IF;
		END_FOR;
			
	IF NOT(Path = '') THEN//œcie¿ka podstawowa.
		brsstrcat(ADR(Path),ADR(slesz));	
		END_IF;
		brsstrcat(ADR(Path),ADR(FileName));
		
	
			END_ACTION
