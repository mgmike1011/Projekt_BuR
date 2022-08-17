
(* Recursive JSON parser *)
FUNCTION JSON_PARSER_fun
	brsmemset(ADR(Output_string),0,brsstrlen(ADR(Output_string)));
	brsmemset(ADR(String_bufer),0,brsstrlen(ADR(String_bufer)));
	brsmemset(ADR(Member_value_as_string),0,brsstrlen(ADR(Member_value_as_string)));
	Output_string := '{';
	PV_ninfo(ADR(PV),ADR(Struct_type),ADR(Struct_Len),ADR(Struct_dimension));
	PV_xgetadr(ADR(PV),ADR(Struct_address),ADR(Struct_Len));
	Member_adres :=	Struct_address;
	FOR	Iterator :=0 TO	Struct_dimension-1BY 1 DO
		Member_value_as_string :='';
		PV_acces_string	:= PV;
		String_bufer :='.';
		brsstrcat(ADR(PV_acces_string),ADR(String_bufer));
		PV_item(ADR(PV),Iterator,ADR(Member_name));
		brsstrcat(ADR(PV_acces_string),ADR(Member_name));
		PV_ninfo(ADR(PV_acces_string),ADR(member_type),ADR(member_len),ADR(Member_dim));
		PV_xgetadr(ADR(PV_acces_string),ADR(Member_adres),ADR(member_len));
		CASE member_type OF
			0: //struct	TO_DO
				RETURN;
			1: // BOOL
				Bool_buffer	ACCESS (Member_adres);
				IF Bool_buffer =1 THEN
					Member_value_as_string := 'true';
				ELSIF Bool_buffer =0 THEN 
					Member_value_as_string:= 'false';
				END_IF
			2: //SINT
				Byte_buffer	ACCESS (Member_adres);
				Member_value_as_string:= SINT_TO_STRING(BYTE_TO_SINT(Byte_buffer));
			3: //INT
				Word_buffer	ACCESS (Member_adres);
				Member_value_as_string:= INT_TO_STRING(WORD_TO_INT(Word_buffer));
			4: //DINT
				Dword_buffer ACCESS (Member_adres);
				Member_value_as_string:= DINT_TO_STRING(DWORD_TO_DINT(Dword_buffer));
			5: //USINT
				Byte_buffer	ACCESS (Member_adres);
				Member_value_as_string:= USINT_TO_STRING(BYTE_TO_USINT(Byte_buffer));
			6: //UINT
				Word_buffer	ACCESS (Member_adres);
				Member_value_as_string:= UINT_TO_STRING(WORD_TO_UINT(Word_buffer));
			7: //UDINT
				Dword_buffer ACCESS (Member_adres);
				Member_value_as_string:= UDINT_TO_STRING(DWORD_TO_UDINT(Dword_buffer));
			8: //REAL
				Real_buffer ACCESS (Member_adres);
				Real_buffer1 := Real_buffer;
				Member_value_as_string:= REAL_TO_STRING(Real_buffer1);
			9: //STRING
				brsmemcpy(ADR(String_bufer),Member_adres,member_len);
				Member_value_as_string := '"';
				String_bufer := String_bufer;
				brsstrcat(ADR(Member_value_as_string),ADR(String_bufer));
				String_bufer:= '"';
				brsstrcat(ADR(Member_value_as_string),ADR(String_bufer));
			
		END_CASE
		String_bufer :='"';
		brsstrcat(ADR(Output_string),ADR(String_bufer));
		brsstrcat(ADR(Output_string),ADR(Member_name));
		String_bufer :='": ';
		brsstrcat(ADR(Output_string),ADR(String_bufer));
		brsstrcat(ADR(Output_string),ADR(Member_value_as_string));
		IF NOT (Iterator = Struct_dimension-1) THEN
			String_bufer :=',';
			brsstrcat(ADR(Output_string),ADR(String_bufer));
		END_IF
	END_FOR
	String_bufer :=	'}';
	brsstrcat(ADR(Output_string),ADR(String_bufer));
	brsmemcpy(Target_string_adress,ADR(Output_string),brsstrlen(ADR(Output_string)));
	JSON_PARSER_fun :=TRUE;
END_FUNCTION
