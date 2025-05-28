
-- convert UTC to local time when data is stored UTC in the table
SELECT 
    DATEADD(
            mi, 
            DATEDIFF(mi, GETUTCDATE(), GETDATE()),
            MyTable.UtcColumn                        -- this and the alias are all you need to change
            ) 
       AS ColumnInLocalTime
FROM MyTable