


--Generate t-log scripts from directory
--INT in the RIGHT command will vary based on size of the database name
SET NOCOUNT ON

CREATE TABLE #DirResults (Diroutput VARCHAR(500))
INSERT #DirResults
  EXEC master.dbo.xp_cmdshell 'dir J:\backup\MIA32354SQL101_INSTANCE1\mmdtpc'		-- Change This to your path
  Select 
	'Restore Log MyDB1 from disk = ''J:\backup\MIA32354SQL101_INSTANCE1\MyDb1\'		-- Chnage this too (dbname and path)
		+ Right (Diroutput,25)														-- Change the number to make it work...database name affects it
		+ ''' with norecovery' as [filecmd]
  from #DirResults
  Where Diroutput like '%mmdtpc_%trn%'												-- Change this as needed to eliminate rows at top and bottom
  ORder by [filecmd]
  Drop table #DirResults