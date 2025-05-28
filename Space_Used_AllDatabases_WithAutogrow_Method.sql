
CREATE table #SPACEUSED(
[DatabaseName] Varchar(1000),
[LogicalName] Varchar(255),
[PhysicalName] Varchar(1024),
[Allocated Size in MB] Decimal(10,2),
[Space Used in MB] Decimal(10,2),
[Max in MB] Decimal(10,2),
[Autogrowth] Varchar(100),
[Available Space in MB] Decimal(10,2),
[Percent Used] Decimal(10,2)
)
--This works
DECLARE @command varchar(1000)
SELECT @command = 'USE [?] 
INSERT #SPACEUSED
SELECT ''?'', RTRIM(name),
--groupid,
Physical_Name,
CAST(size/128.0 AS DECIMAL(10,2)),
CAST(FILEPROPERTY(name, ''SpaceUsed'')/128.0 AS DECIMAL(10,2)),
CAST([max_size]/128.0 AS DECIMAL(10,2)),
upPCT=case when (sf.is_percent_growth) =1 then str(sf.growth)+''%'' else str(sf.growth/128.00)+''MB'' end,
CAST(size/128.0-(FILEPROPERTY(name, ''SpaceUsed'')/128.0) AS DECIMAL(10,2)),
CAST((CAST(FILEPROPERTY(name, ''SpaceUsed'')/128.0 AS DECIMAL(10,2))/CAST(size/128.0 AS DECIMAL(10,2)))*100 AS DECIMAL(10,2))
FROM sys.database_files sf'
EXEC sp_MSforeachdb @command

SELECT * FROM #SPACEUSED
WHERE 1=1
	and DatabaseName in ('StackOverflow')
	and physicalname not like '%ldf'
ORDER BY DatabaseName --DESC

--Clean up after yourself, you weren't raised in a barn!
DROP TABLE #SPACEUSED

--Please work


