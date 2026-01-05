-- Top Percentile Fraud
with state_p95 as (
    select
        state,
        percentile_cont(0.95) within group (order by fraud_score) as threshold
    from fraud_score
    group by state
)
SELECT 
    f.policy_num,
    f.state,
    f.claim_cost,
    f.fraud_score
FROM fraud_score f
join state_p95 p on f.state = p.state
where f.fraud_score >= p.threshold
;
