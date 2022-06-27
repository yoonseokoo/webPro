

--[1] CONSTRUCTING TABLE MEMBER
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MID VARCHAR2(3) PRIMARY KEY,
    MNAME VARCHAR2(10) NOT NULL,
    MADDR VARCHAR2(30),
    MTEL CHAR(13) CHECK (LENGTH(MTEL) =13),
    MEMAIL VARCHAR2(20));

INSERT INTO MEMBER (MID, MNAME, MADDR, MTEL)
    VALUES ('abc', '홍길동', '서울 강남구', '010-1111-1111');

INSERT INTO MEMBER (MID, MNAME, MADDR, MTEL)
    VALUES ('def', '전투왕', '서울 서대문구 ', '010-2222-2222');
    
SELECT*FROM MEMBER;
    
--[2] CONSTRUCTING TABLE PRODUCT
DROP TABLE PRODUCT;

CREATE TABLE PRODUCT(
    PCODE VARCHAR2(2) PRIMARY KEY,
    PNAME VARCHAR2(15) NOT NULL,
    PRICE NUMBER(6) NOT NULL CHECK (PRICE>0),
    PSTOCK NUMBER(3) NOT NULL CHECK (PSTOCK>0));

INSERT INTO PRODUCT (PCODE, PNAME, PRICE, PSTOCK)
    VALUES ('A1', 'BEER', 3000, 15);

INSERT INTO PRODUCT (PCODE, PNAME, PRICE, PSTOCK)
    VALUES ('A2', 'SOJU', 2000, 20);
    
INSERT INTO PRODUCT (PCODE, PNAME, PRICE, PSTOCK)
    VALUES ('B1', 'PEANUTS', 3500, 30);

INSERT INTO PRODUCT (PCODE, PNAME, PRICE, PSTOCK)
    VALUES ('B2', 'SQUID', 5000, 18);
    
INSERT INTO PRODUCT (PCODE, PNAME, PRICE, PSTOCK)
    VALUES ('C1', 'DIPERS', 7000, 25);
    
SELECT*FROM PRODUCT;

--[3] CONSTRUCTING TABLE CART (1)
DROP TABLE CART;

DROP SEQUENCE  CART_SEQ;

CREATE SEQUENCE CART_SEQ
    MAXVALUE 999
    NOCACHE 
    NOCYCLE;
    
CREATE TABLE CART(
    OSEQ VARCHAR2(2) NOT NULL,
    MID VARCHAR2(3),
    QTY1 NUMBER(2) NOT NULL,
    COST1 NUMBER(6) NOT NULL CHECK (COST1>0),
    FOREIGN KEY (MID) REFERENCES MEMBER(MID));

INSERT INTO CART 
    VALUES (CART_SEQ.NEXTVAL, 'abc', 7, 21500);
    
    
SELECT PRICE FROM PRODUCT  WHERE PCODE ='A1'


INSERT INTO CART 
    VALUES (CART_SEQ.NEXTVAL, 'def', 4, 16000);


SELECT*FROM CART;

--[4] CONSTRUCTING TABLE ORDER
DROP TABLE ORDERTAB; 

DROP SEQUENCE ORDER_SEQ;

CREATE SEQUENCE ORDER_SEQ
    MAXVALUE 999
    NOCACHE 
    NOCYCLE;
    
CREATE TABLE ORDERTAB(
    ONUM  VARCHAR2 (11) PRIMARY KEY,
    MID VARCHAR2(3),
    OADDR VARCHAR2 (30),
    OTEL CHAR(13) CHECK (LENGTH(OTEL) =13),
    ODATE DATE DEFAULT SYSDATE,
    FOREIGN KEY (MID) REFERENCES MEMBER(MID));
    
INSERT INTO ORDERTAB 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDER_SEQ.NEXTVAL, 'abc', '서울 강남구', '010-1111-1111', TO_DATE(SYSDATE, 'YY/MM/DD'));

INSERT INTO ORDERTAB 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDER_SEQ.NEXTVAL, 'def', '서울 서대문구 ', '010-2222-2222', TO_DATE(SYSDATE, 'YY/MM/DD'));
    
INSERT INTO ORDERTAB 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDER_SEQ.NEXTVAL, 'abc', '경기도 과천', '010-3333-3333', TO_DATE(SYSDATE, 'YY/MM/DD'));

    
SELECT*FROM ORDERTAB;
    
    
--[5] CONSTRUCTING TABLE ORDER DETAIL (2)
DROP TABLE ORDERDETAIL;

DROP SEQUENCE ORDERDETAIL_SEQ;

CREATE SEQUENCE ORDERDETAIL_SEQ
    MAXVALUE 999
    NOCACHE 
    NOCYCLE;
    
CREATE TABLE ORDERDETAIL(
    ONUM  VARCHAR2 (12) NOT NULL,
    PCODE VARCHAR2(2),
    QTY NUMBER(2),
    COST NUMBER(6),
    FOREIGN KEY (ONUM) REFERENCES ORDERTAB(ONUM),
    FOREIGN KEY (PCODE) REFERENCES PRODUCT(PCODE));
    
INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.NEXTVAL, 'A1', 3, 3*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='A1'));


INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'B1', 1, 1*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='B1'));


INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'A2', 2, 2*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='A2'));

    
 INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'B2', 1, 1*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='B2'));

----

INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.NEXTVAL, 'A2', 2, 2*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='A2'));


INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'B2', 1, 1*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='B2'));


INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'C1', 1, 1*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='C1'));

----

INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.NEXTVAL, 'A1', 2, 2*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='A1'));


INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'B1', 1, 1*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='B1'));


INSERT INTO ORDERDETAIL 
    VALUES (TO_CHAR(SYSDATE, 'YYMMDD')||'0000'||ORDERDETAIL_SEQ.CURRVAL, 'C1', 1, 1*(SELECT PRICE FROM PRODUCT  WHERE PCODE ='C1'));





SELECT*FROM MEMBER;
SELECT*FROM PRODUCT;
SELECT*FROM CART;
SELECT*FROM ORDERTAB;
SELECT*FROM ORDERDETAIL;
    
    
    
    





