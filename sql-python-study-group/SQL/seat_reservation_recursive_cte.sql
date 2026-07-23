-- 출처: CodeSignal Practice
-- 문제: 좌석 예약/구매 시스템 - request를 순서대로 적용해서 최종 seat 상태 구하기
-- 유형: 순차 상태 업데이트 (재귀 CTE 필요)
-- 배운 점: WITH RECURSIVE, CASE WHEN으로 조건부 업데이트, 상관 서브쿼리(correlated subquery)
-- 난이도: 어려움

CREATE PROCEDURE solution()
BEGIN
	WITH RECURSIVE seat_sim AS (
		SELECT 
			seat_no,
			status,
			person_id,
			0 AS last_request_id
		FROM seats

		UNION ALL

		SELECT
			s.seat_no,
			CASE WHEN s.status = 0 AND r.request = 1 THEN 1
				WHEN s.status = 0 AND r.request = 2 THEN 2
				WHEN s.status = 1 AND r.request = 2 AND s.person_id = r.person_id THEN 2
				ELSE s.status
			END AS status,
			CASE WHEN s.status = 0 AND r.request IN (1,2) THEN r.person_id
				ELSE s.person_id
			END AS person_id,
			r.request_id AS last_request_id
		FROM seat_sim s
		JOIN requests r 
			ON r.seat_no = s.seat_no
			AND r.request_id > s.last_request_id
		WHERE r.request_id = (
			SELECT MIN(r2.request_id)
			FROM requests r2
			WHERE r2.seat_no = s.seat_no
			  AND r2.request_id > s.last_request_id
		)
	)

	SELECT seat_no, status, person_id
	FROM seat_sim
	WHERE (seat_no, last_request_id) IN (
		SELECT seat_no, MAX(last_request_id)
		FROM seat_sim
		GROUP BY seat_no
	)
	ORDER BY seat_no;
END;
