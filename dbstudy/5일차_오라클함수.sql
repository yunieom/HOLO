-- 오라클 함수
-- 함수 결과 확인이 가능한 쿼리문은 SELECT 문이다.
-- SELECT 문은 반드시 테이블이 필요하다.
-- 오라클은 DUAL 이라고 하는 의미 없는 테이블을 제공한다.

-- DUAL 테이블의 구조 확인
DESC DUAL;


-- 문자열 함수

-- 1. 대소문자 처리 함수
SELECT INITCAP('appLE') FROM DUAL;  -- Apple
SELECT UPPER('appLE') FROM DUAL;  -- APPLE
SELECT LOWER('appLE') FROM DUAL;  -- apple


-- 2. 문자열의 일부를 분리
-- SUBSTR('문자열', 시작위치, [갯수]) : 시작위치부터 지정한 갯수만큼 분리 (갯수를 생략하면 끝까지 분리)
SELECT SUBSTR('991212-1234567', 1, 2) FROM DUAL;  -- 99, 1번째 글자부터 2글자를 가져온다.
SELECT SUBSTR('991212-1234567', 8) FROM DUAL;  -- 1234567, 8번째 글자부터 끝까지 가져온다.
SELECT SUBSTR('991212-1234567', -7) FROM DUAL;  -- 1234567, 뒤에서 7번째 글자부터 끝까지 가져온다.


-- 3. 문자열 연결
-- CONCAT('문자열1', '문자열2') : 문자열1 과 문자열2 를 연결한다.
-- CONCAT('문자열1', '문자열2', '문자열3') : 문자열 3개 연결은 지원하지 않는다.
-- CONCAT('문자열1', CONCAT('문자열2', '문자열3')) : 문자열 3개를 연결하는 방법이다.

SELECT CONCAT('김밥에', '라면') FROM DUAL;
SELECT CONCAT('떡볶이', CONCAT('순대', '튀김')) FROM DUAL;

-- 같은 역할을 수행하는 오라클 연산자 (||) 도 있다.

SELECT '김밥에' || '라면' FROM DUAL;
SELECT '떡볶이' || '순대' || '튀김' FROM DUAL;


-- 4. 특정 문자열의 위치를 반환
-- INSTR('문자열', '찾을문자열') : 찾을문자열이 몇 번째 글자인지 최초 발견된 위치를 반환한다.
-- INSTR('문자열', '찾을문자열', 시작, N) : 찾을문자열을 시작위치부터 찾는다. N번째로 발견되는 찾을문자열의 위치를 반환한다.

SELECT INSTR('APPLE', 'P') FROM DUAL;  -- 2 (첫 P의 위치)

SELECT INSTR('SQLSESSION', 'S', 1, 1) FROM DUAL;  -- 1 (1번째 글자부터 찾는다. 1번째로 발견되는 'S'의 위치를 반환한다.)
SELECT INSTR('SQLSESSION', 'S', 1, 2) FROM DUAL;  -- 4 (1번째 글자부터 찾는다. 2번째로 발견되는 'S'의 위치를 반환한다.)
SELECT INSTR('SQLSESSION', 'S', 1, 3) FROM DUAL;  -- 6 (1번째 글자부터 찾는다. 3번째로 발견되는 'S'의 위치를 반환한다.)
SELECT INSTR('SQLSESSION', 'S', 1, 4) FROM DUAL;  -- 7 (1번째 글자부터 찾는다. 4번째로 발견되는 'S'의 위치를 반환한다.)

SELECT INSTR('SQLSESSION', 'S', 4, 1) FROM DUAL;


-- 5. 문자열의 길이를 반환
SELECT LENGTH('떡볶이') FROM DUAL;  -- 3


-- 6. 문자열 앞뒤 공백 제거
-- 1) LTRIM('문자열') : 왼쪽 문자열의 공백 제거
-- 2) RTRIM('문자열') : 오른쪽 문자열의 공백 제거
-- 3) TRIM('문자열') : 양쪽 문자열의 공백 제거

SELECT LENGTH('     떡볶이') FROM DUAL;  -- 8
SELECT LENGTH(LTRIM('     떡볶이')) FROM DUAL;  -- 3


