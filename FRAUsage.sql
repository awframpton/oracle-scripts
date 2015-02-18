select space_limit / 1073741824 space_limit,
       space_used / 1073741824 space_used,
       (space_reclaimable+(space_limit*(flogs/100))) / 1073741824 space_reclaimable,
       number_of_files,
       (((space_used - space_reclaimable) / space_limit)*100)-flogs pctused,
       flogs
from v$recovery_file_dest a,(select percent_space_used flogs from v$recovery_area_usage where file_type = 'FLASHBACK LOG') b;