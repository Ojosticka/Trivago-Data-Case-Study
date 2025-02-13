select session_id, count(date_id)
from [dbo].[actions_task2]
group by session_id
order by count(date_id) desc


'2022050216343017833'

select tracking_id, session_id, action_id, date_id, action_reference, step
from actions_task2
where tracking_id = '2HE54H89TB'
--order by step
where session_id = '2022050216343017833'

'1RVPW7D5SV'

select tracking_id, count(distinct session_id)
from actions_task2
group by tracking_id
order by count(distinct session_id) desc