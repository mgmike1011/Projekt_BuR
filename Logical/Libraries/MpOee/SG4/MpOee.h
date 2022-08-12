/* Automation Studio generated header file */
/* Do not edit ! */
/* MpOee 5.18.0 */

#ifndef _MPOEE_
#define _MPOEE_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpOee_VERSION
#define _MpOee_VERSION 5.18.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "MpBase.h"
		#include "sys_lib.h"
#endif

#ifdef _SG4
		#include "MpBase.h"
		#include "sys_lib.h"
#endif

#ifdef _SGC
		#include "MpBase.h"
		#include "sys_lib.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpOeeCoreAlarmEnum
{	mpOEE_ALM_EXPORT_STATS_FAILED = 0,
	mpOEE_ALM_EXPORT_TIMELINE_FAILED = 1,
	mpOEE_ALM_UNSCHEDULED_DOWNTIME = 2
} MpOeeCoreAlarmEnum;

typedef enum MpOeeErrorEnum
{	mpOEE_NO_ERROR = 0,
	mpOEE_ERR_ACTIVATION = -1064239103,
	mpOEE_ERR_MPLINK_NULL = -1064239102,
	mpOEE_ERR_MPLINK_INVALID = -1064239101,
	mpOEE_ERR_MPLINK_CHANGED = -1064239100,
	mpOEE_ERR_MPLINK_CORRUPT = -1064239099,
	mpOEE_ERR_MPLINK_IN_USE = -1064239098,
	mpOEE_ERR_PAR_NULL = -1064239097,
	mpOEE_ERR_CONFIG_NULL = -1064239096,
	mpOEE_ERR_CONFIG_NO_PV = -1064239095,
	mpOEE_ERR_CONFIG_LOAD = -1064239094,
	mpOEE_WRN_CONFIG_LOAD = -2137980917,
	mpOEE_ERR_CONFIG_SAVE = -1064239092,
	mpOEE_ERR_CONFIG_INVALID = -1064239091,
	mpOEE_ERR_BUFFER_CREATE = -1064161792,
	mpOEE_ERR_WRITE_EXPORT_FILE = -1064161791,
	mpOEE_ERR_READ_BUFFER_ENTRIES = -1064161790,
	mpOEE_ERR_INVALID_FILE_DEV = -1064161789,
	mpOEE_ERR_MISSING_UICONNECT = -1064161788,
	mpOEE_INF_WAIT_CORE_FB = 1083321861,
	mpOEE_ERR_EVENT_RECORDER = -1064161786,
	mpOEE_ERR_INVALID_SHIFT = -1064161785,
	mpOEE_ERR_BUFFER_RESET = -1064161784
} MpOeeErrorEnum;

typedef enum MpOeeUIStatusEnum
{	mpOEE_UI_STATUS_IDLE = 0,
	mpOEE_UI_STATUS_UPDATE = 1,
	mpOEE_UI_STATUS_FILTER = 2
} MpOeeUIStatusEnum;

typedef enum MpOeeMemoryEnum
{	mpOEE_MEM_TEMP = 0,
	mpOEE_MEM_ROM = 1,
	mpOEE_MEM_SRAM = 2
} MpOeeMemoryEnum;

typedef enum MpOeeUIProductionStateEnum
{	mpOEE_STATE_NO_SHIFT_ACTIVE = 0,
	mpOEE_STATE_UPTIME = 1,
	mpOEE_STATE_SCHDL_DOWNTIME = 2,
	mpOEE_STATE_UNSCHDL_DOWNTIME = 3
} MpOeeUIProductionStateEnum;

typedef struct MpOeeTimeSlotType
{	plctod Start;
	plctod End;
} MpOeeTimeSlotType;

typedef struct MpOeeScheduledDowntimeType
{	plcstring Reason[51];
	plctod Start;
	plctod End;
} MpOeeScheduledDowntimeType;

typedef struct MpOeeShiftParType
{	plcstring Name[21];
	struct MpOeeTimeSlotType TotalTime;
	struct MpOeeScheduledDowntimeType ScheduledDowntime[10];
} MpOeeShiftParType;

