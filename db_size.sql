select filetype,sum(bytes) / 1048576 mb
from (select 'DATA_FILES' filetype,bytes
from dba_data_files
union
select 'TEMP_FILES',bytes
from dba_temp_files
union
select 'ONLINE_REDO',bytes * members
from v$log
) group by filetype
order by 1;

select sum(bytes) / 1048576 mb
from (select 'DATA_FILES' filetype,bytes
from dba_data_files
union
select 'TEMP_FILES',bytes
from dba_temp_files
union
select 'ONLINE_REDO',bytes * members
from v$log
);
