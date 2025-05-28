USE msdb;
GO

DECLARE @DatabaseName NVARCHAR(128) = 'YourDatabaseName'; -- Change this to your database name

SELECT  
    rh.restore_date,
    rh.destination_database_name,
    CASE rh.restore_type
        WHEN 'D' THEN 'Database'
        WHEN 'F' THEN 'File'
        WHEN 'G' THEN 'Filegroup'
        WHEN 'I' THEN 'Differential'
        WHEN 'L' THEN 'Log'
        ELSE rh.restore_type
    END AS restore_type,
    bs.backup_start_date,
    bs.backup_finish_date,
    bmf.physical_device_name AS backup_file_used,
    rf.file_number,
    rf.destination_phys_name AS restored_file_name
FROM msdb.dbo.restorehistory rh
JOIN msdb.dbo.backupset bs ON rh.backup_set_id = bs.backup_set_id
JOIN msdb.dbo.restorefile rf ON rh.restore_history_id = rf.restore_history_id
JOIN msdb.dbo.backupmediafamily bmf ON bs.media_set_id = bmf.media_set_id
WHERE rh.destination_database_name = @DatabaseName
ORDER BY rh.restore_date DESC;
