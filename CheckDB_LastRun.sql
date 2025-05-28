SELECT 
    name AS DatabaseName,
    DATABASEPROPERTYEX(name, 'LastGoodCheckDbTime') AS LastCheckDBSuccess
FROM 
    sys.databases
WHERE 
    state_desc = 'ONLINE'
ORDER BY 
    LastCheckDBSuccess;



--    dbcc checkdb (dba)