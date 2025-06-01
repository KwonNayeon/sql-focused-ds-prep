-- Day 5: NULL 처리 패턴
-- NULL은 예상치 못한 결과의 주범!

-- 패턴 1: 기본값 설정
SELECT 
    user_id,
    name,
    COALESCE(phone, 'No Phone') as phone_display,
    COALESCE(email, 'No Email') as email_display,
    COALESCE(age, 0) as age_display,
    ISNULL(last_login_date, '1900-01-01') as last_login_safe  -- SQL Server
FROM users;

-- 패턴 2: NULL 조건 체크
SELECT 
    user_id,
    name,
    CASE 
        WHEN phone IS NULL THEN 'Contact Info Missing'
        WHEN email IS NULL THEN 'Email Missing' 
        ELSE 'Complete Profile'
    END as profile_status,
    -- 주의: phone = NULL이 아니라 phone IS NULL!
    CASE WHEN phone IS NOT NULL AND LENGTH(phone) > 0 THEN 1 ELSE 0 END as has_valid_phone
FROM users;

-- 패턴 3: 집계에서 NULL 처리
SELECT 
    department,
    COUNT(*) as total_employees,
    COUNT(salary) as employees_with_salary,  -- NULL 제외하고 카운트
    AVG(salary) as avg_salary,              -- NULL 자동 제외
    AVG(COALESCE(salary, 0)) as avg_salary_with_zero,  -- NULL을 0으로 처리
    SUM(COALESCE(bonus, 0)) as total_bonus  -- NULL bonus를 0으로 처리
FROM employees
GROUP BY department;

-- 패턴 4: NULL 안전한 비교
SELECT 
    user_id,
    old_email,
    new_email,
    CASE 
        WHEN old_email IS NULL AND new_email IS NULL THEN 'Both NULL'
        WHEN old_email IS NULL THEN 'Added Email'
        WHEN new_email IS NULL THEN 'Removed Email'
        WHEN old_email = new_email THEN 'No Change'
        ELSE 'Email Changed'
    END as email_change_status,
    -- NULL 안전한 비교 (PostgreSQL)
    old_email IS DISTINCT FROM new_email as has_changed
FROM user_email_updates;

-- 패턴 5: 문자열 연결에서 NULL 처리
SELECT 
    user_id,
    first_name,
    last_name,
    -- 잘못된 방법: NULL이 하나라도 있으면 전체가 NULL
    first_name + ' ' + last_name as full_name_wrong,
    -- 올바른 방법
    COALESCE(first_name, '') + ' ' + COALESCE(last_name, '') as full_name_safe,
    CONCAT(first_name, ' ', last_name) as full_name_concat  -- MySQL/PostgreSQL
FROM users;

-- 💡 핵심: NULL은 "알 수 없는 값"이므로 모든 비교 결과가 NULL
-- 💡 집계 함수는 대부분 NULL을 자동으로 제외
-- 💡 COALESCE는 첫 번째 non-NULL 값 반환