-- 시퀀스 (SEQUENCE)

-- 테이블 생성
CREATE TABLE PRODUCT (
    PROD_NO NUMBER PRIMARY KEY,  -- 1부터 순차적으로 + 자동으로 순번을 부여한다.(시퀀스를 이용한다.)
    PROD_NAME VARCHAR2(30)
);

-- 1. PROD_NO 칼럼에 부착할 PRODUCT_SEQ 시퀀스를 생성한다.
-- 1) 1부터 시작하는 시퀀스이다.
-- 2) 1씩 증가하는 시퀀스이다.
-- 3) 최대 999999 까지 증가할 수 있는 시퀀스이다.
-- 4) 순번은 순환하지 않는다.
-- 5) 캐시 기능을 사용하지 않는다. (사용하면 순번이 끊어지는 것을 방지한다.)

CREATE SEQUENCE PRODUCT_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCYCLE
NOCACHE;

-- 2. 생성된 PRODUCT_SEQ 시퀀스를 확인한다.
-- 시퀀스가 저장되는 테이블 : USER_SEQUENCES
DESC USER_SEQUENCES;
SELECT * FROM USER_SEQUENCES;


-- 3. 생성된 PRODUCT_SEQ 시퀀스를 이용해서 PRODUCT 테이블에 데이터를 입력한다.
-- 새로운 순번을 생성하는 시퀀스 함수는 NEXTVAL 이다.
INSERT INTO PRODUCT (PROD_NO, PROD_NAME) VALUES (PRODUCT_SEQ.NEXTVAL, '냉장고');
INSERT INTO PRODUCT (PROD_NO, PROD_NAME) VALUES (PRODUCT_SEQ.NEXTVAL, '세탁기');
INSERT INTO PRODUCT (PROD_NO, PROD_NAME) VALUES (PRODUCT_SEQ.NEXTVAL, '청소기');
COMMIT;


-- 4. PRODUCT_SEQ 시퀀스를 삭제한다.
DROP SEQUENCE PRODUCT_SEQ;
