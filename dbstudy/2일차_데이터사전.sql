-- 테이블 구조 확인
DESC BOARD;

-- 시스템 카탈로그 (데이터 사전)
-- 어떤 사용자가 있는가?
-- 어떤 테이블이 있는가?
-- 등등
-- 메타 데이터 (데이터를 설명하기 위한 추가 데이터)

-- 검색 쿼리문
SELECT TABLE_NAME FROM DICT;  -- DICT 테이블에서 TABLE_NAME 칼럼을 조회한다.

SELECT COUNT(*) FROM DICT;  -- DICT 테이블의 데이터 개수를 조회한다.

SELECT * FROM TAB;  -- TAB 테이블에서 모든 칼럼을 조회한다. (* : 모든 칼럼)
SELECT * FROM USER_USERS;
SELECT * FROM DBA_USERS;