typedef struct MpOeeExportType
{	plcbit ShiftStatistics;
	plcstring ShiftStatisticsFileNamePattern[51];
	plcbit Timeline;
	plcstring TimelineFileNamePattern[51];
	plcstring TimeStampPattern[51];
	unsigned short DecimalDigits;
	plcstring ColumnSeparator[2];
	plcstring DecimalMark[2];
} MpOeeExportType;

typedef struct MpOeeCoreConfigType
{	unsigned long RecordingSizeShiftStatistics;
	unsigned long RecordingSizeTimeline;
	enum MpOeeMemoryEnum RecordMemory;
	float SaveInterval;
	struct MpOeeShiftParType Shifts[5];
	struct MpOeeExportType Export;
} MpOeeCoreConfigType;

typedef struct MpOeeCoreParType
{	plctime IdealCycleTime;
} MpOeeCoreParType;

typedef struct MpOeeTimeType
{	unsigned long Hours;
	unsigned char Minutes;
	unsigned char Seconds;
} MpOeeTimeType;

typedef struct MpOeeCoreShiftStatisticsType
{	plcstring ShiftName[21];
	struct MpOeeTimeType TotalTime;
	struct MpOeeTimeType ScheduledDowntime;
	struct MpOeeTimeType UnscheduledDowntime;
	struct MpOeeTimeType Uptime;
	unsigned long TargetPieces;
	unsigned long TotalPieces;
	unsigned long GoodPieces;
	unsigned long RejectPieces;
	plctime AverageCycleTime;
} MpOeeCoreShiftStatisticsType;

typedef struct MpOeeCoreUIConnectType
{	float Availability;
	float Performance;
	float Quality;
	float OEE;
	struct MpOeeCoreShiftStatisticsType ShiftStatistics;
} MpOeeCoreUIConnectType;

typedef struct MpOeeUITrendType
{	float SampleData[366];
	unsigned long SampleRate;
	unsigned long SampleCount;
	plcdt SampleDateTime;
	float MinValue;
	float MaxValue;
	signed short HideCurve;
	float TimeZoom;
	float TimeScroll;
} MpOeeUITrendType;

typedef struct MpOeeUIShiftListType
{	plcstring ShiftNames[6][21];
	unsigned short SelectedIndex;
	unsigned char MaxSelection;
} MpOeeUIShiftListType;

typedef struct MpOeeUISetDTFilterType
{	plcbit Enable;
	unsigned short Year;
	unsigned char Month;
	unsigned char Day;
	unsigned char Hour;
	unsigned char Minute;
} MpOeeUISetDTFilterType;

typedef struct MpOeeUIFilterDialogType
{	unsigned short LayerStatus;
	struct MpOeeUISetDTFilterType From;
	struct MpOeeUISetDTFilterType Until;
	plcbit Confirm;
	plcbit Cancel;
} MpOeeUIFilterDialogType;

typedef struct MpOeeUICurrDTFilterType
{	plcbit Enable;
	plcdt DateTime;
} MpOeeUICurrDTFilterType;

typedef struct MpOeeUICurrentFilterType
{	struct MpOeeUICurrDTFilterType From;
	struct MpOeeUICurrDTFilterType Until;
} MpOeeUICurrentFilterType;

typedef struct MpOeeUIFilterType
{	plcbit ShowDialog;
	struct MpOeeUIFilterDialogType Dialog;
	struct MpOeeUICurrentFilterType Current;
	unsigned short DefaultLayerStatus;
} MpOeeUIFilterType;

typedef struct MpOeeTrendUIConnectType
{	enum MpOeeUIStatusEnum Status;
	struct MpOeeUITrendType OEE;
	struct MpOeeUITrendType Availability;
	struct MpOeeUITrendType Performance;
	struct MpOeeUITrendType Quality;
	struct MpOeeUIShiftListType ShiftList;
	struct MpOeeUIFilterType Filter;
} MpOeeTrendUIConnectType;

typedef struct MpOeeUITimeBargraphType
{	unsigned long Duration;
	unsigned long Color;
} MpOeeUITimeBargraphType;

typedef struct MpOeeUITimelineLineType
{	plcdt StartTime;
	plcstring ShiftName[21];
	enum MpOeeUIProductionStateEnum ProductionState;
	plcstring Reason[51];
	struct MpOeeTimeType Duration;
	struct MpOeeUITimeBargraphType DurationBar;
} MpOeeUITimelineLineType;

