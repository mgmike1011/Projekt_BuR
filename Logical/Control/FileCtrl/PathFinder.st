
ACTION PathFinder: 
	
	FileCopy_PDF.enable := TRUE;
	
		FOR i:=0 TO 50 BY 1 DO
			IF MpFileMngConnect.File.List.Items[i].IsSelected = TRUE THEN
				FileName := MpFileMngConnect.File.List.Items[i].Name;
			END_IF;
		END_FOR;
	
	FileCopy_PDF.pDestDev := ADR('BRVisu');
	FileCopy_PDF.pSrcDev := ADR('PDF');
	FileCopy_PDF.pSrc := ADR(FileName);
	FileCopy_PDF.pDest := ADR(FileName);
	FileCopy_PDF.option := fiOVERWRITE;
	FileCopy_PDF();
	test:=1;
	
END_ACTION
