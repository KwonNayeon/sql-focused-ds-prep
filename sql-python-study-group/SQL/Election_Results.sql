with vote_weights as (
    select
        voter,
        candidate,
        1.0 / count(*) over (partition by voter) as vote_weight
    from voting_results
),
total as (
    select
        candidate,
        sum(vote_weight) as total_votes
    from vote_weights
    where candidate is not null
    group by candidate
)
select
    candidate
from total
order by total_votes desc
limit 1;
