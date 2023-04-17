-- 조인(JOIN)
-- 2개 이상의 테이블을 이용해서 쿼리문을 작성한다.


-- 1. 카테전 곱
-- 2개 테이블의 조인을 조건 없이 수행하는 것을 의미한다.
-- 2개 테이블의 모든 조합을 출력한다.
-- 조건식을 잘못 만들면 같은 결과를 볼 수 있다.
SELECT EMPLOYEE.*, DEPARTMENT.*
FROM EMPLOYEE, DEPARTMENT;


-- 2. 내부조인 (INNER JOIN)
-- 2개 테이블에 모두 존재하는 데이터를 조인하는 경우에 사용한다.
-- 콤마 구분법과 JOIN 문법이 있다.

-- 문제1. 모든 사원들의 EMP_NO, NAME, DEPT_NO, LOCATION 을 조회하시오.
-- 1) 콤마 구분법
SELECT E.EMP_NO, E.NAME, D.DEPT_NO, D.LOCATION
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPART = D.DEPT_NO;  -- 조인 조건

-- 2) JOIN 문법
SELECT E.EMP_NO, E.NAME, D.DEPT_NO, D.LOCATION
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DEPART = D.DEPT_NO;  -- 조인 조건


-- 문제2. DEPT_NAME 이 '총무부' 사원들의 평균연봉을 조회하시오.
-- 1)
SELECT AVG(E.SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPART = D.DEPT_NO  -- 조인 조건
AND D.DEPT_NAME = '총무부';  -- 일반 조건

-- 2)
SELECT AVG(E.SALARY)
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DEPART = D.DEPT_NO  -- 조인 조건
WHERE D.DEPT_NAME = '총무부';  -- 일반 조건


-- 문제3. 부서별로 그룹화하여 부서명(DEPT_NAME)과 평균연봉을 조회하시오.
-- 1)
SELECT D.DEPT_NAME, AVG(E.SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPART = D.DEPT_NO
GROUP BY D.DEPT_NAME;

-- 2)
SELECT D.DEPT_NAME, AVG(E.SALARY)
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DEPART = D.DEPT_NO
GROUP BY D.DEPT_NAME;

-- BANK, CUSTOMER 테이블을 활용하시오.
INSERT INTO BANK (BANK_CODE, BANK_NAME) VALUES ('100', '카카오');
INSERT INTO BANK (BANK_CODE, BANK_NAME) VALUES ('200', 'MG');
INSERT INTO BANK (BANK_CODE, BANK_NAME) VALUES ('300', 'NH');

INSERT INTO CUSTOMER (NO, NAME, PHONE, AGE, BANK_CODE) VALUES (1, '앨리스', '010-1111-1111', 25, '100');
INSERT INTO CUSTOMER (NO, NAME, PHONE, AGE, BANK_CODE) VALUES (2, '에밀리', '010-2222-1111', 25, '100');
INSERT INTO CUSTOMER (NO, NAME, PHONE, AGE, BANK_CODE) VALUES (3, '사만다', '010-3333-1111', 25, '200');
INSERT INTO CUSTOMER (NO, NAME, PHONE, AGE, BANK_CODE) VALUES (4, '라이언', '010-4444-1111', 25, '200');
INSERT INTO CUSTOMER (NO, NAME, PHONE, AGE, BANK_CODE) VALUES (5, '제임스', '010-5555-1111', 25, '300');

COMMIT;


-- 문제4. NAME, PHONE, BANK_NAME 을 조회하시오.
-- 1)
SELECT C.NAME, C.PHONE, B.BANK_NAME
FROM CUSTOMER C, BANK B
WHERE C.BANK_CODE = B.BANK_CODE;

-- 2)
SELECT C.NAME, C.PHONE, B.BANK_NAME
FROM CUSTOMER C INNER JOIN BANK B
ON C.BANK_CODE = B.BANK_CODE;


-- 3. 외부조인
-- 

