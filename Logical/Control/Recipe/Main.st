
PROGRAM _INIT
	(* Insert code here *)
	MpRecipeCsv_0.MpLink := ADR(gRecipeCsv);
	MpRecipeCsv_0.Enable := TRUE;
	MpRecipeRegPar_0.MpLink := ADR(gRecipeCsv);
	MpRecipeRegPar_0.Enable := TRUE;
	MpRecipeUI_0.MpLink := ADR(gRecipeCsv);
	MpRecipeUI_0.Enable := TRUE;
	RecipeUISetup.RecipeListSize := 10;
	ParametersMachine.Temp1 := 30;
	ParametersMachine.Temp2 := 30;
	ParametersMachine.Temp3 := 30;
	ParametersMachine.Temp4 := 30;
	ParametersMachine.Time1 := T#5s;
	ParametersMachine.Time2 := T#5s;
	ParametersMachine.Time3 := T#5s;
	ParametersMachine.Time4 := T#5s;
	ParametersMachine.Time5 := T#5s;
	LoadChecked;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpRecipeCsv_0.DeviceName := ADR('RECIPE');
	MpRecipeCsv_0.FileName := ADR('MyFile');
	MpRecipeRegPar_0.PVName := ADR('ParametersMachine');
	MpRecipeUI_0.UIConnect := ADR(RecipeUIConnect);
	MpRecipeUI_0.UISetup := RecipeUISetup;
	//RecipeUISetup.RecipeListSize := RecipeUIConnect.Recipe.List.MaxSelection;
	//set Temp and Time value

	FOR i := 0 TO 9 BY 1 DO
		RecipeListName[i] := RecipeUIConnect.Recipe.List.Names[i];
	END_FOR;
	
	//	IF RecipeUIConnect.New.Create THEN 
	//		RecipeUIConnect.New.FileName := '';
	//	END_IF;
	MpRecipeCsv_0();
	MpRecipeRegPar_0();
	MpRecipeUI_0();
	// naprawic przewijanie i zrobic potwierdzenia delete/save
	IF RecipeUIConnect.Recipe.List.PageUp THEN
		RecipeUIConnect.Recipe.List.SelectedIndex := 0;
		RecipeUIConnect.Recipe.Load := TRUE;
	END_IF;
	
	IF RecipeUIConnect.Recipe.List.PageDown THEN
		RecipeUIConnect.Recipe.List.SelectedIndex := 9;
		RecipeUIConnect.Recipe.Load := TRUE;
	END_IF;
	
	IF LoadChecked THEN
		SetTemp1 := ParametersMachine.Temp1;
		SetTemp2 := ParametersMachine.Temp2;
		SetTemp3 := ParametersMachine.Temp3;
		SetTemp4 := ParametersMachine.Temp4;
		TimeStep1 := ParametersMachine.Time1;
		TimeStep2 := ParametersMachine.Time2;
		TimeStep3 := ParametersMachine.Time3;
		TimeStep4 := ParametersMachine.Time4;
		TimeStep5 := ParametersMachine.Time5;
		LoadChecked := FALSE;
	END_IF;
	
	IF RenameChecked THEN
		RecipeUIConnect.Recipe.NewFileName := '';
		RenameChecked := FALSE;
	END_IF;
	
	IF SetNameChecked THEN
		RecipeUIConnect.New.FileName := '';
		SetNameChecked := FALSE;
	END_IF;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpRecipeCsv_0.Enable := FALSE;
	MpRecipeCsv_0();
	MpRecipeRegPar_0.Enable := FALSE;
	MpRecipeRegPar_0();
	MpRecipeUI_0.Enable := FALSE;
	MpRecipeUI_0();
END_PROGRAM

