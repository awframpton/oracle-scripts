--grab the max scn, you can use to restore to for a full backup
col fuzz# format 99999999999999999999999999
col chkpnt# format 99999999999999999999999999

select max(absolute_fuzzy_change#) fuzz#, max(checkpoint_change#) chkpnt#
from (
select file#, completion_time, checkpoint_change#, absolute_fuzzy_change# from v$backup_datafile
where incremental_level = 0
and trunc(completion_time) = to_date('18-APR-2015','DD-MON-YYYY')
);

--performance queries
select avg(EFFECTIVE_BYTES_PER_SECOND) / 1048576 effective_mbs,avg(DISCRETE_BYTES_PER_SECOND) / 1048576 discrete_mbs
from v$backup_sync_io
where device_type = 'SBT_TAPE';

select avg(EFFECTIVE_BYTES_PER_SECOND) / 1048576 effective_mbs
from v$backup_async_io
where device_type = 'SBT_TAPE';
