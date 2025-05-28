Select
	datediff(ms,last_redone_time,last_hardened_time) as [MilliSeconds behind]
	,Cast((datediff(ss,last_redone_time,last_hardened_time)) as decimal(18,2)) as [Seconds behind]
	,Cast((datediff(mi,last_redone_time,last_hardened_time)) as decimal(18,2)) as [Minutes behind]
	,redo_queue_size as [Redo Queue size in KB]
	,redo_rate as [Redo Rate KB/second]
	--,last_hardened_time
	--,last_redone_time
	, getdate() as [datetime]
From sys.dm_hadr_database_replica_states
Where 1=1
	and is_primary_replica = 0
	--and DB_Name(Database_ID) = 'MyDatabase'
	and datediff(ms,last_redone_time,last_hardened_time)> 1000;