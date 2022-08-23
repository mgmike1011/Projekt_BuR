
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
	
END_PROGRAM


PROGRAM _CYCLIC

	// Switching from singleselect mode to multiselect mode
	IF NOT MpFileMngConnect.File.MultiSelect THEN
		SingleSelect := TRUE;
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
	
	MpFileManagerUI_0();
	
	IF OpenPDF THEN
		PathFinder;
		OpenPDF := 0;
	END_IF;
	
END_PROGRAM


PROGRAM _EXIT
	
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	 
END_PROGRAM