-- EMPLOYEE 테이블에 사원 추가하기
INSERT INTO EMPLOYEE (EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
VALUES (1005, '김미나', 5, '사원', 'F', '18/05/05', 1800000);

COMMIT;

-- 위 사원을 추가하려면 외래키 제약조건을 제거 또는 비활성화 해야 한다.
ALTER TABLE EMPLOYEE DISABLE CONSTRAINT SYS_C007136;


-- 문제1. 모든 사원들의 EMP_NO, NAME, DEPT_NAME 을 조회하시오.
-- 단, 아직 부서가 없는 사원도 모두 조회하시오.
-- 모든 사원을 무조건 조회하시오.
-- 사원은 왼쪽 테이블이므로 왼쪽 외부 조인을 실시한다.

-- 1) 콤마(,) 구분법
--    왼쪽 외부 조인 : 조인 조건에서 오른쪽 테이블에 (+) 추가
--    오른쪽 외부 조인 : 조인 조건에서 왼쪽 테이블에 (+) 추가
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D  -- FROM 왼쪽테이블, 오른쪽테이블
WHERE E.DEPART = D.DEPT_NO(+);  -- 조인 조건

-- 2) JOIN 문법
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
FROM EMPLOYEE E LEFT OUTER JOIN DEPARTMENT D
ON E.DEPART = D.DEPT_NO;


-- EMPLOYEE 테이블과 DEPARTMENT 테이블의 순서만 바꿔서 다시 풀어보자.
-- 1) 
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
FROM DEPARTMENT D, EMPLOYEE E  -- FROM 왼쪽테이블, 오른쪽테이블
WHERE D.DEPT_NO(+) = E.DEPART;  -- 조인 조건

-- 2)
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
FROM DEPARTMENT D RIGHT OUTER JOIN EMPLOYEE E
ON D.DEPT_NO = E.DEPART;


-- 사원이 없는 부서를 만들고, 외래키 제약 조건도 복원하기 위해 두 데이터를 삭제한다.
DELETE FROM EMPLOYEE WHERE EMP_NO = 1004 OR EMP_NO = 1005;
DELETE FROM EMPLOYEE WHERE EMP_NO IN(1004, 1005);
COMMIT;


-- 문제2. 부서별로 그룹화하여 DEPT_NAME 과 평균연봉(SALARY)을 출력하시오.
-- 사원이 없는 부서는 평균연봉을 0으로 출력하시오.

-- 1)
SELECT D.DEPT_NAME, NVL(AVG(E.SALARY), 0)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPART(+) = D.DEPT_NO
GROUP BY D.DEPT_NAME;

-- 2)
SELECT D.DEPT_NAME, NVL(AVG(E.SALARY), 0)
FROM EMPLOYEE E RIGHT OUTER JOIN DEPARTMENT D
ON E.DEPART = D.DEPT_NO
GROUP BY D.DEPT_NAME;


-- 외래키 제약 조건을 활성화 시킨다.
ALTER TABLE EMPLOYEE ENABLE CONSTRAINT SYS_C007136;


-- 셀프 조인을 위해서 EMPLOYEE 테이블에 상사번호(MANAGER_NO) 칼럼을 추가한다.
ALTER TABLE EMPLOYEE ADD MANAGER_NO NUMBER;

-- 상사도 사원이다.
-- 상사번호는 사원번호 중 하나여야 한다.
-- 상사번호를 사원번호(기본키)를 참조하는 외래키로 만든다.
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_FK FOREIGN KEY (MANAGER_NO) REFERENCES EMPLOYEE (EMP_NO);


-- 사원번호(EMP_NO)가 1001 인 사원만 상사가 없고, 나머지 사원은 모두 1001 사원의 부하직원이다.
UPDATE EMPLOYEE SET MANAGER_NO = 1001 WHERE EMP_NO = 1002;
UPDATE EMPLOYEE SET MANAGER_NO = 1001 WHERE EMP_NO = 1003;
COMMIT;


-- 셀프조인
-- 하나의 테이블에서 2개 이상의 칼럼을 비교하여 조인하는 경우

-- 문제. 사원번호(EMP_NO), 사원명(NAME), 상사명(NAME) 을 조회하시오.
-- 사원테이블 : EMPLOYEE E  =>  사원번호(E.EMP_NO), 사원명(E.NAME)
-- 상사테이블 : EMPLOYEE M  =>  상사명(M.NAME)

-- 1) 콤마 구분법
SELECT E.EMP_NO, E.NAME AS 사원명, M.NAME AS 상사명
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_NO = M.EMP_NO;  -- 조인 조건 (사원들의 상사번호 = 상사들의 사원번호)

-- 2) JOIN 문법
SELECT E.EMP_NO, E.NAME AS 사원명, M.NAME AS 상사명
FROM EMPLOYEE E JOIN EMPLOYEE M
ON E.MANAGER_NO = M.EMP_NO;  -- 조인 조건 (사원들의 상사번호 = 상사들의 사원번호)
