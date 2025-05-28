
Declare @BeginTime varchar(8000) = '2025-02-10 01:00:00.000'
Declare @EndTime varchar(8000) = '2025-02-10 23:59:59.000'

SELECT TOP 1000 CPU, reads, collection_time, start_time, [dd hh:mm:ss.mss] AS 'run duration', [program_name], login_name, database_name, session_id, blocking_session_id, wait_info, sql_text, *
FROM DBA..WhoIsActive
WHERE 1=1
	and collection_time between @BeginTime and @EndTime
	AND login_name NOT IN ('DomainName\sqlservice', 'NT AUTHORITY\SYSTEM')
	and program_name <> 'Microsoft® Windows® Operating System'
	and status <> 'sleeping'
	and [dd hh:mm:ss.mss] > '00 00:05:00.000'
	--AND CAST(sql_text AS varchar(max)) LIKE '%IO_message%'
ORDER BY 5 DESC