# SQL Script Documentation

This document provides an overview of the SQL scripts in this repository.

## CloneDatabase.sql

*   **Purpose:** This script provides various examples of using the `DBCC CLONEDATABASE` command to create copies of databases. It includes options for creating schema-only clones, clones with statistics, and clones with Query Store data. It also demonstrates how to verify the cloned database and create a backup of it.
*   **External Calls/OS Interactions:** None directly from the script. `DBCC CLONEDATABASE` itself creates database files on disk. The `BACKUP_CLONEDB` option will also interact with the disk to create a backup file.
*   **Notable URLs:**
    *   [https://learn.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-clonedatabase-transact-sql?view=sql-server-ver16#examples](https://learn.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-clonedatabase-transact-sql?view=sql-server-ver16#examples)

## DBA_ShrinkFile_100MB_increments.sql

*   **Purpose:** This script shrinks a specified database file in 100MB increments until it reaches a target size. It includes a 5-second delay between shrink operations.
*   **External Calls/OS Interactions:** `DBCC SHRINKFILE` interacts with the file system to reduce the size of database files.
*   **Notable URLs:** None.

## FirstResponderKit_20250217/SqlServerVersions.sql

*   **Purpose:** This script creates and populates a table named `dbo.SqlServerVersions`. This table stores a comprehensive list of SQL Server major and minor versions, including their release dates, support end dates, and links to relevant KB articles.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** The script contains numerous `support.microsoft.com` URLs for various SQL Server updates and KB articles.

## FirstResponderKit_20250217/sp_Blitz.sql

*   **Purpose:** This is a stored procedure from the First Responder Kit designed to perform a health check of a SQL Server instance. It identifies potential issues and provides a prioritized list of recommendations.
*   **External Calls/OS Interactions:**
    *   Can interact with the file system to read trace files (`fn_trace_gettable`).
    *   Can execute `xp_regread` to read registry values (e.g., for power plan settings, installed instances).
    *   Can execute `xp_fixeddrives` to get drive information.
    *   Can execute `xp_cmdshell` (conditionally, if enabled and not skipped).
    *   Can execute `sp_MSgetalertinfo` to get SQL Server Agent alert information.
    *   Can execute `sp_validatelogins` to check for invalid logins.
    *   Can send emails via Database Mail (`msdb.dbo.sp_send_dbmail`) if configured.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)
    *   [https://www.BrentOzar.com/blitz/documentation](https://www.BrentOzar.com/blitz/documentation)
    *   Numerous `brentozar.com/go/` URLs for specific findings.

## FirstResponderKit_20250217/sp_BlitzAnalysis.sql

*   **Purpose:** This stored procedure analyzes data collected by other First Responder Kit scripts (`sp_BlitzFirst`, `sp_BlitzCache`, `sp_BlitzWho`) that has been logged to tables. It helps in identifying trends and specific issues over a period.
*   **External Calls/OS Interactions:** None directly. It reads from tables where other scripts have logged data.
*   **Notable URLs:** None directly in the script, but it's part of the First Responder Kit, so the main kit URLs apply.
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)

---
## FirstResponderKit_20250217/sp_BlitzBackups.sql

*   **Purpose:** This stored procedure from the First Responder Kit checks backup history to estimate Recovery Point Objective (RPO) and Recovery Time Objective (RTO). It analyzes how much data might be lost and how long recovery might take.
*   **External Calls/OS Interactions:** None directly. Reads backup history from MSDB (or a specified database).
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)

## FirstResponderKit_20250217/sp_BlitzCache.sql

