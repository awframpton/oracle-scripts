
select l.table_name,l.column_name,l.tablespace_name,l.securefile,l.deduplication,l.compression,l.segment_created,c.data_type,nvl(s.bytes,0) / 1024 kb,num_rows
from dba_lobs l,dba_tab_columns c,dba_segments s,dba_tables t
where l.owner = 'SAPR3'
and c.owner = l.owner
and c.table_name = l.table_name
and c.column_name = l.column_name
and s.owner(+) = l.owner
and s.segment_name(+) = l.segment_name
and t.table_name = l.table_name
and t.owner = l.owner
order by 10 desc;