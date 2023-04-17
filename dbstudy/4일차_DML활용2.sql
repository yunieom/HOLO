-- 1. 제약조건을 사용하여 STUDENT 테이블을 생성하시오.
-- 1) 학번 : NUMBER, 기본키
-- 2) 성명 : VARCHAR2(20), 필수
-- 3) 국어 : NUMBER, 기본값 [0], 0 ~ 100 사이만 가능
-- 4) 영어 : NUMBER, 기본값 [0], 0 ~ 100 사이만 가능
-- 5) 수학 : NUMBER, 기본값 [0], 0 ~ 100 사이만 가능
-- 6) 평균 : NUMBER
-- 7) 이메일 : VARCHAR2(100), 중복 불가
-- 8) 등록일 : DATE, 기본값 [현재 날짜]

CREATE TABLE STUDENT (
    NO NUMBER PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER DEFAULT 0 CHECK(KOR >= 0 AND KOR <= 100),
    ENG NUMBER DEFAULT 0 CHECK(ENG BETWEEN 0 AND 100),
    MAT NUMBER DEFAULT 0 CHECK(MAT BETWEEN 0 AND 100),
    AVERAGE NUMBER,
    EMAIL VARCHAR2(100) UNIQUE,
    REGDATE DATE DEFAULT SYSDATE
);


-- 2. 임의의 학생 정보를 입력한다.
INSERT INTO STUDENT (NO, NAME) VALUES (1, '에밀리');
INSERT INTO STUDENT (NO, NAME, EMAIL) VALUES (2, '제임스', 'james@gmail.com');
INSERT INTO STUDENT (NO, NAME, KOR, ENG, MAT, REGDATE) VALUES (3, '앨리스', 90, 93, 96, '20/06/29');
INSERT INTO STUDENT VALUES (4, '데이빗', 30, 24, 43, NULL, 'david@naver.com', SYSDATE - 3);


-- 3. 저장한다.
COMMIT;


-- 4. 조회한다.
SELECT * FROM STUDENT;


-- 5. 모든 학생들의 평균 칼럼을 계산하시오.
-- UPDATE 테이블 SET 업데이트내용 [WHERE 조건식]
UPDATE STUDENT
SET AVERAGE = (KOR + ENG + MAT) / 3;


-- 6. 저장한다.
COMMIT;


-- 7. NO 가 3인 학생의 이메일을 'alice@gmail.com' 으로 변경하시오.
UPDATE STUDENT
SET EMAIL = 'alice@gmail.com'
WHERE NO = 3;


-- 8. 이메일이 없는 학생을 삭제하시오.
-- DELETE FROM 테이블 [WHERE 조건식]
DELETE FROM STUDENT
WHERE EMAIL IS NULL;