*   **Purpose:** Part of the First Responder Kit, this procedure analyzes the SQL Server plan cache to identify the most resource-intensive queries and offers tuning recommendations.
*   **External Calls/OS Interactions:**
    *   Can execute `xp_cmdshell` (conditionally, if enabled and not skipped, for Opserver output).
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)
    *   Numerous `brentozar.com/go/` and `brentozar.com/blitzcache/` URLs for specific findings.
    *   [http://pastetheplan.com](http://pastetheplan.com) for sharing execution plans.

## FirstResponderKit_20250217/sp_BlitzFirst.sql

*   **Purpose:** This First Responder Kit stored procedure provides a quick snapshot of the SQL Server's current performance, identifying immediate bottlenecks.
*   **External Calls/OS Interactions:**
    *   Can execute `xp_cmdshell` (conditionally, for `net start` to check service status).
    *   Reads from `sys.dm_server_services` which interacts with the OS service control manager.
    *   Reads from `sys.dm_os_ring_buffers` which can contain OS level information.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)
    *   Numerous `brentozar.com/go/` and `brentozar.com/blitz/` URLs for specific findings.
    *   [https://www.sqlskills.com/help/waits/](https://www.sqlskills.com/help/waits/) (for various wait types)

## FirstResponderKit_20250217/sp_BlitzIndex.sql

*   **Purpose:** A First Responder Kit tool that analyzes index design and performance, identifying issues like unused, duplicate, or missing indexes, and other potential problems.
*   **External Calls/OS Interactions:** None directly.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)
    *   Numerous `brentozar.com/go/` URLs for specific index-related findings.
    *   [http://Ola.Hallengren.com](http://Ola.Hallengren.com) (referenced in comments for index maintenance).

## FirstResponderKit_20250217/sp_BlitzLock.sql

*   **Purpose:** This First Responder Kit procedure analyzes deadlock information from the system_health Extended Event session or a custom Extended Event session to help diagnose and understand deadlocking issues.
*   **External Calls/OS Interactions:**
    *   Reads Extended Event files from disk (`sys.fn_xe_file_target_read_file`).
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)

## FirstResponderKit_20250217/sp_BlitzWho.sql

*   **Purpose:** Part of the First Responder Kit, this procedure provides a snapshot of currently executing queries and sessions on the SQL Server, offering more detail than `sp_who2`.
*   **External Calls/OS Interactions:**
    *   Can execute `DBCC INPUTBUFFER` for sessions.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)

## FirstResponderKit_20250217/sp_DatabaseRestore.sql

*   **Purpose:** A First Responder Kit utility to automate database restores from full, differential, and log backups. It supports various options like moving files, restoring to a point in time, and running `DBCC CHECKDB`.
*   **External Calls/OS Interactions:**
    *   `RESTORE DATABASE`, `RESTORE LOG` commands interact heavily with the file system to read backup files and create database files.
    *   `xp_dirtree` or `xp_cmdshell 'DIR'` to list files in backup directories.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)
    *   [https://ola.hallengren.com](https://ola.hallengren.com) (as it's designed to work with Ola Hallengren's maintenance solution backup structure and requires `CommandExecute`).

## FirstResponderKit_20250217/sp_ineachdb.sql

*   **Purpose:** A utility stored procedure (inspired by the undocumented `sp_MSforeachdb`) that executes a given SQL command in the context of each selected database on the SQL Server instance. It offers more control and flexibility than the original `sp_MSforeachdb`.
*   **External Calls/OS Interactions:** The executed command (`@command` parameter) *could* have external calls, but `sp_ineachdb` itself does not directly perform them.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org)
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/)
    *   [mssqltips.com/sqlservertip/5694/execute-a-command-in-the-context-of-each-database-in-sql-server--part-2/](mssqltips.com/sqlservertip/5694/execute-a-command-in-the-context-of-each-database-in-sql-server--part-2/) (referenced in comments)

---
## IndexOptimize30_50.sql

