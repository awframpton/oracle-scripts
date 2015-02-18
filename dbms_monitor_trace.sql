EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(39,45);

select 'exec DBMS_MONITOR.SESSION_TRACE_disable('||sid||','||serial#||');'
from v$session
where osuser = 'wasadm'
and username =  'IMFGTW';