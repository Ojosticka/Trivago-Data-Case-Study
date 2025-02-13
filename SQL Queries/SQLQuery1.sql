
--select session_id, count(date_id)
--from [dbo].[actions_task2]
--group by session_id
--order by count(date_id) desc


--'2022050216343017833'

--select tracking_id, session_id, action_id, date_id, action_reference, step
--from actions_task2
--where tracking_id = '2HE54H89TB'
----order by step
--where session_id = '2022050216343017833'

--'1RVPW7D5SV'

--select tracking_id, count(distinct session_id)
--from actions_task2
--group by tracking_id
--order by count(distinct session_id) desc

with inicte as
(
select *, case when (step = min(step) over (partition by session_id)) then 'start_action' 
			   --when (step = max(step) over (partition by session_id)) then 'end_action'
			   else null end as checkers, 
		  case when (step = max(step) over (partition by session_id)) then 'end_action'
			   else null end as checkers_end
from actions_task2
--where tracking_id = '2HE54H89TB'
),

newcte as
(
select action_id, count(distinct session_id) as total_actions, count(distinct (case when checkers_end = 'end_action' then session_id else null end)) as drop_actions
from inicte
group by action_id
),
--order by count(distinct session_id) desc
badcte as
(select action_id, total_actions, drop_actions, round(((cast(drop_actions as float)*100)/cast(total_actions as float)), 3) as drop_rate
from newcte
--order by round(((cast(drop_actions as float)*100)/cast(total_actions as float)), 3) desc
)

select row_number() over (order by drop_rate desc) as row_index, action_id, total_actions, drop_actions, drop_rate
from badcte
order by drop_rate desc


--cast(drop_actions as float)/cast(total_actions as float) as drop_rate