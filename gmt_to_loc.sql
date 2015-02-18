create function gmt_to_loc(p_gmt timestamp) return timestamp
is
  v_loc_timestamp timestamp;
begin
  v_loc_timestamp := from_tz(p_gmt,'GMT') at local;
  return v_loc_timestamp;
end gmt_to_loc;
/