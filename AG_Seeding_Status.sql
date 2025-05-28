SELECT
    dhas.start_time
    ,dhas.completion_time
    ,ag.name
    ,adb.database_name
    ,dhas.current_state
    ,dhas.performed_seeding
    ,dhas.failure_state
    ,dhas.failure_state_desc
FROM sys.dm_hadr_automatic_seeding as dhas 
JOIN sys.availability_databases_cluster as adb 
    ON dhas.ag_db_id = adb.group_database_id
JOIN sys.availability_groups as ag 
    ON dhas.ag_id = ag.group_id