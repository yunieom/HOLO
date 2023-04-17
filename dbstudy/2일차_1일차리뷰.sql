-- DBMS : DataBase Management System (데이터베이스 관리 프로그램)
-- 오라클, MySQL, MariaDB, SQLite 등
-- 중규모이상(Oracle), 소규모(MySQL)


-- 오라클 관리자 계정 : SYSTEM, SYS
-- CONN SYSTEM/1111
-- CONN /AS SYSDBA   비번 모를 때


-- 사용자 만들기
CREATE USER 사용자 IDENTIFIED BY 비밀번호;

-- 권한 부여
GRANT 권한 TO 사용자;
(권한 : CONNECT, RESOURCE, DBA)

-- 사용자 삭제하기
DROP USER 사용자;

-- 권한 해제
REVOKE 권한 FROM 사용자;

-- 테이블 생성
CREATE TABLE 테이블 (
칼럼명 칼럼타입 [제약조건],
칼럼명 칼럼타입 [제약조건],
....
);

-- 테이블 삭제
DROP TABLE 테이블;




-- PPT 8번 데이터베이스 오브젝트 설계

-- 부서테이블
CREATE TABLE 부서 (
    부서번호 NUMBER PRIMARY KEY,
    부서명 VARCHAR2(10),
    위치 VARCHAR2(100)
);

-- 사원테이블
CREATE TABLE 사원 (
    사원번호 NUMBER PRIMARY KEY,  -- NOT NULL + UNIQUE
    소속부서 NUMBER REFERENCES 부서(부서번호),
    직급 VARCHAR2(10),
    성별 VARCHAR2(10),
    입사일 DATE,
    봉급 NUMBER
);

-- 삭제 주의사항 (외래키를 가진 테이블을 먼저 삭제한다.)
DROP TABLE 사원;
DROP TABLE 부서;
