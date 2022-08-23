
ACTION PathFinder: 
	
	FileCopy_PDF.enable := TRUE;
	
//	Path := '';//œcie¿ka podstawowa, to samo ni¿ej.
//		slesz := '/';
//		brsstrcat(ADR(Path),ADR(MpFileMngConnect.File.PathInfo.CurrentDir));
	
		FOR i:=0 TO 50 BY 1 DO
			IF MpFileMngConnect.File.List.Items[i].IsSelected = TRUE THEN
				FileName := MpFileMngConnect.File.List.Items[i].Name;
			END_IF;
		END_FOR;
			
//	IF NOT(Path = '') THEN//œcie¿ka podstawowa.
//		brsstrcat(ADR(Path),ADR(slesz));	
//		END_IF;
//	brsstrcat(ADR(Path),ADR(FileName));
	
	FileCopy_PDF.pDestDev := ADR('BRVisu');
	FileCopy_PDF.pSrcDev := ADR('PDF');
	FileCopy_PDF.pSrc := ADR(FileName);
	FileCopy_PDF.pDest := ADR(FileName);
	FileCopy_PDF.option := fiOVERWRITE;
		FileCopy_PDF.enable := FALSE;
		FileCopy_PDF.option := 0;
			END_ACTION
