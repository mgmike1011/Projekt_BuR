
PROGRAM _INIT
	
	MpFileManagerUI_0.MpLink := ADR(gFileManagerUI);
	MpFileManagerUI_0.Enable := TRUE;
	MpFileMngSetup.FileListSize := 50;
	MpFileManagerUI_0.UISetup := MpFileMngSetup;
	MpFileManagerUI_0.UIConnect := ADR(MpFileMngConnect);
	MpFileMngConnect.DeviceList.DeviceNames[0] := 'DISK';
	
	StartValue := 0;
	StopValue := 49;
	Step := 1;
	SortType[0] := TRUE;
	
END_PROGRAM


PROGRAM _CYCLIC
	
	IF NOT MpFileMngConnect.File.MultiSelect THEN
		SingleSelect := TRUE;
	END_IF
	
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
	
	IF EDGEPOS(MpFileMngConnect.File.MultiSelect) THEN
		FOR i := StartValue TO StopValue BY Step DO
			MpFileMngConnect.File.List.Items[i].IsSelected := FALSE;
		END_FOR
	END_IF
	
//	IF EDGEPOS(MpFileMngConnect.File.Filter = '') THEN
//		MpFileMngConnect.File.Refresh := FALSE;
//	ELSE
//		MpFileMngConnect.File.Refresh := TRUE;
//	END_IF
	
	FOR i := StartValue TO StopValue BY Step DO
		IF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_NONE THEN	
			ElementType[i] := '';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_FOLDER THEN	
			ElementType[i] := 'Folder';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_FILE THEN	
			ElementType[i] := 'File';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_TXT THEN	
			ElementType[i] := 'txt';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_HTML THEN	
			ElementType[i] := 'html';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_DOC THEN	
			ElementType[i] := 'doc';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_XLS THEN	
			ElementType[i] := 'xls';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_XML THEN	
			ElementType[i] := 'xml';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_CSV THEN	
			ElementType[i] := 'csv';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_JPG THEN	
			ElementType[i] := 'jpg';
		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_BMP THEN	
			ElementType[i] := 'bmp';
//		ELSIF MpFileMngConnect.File.List.Items[i].ItemType = mpFILE_ITEM_TYPE_USER1 THEN	
//			ElementType[i] := 'pdf';
		END_IF
		
		IF MpFileMngConnect.File.List.Items[i].IsSelected AND MpFileMngConnect.File.List.Items[i].IsFolder AND NOT MpFileMngConnect.File.MultiSelect AND MpFileMngConnect.File.Delete THEN
			Folder := TRUE;
			File := FALSE;
			Items := FALSE;
		ELSIF MpFileMngConnect.File.List.Items[i].IsSelected AND NOT MpFileMngConnect.File.List.Items[i].IsFolder AND NOT MpFileMngConnect.File.MultiSelect AND MpFileMngConnect.File.Delete THEN
			Folder := FALSE;
			File := TRUE;
			Items := FALSE;
		ELSIF MpFileMngConnect.File.List.Items[i].IsSelected AND MpFileMngConnect.File.MultiSelect AND MpFileMngConnect.File.Delete THEN
			Folder := FALSE;
			File := FALSE;
			Items := TRUE;
		END_IF
		
//		IF MpFileMngConnect.MessageBox.Confirm THEN
//			Folder := FALSE;
//			File := FALSE;
//			Items := FALSE;
//		ELSIF MpFileMngConnect.MessageBox.Cancel THEN
//			Folder := FALSE;
//			File := FALSE;
//			Items := FALSE;
//		END_IF
	END_FOR	
	
	MpFileManagerUI_0();
	 
END_PROGRAM


PROGRAM _EXIT
	
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	 
END_PROGRAM

