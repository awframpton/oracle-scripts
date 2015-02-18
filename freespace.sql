select df.tablespace_name,df.bytes / 1048576 total_mb,
        round((df.bytes - nvl(fs.bytes,0)) / 1048576,2) used_mb,
        round(nvl(fs.bytes,0) / 1048576,2) free_mb,
        round(df.aebytes / 1048576,2) autoextend_mb,
        round((nvl(fs.bytes,0) + (df.aebytes - df.bytes))/ 1048576,2) autoextendfree_mb,
        round((df.bytes - nvl(fs.bytes,0))/df.bytes * 100,2) pct_used,
        round((df.bytes - nvl(fs.bytes,0))/df.aebytes * 100,2) autoextend_used,
        decode(df.aebytes,0,'NO','YES') autoextend
  from 
(select tablespace_name,sum(case when nvl(maxbytes,0) > bytes then maxbytes else bytes end) aebytes,sum(bytes) bytes from dba_data_files group by tablespace_name) df,
(select tablespace_name,sum(bytes) bytes from dba_free_space group by tablespace_name) fs
where df.tablespace_name = fs.tablespace_name(+)
order by autoextend_used desc;