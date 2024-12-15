-- 트러블슈팅 노트:
-- 1. 시간 오프셋 처리:
--    - CTE(`time`)에서 `end_at`은 원래 시간(`measured_at`)보다 10분 뒤의 시간으로 설정.
--    - `datetime()` 함수를 사용하여 `measured_at`에 '+10 minutes' 오프셋을 적용.
--    - 이로 인해 출력 시 계산이 `measured_at` 기준으로 처리되더라도 최종 출력은 `end_at` 기준으로 정렬 가능.
--    - 초기에는 이를 간과하여 `end_at`이 제대로 반영되지 않아 평균값이 시간상 밀려 보이는 문제가 발생.
--    - 해결: `ON A.measured_at = B.measured_at` JOIN 조건 및 시간 오프셋 정확히 처리.

-- 2. 이동 평균 계산:
--    - 각 Zone(예: `zone_quads`, `zone_smir`, `zone_boussafou`)의 이동 평균을 계산.
--    - `ROWS BETWEEN 5 PRECEDING AND CURRENT ROW`를 활용하여 현재 행과 이전 5개 행을 포함한 평균을 계산.
--    - 평균 계산 범위 및 순서: `ORDER BY A.measured_at` 기준으로 정렬.

-- 3. 성능 최적화:
--    - CTE에서 `measured_at`에 대한 필터링(`2017-01-01` ~ `2017-02-01`)을 사전에 처리.
--    - `LEFT JOIN`을 사용하여 누락된 데이터가 있어도 결과를 출력 가능하도록 설계.
--    - `ORDER BY A.end_at`으로 결과 정렬하여 가독성 확보.

-- 추가 개선 사항:
--    - Window Function에서 시간 데이터의 정렬 기준과 출력 기준(`measured_at` vs `end_at`)을 명확히 구분.
--    - `datetime()`으로 생성된 `end_at`이 계산된 평균값에 맞춰 올바르게 출력되도록 JOIN 및 정렬 구조 점검.

WITH time AS (
  SELECT datetime(measured_at, '+10 minutes') AS end_at,
         measured_at
  FROM power_consumptions
  WHERE measured_at >= '2017-01-01 00:00:00'
    AND measured_at <= '2017-02-01 00:00:00'
)
SELECT 
    A.end_at,
    ROUND(AVG(B.zone_quads) OVER (
        ORDER BY A.measured_at
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ), 2) AS zone_quads,
    ROUND(AVG(B.zone_smir) OVER (
        ORDER BY A.measured_at
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ), 2) AS zone_smir,
    ROUND(AVG(B.zone_boussafou) OVER (
        ORDER BY A.measured_at
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ), 2) AS zone_boussafou
FROM time A
LEFT JOIN power_consumptions B
  ON A.measured_at = B.measured_at
ORDER BY A.end_at;
