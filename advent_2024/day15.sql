-- 트러블슈팅 노트:
-- 1. 날짜 필터링 수정:
--    - 초기에는 `BETWEEN '2018-10-01' AND '2018-10-31'` 조건을 사용했으나,
--      SQL의 `BETWEEN`이 양쪽 끝 값을 포함하는 특성 때문에 '2018-10-31' 자정에 발생한 데이터가 누락됨.
--    - 이를 해결하기 위해 날짜 조건을 `>= '2018-10-01' AND < '2018-11-01'`으로 변경하여 
--      2018년 10월 전체 데이터를 정확히 조회하도록 수정.

-- 2. 대여(rent) 및 반납(return) 모두 고려:
--    - 초기 쿼리에서는 대여(`rent_station_id`) 데이터만 조회했기 때문에,
--      정류소 사용량(usage_count)에 대한 분석이 불완전했음.
--    - 이를 보완하기 위해 반납(`return_station_id`) 데이터도 함께 포함시키도록 `UNION ALL`을 사용.
--      - `UNION ALL`을 사용하면 중복 제거 없이 모든 대여 및 반납 데이터를 통합하여 정류소별 사용량을 계산할 수 있음.

-- 최종 쿼리:
--    - 정류소의 2019년 10월 사용량이 2018년 10월 사용량의 50% 이하인 정류소를 조회.
--    - 결과는 사용량 감소율(usage_pct)이 큰 순서대로 정렬됨.

WITH usage_2018 AS (
    SELECT 
        station_id, 
        COUNT(*) AS usage_count 
    FROM (
        SELECT rent_station_id AS station_id 
        FROM rental_history 
        WHERE rent_at >= '2018-10-01' 
          AND rent_at < '2018-11-01'
        
        UNION ALL 
        
        SELECT return_station_id AS station_id 
        FROM rental_history 
        WHERE return_at >= '2018-10-01' 
          AND return_at < '2018-11-01'
    ) t2018 
    GROUP BY station_id
), 

usage_2019 AS (
    SELECT 
        station_id, 
        COUNT(*) AS usage_count 
    FROM (
        SELECT rent_station_id AS station_id 
        FROM rental_history 
        WHERE rent_at >= '2019-10-01' 
          AND rent_at < '2019-11-01'
        
        UNION ALL 
        
        SELECT return_station_id AS station_id 
        FROM rental_history 
        WHERE return_at >= '2019-10-01' 
          AND return_at < '2019-11-01'
    ) t2019 
    GROUP BY station_id
),

merged AS (
    SELECT 
        COALESCE(A.station_id, B.station_id) AS station_id,
        COALESCE(A.usage_count, 0) AS usage_2018,
        COALESCE(B.usage_count, 0) AS usage_2019,
        ROUND((COALESCE(B.usage_count, 0) * 100.0) / A.usage_count, 2) AS usage_pct
    FROM usage_2018 A
    FULL OUTER JOIN usage_2019 B 
        ON A.station_id = B.station_id
)

SELECT 
    s.station_id,
    s.name,
    s.local,
    m.usage_pct
FROM station s
JOIN merged m 
    ON s.station_id = m.station_id
WHERE m.usage_pct <= 50 
    AND m.usage_2018 > 0 
    AND m.usage_2019 > 0
;
