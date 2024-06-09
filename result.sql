1. employees 테이블의 last_name이 'De Haan'인 직원과 같은 월급을 받는 직원을 조회

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employees e
WHERE SALARY = (
    SELECT SALARY
    FROM employees
    WHERE LAST_NAME = 'De Haan'
);

2. employees 테이블의 last_name이 'Taylor'인 직원과 같은 월급을 받는 직원을 조회

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employees e
WHERE SALARY IN (
    SELECT SALARY
    FROM employees
    WHERE LAST_NAME = 'TAYLOR'
);

3. employees 테이블의 department_id별로 가장 낮은 salary가 얼마인지 찾아보고, 찾아낸 salary에 해당하는 직원을 salary가 높은 순으로 조회

SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY
FROM employees e
WHERE e.SALARY IN (
SELECT MIN(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID
)
ORDER BY e.SALARY DESC;

4. employees 테이블의 job_id별로 가장 낮은 salary가 얼마인지 찾아보고, 찾아낸 job_id별 salary에 해당하는 직원을 salary가 높은 순으로 조회 (job_id와 salary 모두 일치하는 직원 찾기 - 다중 열 서브쿼리)

SELECT e.JOB_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY
FROM employees e
WHERE (e.JOB_ID, e.SALARY) IN (
    SELECT JOB_ID, MIN(SALARY)
    FROM employees
    GROUP BY JOB_ID
)
ORDER BY e.SALARY DESC;

5. employees 테이블에서 manager가 아닌 직원을 조회 (null 처리에 유의)

SELECT e.EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM employees e
WHERE e.EMPLOYEE_ID NOT IN (
    SELECT MANAGER_ID
    FROM employees
    WHERE MANAGER_ID IS NOT NULL
);

6. dept 테이블에 있는 dept_id 중에 employees에도 존재하는 부서를 조회

SELECT DISTINCT d.DEPT_ID, d.DEPT_NAME
FROM employees e
JOIN dept d ON e.DEPARTMENT_ID = d.DEPT_ID
WHERE e.DEPARTMENT_ID IN (
  SELECT DISTINCT DEPARTMENT_ID 
  FROM employees 
  WHERE DEPARTMENT_ID IS NOT NULL
);

7. jobs 테이블에서 job_title이 ‘개발자’인 부서보다 평균 월급이 더 큰 부서를 조회 (3중 쿼리 사용)

SELECT t.JOB_TITLE, t.평균 월급
FROM (
  SELECT j.JOB_TITLE AS job_title, TRUNCATE(AVG(e.SALARY), 0) AS 평균 월급
  FROM employees e
  JOIN jobs j ON e.JOB_ID = j.JOB_ID
  GROUP BY j.JOB_TITLE
) t
WHERE t.평균 월급 > (
  SELECT TRUNCATE(AVG(e.SALARY), 0) AS 개발자 평균 월급
  FROM employees e
  JOIN jobs j ON e.JOB_ID = j.JOB_ID
  WHERE j.JOB_TITLE = '개발자'
);