typedef struct MpOeeUITimelineOutputType
{	struct MpOeeUITimelineLineType Display[20];
	float RangeStart;
	float RangeEnd;
	plcbit PageUp;
	plcbit StepUp;
	plcbit StepDown;
	plcbit PageDown;
} MpOeeUITimelineOutputType;

typedef struct MpOeeTimelineUISetupType
{	unsigned short TimelineListSize;
	unsigned char ScrollWindow;
} MpOeeTimelineUISetupType;

typedef struct MpOeeTimelineUIConnectType
{	enum MpOeeUIStatusEnum Status;
	struct MpOeeUITimelineOutputType Output;
	struct MpOeeUIFilterType Filter;
} MpOeeTimelineUIConnectType;

typedef struct MpOeeUIListOutputType
{	plcdt StartTime[20];
	plcdt EndTime[20];
	plcstring ShiftName[20][21];
	float Availability[20];
	float Performance[20];
	float Quality[20];
	float OEE[20];
	unsigned long TargetPieces[20];
	unsigned long TotalPieces[20];
	unsigned long GoodPieces[20];
	unsigned long RejectPieces[20];
	plctime IdleCycleTime[20];
	plctime AverageCycleTime[20];
	struct MpOeeTimeType TotalTime[20];
	struct MpOeeTimeType SchedDowntime[20];
	struct MpOeeTimeType UnschedDowntime[20];
	struct MpOeeTimeType Uptime[20];
	float RangeStart;
	float RangeEnd;
	plcbit PageUp;
	plcbit StepUp;
	plcbit StepDown;
	plcbit PageDown;
} MpOeeUIListOutputType;

typedef struct MpOeeListUIConnectType
{	enum MpOeeUIStatusEnum Status;
	struct MpOeeUIListOutputType Output;
	struct MpOeeUIFilterType Filter;
} MpOeeListUIConnectType;

typedef struct MpOeeListUISetupType
{	unsigned short OutputListSize;
	unsigned char ScrollWindow;
} MpOeeListUISetupType;

typedef struct MpOeeStatusIDType
{	enum MpOeeErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpOeeStatusIDType;

typedef struct MpOeeDiagType
{	struct MpOeeStatusIDType StatusID;
} MpOeeDiagType;

typedef struct MpOeeCoreInfoType
{	struct MpOeeCoreShiftStatisticsType ShiftStatistics;
	struct MpOeeDiagType Diag;
} MpOeeCoreInfoType;

typedef struct MpOeeInfoType
{	struct MpOeeDiagType Diag;
} MpOeeInfoType;

typedef struct MpOeeCore
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpOeeCoreParType* Parameters;
	plcstring (*DowntimeReason);
	unsigned long PieceCounter;
	unsigned long RejectCounter;
	plcstring (*DeviceName);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Availability;
	float Performance;
	float Quality;
	float OEE;
	struct MpOeeCoreInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Downtime;
	plcbit Export;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandDone;
	plcbit ExportDone;
} MpOeeCore_typ;

typedef struct MpOeeCoreConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpOeeCoreConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpOeeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpOeeCoreConfig_typ;

typedef struct MpOeeCoreUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpOeeCoreUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpOeeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpOeeCoreUI_typ;

typedef struct MpOeeTimelineUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpOeeTimelineUISetupType UISetup;
	struct MpOeeTimelineUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpOeeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpOeeTimelineUI_typ;

typedef struct MpOeeTrendUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpOeeTrendUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpOeeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpOeeTrendUI_typ;

typedef struct MpOeeListUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpOeeListUISetupType UISetup;
	struct MpOeeListUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpOeeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpOeeListUI_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpOeeCore(struct MpOeeCore* inst);
_BUR_PUBLIC void MpOeeCoreConfig(struct MpOeeCoreConfig* inst);
_BUR_PUBLIC void MpOeeCoreUI(struct MpOeeCoreUI* inst);
_BUR_PUBLIC void MpOeeTimelineUI(struct MpOeeTimelineUI* inst);
_BUR_PUBLIC void MpOeeTrendUI(struct MpOeeTrendUI* inst);
_BUR_PUBLIC void MpOeeListUI(struct MpOeeListUI* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPOEE_ */

