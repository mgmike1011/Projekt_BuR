(*Enum type*)

TYPE
	MpOeeUIStatusEnum : 
		(
		mpOEE_UI_STATUS_IDLE := 0, (*Status: Idle, Waiting for command*)
		mpOEE_UI_STATUS_UPDATE := 1, (*Status: Updating UIConnect structer*)
		mpOEE_UI_STATUS_FILTER := 2 (*Status: Showing filter-dialog*)
		);
	MpOeeMemoryEnum : 
		(
		mpOEE_MEM_TEMP := 0, (*Memory location: DRAM (temporary)*)
		mpOEE_MEM_ROM := 1, (*Memory location: USER ROM (memory card)*)
		mpOEE_MEM_SRAM := 2 (*Memory location: SRAM (battery-backed)*)
		);
END_TYPE

(*Config type*)

TYPE
	MpOeeCoreConfigType : 	STRUCT 
		RecordingSizeShiftStatistics : UDINT := 20; (*Size of the shiftstatistics-Buffer [kBytes]. *)
		RecordingSizeTimeline : UDINT := 20; (*Size of the timeline-Buffer [kBytes]. *)
		RecordMemory : MpOeeMemoryEnum := mpOEE_MEM_SRAM; (*Memory where logging is stored while active. This value is only read when the component is initialized (Disabled -> Enabled).*)
		SaveInterval : REAL := 60.0; (*Defines how often buffer is saved for data protection*)
		Shifts : ARRAY[0..4]OF MpOeeShiftParType := [(Name:='Morning',TotalTime:=(Start:=TOD#06:00:00,End:=TOD#14:00:00),ScheduledDowntime:=[(Start:=TOD#11:00:00,End:=TOD#11:30:00),9(0)]),(Name:='Noon',TotalTime:=(Start:=TOD#14:00:00,End:=TOD#22:00:00),ScheduledDowntime:=[(Start:=TOD#18:00:00,End:=TOD#18:30:00),9((0))]),0,2((0))]; (*Shift schedule in detailed*)
		Export : MpOeeExportType; (*Configuration for export*)
	END_STRUCT;
	MpOeeExportType : 	STRUCT 
		ShiftStatistics : BOOL := TRUE; (*Export the shift statistics or not.*)
		ShiftStatisticsFileNamePattern : STRING[50] := 'ShiftStatistics_%Y_%m_%d_%H_%M.csv'; (*Pattern for export shift statistics file.*)
		Timeline : BOOL := TRUE; (*Export the timeline statistics or not.*)
		TimelineFileNamePattern : STRING[50] := 'Timeline_%Y_%m_%d_%H_%M.csv'; (*Pattern for export timeline  file.*)
		TimeStampPattern : STRING[50] := '%Y-%m-%d %H:%M:%S'; (*Time stamp pattern in exported file.*)
		DecimalDigits : UINT := 2; (*Specifies how many decimal positions are saved*)
		ColumnSeparator : STRING[1] := ','; (*Delimiter used to split up PVs in the .csv file*)
		DecimalMark : STRING[1] := '.'; (*Character to be used for the decimal separator*)
	END_STRUCT;
	MpOeeShiftParType : 	STRUCT 
		Name : STRING[20]; (*Shift name*)
		TotalTime : MpOeeTimeSlotType; (*Total time of one shift*)
		ScheduledDowntime : ARRAY[0..9]OF MpOeeScheduledDowntimeType; (*Scheduled downtime in one shift*)
	END_STRUCT;
	MpOeeTimeSlotType : 	STRUCT 
		Start : TIME_OF_DAY; (*Start time.*)
		End : TIME_OF_DAY; (*End time*)
	END_STRUCT;
	MpOeeScheduledDowntimeType : 	STRUCT 
		Reason : STRING[50]; (*Downtime reason*)
		Start : TIME_OF_DAY; (*Start time.*)
		End : TIME_OF_DAY; (*End time*)
	END_STRUCT;
END_TYPE

(*Parameter type*)

TYPE
	MpOeeCoreParType : 	STRUCT 
		IdealCycleTime : TIME := T#1s; (*Ideal cycle time for one piece*)
	END_STRUCT;
END_TYPE

(*UI type*)

TYPE
	MpOeeCoreUIConnectType : 	STRUCT 
		Availability : REAL; (*Avaliablity(0-1)*)
		Performance : REAL; (*Performance(0-1)*)
		Quality : REAL; (*Quality(0-1)*)
		OEE : REAL; (*Oee result(0-1)*)
		ShiftStatistics : MpOeeCoreShiftStatisticsType; (*Shift statistics*)
	END_STRUCT;
	MpOeeUITrendType : 	STRUCT 
		SampleData : ARRAY[0..365]OF REAL; (*FB->VC:Sample data for trend data*)
		SampleRate : UDINT; (*FB->VC:Sample rate datapoint for trend data*)
		SampleCount : UDINT; (*FB->VC:Sample count datapoint for trend data*)
		SampleDateTime : DATE_AND_TIME; (*FB->VC:Sample DataTime datapoint for trend data*)
		MinValue : REAL; (*FB->VC:Min.value datapoint for trend data*)
		MaxValue : REAL; (*FB->VC:Max.value datapoint for trend data*)
		HideCurve : INT; (*FB->VC:Hide the curve if set to 1, status datapoint for trend curve*)
		TimeZoom : REAL; (*FB->VC:Zoom datapoint for trend time scale.*)
		TimeScroll : REAL; (*FB->VC:Scoll datapoint for trend time scale.*)
	END_STRUCT;
	MpOeeUIShiftListType : 	STRUCT 
		ShiftNames : ARRAY[0..5]OF STRING[20]; (*FB->VC: Shift names, *)
		SelectedIndex : UINT; (*VC->FB: Selection index for ShiftList.*)
		MaxSelection : USINT;
	END_STRUCT;
	MpOeeTrendUIConnectType : 	STRUCT 
		Status : MpOeeUIStatusEnum; (*Status of UI function block*)
		OEE : MpOeeUITrendType; (*Trend for OEE*)
		Availability : MpOeeUITrendType; (*Trend for Availability*)
		Performance : MpOeeUITrendType; (*Trend for Performance*)
		Quality : MpOeeUITrendType; (*Trend for Quality*)
		ShiftList : MpOeeUIShiftListType; (*Determin which shift in the day is shown in th trend*)
		Filter : MpOeeUIFilterType; (*Output filter.*)
	END_STRUCT;
	MpOeeUITimelineOutputType : 	STRUCT 
		Display : ARRAY[0..19]OF MpOeeUITimelineLineType; (*States display*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
	END_STRUCT;
	MpOeeUITimelineLineType : 	STRUCT 
		StartTime : DATE_AND_TIME; (*FB->VC:Start time of this state*)
		ShiftName : STRING[20]; (*FB->VC:Shift name*)
		ProductionState : MpOeeUIProductionStateEnum; (*FB->VC:Production state*)
		Reason : STRING[50]; (*FB->VC:Reason of this state*)
		Duration : MpOeeTimeType; (*FB->VC:Duration of this state*)
		DurationBar : MpOeeUITimeBargraphType; (*FB->VC:Duration of this state in a graphic way*)
	END_STRUCT;
	MpOeeUITimeBargraphType : 	STRUCT 
		Duration : UDINT; (*FB->VC:EndValue(lenth) of the scale*)
		Color : UDINT; (*FB->VC:ColorDatapoint of the scale*)
	END_STRUCT;
	MpOeeTimelineUISetupType : 	STRUCT 
		TimelineListSize : UINT := 10; (*Output list size*)
		ScrollWindow : USINT := 0; (*Scroll Window (overlap for PageUp/Down)*)
	END_STRUCT;
	MpOeeTimelineUIConnectType : 	STRUCT 
		Status : MpOeeUIStatusEnum; (*Status of UI function block*)
		Output : MpOeeUITimelineOutputType; (*Output information.*)
		Filter : MpOeeUIFilterType; (*Output filter.*)
	END_STRUCT;
	MpOeeTimeType : 	STRUCT 
		Hours : UDINT; (*Numbers of hours*)
		Minutes : USINT; (*Numbers of minutes within an hour*)
		Seconds : USINT; (*Numbers of seconds within a minute*)
	END_STRUCT;
	MpOeeListUIConnectType : 	STRUCT 
		Status : MpOeeUIStatusEnum; (*Status of UI function block*)
		Output : MpOeeUIListOutputType; (*Output information.*)
		Filter : MpOeeUIFilterType; (*Output filter.*)
	END_STRUCT;
	MpOeeUIListOutputType : 	STRUCT 
		StartTime : ARRAY[0..19]OF DATE_AND_TIME; (*Start time list*)
		EndTime : ARRAY[0..19]OF DATE_AND_TIME; (*End time list*)
		ShiftName : ARRAY[0..19]OF STRING[20]; (*Shift ID list*)
		Availability : ARRAY[0..19]OF REAL; (*Availability list*)
		Performance : ARRAY[0..19]OF REAL; (*Performance list*)
		Quality : ARRAY[0..19]OF REAL; (*Quality list*)
		OEE : ARRAY[0..19]OF REAL; (*OEE list*)
		TargetPieces : ARRAY[0..19]OF UDINT; (*Target pieces list*)
		TotalPieces : ARRAY[0..19]OF UDINT; (*Total pieces list*)
		GoodPieces : ARRAY[0..19]OF UDINT; (*Good pieces list*)
		RejectPieces : ARRAY[0..19]OF UDINT; (*Reject pieces list*)
		IdleCycleTime : ARRAY[0..19]OF TIME; (*Idle cycle time list*)
		AverageCycleTime : ARRAY[0..19]OF TIME; (*Average cycle time list*)
		TotalTime : ARRAY[0..19]OF MpOeeTimeType; (*Total time list*)
		SchedDowntime : ARRAY[0..19]OF MpOeeTimeType; (*Scheduled Downtime list*)
		UnschedDowntime : ARRAY[0..19]OF MpOeeTimeType; (*Unscheduled Downtime list*)
		Uptime : ARRAY[0..19]OF MpOeeTimeType; (*Uptime list*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
	END_STRUCT;
	MpOeeListUISetupType : 	STRUCT 
		OutputListSize : UINT := 10; (*Output list size*)
		ScrollWindow : USINT := 0; (*Scroll Window (overlap for PageUp/Down)*)
	END_STRUCT;
	MpOeeUIProductionStateEnum : 
		(
		mpOEE_STATE_NO_SHIFT_ACTIVE := 0, (*Inactive state*)
		mpOEE_STATE_UPTIME := 1, (*Uptime state*)
		mpOEE_STATE_SCHDL_DOWNTIME := 2, (*Scheduled downtime state*)
		mpOEE_STATE_UNSCHDL_DOWNTIME := 3 (*Unscheduled downtime state*)
		);
	MpOeeUICurrDTFilterType : 	STRUCT 
		Enable : BOOL; (*Enable Filter*)
		DateTime : DATE_AND_TIME; (*Date and time of filter*)
	END_STRUCT;
	MpOeeUISetDTFilterType : 	STRUCT 
		Enable : BOOL; (*Enable Filter*)
		Year : UINT; (*Date&Time: Year*)
		Month : USINT; (*Date&Time: Month*)
		Day : USINT; (*Date&Time: Day*)
		Hour : USINT; (*Date&Time: Hour*)
		Minute : USINT; (*Date&Time: Minute*)
	END_STRUCT;
	MpOeeUIFilterDialogType : 	STRUCT 
		LayerStatus : UINT;
		From : MpOeeUISetDTFilterType; (*Display entries from given date&time*)
		Until : MpOeeUISetDTFilterType; (*Display entries until given date&time*)
		Confirm : BOOL;
		Cancel : BOOL;
	END_STRUCT;
	MpOeeUIFilterType : 	STRUCT 
		ShowDialog : BOOL;
		Dialog : MpOeeUIFilterDialogType; (*Dialog-data to change filter-settings*)
		Current : MpOeeUICurrentFilterType; (*Currently active filter settings*)
		DefaultLayerStatus : UINT;
	END_STRUCT;
	MpOeeUICurrentFilterType : 	STRUCT 
		From : MpOeeUICurrDTFilterType;
		Until : MpOeeUICurrDTFilterType;
	END_STRUCT;
END_TYPE

(*Info type*)

TYPE
	MpOeeCoreShiftStatisticsType : 	STRUCT 
		ShiftName : STRING[20]; (*Shift name.*)
		TotalTime : MpOeeTimeType; (*Total time since this shift started*)
		ScheduledDowntime : MpOeeTimeType; (*Scheduled downtime since this shift started*)
		UnscheduledDowntime : MpOeeTimeType; (*Unsheduled downtime since this shift started*)
		Uptime : MpOeeTimeType; (*Uptime since this shift started*)
		TargetPieces : UDINT; (*Counter for target products since this shift started*)
		TotalPieces : UDINT; (*Counter for total products since this shift started*)
		GoodPieces : UDINT; (*Counter for good products since this shift started*)
		RejectPieces : UDINT; (*Counter for reject products since this shift started*)
		AverageCycleTime : TIME; (*Average cycle time for one piece since this shift started*)
	END_STRUCT;
	MpOeeCoreInfoType : 	STRUCT 
		ShiftStatistics : MpOeeCoreShiftStatisticsType; (*Shift statistics*)
		Diag : MpOeeDiagType; (*Additional diagnostic information*)
	END_STRUCT;
	MpOeeInfoType : 	STRUCT 
		Diag : MpOeeDiagType; (*Additional diagnostic information*)
	END_STRUCT;
	MpOeeDiagType : 	STRUCT 
		StatusID : MpOeeStatusIDType; (*Segmented StatusID output*)
	END_STRUCT;
	MpOeeStatusIDType : 	STRUCT 
		ID : MpOeeErrorEnum; (*StatusID as enumerator*)
		Severity : MpComSeveritiesEnum; (*Severity of the error*)
		Code : UINT; (*Error code*)
	END_STRUCT;
END_TYPE
