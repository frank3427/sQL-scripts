USE Orion_db1 -- change me
GO

-- this shouldn't be necessary, but frequently is
checkpoint
go 100

-- Sometimes a backup is needed to move the active bit the the "front" of the log
backup Log Orion_db1
to Disk = 'A:\Someplace\Orion_db1_20221216_time.trn'  -- change path once and time each time you go through this
With compression

DBCC SHRINKFILE (N'Orion_db1_log_overflow' , 0, TRUNCATEONLY) -- change as you get each one shrunk
GO

dbcc loginfo



/* remove file nonsense 

DBCC SHRINKFILE (Disaster_1_log, EMPTYFILE);
GO
-- Remove the data file from the database.
ALTER DATABASE Disaster
REMOVE FILE Disaster_1_log;
GO

*/


select * from sysfiles