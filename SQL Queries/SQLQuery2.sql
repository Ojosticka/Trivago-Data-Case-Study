-- CHALLENGE 1

with initialcte as 
(
select *
from [dbo].[sessions_task1]
where is_repeater = 1
)

select --traffic_type , 
		sum(clickouts) as totalclickouts, count(session_id) as totalsessions,
		(cast(sum(clickouts) as float)*100/cast(count(session_id) as float)) as COR,
		sum(bookings) as totalbookings,
		(cast(sum(bookings) as float)*100/cast(count(session_id) as float)) as BOOKR
from initialcte
--group by traffic_type
--order by (cast(sum(clickouts) as float)*100/cast(count(session_id) as float)) desc

select sum(did_user_click), count(session_id), cast((sum(did_user_click)*100) as float)/cast(count(session_id) as float) as clickedusers from 
	(select *, case when clickouts > 0 then 1 else 0 end as did_user_click
	from [dbo].[sessions_task1]
	where entry_page = 2116) aa
--group by tracking_id
--order by count(session_id) desc

select *
from [dbo].[actions_task2]

select entry_page, count(entry_page) as counterr
from [dbo].[sessions_task1]
group by entry_page
order by count(entry_page) desc
-- where tracking_id = 'L47NTB4H8A'

2116

select count(tracking_id)
from [dbo].[sessions_task1]
where tracking_id is null