-- 7. 문자열에 특정 문자 채우기
-- 1) LPAD('문자열', 결과길이, '채울문자') : 문자열의 왼쪽에 채울문자를 채운다. 결과길이에 맞춰서 채운다.
-- 2) RPAD('문자열', 결과길이, '채울문자') : 문자열의 오른쪽에 채울문자를 채운다. 결과길이에 맞춰서 채운다.
-- '채울문자'를 생략하면 공백을 채운다.


-- 공백으로 채우는 경우 LPAD는 오른쪽 정렬, RPAD는 왼쪽 정렬이 된다.
SELECT LPAD('가', 10) FROM DUAL;
SELECT LPAD('가나', 10) FROM DUAL;
SELECT LPAD('가나다', 10) FROM DUAL;
SELECT LPAD('가나다라', 10) FROM DUAL;
SELECT LPAD('가나다라마', 10) FROM DUAL;

SELECT RPAD('991212-1', 14, '*') FROM DUAL;  -- 991212-1******


-- 문제1. 공백으로 분리된 이름을 성/이름 분리하기.
-- JAMES BOND : JAMES, BOND
-- SUBSTR, INSTR 함수
SELECT INSTR('JAMES BOND', ' ') FROM DUAL;  -- 공백의 위치 : INSTR('JAMES BOND', ' ')
-- 성 : JAMES  처음부터 공백 전까지 분리
-- 이름 : BOND  공백 다음부터 끝까지 분리
SELECT SUBSTR('JAMES BOND', 1, INSTR('JAMES BOND', ' ') - 1) FROM DUAL;
SELECT SUBSTR('JAMES BOND', INSTR('JAMES BOND', ' ') + 1) FROM DUAL;


-- 문제2. 이메일에서 아이디/도메인 분리하기.
-- ADMIN@GMAIL.COM : ADMIN, GMAIL.COM
-- SUBSTR, INSTR 함수
SELECT SUBSTR('ADMIN@GMAIL.COM', 1, INSTR('ADMIN@GMAIL.COM', '@') - 1) FROM DUAL;
SELECT SUBSTR('ADMIN@GMAIL.COM', INSTR('ADMIN@GMAIL.COM', '@') + 1) FROM DUAL;


-- 문제3. 아이디 보안 처리하기
-- ADMIN : A****
-- USERID : U*****
-- ABC : A**
-- SUBSTR, LENGTH, RPAD 함수

SELECT SUBSTR('ADMIN', 1, 1) FROM DUAL;  -- 아이디 첫 번째 글자 : SUBSTR('ADMIN', 1, 1)
SELECT LENGTH('ADMIN') FROM DUAL;  -- 아이디의 글자 수 : LENGTH('ADMIN')
-- SELECT RPAD(아이디 첫 번째 글자, 아이디 길이, *) FROM DUAL;
SELECT RPAD(SUBSTR('ADMIN', 1, 1), LENGTH('ADMIN'), '*') FROM DUAL;

-- EMPLOYEES 테이블의 LAST_NAME 을 기준으로 문제3. 을 적용해 보자.
SELECT RPAD(SUBSTR(LAST_NAME, 1, 2), LENGTH(LAST_NAME), '*') FROM EMPLOYEES;




-- 숫자 함수

-- 1. 반올림
SELECT ROUND(123.4567, 2) FROM DUAL;  -- 123.46 (소수 2자리 남김)
SELECT ROUND(123.4567, 1) FROM DUAL;  -- 123.5 (소수 1자리 남김)
SELECT ROUND(123.4567) FROM DUAL;  -- 123 (정수)
SELECT ROUND(123.4567, -1) FROM DUAL;  -- 120 (일의 자리에서 반올림)
SELECT ROUND(123.4567, -2) FROM DUAL;  -- 100 (십의 자리에서 반올림)


-- 2. 올림
SELECT CEIL(123.4567 * 100) / 100 FROM DUAL;  -- 123.46 (소수 2자리 올림)
SELECT CEIL(123.4567 * 10) / 10 FROM DUAL;  -- 123.5 (소수 1자리 올림)
SELECT CEIL(123.4567) FROM DUAL;  --124 (정수로 올림)
SELECT CEIL(123.4567 / 10) * 10 FROM DUAL;  -- 130 (일의 자리에서 올림)
SELECT CEIL(123.4567 / 100) * 100 FROM DUAL;  -- 200 (십의 자리에서 올림)