*   **Purpose:** This script defines a SQL Server Agent job named "IndexOptimize - USER_DATABASES". This job executes Ola Hallengren's `IndexOptimize` stored procedure against all user databases.
*   **Job Configuration:**
    *   Targets user databases (`@Databases = 'USER_DATABASES'`).
    *   Logs actions to a table (`@LogToTable = 'Y'`).
    *   Only considers indexes with at least 10,000 pages (`@MinNumberOfPages = 10000`).
    *   Fragmentation Levels:
        *   Low (not explicitly set, defaults to `IndexOptimize`'s internal logic, likely <30%): No action specified beyond statistics update.
        *   Medium (30% to 50%, `@FragmentationLevel1 = 30`, `@FragmentationLevel2 = 50`): Attempts `INDEX_REORGANIZE`, then `INDEX_REBUILD_ONLINE`.
        *   High (>50%): Attempts `INDEX_REORGANIZE`, then `INDEX_REBUILD_ONLINE`, then `INDEX_REBUILD_OFFLINE`.
    *   Updates all statistics (`@UpdateStatistics = 'ALL'`).
    *   Only updates statistics that have been modified (`@OnlyModifiedStatistics = 'Y'`).
*   **External Calls/OS Interactions:** Relies on `msdb.dbo.sp_add_job`, `msdb.dbo.sp_add_jobstep`, etc., to create agent jobs. The `IndexOptimize` procedure itself will interact with database files during index operations. Writes job output logs to the path specified by `$(ESCAPE_SQUOTE(SQLLOGDIR))`.
*   **Notable URLs:**
    *   [https://ola.hallengren.com](https://ola.hallengren.com) (Source of the `IndexOptimize` procedure).

## IndexOptimizeStatsOnly.sql

*   **Purpose:** This script defines a SQL Server Agent job named "Index Optimize - STATISTICS_ONLY". This job executes Ola Hallengren's `IndexOptimize` stored procedure to update statistics only, without performing index rebuilds or reorganizations.
*   **Job Configuration:**
    *   Targets user databases (`@Databases = 'USER_DATABASES'`).
    *   No index fragmentation operations are performed (`@FragmentationLow = NULL`, `@FragmentationMedium = NULL`, `@FragmentationHigh = NULL`).
    *   Updates all statistics (`@UpdateStatistics = 'ALL'`).
    *   Only updates statistics that have been modified (`@OnlyModifiedStatistics = 'Y'`).
    *   Logs actions to a table (`@LogToTable = 'Y'`).
*   **External Calls/OS Interactions:** Relies on `msdb.dbo.sp_add_job`, `msdb.dbo.sp_add_jobstep`, etc., to create agent jobs. Writes job output logs to the path specified by `$(ESCAPE_SQUOTE(SQLLOGDIR))`.
*   **Notable URLs:**
    *   [https://ola.hallengren.com](https://ola.hallengren.com) (Source of the `IndexOptimize` procedure).
    *   Mentions "Darling Data, LLC" in the job description, likely as the customizer or implementer of this specific statistics-only job.

## Job_Template_Check_IF_AG_Primary.sql

*   **Purpose:** This script provides a template for a SQL Server Agent job step to check if the current SQL Server instance is the primary replica in an Availability Group (AG) before proceeding with the actual job logic.
*   **External Calls/OS Interactions:** None directly within the template itself. The commented-out `EXEC usp_DoImportantStuff;` would be the actual workload.
*   **Notable URLs:** None.

## Job_to_stop_other_jobs.sql

*   **Purpose:** This script iterates through a predefined list of SQL Server Agent jobs and their maximum allowed run times. If a job from the list is found to be running longer than its specified maximum, an attempt is made to stop it using `msdb.dbo.sp_stop_job`.
*   **External Calls/OS Interactions:** Interacts with the SQL Server Agent by querying `msdb.dbo.sysjobs` and `msdb.dbo.sysjobactivity`, and by calling `msdb.dbo.sp_stop_job`.
*   **Notable URLs:** None.

## Lead_Blocker.sql

*   **Purpose:** This script queries system DMVs (`sys.sysprocesses`, `sys.dm_exec_requests`, `sys.dm_exec_sql_text`) to identify lead blockers in SQL Server. A lead blocker is a session that is blocking other sessions but is not itself being blocked.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## Log_Restore_Generate_Scripts.sql

*   **Purpose:** This script generates `RESTORE LOG` T-SQL commands for a specified database by listing transaction log backup files from a given directory.
*   **External Calls/OS Interactions:**
    *   Uses `xp_cmdshell 'dir ...'` to list files in the specified backup path (`J:\backup\MIA32354SQL101_INSTANCE1\mmdtpc` in the example).
*   **Notable URLs:** None.
*   **Note:** This script has hardcoded paths and database names that need to be changed for practical use. It also uses `xp_cmdshell` which has security implications.

## MaintenanceSolution_20250521.sql

*   **Purpose:** This is a comprehensive SQL Server maintenance solution script by Ola Hallengren. It installs several stored procedures (`CommandExecute`, `DatabaseBackup`, `DatabaseIntegrityCheck`, `IndexOptimize`) and creates SQL Server Agent jobs to automate common maintenance tasks like backups, integrity checks, and index/statistics maintenance.
*   **External Calls/OS Interactions:**
    *   `CommandExecute` can execute various commands, some of which might interact with the OS (like `xp_cmdshell` if used within the commands it executes).
    *   `DatabaseBackup` interacts with the file system for creating backup files and potentially `xp_delete_file` or `xp_cmdshell` for cleanup if not using native backup commands with retention. It can also interact with Azure Blob Storage or S3 if URLs are provided.
    *   `DatabaseIntegrityCheck` executes `DBCC` commands which read database files.
    *   `IndexOptimize` executes `ALTER INDEX` and `UPDATE STATISTICS` which read/write database files.
    *   The job creation part interacts with `msdb` system procedures (`sp_add_job`, `sp_add_jobstep`, etc.).
    *   May use `xp_instance_regread` to get default backup paths.
    *   May use `xp_fileexist` to check for directory existence.
    *   May use `xp_create_subdir` to create directories.
*   **Notable URLs:**
    *   [https://ola.hallengren.com](https://ola.hallengren.com) (The primary source and documentation site for this solution).
    *   [https://github.com/olahallengren/sql-server-maintenance-solution](https://github.com/olahallengren/sql-server-maintenance-solution) (Official GitHub repository).
    *   Various `microsoft.com` docs URLs are implicitly referenced for `DBCC` commands, backup/restore options, etc.

## QueriesUsingSpecificIndex.sql

*   **Purpose:** This script queries system DMVs (`sys.dm_exec_query_stats`, `sys.dm_exec_text_query_plan`, `sys.dm_exec_sql_text`) to identify queries that are currently in the plan cache and are using a specific index. The specific index is determined by a `LIKE` predicate on the `query_plan` XML (e.g., `WHERE q4_group IN (SELECT q4_group %`).
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:**
    *   [https://blog.sqlauthority.com](https://blog.sqlauthority.com) (Credits Pinal Dave).
*   **Note:** The `LIKE` predicate for identifying the index is hardcoded and needs to be modified for a specific index.

## RestoreHistory.sql

*   **Purpose:** This script queries MSDB system tables (`restorehistory`, `backupset`, `restorefile`, `backupmediafamily`) to retrieve the restore history for a specified database.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## Shrink_Log_File_Nonsense.sql

*   **Purpose:** This script provides a series of commands to attempt to shrink a transaction log file. It includes `CHECKPOINT`, `BACKUP LOG`, and `DBCC SHRINKFILE` with `TRUNCATEONLY`. It also includes commented-out commands for removing a log file (which is generally a bad idea unless the file is truly obsolete and empty).
*   **External Calls/OS Interactions:**
    *   `BACKUP LOG` interacts with the file system to write the log backup.
    *   `DBCC SHRINKFILE` interacts with the file system to reduce the log file size.
*   **Notable URLs:** None.
*   **Note:** Shrinking log files, especially with `TRUNCATEONLY` or by removing files, should be done with extreme caution and understanding of the implications. The script name "Nonsense" suggests an awareness of the often problematic nature of log shrinking attempts.

## Space_Used_AllDatabases_WithAutogrow_Method.sql

*   **Purpose:** This script iterates through all databases on an instance (using the undocumented `sp_MSforeachdb`) and collects space usage information for data and log files, including allocated size, space used, max size, and autogrowth settings.
*   **External Calls/OS Interactions:** None directly by the core logic, but `sp_MSforeachdb` itself is an undocumented system procedure.
*   **Notable URLs:** None.

## StaleStats.sql

*   **Purpose:** This script queries system DMVs (`sys.stats`, `sys.dm_db_stats_properties`) to identify statistics that were last updated more than a day ago and have had modifications since then.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## TempDB_Move_BrentScript.sql

*   **Purpose:** This script generates `ALTER DATABASE tempdb MODIFY FILE` commands to move tempdb's data and log files to a new specified location (hardcoded as `Z:\MSSQL\DATA\` in the script).
*   **External Calls/OS Interactions:** The generated `ALTER DATABASE` commands, when executed, will cause SQL Server to interact with the file system to create files in the new location upon next startup. The old files will be removed from the original location after SQL Server restarts and successfully starts using the new file locations.
*   **Notable URLs:**
    *   [https://www.brentozar.com/archive/2017/11/move-tempdb-another-drive-folder/](https://www.brentozar.com/archive/2017/11/move-tempdb-another-drive-folder/) (Source of the script).
*   **Note:** This script only *generates* the commands. The user must execute these commands and then restart SQL Server for the changes to take effect.

## UTC_to_Local_Conversion.sql

*   **Purpose:** This script provides a simple example of how to convert a datetime column stored in UTC to the server's local time using `DATEADD` and `DATEDIFF` with `GETUTCDATE()` and `GETDATE()`.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## Unused_Indexes_AllDBs.SQL

*   **Purpose:** This script iterates through all databases (using `sp_MSforeachdb`) and identifies potentially unused nonclustered indexes. An index is considered unused if it has no user seeks, scans, or lookups, but may have updates. It calculates an "impact" score based on user updates and table rows.
*   **External Calls/OS Interactions:** None directly by the core logic.
*   **Notable URLs:**
    *   Credits Pinal Dave in comments.
*   **Note:** Identifying unused indexes purely based on `sys.dm_db_index_usage_stats` can be misleading, as usage stats are cleared on instance restart or if the database is detached/restored. This script should be used as a starting point for investigation.

## VerrsionStore_Troubleshooting.sql

*   **Purpose:** This script contains a collection of queries to troubleshoot issues related to the version store in SQL Server, typically used by features like Read Committed Snapshot Isolation (RCSI) or Snapshot Isolation. It queries DMVs like `sys.dm_tran_version_store_space_usage`, `sys.dm_tran_active_transactions`, `sys.dm_tran_active_snapshot_database_transactions`, and `sys.sysprocesses`.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## VersionStore_Open_Sleeping_Transactions.sql

*   **Purpose:** Similar to `VerrsionStore_Troubleshooting.sql`, this script provides queries focused on identifying sleeping sessions that have open transactions, which can contribute to version store growth and other issues. It queries `sys.dm_tran_version_store_space_usage`, `sys.dm_tran_active_transactions`, `sys.dm_tran_active_snapshot_database_transactions`, and `sys.sysprocesses`.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## Waits_now.sql

*   **Purpose:** This script queries `sys.dm_os_wait_stats` to show current wait statistics on the SQL Server instance, ordered by the total wait time. It filters out many common "benign" wait types to focus on potentially problematic ones.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:**
    *   [https://www.sqlskills.com/help/waits/](https://www.sqlskills.com/help/waits/) (Referenced for each wait type listed in the exclusion list).

## WhoIsActive_Logging.sql

*   **Purpose:** This script sets up and manages logging for `sp_WhoIsActive` (a popular third-party stored procedure for monitoring SQL Server activity). It creates a destination table if it doesn't exist, creates a clustered index on `collection_time`, collects data using `sp_WhoIsActive`, and then purges data older than a specified retention period (default 7 days).
*   **External Calls/OS Interactions:** Relies on `dbo.sp_WhoIsActive` to be installed.
*   **Notable URLs:** None directly, but `sp_WhoIsActive` itself is typically downloaded from [whoisactive.com](http://whoisactive.com) or GitHub.

## WhoIsActive_Logging_Analysis_V2.sql

*   **Purpose:** This script queries a table (assumed to be `DBA..WhoIsActive`, the default logging table for `sp_WhoIsActive`) to analyze logged activity data within a specified time range. It filters out common background processes and sleeping sessions to focus on potentially problematic queries.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## _Job_History.sql

*   **Purpose:** This script queries `msdb.dbo.sysjobhistory` and `msdb.dbo.sysjobs` to retrieve the history of SQL Server Agent jobs, including run status, date/time, and duration. It has commented-out filters for specific run statuses, dates, and job names.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## _LastBackups.sql

*   **Purpose:** This script queries MSDB system tables (`backupset`, `backupmediafamily`) and `master..sysdatabases` to show the last full, differential, and log backup dates and device types for each database.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## _read_errorlog.sql

*   **Purpose:** This script uses `sys.xp_readerrorlog` to read the current and previous SQL Server error logs, filters for entries containing "Error", "Fail", or "deadlock encountered", and excludes common informational or less critical messages.
*   **External Calls/OS Interactions:** `sys.xp_readerrorlog` reads SQL Server error log files from the file system.
*   **Notable URLs:** None.

## backupHistory.sql

*   **Purpose:** This script queries MSDB system tables (`backupset`, `backupmediafamily`) to retrieve backup history for a specific database (hardcoded as 'StackOverflow'), showing backup start date, type, size, compressed size, physical device name, and copy-only status.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.
*   **Note:** The database name is hardcoded and needs to be changed for general use.

## sp_BlitzCache_Decoupled.sql

*   **Purpose:** This script appears to be a standalone or modified version of `sp_BlitzCache` from the First Responder Kit, likely intended for execution outside of the main kit or for specific integration (e.g., with SQLServerCheckup as hinted in the initial comments). It analyzes the plan cache for resource-intensive queries.
*   **External Calls/OS Interactions:** Similar to the main `sp_BlitzCache.sql`.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org) (Referenced in comments).
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/) (Referenced in comments).
    *   Numerous `brentozar.com/go/` and `brentozar.com/blitzcache/` URLs for specific findings.

## sp_BlitzIndex_TempProc.sql

*   **Purpose:** This script creates a temporary stored procedure named `#sp_BlitzIndex`. This is likely a version of `sp_BlitzIndex` from the First Responder Kit, modified to be created as a temporary procedure. It analyzes index design and performance.
*   **External Calls/OS Interactions:** Similar to the main `sp_BlitzIndex.sql`.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org) (Referenced in comments).
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/) (Referenced in comments).

## sp_BlitzLock_Temp.sql

*   **Purpose:** This script creates a temporary stored procedure named `#sp_BlitzLock`. This is likely a version of `sp_BlitzLock` from the First Responder Kit, modified to be created as a temporary procedure. It analyzes deadlock information.
*   **External Calls/OS Interactions:** Similar to the main `sp_BlitzLock.sql` (reads Extended Event files).
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org) (Referenced in comments).

---
## AG_Latency.sql

*   **Purpose:** This script queries `sys.dm_hadr_database_replica_states` to check for latency in Availability Group (AG) synchronization. It calculates the time difference in milliseconds, seconds, and minutes between `last_redone_time` and `last_hardened_time` for secondary replicas. It also shows the `redo_queue_size` and `redo_rate`.
*   **Filters:** Only shows replicas where the time difference is greater than 1000 milliseconds (1 second). Commented out filter for a specific database name.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## AG_Latency_Email_Job.sql

*   **Purpose:** This script is designed to be used in a SQL Server Agent job. It checks AG latency (similar to `AG_Latency.sql`) and sends an email alert if the latency (in minutes) exceeds a threshold (hardcoded as 5 minutes).
*   **Logic:**
    *   First, it checks if the current replica is the primary for the database 'NeriumReporting'. If it is, the script exits (alerts are typically for secondaries).
    *   It then queries `sys.dm_hadr_database_replica_states` for latency metrics.
    *   If `@MinutesBehind > 5`, it formats an HTML email with the latency details and sends it using `msdb.dbo.sp_send_dbmail`.
*   **External Calls/OS Interactions:** Uses `msdb.dbo.sp_send_dbmail` to send email.
*   **Notable URLs:** None.
*   **Note:** Hardcoded database name ('NeriumReporting') and email profile ('Nerium') and recipients.

## AG_Seeding_Status.sql

*   **Purpose:** This script queries `sys.dm_hadr_automatic_seeding` and related AG DMVs (`sys.availability_databases_cluster`, `sys.availability_groups`) to display the status of automatic seeding operations in an Availability Group.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## Backup_Completion_Percent.sql

*   **Purpose:** This script queries `sys.dm_exec_requests` and `sys.dm_exec_sql_text` to show the progress of ongoing `BACKUP DATABASE`, `RESTORE DATABASE`, or `BACKUP LOG` commands. It displays the command, start time, percent complete, and estimated completion time.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## CheckDB_LastRun.sql

*   **Purpose:** This script queries `sys.databases` to retrieve the `LastGoodCheckDbTime` property for each online database, indicating the last time `DBCC CHECKDB` successfully ran without errors.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## LICENSE

*   **Purpose:** This file contains the MIT License text for the software in this repository.
*   **Content:** Standard MIT License boilerplate, attributing copyright to "Frank Dias" for the year 2025.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## sp_Blitz_Decoupled.sql

*   **Purpose:** This script is a version of `sp_Blitz` from the First Responder Kit. `sp_Blitz` is a comprehensive health check stored procedure for SQL Server, identifying a wide range of potential issues and best practice violations. This "decoupled" version might be intended for running independently or in specific environments where the full kit isn't installed.
*   **External Calls/OS Interactions:** Similar to the main `sp_Blitz.sql`:
    *   Can read trace files (`fn_trace_gettable`).
    *   Can execute `xp_regread` for registry values.
    *   Can execute `xp_fixeddrives`.
    *   Can execute `xp_cmdshell` (conditionally).
    *   Can call `sp_MSgetalertinfo`.
    *   Can call `sp_validatelogins`.
    *   Can send email via `msdb.dbo.sp_send_dbmail`.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org) (Referenced in comments).
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/) (Referenced in comments).
    *   Numerous `brentozar.com/go/` URLs for specific findings.

## sp_Blitz_Decoupled_NoDatabaseInfo.sql

*   **Purpose:** This script is another variation of `sp_Blitz` from the First Responder Kit. The "NoDatabaseInfo" in the name suggests it might be a version that skips database-specific checks, possibly to run faster or with fewer permissions.
*   **External Calls/OS Interactions:** Likely similar to `sp_Blitz.sql` but may omit those that require iterating through databases or accessing database-specific DMVs/catalog views.
*   **Notable URLs:**
    *   [http://FirstResponderKit.org](http://FirstResponderKit.org) (Referenced in comments).
    *   [https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/) (Referenced in comments).

## sp_PressureDetector_temp.sql

*   **Purpose:** This script creates a temporary stored procedure `#sp_PressureDetector`. This procedure by Erik Darling is designed to identify memory and CPU pressure on a SQL Server instance.
*   **Checks:**
    *   DAC (Dedicated Admin Connection) status.
    *   Buffer pool and non-buffer pool memory usage.
    *   Memory grant information from `sys.dm_exec_query_memory_grants`.
    *   Resource semaphore status from `sys.dm_exec_query_resource_semaphores`.
    *   Thread usage from `sys.dm_os_schedulers`.
    *   Threadpool waits from `sys.dm_os_waiting_tasks`.
    *   Currently running queries (`sys.dm_exec_requests`) that might be causing CPU pressure.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:**
    *   [https://erikdarlingdata.com/](https://erikdarlingdata.com/) (Author's website).
    *   [https://bit.ly/RemoteDAC](https://bit.ly/RemoteDAC) (URL for DAC usage information).

## tempDB_Configured_vs_current_size.sql

*   **Purpose:** This script compares the configured size of tempdb files (from `sys.master_files`) with their current actual size (from `tempdb.sys.database_files`). This helps identify if tempdb has grown since the last service restart or explicit resize.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## tempdb_monitoring.sql

*   **Purpose:** This script queries `tempdb.sys.dm_db_file_space_usage` to provide a snapshot of space usage within tempdb, broken down by:
    *   Total free space.
    *   Space used by the version store.
    *   Space used by internal objects.
    *   Space used by user objects.
*   **External Calls/OS Interactions:** None.
*   **Notable URLs:** None.

## zwho_is_active_12.sql

*   **Purpose:** This script contains the source code for `sp_WhoIsActive` version 12.00 by Adam Machanic. `sp_WhoIsActive` is a very popular and feature-rich stored procedure for monitoring current activity on a SQL Server instance, providing significantly more detail than `sp_who` or `sp_who2`.
*   **External Calls/OS Interactions:**
    *   Can execute `DBCC INPUTBUFFER` to get the input buffer for sessions.
    *   Can execute `DBCC OPENTRAN` to get open transaction information.
    *   The script itself doesn't make direct OS calls but provides extensive diagnostics about SQL Server internal operations.
*   **Notable URLs:**
    *   [http://whoisactive.com](http://whoisactive.com) (Official documentation site).
    *   [https://github.com/amachanic/sp_whoisactive](https://github.com/amachanic/sp_whoisactive) (Official GitHub repository).

## zwho_is_active_temp_Create_Exec_Drop.sql

*   **Purpose:** This script is a wrapper that creates `sp_WhoIsActive` (v11.33 in this case) as a temporary procedure (`#sp_WhoIsActive`), executes it with specific parameters (`@get_plans = 1`), and then drops the temporary procedure. This is useful for running `sp_WhoIsActive` without permanently installing it in a database.
*   **External Calls/OS Interactions:** Same as `zwho_is_active_12.sql` (or the specific version of `sp_WhoIsActive` embedded).
*   **Notable URLs:**
    *   [http://whoisactive.com](http://whoisactive.com) (Indirectly, as it uses `sp_WhoIsActive`).
    *   [https://github.com/amachanic/sp_whoisactive](https://github.com/amachanic/sp_whoisactive) (Indirectly).

---
