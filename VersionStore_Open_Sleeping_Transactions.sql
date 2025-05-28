--dbcc updateusage(tempdb)

select * from master.sys.databases where is_read_committed_snapshot_on = 1


-- get the VS space used by database
Select db_name(database_id), reserved_page_count, reserved_space_kb/1024/1024 as [GB Used]
from sys.dm_tran_version_store_space_usage
Order by reserved_space_kb desc



select
t.transaction_id,t.name,t.transaction_type, t.transaction_state,
s.transaction_id,s.session_id,
s.elapsed_time_seconds/60/60.0 as hours_tran_has_been_open,
p.status, p.cmd, p.dbid
from sys.dm_tran_active_transactions t
  join sys.dm_tran_active_snapshot_database_transactions s
     on t.transaction_id = s.transaction_id
  join sys.sysprocesses p
     on p.spid = s.session_id


--select SUM(aggregated_record_length_in_bytes) [SpaceUsed] from sys.dm_tran_top_version_generators
--GROUP by database_id
--ORDER by SpaceUsed DESC


-- look for sleeping transactions that are open
SELECT 
   a.session_id
 , a.transaction_id
 , a.transaction_sequence_num
 , a.elapsed_time_seconds/60 [minutes]
 , b.program_name
 , b.open_tran
 , b.STATUS
 ,db_name(b.dbid)
FROM sys.dm_tran_active_snapshot_database_transactions a
JOIN sys.sysprocesses b ON a.session_id = b.spid
Where open_tran <> 0
ORDER BY elapsed_time_seconds DESC
