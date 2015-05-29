alter session set nls_date_format = 'DD-MON-YY HH24:MI:SS';

--primary
select thread#,sequence#,completion_time from (
select thread#,sequence#,completion_time,row_number() over (partition by thread# order by sequence# desc) rn
from v$archived_log where resetlogs_change# = (select max(resetlogs_change#) from v$database_incarnation))
where rn = 1;

--standby
select thread#,sequence#,completion_time from (
select thread#,sequence#,completion_time,row_number() over (partition by thread# order by sequence# desc) rn
from v$archived_log where applied = 'YES' and resetlogs_change# = (select max(resetlogs_change#) from v$database_incarnation))
where rn = 1;

--on standby
select thread#,max(SEQUENCE#) 
from v$archived_log 
where resetlogs_time = (select max(resetlogs_time) from v$database_incarnation) and applied='YES'
group by thread#;

select thread#,max(SEQUENCE#) 
from v$archived_log 
where resetlogs_time = (select max(resetlogs_time) from v$database_incarnation)
group by thread#;

SELECT PROCESS, STATUS, THREAD#, SEQUENCE#,BLOCK#, BLOCKS FROM V$MANAGED_STANDBY;

SELECT DEST_ID, APPLIED_SCN FROM V$ARCHIVE_DEST WHERE TARGET='STANDBY';

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT;

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

SELECT PROTECTION_MODE, PROTECTION_LEVEL,
DATABASE_ROLE ROLE, SWITCHOVER_STATUS
FROM V$DATABASE;

--from primary
select dest_id,status,db_unique_name,applied_scn,error from v$archive_dest;

set lines 180
col value format a30
select * from v$dataguard_stats;

select *
from v$archive_gap;
