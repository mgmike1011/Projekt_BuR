
TYPE
    MpOeeErrorEnum : 
        ( (* Error numbers of library MpOee *)
        mpOEE_NO_ERROR := 0, (* No error *)
        mpOEE_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpOEE_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpOEE_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpOEE_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpOEE_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpOEE_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpOEE_ERR_PAR_NULL := -1064239097, (* Parameters structure is a null pointer [Error: 7, 0xc0910007] *)
        mpOEE_ERR_CONFIG_NULL := -1064239096, (* Configuration structure is null pointer [Error: 8, 0xc0910008] *)
        mpOEE_ERR_CONFIG_NO_PV := -1064239095, (* Configuration pointer not PV [Error: 9, 0xc0910009] *)
        mpOEE_ERR_CONFIG_LOAD := -1064239094, (* Error loading configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 10, 0xc091000a] *)
        mpOEE_WRN_CONFIG_LOAD := -2137980917, (* Warning loading configuration [Warning: 11, 0x8091000b] *)
        mpOEE_ERR_CONFIG_SAVE := -1064239092, (* Error saving configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 12, 0xc091000c] *)
        mpOEE_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpOEE_ERR_BUFFER_CREATE := -1064161792, (* Could not allocate memory (ErrorCause: {1:ErrorNumber}) [Error: 11776, 0xc0922e00] *)
        mpOEE_ERR_WRITE_EXPORT_FILE := -1064161791, (* Error writing export-file {2:FileName} at {3:DeviceName} (ErrorCause: {1:ErrorNumber}) [Error: 11777, 0xc0922e01] *)
        mpOEE_ERR_READ_BUFFER_ENTRIES := -1064161790, (* Error reading event entries from {2:BufferName} (ErrorCause: {1:ErrorNumber}) [Error: 11778, 0xc0922e02] *)
        mpOEE_ERR_INVALID_FILE_DEV := -1064161789, (* Invalid file-device [Error: 11779, 0xc0922e03] *)
        mpOEE_ERR_MISSING_UICONNECT := -1064161788, (* Missing value on UIConnect [Error: 11780, 0xc0922e04] *)
        mpOEE_INF_WAIT_CORE_FB := 1083321861, (* Core is not active [Informational: 11781, 0x40922e05] *)
        mpOEE_ERR_EVENT_RECORDER := -1064161786, (* Event not recorded (ErrorCause: {1:ErrorNumber}) [Error: 11782, 0xc0922e06] *)
        mpOEE_ERR_INVALID_SHIFT := -1064161785, (* Invalid shift {2:ShiftName} in configuration: {3:Cause} [Error: 11783, 0xc0922e07] *)
        mpOEE_ERR_BUFFER_RESET := -1064161784 (* Could not reset buffer {2:BufferName} (ErrorCause: {1:ErrorNumber}) [Error: 11784, 0xc0922e08] *)
        );
END_TYPE
