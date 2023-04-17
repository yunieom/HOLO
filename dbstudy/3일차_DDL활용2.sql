-- 데이터 사전
-- 1. 사용자 정보 : DBA_USERS 테이블
-- 2. 테이블 정보 : TAB 테이블
-- 3. 제약조건 정보 : USER_CONSTRAINTS 테이블


-- USER_CONSTRAINTS 테이블 구조 확인
DESC USER_CONSTRAINTS;

-- 테이블 조회 쿼리문
-- SELECT 칼럼들 FROM 테이블 [WHERE 조건식]

SELECT CONSTRAINT_NAME, TABLE_NAME FROM USER_CONSTRAINTS;

-- 테이블명이 소문자로 작성되면 비교되지 않는다. (테이블명은 대문자로 저장된다.)
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'bank';

-- 아래와 같이 쿼리를 작성해야 한다.
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'BANK';
