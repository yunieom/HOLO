-- ROWNUM
-- 행 번호를 가지고 있는 가상 칼럼이다.

-- ROWNUM 가상 칼럼의 특징을 확인한다. (HR 계정)
-- 1. EMPLOYEES 테이블에서 ROWNUM 칼럼을 확인한다.
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES;


-- ROWNUM 칼럼은 크기 비교용으로 사용할 수 없다.
-- 예외적으로 ROWNUM = 1 만 허용한다.
-- ROWNUM 값이 1이 포함되어 있으면 비교가 가능하다.


-- 2. ROWNUM 의 크기 비교(ROWNUM = 1) 가능 여부를 확인한다. (예외적으로 허용)
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE ROWNUM = 1;


-- 3. ROWNUM 의 크기 비교(ROWNUM = 2) 가능 여부를 확인한다. (원래 안 되는 작업)
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE ROWNUM = 2;


-- 4. ROWNUM 의 크기 비교(ROWNUM <= 5) 가능 여부를 확인한다. (크기 비교에 1이 포함되므로 허용)
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE ROWNUM <= 5;


-- 5. ROWNUM 의 크기 비교(ROWNUM >= 5) 가능 여부를 확인한다. (크기 비교에 1이 포함되지 않으므로 안 됨)
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE ROWNUM >= 5;


-- ROWNUM >= 5 작업이 가능하도록 작업을 진행한다.
-- 1. ROWNUM 을 실제 칼럼으로 변경한다. (칼럼에 별명을 부여하고, 그 별명을 사용하면 된다.)
-- 2. ROWNUM 을 실제 칼럼으로 변경하는 작업을 사용 전에 먼저 해야 한다.

-- ROWNUM 칼럼을 실제 칼럼 RN 으로 변경해서 다시 해 보자.
SELECT ROWNUM AS RN, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE RN >= 5;

-- 왜 안 될까?
-- 쿼리문의 실행순서는 다음과 같다.
-- 1. FROM EMPLOYEES
-- 2. WHERE RN >= 5  (RN 이 EMPLOYEES 테이블에 없기 때문에(별명이라는 것을 아직 모름) 오류가 발생한다.)
-- 3. SELECT ROWNUM AS RN, EMPLOYEE_ID, LAST_NAME

-- 해결책 : RN 을 WHERE 보다 먼저 만들면 된다. 방법은 서브쿼리 뿐이다.
-- 1. FROM (SELECT ROWNUM AS RN, EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES) E
-- 2. WHERE E.RN >= 5
-- 3. SELECT E.RN, E.EMPLOYEE_ID, E.LAST_NAME

SELECT E.RN, E.EMPLOYEE_ID, E.LAST_NAME
FROM (SELECT ROWNUM AS RN, EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES) E
WHERE E.RN >= 5;


-- 문제1. 연봉을 기준으로 TOP 5 (가장 높은 연봉 5명) 를 조회하자.
-- 1) 연봉을 내림차순 정렬을 한다. (높은 연봉이 위로 올라온다.) : 정렬을 먼저 하려면 서브쿼리 뿐이다.
-- 2) ROWNUM 1 ~ 5 범위를 조회한다.

-- 실행순서
-- 1. FROM (SELECT LAST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) E
-- 2. WHERE ROWNUM <= 5   (ROWNUM 크기 비교가 1을 포함하므로 가능하다.)
-- 3. SELECT E.LAST_NAME, E.SALARY
SELECT E.LAST_NAME, E.SALARY
FROM (SELECT LAST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;


-- 문제2. 연봉을 기준으로 TOP 2 ~ 10 (TOP 1만 제외) 를 조회하자.
-- 실행순서
-- 1. 정렬  (SELECT LAST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) E1)
-- 2. RN   FROM (SELECT ROWNUM AS RN, E1.LAST_NAME, E1.SALARY
--               FROM (SELECT LAST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) E1) E2
-- 3. WHERE E2.RN BETWEEN 2 AND 10
-- 4. SELECT E2.RN, E2.LAST_NAME, E2.SALARY

SELECT E2.RN, E2.LAST_NAME, E2.SALARY
FROM (SELECT ROWNUM AS RN, E1.LAST_NAME, E1.SALARY
      FROM (SELECT LAST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC) E1) E2
WHERE E2.RN BETWEEN 2 AND 10;



-- 1. 게시글을 저장할 수 있는 게시판(BOARD) 테이블을 생성한다.
--    1) NO : 게시글 번호, NUMBER, 기본키
--    2) WRITER : 작성자, VARCHAR2(50), 필수
--    3) TITLE : 제목, VARCHAR2(100), 필수
--    4) CONTENT : 내용, VARCHAR2(2000)
--    5) HIT : 조회수, NUMBER
--    6) REGDATE : 작성일, DATE, 현재날짜 자동삽입
CREATE TABLE BOARD (
    NO NUMBER PRIMARY KEY,
    WRITER VARCHAR2(50) NOT NULL,
    TITLE VARCHAR2(100) NOT NULL,
    CONTENT VARCHAR2(2000),
    HIT NUMBER,
    REGDATE DATE DEFAULT SYSDATE
);

DROP TABLE BOARD;

-- 2. 게시글 번호를 자동으로 부여하기 위해 BOARD_SEQ 시퀀스를 생성한다.
-- 1) 1~999999 까지 사용할 수 있다.
-- 2) 게시글 번호는 자동으로 1씩 증가되며 부여된다.
-- 3) 999999 까지 번호가 사용되더라도 초기화 되지 않는다.
-- 4) 캐시는 사용하지 않는다.
CREATE SEQUENCE BOARD_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCYCLE
NOCACHE;

-- 3. BOARD_SEQ 시퀀스를 이용하여 임의의 데이터를 5개만 생성한다.
INSERT INTO BOARD (NO, WRITER, TITLE, CONTENT, HIT) VALUES (BOARD_SEQ.NEXTVAL, '박나래', '2019연예대상', '대상을축하합니다.', 15);
INSERT INTO BOARD (NO, WRITER, TITLE, CONTENT, HIT) VALUES (BOARD_SEQ.NEXTVAL, '이영자', '2018연예대상', '대상을축하합니다.', 5);
INSERT INTO BOARD (NO, WRITER, TITLE, CONTENT, HIT) VALUES (BOARD_SEQ.NEXTVAL, '전현무', '2017연예대상', '대상을축하합니다.', 1);
INSERT INTO BOARD (NO, WRITER, TITLE, CONTENT, HIT) VALUES (BOARD_SEQ.NEXTVAL, '유재석', '2016연예대상', '대상을축하합니다.', 55);
INSERT INTO BOARD (NO, WRITER, TITLE, CONTENT, HIT) VALUES (BOARD_SEQ.NEXTVAL, '김구라', '2015연예대상', '대상을축하합니다.', 85);
COMMIT;


-- 4. 조회수가 높은 3개의 게시글을 조회한다.
SELECT B.TITLE, B.HIT
FROM (SELECT TITLE, HIT FROM BOARD ORDER BY HIT DESC) B
WHERE ROWNUM <= 3;


-- 5. 조회수 순으로 게시글에서 3 ~ 5 번째 게시글을 조회한다.
SELECT B2.*
FROM (SELECT ROWNUM AS RN, B1.*
      FROM (SELECT *
            FROM BOARD
            ORDER BY HIT DESC) B1) B2
WHERE B2.RN BETWEEN 3 AND 5;
