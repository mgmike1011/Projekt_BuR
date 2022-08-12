
TYPE
    MpOeeCoreAlarmEnum : 
        ( (* Alarms of MpOee Core *)
        mpOEE_ALM_EXPORT_STATS_FAILED := 0, (* Export shift statistics failed. *)
        mpOEE_ALM_EXPORT_TIMELINE_FAILED := 1, (* Export timeline failed. *)
        mpOEE_ALM_UNSCHEDULED_DOWNTIME := 2 (* Machine is in an unscheduled downtime phase *)
    );
END_TYPE
