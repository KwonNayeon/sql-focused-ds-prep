CREATE PROCEDURE solution()
BEGIN
	WITH RECURSIVE seat_sim AS (
		-- 1) 초기 상태 (Anchor)
		-- seats 테이블의 원래 상태를 그대로 가져오되,
		-- "다음에 적용할 request_id"가 뭔지 추적할 컬럼도 필요함
		SELECT 
			seat_no,
			status,
			person_id,
			0 AS last_request_id  -- 아직 아무 request도 적용 안 한 상태
		FROM seats

		UNION ALL

		-- 2) 재귀 부분 (Recursive)
		-- 이전 단계(seat_sim)의 상태에, 
		-- 그 좌석에 대한 "다음 순서의 request" 하나를 적용
		SELECT
			-- seat_no는 그대로
			-- status는: 조건에 따라 바뀌거나 그대로
			-- person_id도 마찬가지
			-- last_request_id는 이번에 적용한 r.request_id로 갱신
			s.seat_no,
			case when s.status = 0 and r.request = 1 then 1
				when s.status = 0 and r.request = 2 then 2
				when s.status = 1 and r.request = 2 and s.person_id = r.person_id then 2
				else s.status
			end as status,
			case when s.status = 0 and r.request in (1,2) then r.person_id
				else s.person_id
			end as person_id,
			r.request_id as last_request_id
		FROM seat_sim s
		JOIN requests r 
			ON r.seat_no = s.seat_no
			AND r.request_id > s.last_request_id   -- 다음 순서의 request만
		WHERE r.request_id = (
			select min(r2.request_id)
			from requests r2
			WHERE r2.seat_no = s.seat_no
      		AND r2.request_id > s.last_request_id
		)
	)

	-- 3) 최종적으로, 각 seat_no별로 "가장 마지막에 적용된 상태"만 골라내기
	SELECT seat_no, status, person_id
	FROM seat_sim
	WHERE (seat_no, last_request_id) IN (
		SELECT seat_no, MAX(last_request_id)
		FROM seat_sim
		GROUP BY seat_no
	)
	ORDER BY seat_no;
END;
