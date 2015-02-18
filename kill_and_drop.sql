alter user GSMSDEV account lock;
begin
for c in (select sid,serial# from v$session
            where username = 'GSMSDEV')
loop
  execute immediate 'alter system disconnect session '''||c.sid||','||c.serial#||''' immediate';
end loop;
end;
/

--drop user GSMSDEV cascade;