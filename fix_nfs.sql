alter system set events '10298 trace name context forever, level 32';
alter system set event = '10298 trace name context forever, level 32' scope=spfile;
