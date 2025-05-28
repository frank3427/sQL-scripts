
https://learn.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-clonedatabase-transact-sql?view=sql-server-ver16#examples


-- Create a clone of a database that includes schema, statistics and Query Store
-- This is what you might send if you needed to get help from Microsoft

DBCC CLONEDATABASE (StackOverflow, StackOverflow_Clone_QS_Stats);
GO


--Create a schema-only clone of a database without statistics, but WITH Query Store
-- This is what you might send if you needed to get help from Microsoft

DBCC CLONEDATABASE (StackOverflow, StackOverflow_Clone_QS) WITH NO_STATISTICS;
GO


-- Create a schema-only clone of a database without statistics and Query Store
-- This is for when 'joe' overwrites a stored proc in prod.
-- Also, don't let Joe touch prod.

DBCC CLONEDATABASE (StackOverflow, StackOverflow_Clone) WITH NO_STATISTICS, NO_QUERYSTORE;
GO


--Create a clone of a database that is verified for use that includes a backup of the cloned database

DBCC CLONEDATABASE (StackOverflow, StackOverflow_Clone) WITH VERIFY_CLONEDB, BACKUP_CLONEDB;
GO


--Install Service Packs and CUs