select s.sid as SID, s.serial#, sysdate as TIME_CREATED, s.LOGON_TIME,
      s.machine, ddl.OWNER,
       ddl.mode_held "LOCK_TYPE",
       ddl.name, do.object_id,
       do.object_type,
       trunc(ddl.last_convert) as "SECONDS_HOLDING_LOCKS"
from v$session s, dba_dml_locks ddl, dba_objects do
where s.sid = ddl.session_id
  and do.owner = ddl.owner
  and do.object_name = ddl.name
  and ddl.mode_held = 'Row-X (SX)'
  and ddl.LAST_CONVERT > 15
order by ddl.LAST_CONVERT, ddl.session_id;
