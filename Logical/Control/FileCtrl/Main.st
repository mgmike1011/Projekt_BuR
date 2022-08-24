
PROGRAM _INIT
	
	MpFileManagerUI_0.MpLink := ADR(gFileManagerUI);
	MpFileManagerUI_0.Enable := TRUE;
	MpFileMngSetup.FileListSize := 50;
	MpFileManagerUI_0.UISetup := MpFileMngSetup;
	MpFileManagerUI_0.UIConnect := ADR(MpFileMngConnect);
	MpFileMngConnect.DeviceList.DeviceNames[0] := 'DISK';
	
	StartValueFor1 := 0;
	StopValueFor1 := 49;
	StartValueFor2 := 0;
	StopValueFor2 := 49;
	StartValueFor3 := 0;
	StopValueFor3 := 49;
	Step := 1;
	SortType[0] := TRUE;
	
	OpenPDF := 0;
	OpenDialogPDF := 0;
	FileCopy_PDF.enable := TRUE;
	test := 0;
	OpenDialogPDFchange := 0;
	closeDelete := 0;
	
	
//	del1 := 0;
//	del2 := 0;
//	del3 := 0;
END_PROGRAM


PROGRAM _CYCLIC

	// Switching from singleselect mode to multiselect mode
	IF NOT MpFileMngConnect.File.MultiSelect THEN
		SingleSelect := TRUE;
	END_IF
	
	// Confirmation of replacing an item
	IF MpFileMngConnect.MessageBox.Type = mpFILE_MSG_CONFIRM_OVERWRITE THEN
		OpenConOveDia := TRUE;
	ELSE
		OpenConOveDia := FALSE;
	END_IF
	
	// Locking and unlocking the buttons
	IF MpFileMngConnect.File.MultiSelect THEN
		ItemsEnabled := FALSE;
	END_IF
	IF EDGEPOS(MpFileMngConnect.File.Delete) OR EDGEPOS(MpFileMngConnect.File.Paste) OR EDGEPOS(MpFileMngConnect.MessageBox.Confirm) OR EDGEPOS(MpFileMngConnect.MessageBox.Cancel) THEN
		MpFileMngConnect.File.MultiSelect := FALSE;
		SingleSelect := TRUE;
		ItemsEnabled := TRUE;
	END_IF
	
	// Sorting
	IF SortType[0] THEN
		MpFileMngConnect.File.SortOrder := 0;
	ELSIF SortType[1] THEN
		MpFileMngConnect.File.SortOrder := 1;
	ELSIF SortType[2] THEN
		MpFileMngConnect.File.SortOrder := 2;
	ELSIF SortType[3] THEN
		MpFileMngConnect.File.SortOrder := 3;
	ELSIF SortType[4] THEN
		MpFileMngConnect.File.SortOrder := 4;
	ELSIF SortType[5] THEN
		MpFileMngConnect.File.SortOrder := 5;	
	END_IF
	
	// Deselecting all boxes when switching on the multiselect mode
	IF EDGEPOS(MpFileMngConnect.File.MultiSelect) THEN
		FOR iFor1 := StartValueFor1 TO StopValueFor1 BY Step DO
			MpFileMngConnect.File.List.Items[iFor1].IsSelected := FALSE;
		END_FOR
	END_IF
	
	// Main loop
	FOR iFor2 := StartValueFor2 TO StopValueFor2 BY Step DO
		// Assigning file types
		IF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_NONE THEN	
			ElementType[iFor2] := '';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_FOLDER THEN	
			ElementType[iFor2] := 'Folder';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_FILE THEN	
			ElementType[iFor2] := 'File';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_TXT THEN	
			ElementType[iFor2] := 'txt';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_HTML THEN	
			ElementType[iFor2] := 'html';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_DOC THEN	
			ElementType[iFor2] := 'doc';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_XLS THEN	
			ElementType[iFor2] := 'xls';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_XML THEN	
			ElementType[iFor2] := 'xml';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_CSV THEN	
			ElementType[iFor2] := 'csv';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_JPG THEN	
			ElementType[iFor2] := 'jpg';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_BMP THEN	
			ElementType[iFor2] := 'bmp';
		ELSIF MpFileMngConnect.File.List.Items[iFor2].ItemType = mpFILE_ITEM_TYPE_USER1 THEN	
			ElementType[iFor2] := 'pdf';
		END_IF
		
		// Counting marked boxes
		NumSelBox := 0;
		FOR iFor3 := StartValueFor3 TO StopValueFor3 BY Step DO
			IF MpFileMngConnect.File.List.Items[iFor3].IsSelected THEN
				NumSelBox := NumSelBox + 1;
			END_IF
		END_FOR
		
		// Selecting a message informing about what we are removing and opening a window with this message
		IF NumSelBox = 1 AND MpFileMngConnect.File.List.Items[iFor2].IsSelected AND MpFileMngConnect.File.List.Items[iFor2].IsFolder THEN
			Folder := TRUE;
			File := FALSE;
			Items := FALSE;
		ELSIF NumSelBox = 1 AND MpFileMngConnect.File.List.Items[iFor2].IsSelected AND NOT MpFileMngConnect.File.List.Items[iFor2].IsFolder THEN
			Folder := FALSE;
			File := TRUE;
			Items := FALSE;
		ELSIF NumSelBox > 1 AND MpFileMngConnect.File.List.Items[iFor2].IsSelected AND MpFileMngConnect.File.MultiSelect THEN
			Folder := FALSE;
			File := FALSE;
			Items := TRUE;
		END_IF
		
		// Checking if a box is selected
		IF MpFileMngConnect.File.List.Items[iFor2].IsSelected THEN 
			DeactivatedBoxes := FALSE;
			EXIT;
		ELSE
			DeactivatedBoxes := TRUE;
		END_IF
	END_FOR	
	
	//////////////////////////////////////////////////////
	
	IF OpenPDF THEN
		
		FOR i:=0 TO 50 BY 1 DO
			IF MpFileMngConnect.File.List.Items[i].IsSelected = TRUE THEN
				
				FileName := MpFileMngConnect.File.List.Items[i].Name;
				//del1 := 1;////////////////////////////////////////////////////
				IF ElementType[i] = 'pdf' THEN 
					PDFtrue := TRUE;
					//del2 := 1;///////////////////////////////////////////////
				ELSE
					PDFtrue := FALSE;
					OpenPDF := FALSE;
				END_IF;
				
				EXIT;
				
			END_IF;
		END_FOR;
		
		IF test = 0 AND OpenDialogPDFchange = 0 AND PDFtrue = TRUE THEN
			PathFinder;
		END_IF;
		
		IF test = 1 AND OpenDialogPDFchange = 0 AND PDFtrue = TRUE THEN
			FileCopy_PDF();
		END_IF;
		
		IF FileCopy_PDF.status = 0 AND PDFtrue = TRUE THEN
			FileCopy_PDF.enable := FALSE;
			FileCopy_PDF();
			OpenDialogPDF := 1;
			OpenDialogPDFchange := 1;
		END_IF;
		
        IF OpenDialogPDF = 0 AND OpenDialogPDFchange = 1 AND PDFtrue = TRUE THEN
            IF closeDelete = 0 THEN
                DeleteCopied;
            ELSE
                FileDelete_PDF();
			END_IF
			
			IF FileDelete_PDF.status = 0 AND PDFtrue = TRUE THEN
				FileDelete_PDF.enable := FALSE;
				FileDelete_PDF();
				OpenDialogPDFchange := 0;
				test := 0;
				OpenPDF := 0;
				closeDelete := 0;
				PDFtrue := FALSE;
            END_IF
		END_IF
	END_IF;
	
	///////////////////////////////////////////////////////
	
	MpFileManagerUI_0();
	
END_PROGRAM


PROGRAM _EXIT
	
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	 
	FileCopy_PDF.enable := FALSE;
	FileCopy_PDF();
	FileDelete_PDF.enable := FALSE;
	FileDelete_PDF();
	
END_PROGRAM

