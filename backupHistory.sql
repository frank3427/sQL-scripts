Use msdb; 
go
Select  -- *
	backup_start_date, database_name, type,	backup_size/1024/1024/1024 as [backup size (GB)], 
	compressed_backup_size/1024/1024/1024 as [Compressed backup size (GB)]
	,Physical_device_name as [Backup location], is_copy_only
from msdb..backupset join msdb..backupmediafamily bmf on backupset.media_set_id = bmf.media_set_id
where 	1=1
	--and type = 'D' 	
	and database_name = 'StackOverflow' --<<<<< change this
	--and physical_device_name like '{%'
order by 	backup_start_date desc
--exec master.sys.xp_fixeddrives


--D:\Backups\KBH-Precision_SQL2016\KBH-PRECISION$SQL2016\StackOverflow\FULL\KBH-PRECISION$SQL2016_StackOverflow_FULL_20221223_102635.bak