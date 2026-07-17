select
    user_id,
    friend_id
from google_friends_network

union

select
    friend_id as user_id,
    user_id as friend_id
from google_friends_network
order by 1
;
