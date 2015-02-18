select msg||chr(10)
from 
(select 1 sort_order,cast(ltrim(rtrim(ltrim(dbms_metadata.get_ddl('USER',upper(:username))))||';') as varchar2(4000)) msg
from dual
union
select 2,'alter user '||username||' quota '||decode(max_bytes,-1,'UNLIMITED',max_bytes)||' on '||tablespace_name||';'
from dba_ts_quotas
where username = upper(:username)
union
select 3,'grant '||privilege||' to '||grantee||';'
from dba_sys_privs
where grantee = upper(:username)
union
select 4,'grant '||granted_role||' to '||grantee||';'
from dba_role_privs
where grantee = upper(:username)
union
select 5,'grant '||privilege||' on '||owner||'."'||table_name||'" to '||grantee||';'
from dba_tab_privs
where grantee = upper(:username)
and table_name not like 'BIN$%'
) order by sort_order,msg