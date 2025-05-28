--only run job when this is database is the secondary
IF(sys.fn_hadr_is_primary_replica ( 'NeriumReporting' ) = 1)
BEGIN
	return;
END

	DECLARE @Message NVARCHAR(MAX) 
	DECLARE @MillisecondsBehind DECIMAL(18,2)
	DECLARE @SecondsBehind DECIMAL(18,2)
	DECLARE @MinutesBehind DECIMAL(18,2)
	DECLARE @RedoQueueSizeInMB INT
	DECLARE @RedoRateInKBPerSeconds INT

	SET @Message = '<style>
			table {
				font-family: Consolas;
				border-collapse: collapse;
				width: 100%;
			}
			td, th {
				border: 1px solid #dddddd;
				text-align: left;
				padding: 8px;
			}
			tr:nth-child(even) {
				background-color: #dddddd;
			}
			</style>'


	SELECT 
		@MillisecondsBehind = datediff(ms,last_redone_time,last_hardened_time),
		@SecondsBehind = Cast((datediff(ss,last_redone_time,last_hardened_time)) as decimal(18,2)),
		@MinutesBehind = Cast((datediff(mi,last_redone_time,last_hardened_time)) as decimal(18,2)),
		@RedoQueueSizeInMB = redo_queue_size,
		@RedoRateInKBPerSeconds = redo_rate
	FROM sys.dm_hadr_database_replica_states
	WHERE is_primary_replica = 0
	
	IF(@MinutesBehind > 5)
	BEGIN
		SET @Message = @Message + '<br />NeriumSQL03 Latency Alert' + '
			<br />
			<br />
			<table>
			<tr><th>MilliSeconds behind</th><th>Seconds behind</th><th>Minutes behind</th><th>Redo Queue size in MB</th><th>Redo Rate in KB/second</th></tr>
			<tr><td>' + cast(@MillisecondsBehind as varchar(max)) + '</td><td>' + cast(@SecondsBehind as varchar(max)) + '</td><td>' + cast(@MinutesBehind as varchar(max)) + '</td><td>' + cast(@RedoQueueSizeInMB as varchar(max)) + '</td><td>' + cast(@RedoRateInKBPerSeconds as varchar(max)) + '</td></tr>
			</table>'

		PRINT @Message

		EXEC msdb.dbo.sp_send_dbmail @profile_name = 'Nerium',
		@recipients = 'incident@neora.com;Kevin@DallasDBAs.com;stripp@neora.com',
		@subject = 'NeriumSQL3 Latency Alert',
		@body_format = 'HTML',
		@body = @Message;
	END

	
	