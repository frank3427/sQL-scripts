Select j.name, jh.step_name, run_status, MSDB.DBO.AGENT_DATETIME(run_date,run_time) as RunDateTime, run_duration, [server]
From [msdb].[dbo].[sysjobhistory] jh
	join [msdb].[dbo].sysjobs j on jh.job_id = j.job_id
Where 1=1 
	--and run_status not in (1,4)
	and run_date > 20171110

	and [name] <> 'Clients not in Voyager'
	-- and run_time > 60000
Order by run_date  desc, run_time desc
	