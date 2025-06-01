# SQL Patterns Collection

실무에서 자주 사용하는 SQL 패턴들을 정리한 개인 레퍼런스

## Week 1: Essential Patterns (완료)

### Day 1-7: 기본 필수 패턴
- [x] `day1_zero_division.sql` - 0으로 나누기 방지 패턴
- [x] `day2_join_patterns.sql` - JOIN 선택 가이드 (LEFT vs INNER)
- [x] `day3_conditional_aggregation.sql` - 조건부 집계 패턴
- [x] `day4_window_functions.sql` - 윈도우 함수 기본 패턴
- [x] `day5_null_handling.sql` - NULL 처리 패턴
- [x] `day6_date_patterns.sql` - 날짜 처리 패턴
- [x] `day7_cte_patterns.sql` - CTE 활용 패턴

## Future Patterns (나중에 추가할 것들)

### Week 2: Performance & Optimization
- [ ] **UNION vs UNION ALL** - 중복 처리와 성능 고려사항
- [ ] **EXISTS vs IN vs JOIN** - 조건 필터링 최적화
- [ ] **Index-friendly patterns** - 인덱스 활용을 위한 쿼리 작성법
- [ ] **DISTINCT vs GROUP BY** - 중복 제거 방법 선택
- [ ] **Subquery vs CTE vs JOIN** - 성능 관점에서의 선택

### Week 3: Advanced Analysis
- [ ] **Dynamic PIVOT/UNPIVOT** - 행↔열 변환 패턴
- [ ] **Running calculations** - 누적합, 이동평균, 증감률
- [ ] **Percentile & Quartile** - 분위수 계산 패턴
- [ ] **Time series gaps** - 시계열 데이터 빈 구간 처리
- [ ] **Hierarchical queries** - 트리 구조 데이터 처리

### Week 4: Real-world Scenarios
- [ ] **Data quality checks** - 데이터 검증 패턴
- [ ] **Slowly changing dimensions** - 이력 데이터 관리
- [ ] **Cohort analysis** - 코호트 분석 패턴
- [ ] **A/B testing analysis** - 실험 결과 분석
- [ ] **Funnel analysis** - 전환율 분석 패턴

### Week 5: Database-specific
- [ ] **PostgreSQL specific** - 배열, JSON, 정규식 등
- [ ] **MySQL specific** - 특화 함수들
- [ ] **SQL Server specific** - T-SQL 패턴들
- [ ] **BigQuery specific** - 클라우드 환경 최적화

## 사용법

1. **하루에 하나씩** 패턴 파일 읽기
2. **실제 프로젝트에 적용**해보기
3. **변형해서 사용**하면서 익숙해지기

## 목표

- 일주일에 **7개 패턴 완전 습득**
- 실무에서 **즉시 활용 가능한 수준**으로
- **버그 없는 안전한 쿼리** 작성 능력 향상

---

> 💡 **Tip**: 각 패턴의 "언제 사용하는지"와 "주의할 점"을 특히 주의깊게 읽기