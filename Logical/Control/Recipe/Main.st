
PROGRAM _INIT
	(* Insert code here *)
	MpRecipeCsv_0.MpLink := ADR(gRecipeCsv);
	MpRecipeCsv_0.Enable := TRUE;
	MpRecipeRegPar_0.MpLink := ADR(gRecipeCsv);
	MpRecipeRegPar_0.Enable := TRUE;
	MpRecipeUI_0.MpLink := ADR(gRecipeCsv);
	MpRecipeUI_0.Enable := TRUE;
	ParametersMachine.Temp1 := 30;
	ParametersMachine.Temp2 := 35;
	ParametersMachine.Temp3 := 33;
	ParametersMachine.Temp4 := 32;
	ParametersMachine.Time1 := T#5s;
	ParametersMachine.Time2 := T#6s;
	ParametersMachine.Time3 := T#3s;
	ParametersMachine.Time4 := T#1s;
	ParametersMachine.Time5 := T#2s;
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpRecipeCsv_0.DeviceName := ADR('RECIPE');
	MpRecipeCsv_0.FileName := ADR('MyFile');
	MpRecipeRegPar_0.PVName := ADR('ParametersMachine');
	MpRecipeUI_0.UIConnect := ADR(RecipeUIConnect);
	MpRecipeUI_0.UISetup := RecipeUISetup;
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

