
ACTION PathFinder: 
	
	FileCopy_PDF.enable := TRUE;
	
	FileCopy_PDF.pDestDev := ADR('BRVisu');
	FileCopy_PDF.pSrcDev := ADR('PDF');
	FileCopy_PDF.pSrc := ADR(FileName);
	FileCopy_PDF.pDest := ADR(FileName);
	FileCopy_PDF.option := fiOVERWRITE;
	FileCopy_PDF();
	test:=1;
	
END_ACTION
