-- My answer
with data as (
 SELECT
   sum(case when caller.country_id <> receiver.country_id 
     then 1 else 0 end) as international_calls,
   count(*) as total_calls
 from phone_calls as calls
 left join phone_info as caller
   on calls.caller_id = caller.caller_id
 left join phone_info as receiver
   on calls.receiver_id = receiver.caller_id
)
SELECT
 round(100.0 * international_calls::decimal/total_calls, 1) as international_calls_pct
from data

-- Solution
SELECT
 round(
   100.0 * sum(case when caller.country_id <> receiver.country_id 
     then 1 else 0 end)
   /count(*), 1
 ) as international_call_pct
from phone_calls as calls
left join phone_info as caller
 on calls.caller_id = caller.caller_id
left join phone_info as receiver
 on calls.receiver_id = receiver.caller_id
