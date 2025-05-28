--04 Last Backups
;with
db as (
	select [Instance] = @@SERVERNAME,
		[Database]  = name,
	    [RecoveryMode]   = DATABASEPROPERTYEX(name, 'Recovery'),
	    [CreationTime]   = crdate,
	    [Status]         = DATABASEPROPERTYEX(name, 'Status')
		from master..sysdatabases
		where name!='tempdb'
),
lastfull as	(
	select * from (
	 select [Database]     = s.database_name,
		[LastFullDate] = convert(varchar, s.backup_finish_date, 120),
		[LastFullSize]   = s.backup_size,
		[LastFullDevice] = f.physical_device_name,
        [LastFullDevTyp] = f.device_type,
		[Nrank] = rank() over (partition by s.database_name order by s.backup_finish_date desc)
	from msdb.dbo.backupset s, msdb.dbo.backupmediafamily f
		where 
         s.media_set_id=f.media_set_id
		and s.type='D'
	) f
	where Nrank=1
),
lastdiff as	(
	select * from (
	 select [Database]     = s.database_name,
		[LastDiffDate] = convert(varchar, s.backup_finish_date, 120),
		[LastDiffSize]   = s.backup_size,
		[LastDiffDevice] = f.physical_device_name,
        [LastDiffDevTyp] = f.device_type,
		[Nrank] = rank() over (partition by s.database_name order by s.backup_finish_date desc)
	from msdb.dbo.backupset s, msdb.dbo.backupmediafamily f
		where 
         s.media_set_id=f.media_set_id
		and s.type='I'
	) f
	where Nrank=1
	),
lastlog as (
	select * from (
	 select [Database]     = s.database_name,
		[LastLogDate] = convert(varchar, s.backup_finish_date, 120),
		[LastLogSize]   = s.backup_size,
		[LastLogDevice] = f.physical_device_name,
        [LastLogDevTyp] = f.device_type,
		[Nrank] = rank() over (partition by s.database_name order by s.backup_finish_date desc)
	 from msdb.dbo.backupset s, msdb.dbo.backupmediafamily f
		where 
         s.media_set_id=f.media_set_id  
		and s.type='L'
	) l
	where Nrank=1
)
select db.[Instance],db.[Database], db.[RecoveryMode],  db.[Status],
	lastfull.[LastFullDate],
        lastfull.[LastFullDevice], 
	lastdiff.[LastDiffDate],
	lastdiff.[LastDiffDevice],
	lastlog.[LastLogDate],
	lastlog.[LastLogDevice]
	--into #bkupstatus
from db
	left outer join lastfull
		on (db.[Database]=lastfull.[Database])
	left outer join lastdiff
		on (db.[Database]=lastdiff.[Database])
	left outer join lastlog
		on (db.[Database]=lastlog.[Database])

