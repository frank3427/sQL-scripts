-- Check if the local replica is the Primary
IF NOT EXISTS (
    SELECT 1
    FROM sys.dm_hadr_availability_replica_states ars
    JOIN sys.availability_replicas ar ON ars.replica_id = ar.replica_id
    WHERE ars.role_desc = 'PRIMARY'
      AND ar.replica_server_name = @@SERVERNAME
)
BEGIN
    PRINT 'This is not the primary replica. Skipping job step.';
    RETURN;
END

-- If we get here, we're on the Primary
PRINT 'This is the Primary replica. Continuing job logic...';

BEGIN
    -- Your actual job logic goes here
    -- Example:
    -- EXEC usp_DoImportantStuff;
END
