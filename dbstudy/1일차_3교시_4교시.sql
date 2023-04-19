/*
    도구 - 환경설정 - 코드 편집기 - 글꼴 / 행 여백 - 행 번호 체크
*/
-- 한 줄 주석 처리

-- 회원테이블
-- 1. 회원번호 : NO, 숫자, 기본키(PRIMARY KEY)-(자동으로 NOT NULL + UNIQUE)
-- 2. 아이디 : ID, 가변길이(20), 필수, 중복 불가
-- 3. 비밀번호 : PW, 가변길이(20), 필수
-- 4. 이름 : NAME, 가변길이(20), 필수
-- 5. 나이 : AGE, 숫자(3)
-- 6. 이메일 : EMAIL, 가변길이(100), 필수, 중복 불가
-- 7. 핸드폰 : HP, 고정길이(15), 중복 불가
-- 8. 가입일 : REGDATE, 날짜

DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    NO NUMBER PRIMARY KEY,
    ID VARCHAR2(20) NOT NULL UNIQUE,
    PW VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER(3),
    EMAIL VARCHAR2(100) NOT NULL UNIQUE,
    HP CHAR(15) UNIQUE,
    REGDATE DATE
);

-- 기본키로 가능한 칼럼들 : 널 값이 없고, 중복이 없는 칼럼
-- NO, ID, EMAIL

-- 후보키 : 기본키가 될 수 있는 후보들 (NO, ID, EMAIL)
-- 기본키 : 후보키에서 선택된 식별자 (NO)
-- 대체키 : 기본키로 선택되지 못한 후보키 (ID, EMAIL)

-- 게시판테이블 (회원만 작성할 수 있다.)
-- 1. 일련번호 : NO, 숫자, PRIMARY KEY (자동으로 NOT NULL + UNIQUE)
-- 2. 작성자 : ID, 가변길이(20)    ** 중요 : 회원테이블의 '아이디(ID)' 칼럼과 연결하는 칼럼 (그래야 회원만 작성할 수 있다.)
--                                        다른테이블의 식별자(후보키)와 연결되는 칼럼을 "외래키"라고 한다.
--                                        "외래키" : FOREIGN KEY
-- 3. 제목 : TITLE, 가변길이(1000), 필수
-- 4. 내용 : CONTENT, 가변길이(4000)

DROP TABLE BOARD;
CREATE TABLE BOARD (
    NO NUMBER PRIMARY KEY,
    ID VARCHAR2(20) REFERENCES MEMBER(ID),  -- MEMBER테이블의 ID칼럼을 참조하는 외래키
    TITLE VARCHAR2(1000) NOT NULL,
    CONTENT VARCHAR2(4000)
);

-- 외래키는 자신이 참조하는 칼럼의 값만 가질 수 있다. (참조 무결성)
-- BOARD 테이블의 작성자(ID)는 MEMBER 테이블의 아이디(ID)만 가질 수 있다.
-- 외래키를 가진 테이블을 "자식 테이블" 이라고 한다.
-- BOARD 테이블은 MEMBER 테이블의 "자식 테이블"이다.

-- 외래키가 참조 중인 식별자(후보키)는 외래키가 참조하는 동안 함부로 변경, 삭제될 수 없다.
-- 상황
-- 회원테이블 아이디   게시판테이블 작성자
-- ABC               ABC
-- EFG               ABC
--                   EFG
-- 이 상황에서 회원테이블의 ABC 아이디를 제거하면(수정하면)? 참조무결성이 위배된다.
-- 참조무결성의 위배를 피하기 위해서 수정, 삭제가 안 된다.


-- 정리

-- 1. 외래키가 참조 중인 테이블(MEMBER)은 먼저 삭제할 수 없다.
--    게시판(BOARD)을 먼저 삭제하고, 회원(MEMBER)을 나중에 삭제해야 한다.

-- 2. 두 테이블 중에서 반드시 먼저 만들어야 하는 테이블은 MEMBER 테이블이다.
