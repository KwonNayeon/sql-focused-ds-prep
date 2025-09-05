-- ============================================================
-- [트러블슈팅 노트] Well Paid Employees
-- Filename: well_paid_employees.sql
-- 
-- [1] 목표:
--   - 자신의 직속 상사보다 급여를 많이 받는
--   - 직원들의 ID와 이름 추출
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - 직원과 매니저의 급여 비교 방법을 파악하지 못함
--      - JOIN의 필요성을 인지하지 못한 상태
--      - 힌트를 통해 INNER JOIN 활용이 필요함을 확인
--      
--   2. INNER JOIN 학습과 적용:
--      - 같은 테이블을 두 번 사용하는 Self Join 개념 학습
--      - 직원-매니저 관계를 매핑하는 방법 이해
--      - employee 테이블을 e1(직원), e2(매니저)로 구분하여 조인
--
-- [3] 학습 포인트:
--   - Self Join의 기본 개념 습득:
--     * 하나의 테이블을 두 개의 역할로 활용 가능
--     * 별칭(alias)을 통한 테이블 구분의 중요성
--   - JOIN 활용의 실제 사례 학습:
--     * 계층 구조(직원-매니저)를 다루는 방법
--     * 데이터 비교를 위한 테이블 연결 기법
-- ============================================================

select
  e1.employee_id,
  e1.name as employee_name
from employee as e1
inner join employee as e2
  on e1.manager_id = e2.employee_id
where e1.salary >= e2.salary
;
