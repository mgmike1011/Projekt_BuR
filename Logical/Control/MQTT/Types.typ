
TYPE
	Test_struct : 	STRUCT 
		New_Member9 : BOOL := 1;
		New_Member8 : SINT := -2;
		New_Member7 : INT := -3;
		New_Member6 : DINT := -4;
		New_Member5 : USINT := 5;
		New_Member4 : UINT := 6;
		New_Member3 : UDINT := 7;
		New_Member2 : REAL := -8.5;
		New_Member : STRING[80] := 'loooooong test';
	END_STRUCT;
	Fans_struct : 	STRUCT 
		Fan1 : REAL := 0.0;
		Fan2 : REAL := 0.0;
		Fan3 : REAL := 0.0;
		Fan4 : REAL := 0.0;
	END_STRUCT;
	SetPoints : 	STRUCT 
		SetPoint1 : REAL;
		SetPoint2 : REAL;
		SetPoint3 : REAL;
		SetPoint4 : REAL;
	END_STRUCT;
	Temperatures : 	STRUCT 
		Temp1 : REAL;
		Temp2 : REAL;
		Temp3 : REAL;
		Temp4 : REAL;
	END_STRUCT;
	Zone_status : 	STRUCT 
		Zone1 : DINT;
		Zone2 : DINT;
		Zone3 : DINT;
		Zone4 : DINT;
	END_STRUCT;
END_TYPE
