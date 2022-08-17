
PROGRAM _INIT
	(* Insert code here *)
	MpRecipeCsv_0.MpLink := ADR(gRecipeCsv);
	MpRecipeCsv_0.Enable := TRUE;
	MpRecipeRegPar_0.MpLink := ADR(gRecipeCsv);
	MpRecipeRegPar_0.Enable := TRUE;
	MpRecipeUI_0.MpLink := ADR(gRecipeCsv);
	MpRecipeUI_0.Enable := TRUE;
	RecipeUISetup.RecipeListSize := 8;
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
	IF RecipeUIConnect.Recipe.Load THEN
		SetTemp1 := ParametersMachine.Temp1;
		SetTemp2 := ParametersMachine.Temp2;
		SetTemp3 := ParametersMachine.Temp3;
		SetTemp4 := ParametersMachine.Temp4;
		TimeStep1 := ParametersMachine.Time1;
		TimeStep2 := ParametersMachine.Time2;
		TimeStep3 := ParametersMachine.Time3;
		TimeStep4 := ParametersMachine.Time4;
		TimeStep5 := ParametersMachine.Time5;
	END_IF;
	
	MpRecipeCsv_0();
	MpRecipeRegPar_0();
	MpRecipeUI_0();
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

