## 과제 3 Join

- 1. 사원들의 이름, 부서번호, 부서명 조회

```sql
SELECT e.FIRST_NAME as "이름", e.DEPARTMENT_ID as "부서번호", d.DEPT_NAME as "부서명"
FROM employees e
JOIN dept d
ON e.DEPARTMENT_ID = d.DEPT_ID;
```

- 2. 각 부서별로 2000년 이전(~1999년)에 입사한 직원의 수 조회

```sql
SELECT
    d.DEPT_NAME AS "부서명",
    COUNT(e.DEPARTMENT_ID) AS "인원수"
FROM dept d
JOIN employees e ON e.DEPARTMENT_ID = d.DEPT_ID
WHERE e.HIRE_DATE < '2000-01-01'
GROUP BY d.DEPT_NAME;
```

- 3. 60번 IT 부서의 사원들의 이름, 직업, 부서명 조회

```sql
SELECT e.FIRST_NAME as '이름', j.JOB_TITLE as '직업', d.DEPT_NAME as '부서명'
FROM employees e
JOIN jobs j ON e.JOB_ID = j.JOB_ID
JOIN dept d ON e.DEPARTMENT_ID = d.DEPT_ID
WHERE d.DEPT_ID = 60;
```

- 4. employee, department, location를 조인하여 각 직원이 어느 부서에 속하는지와 부서의 소재지 조회 - 부서명 오름차순

```sql
SELECT
  e.EMPLOYEE_ID AS '사원번호',
  e.DEPARTMENT_ID AS '부서번호',
  d.DEPT_NAME AS '부서명',
  l.CITY AS '소재지'
FROM employees e
JOIN dept d ON e.DEPARTMENT_ID = d.DEPT_ID
JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
ORDER BY d.DEPT_NAME, e.EMPLOYEE_ID;
```

- 5. 부서별 근무하는 인원 수를 조회 (단, 사원이 없는 부서명도 나타냄) - 부서명 오름차순

```sql
SELECT d.DEPT_NAME AS "부서명", COUNT(e.DEPARTMENT_ID) AS "사원수"
FROM dept d
LEFT JOIN employees e ON e.DEPARTMENT_ID = d.DEPT_ID
GROUP BY d.DEPT_NAME
ORDER BY d.DEPT_NAME;
```

- 6. 사원별 담당 매니저 조회 (단, 하나의 열에 매니저의 이름 전체가 출력)

```sql
SELECT
  e.EMPLOYEE_ID AS '사원번호',
  CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS '사원명',
  m.EMPLOYEE_ID AS '매니저 번호',
  CONCAT(m.FIRST_NAME, ' ', m.LAST_NAME) AS '매니저 이름'
FROM employees e
LEFT JOIN employees m ON e.MANAGER_ID = m.EMPLOYEE_ID
WHERE e.MANAGER_ID IS NOT NULL;
```

- 7. 부서별 평균 급여가 7000 이상인 부서를 조회 (단, 소수 이하 자리 반올림하여 나타냄) - 평균 급여가 높은 순

```sql
SELECT d.DEPT_NAME AS 부서명,
    CASE
        WHEN COUNT(*) = 1 THEN MAX(e.SALARY)
        ELSE ROUND(AVG(e.SALARY), 0)
    END AS 평균연봉

FROM EMPLOYEES e

INNER JOIN dept d
ON e.DEPARTMENT_ID = d.DEPT_ID

WHERE e.SALARY >= 7000

GROUP BY d.DEPT_NAME
ORDER BY 평균연봉 DESC;
```

## 과제 4-1 서브쿼리

- 1. employees 테이블의 last_name이 'De Haan'인 직원과 같은 월급을 받는 직원을 조회

```sql
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employees e
WHERE SALARY = (
    SELECT SALARY
    FROM employees
    WHERE LAST_NAME = 'De Haan'
);
```

- 2. employees 테이블의 last_name이 'Taylor'인 직원과 같은 월급을 받는 직원을 조회

```sql
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employees e
WHERE SALARY IN (
SELECT SALARY
FROM employees
WHERE LAST_NAME = 'TAYLOR'
);
```

- 3. employees 테이블의 department_id별로 가장 낮은 salary가 얼마인지 찾아보고, 찾아낸 salary에 해당하는 직원을 salary가 높은 순으로 조회

```sql
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY
FROM employees e
WHERE e.SALARY IN (
SELECT MIN(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID
)
ORDER BY e.SALARY DESC;
```

- 4. employees 테이블의 job_id별로 가장 낮은 salary가 얼마인지 찾아보고, 찾아낸 job_id별 salary에 해당하는 직원을 salary가 높은 순으로 조회 (job_id와 salary 모두 일치하는 직원 찾기 - 다중 열 서브쿼리)

```sql
SELECT e.JOB_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY
FROM employees e
WHERE (e.JOB_ID, e.SALARY) IN (
SELECT JOB_ID, MIN(SALARY)
FROM employees
GROUP BY JOB_ID
)
ORDER BY e.SALARY DESC;
```

- 5. employees 테이블에서 manager가 아닌 직원을 조회 (null 처리에 유의)

```sql
SELECT e.EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM employees e
WHERE e.EMPLOYEE_ID NOT IN (
SELECT MANAGER_ID
FROM employees
WHERE MANAGER_ID IS NOT NULL
);
```

- 6. dept 테이블에 있는 dept_id 중에 employees에도 존재하는 부서를 조회

```sql
SELECT DISTINCT d.DEPT_ID, d.DEPT_NAME
FROM employees e
JOIN dept d ON e.DEPARTMENT_ID = d.DEPT_ID
WHERE e.DEPARTMENT_ID IN (
SELECT DISTINCT DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
);
```

- 7. jobs 테이블에서 job_title이 ‘개발자’인 부서보다 평균 월급이 더 큰 부서를 조회 (3중 쿼리 사용)

```sql
SELECT t1.job_title, t1.`평균 월급`
FROM (
SELECT j.JOB_TITLE AS job_title, TRUNCATE(AVG(e.SALARY), 0) AS `평균 월급`
FROM employees e
JOIN jobs j ON e.JOB_ID = j.JOB_ID
GROUP BY j.JOB_TITLE
) t1
WHERE t1.`평균 월급` > (
SELECT TRUNCATE(AVG(e.SALARY), 0) AS `개발자 평균 월급`
FROM employees e
JOIN jobs j ON e.JOB_ID = j.JOB_ID
WHERE j.JOB_TITLE = '개발자'
);
```
