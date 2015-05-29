select name,total_mb,free_mb,round((free_mb/total_mb) * 100) pct_free
from V$ASM_DISKGROUP;

select dg.name, d.path, d.total_mb, d.failgroup_type 
from v$asm_diskgroup dg, v$asm_disk d where dg.group_number = d.group_number and dg.name = '&&DGNAME' order by dg.name, d.path;

col pct_free format 99.99
select group_number DG#, name, state, type, total_mb, free_mb , (free_mb/total_mb)*100 pct_free from v$asm_diskgroup;

set linesize 200
col PATH format a40
col NAME format a30
col LABEL format a15
select GROUP_NUMBER,name,DISK_NUMBER,LABEL,PATH,TOTAL_MB,MOUNT_STATUS,header_status from v$asm_disk order by 1,5;

set linesize 200
col PATH format a40
col NAME format a15
col LABEL format a15
select GROUP_NUMBER,name,DISK_NUMBER,LABEL,PATH,TOTAL_MB,MOUNT_STATUS from v$asm_disk;

select GROUP_NUMBER,OS_MB,TOTAL_MB,MOUNT_STATUS,HEADER_STATUS,MODE_STATUS  from v$asm_disk;

/etc/init.d/oracleasm listdisks
/etc/init.d/oracleasm status
