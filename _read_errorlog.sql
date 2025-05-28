Create Table #Errorlog 
(Logdate datetime, 
ProcessInfo varchar(50), 
LogText varchar(5000))

--Dump all the things into the table
insert into #Errorlog
EXEC sys.xp_readerrorlog 
0 -- Current ERRORLOG
,1 -- SQL ERRORLOG (not Agent)

insert into #Errorlog
EXEC sys.xp_readerrorlog 
1 -- First old errorlog
,1 -- SQL ERRORLOG (not Agent)

--Query just like you would anything else:
Select * 
from #Errorlog 
Where 1=1
--and LogText like '(c) Microsoft Corporation%'
and (LogText like '%Error%' or LogText like '%Fail%' or LogText like '%deadlock encountered%' --Error 9002 means the T-log is full
)
And Logdate > getdate() -1
And LogText Not Like '%CheckDB%'
And LogText not like '%35262%'
And LogText not like '%35250%'
And LogText not like '%ErrorMessage = NULL%'         -- Filter out DataCollectionOverrides queries
And LogText not like '%WHERE ErrorMessage LIKE%'
And Logtext not like '%CLIENT: 10.1.4.22%' --removed the square brackets
And LogText not like '%18456%'
And LogText not like 'Log was backed up%'
And logtext not like 'Attempting to cycle error log%'
And Logtext not like 'BackupVirtualDeviceFile%'
And Logtext not like '%Operating system error 995%'
And LogText not like '%VeeamAdmin%'
And LogText not like '%xpstar.dll%'
And LogText not like '%Severity: 20%'



Order by Logdate

--Clean up your mess, you weren't raised in a barn!
Drop Table #Errorlog