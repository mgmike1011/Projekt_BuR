
(* Parses Struct of	base types to JSON string *)
FUNCTION_BLOCK JSON_PARSER
	Current_offset :=0;
	JSON_String := '{';
	PV_ninfo(ADR(PV),ADR(Struct_type),ADR(Struct_Len),ADR(Struct_dimension));
	PV_xgetadr(ADR(PV),ADR(Struct_address),ADR(Struct_Len));
	Member_adres :=	Struct_address;
	FOR	Iterator :=0 TO	Struct_dimension-1BY 1 DO
		PV_acces_string	:= PV;
		String_bufer :='.';
		brsstrcat(ADR(PV_acces_string),ADR(String_bufer));
		PV_item(ADR(PV),Iterator,ADR(Member_name));
		brsstrcat(ADR(PV_acces_string),ADR(Member_name));
		PV_ninfo(ADR(PV_acces_string),ADR(member_type),ADR(member_len),ADR(Member_dim));
		CASE member_type OF
			0: //struct	TO_DO
				RETURN;
			1: // BOOL
				//Member_adres := brsmemcpy(ADR(Bool_buffer),Member_adres,member_len*8);
				Byte_buffer	ACCESS (Struct_address +Current_offset);
				IF Bool_buffer =1 THEN
					Member_value_as_string := 'TRUE';
				ELSIF Bool_buffer =0 THEN 
					Member_value_as_string:= 'FALSE';
				END_IF
			2: //SINT
				//Member_adres := brsmemcpy(ADR(Byte_buffer),Member_adres,member_len*8);
				Byte_buffer	ACCESS (Struct_address +Current_offset);
				Member_value_as_string:= SINT_TO_STRING(BYTE_TO_SINT(Byte_buffer));
			3: //INT
				//Member_adres := brsmemcpy(ADR(Word_buffer),Member_adres,member_len*8);
				Word_buffer	ACCESS (Struct_address +Current_offset);
				Member_value_as_string:= INT_TO_STRING(WORD_TO_INT(Word_buffer));
			4: //DINT
				//Member_adres := brsmemcpy(ADR(Dword_buffer),Member_adres,member_len*8);
				Dword_buffer ACCESS	(Struct_address	+Current_offset);
				Member_value_as_string:= DINT_TO_STRING(DWORD_TO_DINT(Dword_buffer));
			5: //USINT
				//Member_adres := brsmemcpy(ADR(Byte_buffer),Member_adres,member_len*8);
				Byte_buffer	ACCESS (Struct_address +Current_offset);
				Member_value_as_string:= USINT_TO_STRING(BYTE_TO_USINT(Byte_buffer));
			6: //UINT
				//Member_adres := brsmemcpy(ADR(Word_buffer),Member_adres,member_len*8);
				Word_buffer	ACCESS (Struct_address +Current_offset);
				Member_value_as_string:= UINT_TO_STRING(WORD_TO_UINT(Word_buffer));
			7: //UDINT
				//Member_adres := brsmemcpy(ADR(Dword_buffer),Member_adres,member_len*8);
				Dword_buffer ACCESS	(Struct_address	+Current_offset);
				Member_value_as_string:= UDINT_TO_STRING(DWORD_TO_UDINT(Dword_buffer));
			8: //REAL
				//Member_adres := brsmemcpy(ADR(Dword_buffer),Member_adres,member_len*8);
				Dword_buffer ACCESS	(Struct_address	+Current_offset);
				Member_value_as_string:= REAL_TO_STRING(DWORD_TO_REAL(Dword_buffer));
			9: //STRING
				brsmemcpy(ADR(String_bufer),Struct_address + Current_offset,member_len);
				Member_value_as_string := String_bufer;
		END_CASE
		Current_offset := Current_offset + member_len;
		
		String_bufer :='"';
		brsstrcat(ADR(JSON_String),ADR(String_bufer));
		brsstrcat(ADR(JSON_String),ADR(Member_name));
		String_bufer :='": ';
		brsstrcat(ADR(JSON_String),ADR(String_bufer));
		
		brsstrcat(ADR(JSON_String),ADR(Member_value_as_string));
		String_bufer :=',';
		brsstrcat(ADR(JSON_String),ADR(String_bufer));
	END_FOR
	String_bufer :=	'}';
	brsstrcat(ADR(JSON_String),ADR(String_bufer));
	
	Output_string :=JSON_String;
END_FUNCTION_BLOCK
