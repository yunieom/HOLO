-- 41. 이름(FIRST_NAME) 이 'Curtis' 인 사람의 FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, JOB_ID 를 조회한다.
-- 단, JOB_ID 의 결과는 소문자로 조회되도록 한다.(LOWER 함수)
SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, LOWER(JOB_ID)
FROM EMPLOYEES
WHERE FIRST_NAME = 'Curtis';


-- 42. 부서(DEPARTMENT_ID) 가 60, 70, 80, 90 인 사원들의 EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID 를 조회한다.
-- 단, JOB_ID 가 'IT_PROG' 인 사원의 경우 '프로그래머'로 변경하여 조회한다.(REPLACE 함수)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, REPLACE(JOB_ID, 'IT_PROG', '프로그래머')
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(60, 70, 80, 90);

-- DECODE(칼럼, 조건1, 값1, 조건2, 값2, 조건3, 값3, 값4)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, DECODE(JOB_ID, 'IT_PROG', '프로그래머', 'SA_MAN', '판매매니저', '기타')
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(60, 70, 80, 90);


-- 번외. DECODE 문제
-- 직업(JOB_ID)별 평균연봉이 10000 이상이면 '고소득', 5000 이상이면 '중소득', 나머지는 '저소득' 으로 출력하시오.
SELECT JOB_ID, AVG(SALARY), DECODE(TRUNC(AVG(SALARY) / 5000), 4, '고소득',
                                                              3, '고소득',
                                                              2, '고소득',
                                                              1, '중소득', '저소득')
FROM EMPLOYEES
GROUP BY JOB_ID;


-- 43. 직업(JOB_ID) 이 'AD_PRES', 'PU_CLERK' 인 사원들의 EMPLOYEE_ID, 사원명(FULL_NAME), EMPLOYEE_ID, DEPARTMENT_ID, JOB_ID 를 조회한다.
-- 단, 사원명(FULL_NAME)은 FIRST_NAME 과 LAST_NAME 의 중간에 공백을 포함한 상태로 연결하여 조회한다.(CONCAT 함수)
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) AS FULL_NAME, EMPLOYEE_ID, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES;


-- 44. 성(LAST_NAME) 에 'u' 가 포함되는 사원들의 EMPLOYEE_ID, LAST_NAME 을 조회한다.(INSTR 함수)
-- INSTR(LAST_NAME, 'u') : LAST_NAME 에 'u' 가 몇 번째 글자인지 반환
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE INSTR(LAST_NAME, 'u') > 0;
-- WHERE LAST_NAME LIKE '%u%';


-- 45. 전화번호(PHONE_NUMBER)가 '650' 으로 시작하는 사원들의 LAST_NAME, PHONE_NUMBER 를 조회한다.(SUBSTR 함수)
SELECT LAST_NAME, PHONE_NUMBER
FROM EMPLOYEES
WHERE SUBSTR(TRIM(PHONE_NUMBER), 1, 3) = '650';


-- 46. 성(LAST_NAME) 의 네 번째 글자가 'a' 인 사원들의 LAST_NAME 을 조회한다.(SUBSTR 함수 또는 INSTR 함수)
SELECT LAST_NAME
FROM EMPLOYEES
WHERE SUBSTR(LAST_NAME, 4, 1) = 'a';

SELECT LAST_NAME
FROM EMPLOYEES
WHERE INSTR(LAST_NAME, 'a', 4, 1) = 4;


-- 47. 모든 사원의 연봉(SALARY) 평균을 소수 2자리까지 반올림하여 조회한다.(ROUND, AVG 함수)
SELECT ROUND(AVG(SALARY), 2)
FROM EMPLOYEES;


-- 48. 모든 사원의 연봉(SALARY) 총액을 '$500,000' 과 같은 형식으로 조회한다.(TO_CHAR, SUM 함수)
SELECT TO_CHAR(SUM(SALARY), '$999,999')
FROM EMPLOYEES;


-- 49. 성(LAST_NAME) 이 'McCain' 인 사원이 지금까지 근무한 근속일(SERVICE_DAYS)을 '4500일' 과 같은 형식으로 조회한다.(TRUNC, SYSDATE 함수)
SELECT TRUNC(SYSDATE - HIRE_DATE) || '일' AS SERVICE_DAYS
FROM EMPLOYEES
WHERE LAST_NAME = 'McCain';


-- 50. 성(LAST_NAME) 이 'McCain' 인 사원이 지금까지 근무한 근속일(SERVICE_DAYS)을 '120개월' 과 같은 형식으로 조회한다.(TRUNC, SYSDATE, MONTHS_BETWEEN 함수)
SELECT CONCAT(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)), '개월') AS SERVICE_DAYS
FROM EMPLOYEES
WHERE LAST_NAME = 'McCain';
