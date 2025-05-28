-- Sample input: list of job names and allowed max run times (in minutes)
DECLARE @JobList TABLE (
    JobName NVARCHAR(128),
    MaxRunMinutes INT
);

-- Add your jobs here
INSERT INTO @JobList (JobName, MaxRunMinutes)
VALUES 
    (N'Daily ETL Job', 60),
    (N'Index Maintenance', 45),
    (N'Nightly Backup', 120),
    (N'ThisJobDoesNotExist', 10),
    (N'syspolicy_purge_history',10);

-- Variables for processing
DECLARE @JobName NVARCHAR(128);
DECLARE @MaxRunMinutes INT;
DECLARE @StartExecutionDateTime DATETIME;
DECLARE @RunDurationMinutes INT;
DECLARE @JobExists BIT;

-- Cursor to loop through each job
DECLARE job_cursor CURSOR FOR
SELECT JobName, MaxRunMinutes FROM @JobList;

OPEN job_cursor;
FETCH NEXT FROM job_cursor INTO @JobName, @MaxRunMinutes;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Check if the job exists in sysjobs
    SELECT @JobExists = CASE WHEN EXISTS (
        SELECT 1 FROM msdb.dbo.sysjobs WHERE name = @JobName
    ) THEN 1 ELSE 0 END;

    IF @JobExists = 0
    BEGIN
        PRINT 'WARNING: Job "' + @JobName + '" does not exist in msdb.dbo.sysjobs. Skipping...';
    END
    ELSE
    BEGIN
        -- Check if the job is currently running
        IF EXISTS (
            SELECT 1
            FROM msdb.dbo.sysjobactivity AS activity
            INNER JOIN msdb.dbo.sysjobs AS job ON activity.job_id = job.job_id
            WHERE job.name = @JobName
              AND activity.stop_execution_date IS NULL
              AND activity.start_execution_date IS NOT NULL
        )
        BEGIN
            -- Get the start time of the running job
            SELECT @StartExecutionDateTime = activity.start_execution_date
            FROM msdb.dbo.sysjobactivity AS activity
            INNER JOIN msdb.dbo.sysjobs AS job ON activity.job_id = job.job_id
            WHERE job.name = @JobName
              AND activity.stop_execution_date IS NULL
              AND activity.start_execution_date IS NOT NULL;

            -- Calculate how long the job has been running
            SET @RunDurationMinutes = DATEDIFF(MINUTE, @StartExecutionDateTime, GETDATE());

            PRINT 'Job "' + @JobName + '" has been running for ' + CAST(@RunDurationMinutes AS NVARCHAR) + ' minutes.';

            IF @RunDurationMinutes > @MaxRunMinutes
            BEGIN
                PRINT 'Job has exceeded max runtime of ' + CAST(@MaxRunMinutes AS NVARCHAR) + ' minutes. Attempting to stop it...';

                EXEC msdb.dbo.sp_stop_job @job_name = @JobName;

                PRINT 'Stop command issued for "' + @JobName + '".';
            END
            ELSE
            BEGIN
                PRINT 'Job "' + @JobName + '" is running but within allowed time.';
            END
        END
        ELSE
        BEGIN
            PRINT 'Job "' + @JobName + '" is not currently running.';
        END
    END

    FETCH NEXT FROM job_cursor INTO @JobName, @MaxRunMinutes;
END

CLOSE job_cursor;
DEALLOCATE job_cursor;
