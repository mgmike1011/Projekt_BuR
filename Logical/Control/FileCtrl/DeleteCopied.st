
ACTION DeleteCopied: 
	
	FileDelete_PDF.enable := TRUE;
	FileDelete_PDF.pDevice := ADR('BRVisu');
	FileDelete_PDF.pName := ADR(FileName);
	FileDelete_PDF();
	closeDelete := 1;
	
	
END_ACTION
