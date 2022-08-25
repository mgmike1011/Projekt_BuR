
ACTION PathFinder: 
	
	Path := 'F:/';
	brsstrcat(ADR(Path),ADR(MpFileMngConnect.File.PathInfo.CurrentDir));
	
	DevLinkOpenPDF.enable := TRUE;
	DevLinkOpenPDF.pDevice := ADR('PDF');
	DevLinkOpenPDF.pParam := ADR(Path);
	DevLinkOpenPDF();
	
	FileCopy_PDF.enable := TRUE;
	
	FileCopy_PDF.pDestDev := ADR('BRVisu');
	FileCopy_PDF.pSrcDev := ADR('PDF');
	FileCopy_PDF.pSrc := ADR(FileName);
	FileCopy_PDF.pDest := ADR(FileName);
	FileCopy_PDF.option := fiOVERWRITE;
	FileCopy_PDF();
	test:=1;
	
END_ACTION
