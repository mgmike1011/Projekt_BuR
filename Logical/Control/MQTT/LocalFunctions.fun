
{REDUND_ERROR} FUNCTION_BLOCK JSON_PARSER (*Parses Struct of base types to JSON string*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		PV : {REDUND_UNREPLICABLE} STRING[80];
	END_VAR
	VAR
		JSON_String : STRING[256];
	END_VAR
	VAR_OUTPUT
		Output_string : STRING[80];
	END_VAR
	VAR
		String_bufer : STRING[80];
		Dword_buffer : REFERENCE TO DWORD;
		Bool_buffer : REFERENCE TO BOOL;
		Word_buffer : REFERENCE TO WORD;
		Byte_buffer : REFERENCE TO BYTE;
		Struct_Len : UDINT;
		Struct_address : UDINT;
		Current_offset : UDINT;
		member_type : UDINT;
		member_len : UDINT;
		Struct_type : UDINT;
		Struct_dimension : UINT;
		Iterator : UINT;
		Member_name : STRING[80];
		PV_acces_string : STRING[80];
		Member_dim : UINT;
		Member_value_as_string : STRING[80];
		Member_adres : UDINT;
	END_VAR
END_FUNCTION_BLOCK
