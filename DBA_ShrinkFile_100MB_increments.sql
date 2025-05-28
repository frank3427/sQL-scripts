
-- exec master..sp_helpdb 'StackOverflow'


declare @startsize int
Declare @target int
Declare @Filename varchar(50)

Set @Filename = 'StackOverflow_1'	--from sp_helpdb
Set @startsize = 50000				-- in MB, current size from helpdb
Set @target = 47000					-- in MB, target size

While @Startsize > @target
    Begin
        Set @Startsize = @startsize - 100  --100mb increments
        DBCC Shrinkfile (@filename, @startsize)
        Print 'Shrunk to ' + cast(@startsize as varchar(10))
		Waitfor Delay '00:00:05' --5 second delay
    End