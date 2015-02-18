select round(sum(bytes) / 1048576) mb
from (select bytes
from v$datafile
union
select bytes
from v$log
union
select bytes
from v$tempfile);
