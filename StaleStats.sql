 SELECT 
   st.object_id                          AS [Table ID]
 , OBJECT_NAME(st.object_id)             AS [Table Name]
 , st.name                               AS [Index Name]
 , STATS_DATE(st.object_id, st.stats_id) AS [LastUpdated]
 , modification_counter                  AS [Rows Modified]
 FROM
 sys.stats st 
 CROSS APPLY
 sys.dm_db_stats_properties(st.object_id, st.stats_id) AS sp 
 WHERE
 STATS_DATE(st.object_id, st.stats_id)<=DATEADD(DAY,-1,GETDATE())  
 AND modification_counter > 0 
 AND OBJECTPROPERTY(st.object_id,'IsUserTable')=1
 ORDER BY lastUpdated
 GO