-- 3. 내림
SELECT FLOOR(123.9999 * 100) / 100 FROM DUAL;  -- 123.99 (소수 2자리 내림)
SELECT FLOOR(123.9999 * 10) / 10 FROM DUAL;  -- 123.9 (소수 1자리 내림)
SELECT FLOOR(123.9999) FROM DUAL;  -- 123 (정수로 내림)
SELECT FLOOR(123.9999 / 10) * 10 FROM DUAL;  -- 120 (일의 자리에서 내림)
SELECT FLOOR(123.9999 / 100) * 100 FROM DUAL;  -- 100 (십의 자리에서 내림)


-- 4. 절사 (자르기, 내림과 같은 개념)
SELECT TRUNC(123.4567, 2) FROM DUAL;  -- 123.45 (소수 2자리 절사)
SELECT TRUNC(123.4567, 1) FROM DUAL;  -- 123.4 (소수 1자리 절사)
SELECT TRUNC(123.4567) FROM DUAL;  -- 123 (정수)
SELECT TRUNC(123.4567, -1) FROM DUAL;  -- 120 (일의 자리에서 절사)
SELECT TRUNC(123.4567, -2) FROM DUAL;  -- 100 (십의 자리에서 절사)


-- 5. 집계 함수
-- 예제 테이블로 연습합니다.
CREATE TABLE SAMPLE (SCORE NUMBER);
INSERT INTO SAMPLE VALUES (66);
INSERT INTO SAMPLE VALUES (25);
INSERT INTO SAMPLE VALUES (100);
INSERT INTO SAMPLE VALUES (94);
INSERT INTO SAMPLE VALUES (30);
COMMIT;

SELECT SUM(SCORE) FROM SAMPLE;  -- 합계
SELECT ROUND(AVG(SCORE), 2) FROM SAMPLE;  -- 평균, 소수 2자리 반올림
SELECT MAX(SCORE) FROM SAMPLE;  -- 최대
SELECT MIN(SCORE) FROM SAMPLE;  -- 최소
SELECT COUNT(SCORE) FROM SAMPLE;  -- SCORE의 개수
SELECT COUNT(*) FROM SAMPLE;  -- SAMPLE 테이블의 데이터 개수

DROP TABLE SAMPLE;


-- 날짜 함수

-- 1. 현재 날짜
SELECT SYSDATE FROM DUAL;  -- 현재 날짜 : SYSDATE



-- 형 변환 함수

-- 1. 문자열로 변환
SELECT TO_CHAR(100) FROM DUAL;  -- '100'
SELECT TO_CHAR(100, '999999') FROM DUAL;  -- '   100' (100 앞에 공백 3개, 9는 숫자 한 자리를 의미한다.)
SELECT TO_CHAR(100, '000000') FROM DUAL;  -- '000100' (0은 숫자 한 자리이고, 불필요한 공간에 0을 채운다.)
SELECT TO_CHAR(100, '99') FROM DUAL;  -- ### (값보다 9(또는 0)이 부족하면 안 된다.)

SELECT TO_CHAR(12345, '99,999') FROM DUAL;  -- 12,345

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY HH:MI:SS') FROM DUAL;  -- 2020/07/01 수요일 08:29:30
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY HH12:MI:SS') FROM DUAL;  -- 2020/07/01 수요일 08:29:30
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY HH24:MI:SS') FROM DUAL;  -- 2020/07/01 수요일 20:29:30


-- 2. 날짜로 변환
SELECT SYSDATE - '2020/06/30' FROM DUAL;  -- 1.XX 을 기대하였으나 연산 불가 (날짜와 문자열은 연산이 안 된다.)
SELECT SYSDATE - TO_DATE('2020/06/30', 'YYYY/MM/DD') FROM DUAL;
SELECT SYSDATE - TO_DATE('2020/06/30', 'YYYY/MM/DD DAY HH:MM:SS') FROM DUAL;  -- TO_DATE 는 날짜와 형식이 일치해야 한다.
SELECT SYSDATE - TO_DATE('20/06/19', 'DD/MM/YY') FROM DUAL;

