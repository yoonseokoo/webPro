-- ■■■■■ GRADE TABLE ■■■■■ --

DROP TABLE GRADE CASCADE CONSTRAINTS;

CREATE TABLE GRADE(
    MGRADE NUMBER(1) PRIMARY KEY,
    GNAME VARCHAR2(30) NOT NULL,
    LOWGRADE NUMBER(9) NOT NULL,
    HIGHGRADE NUMBER(9) NOT NULL);

-- ■■■■■ MEMBER TABLE ■■■■■ --

DROP TABLE MEMBER CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
    MID VARCHAR2(30) PRIMARY KEY,
    MPW VARCHAR2(30) NOT NULL,
    MNAME VARCHAR2(30) NOT NULL,
    MPHONE VARCHAR(30) NOT NULL,
    MADDRESS VARCHAR2(100),
    MADDRESSDETAIL VARCHAR2(300),
    MBIRTH DATE NOT NULL,
    MEMAIL VARCHAR2(30) NOT NULL,
    MGENDER VARCHAR2(10),
    MCUMPURCHASE NUMBER(9) DEFAULT 0,
    MRDATE DATE DEFAULT SYSDATE,
    MGRADE NUMBER(1) DEFAULT 1 REFERENCES GRADE(MGRADE));
    

-- ■■■■■ BOARD TABLE ■■■■■ --

DROP TABLE BOARD;
 
 CREATE TABLE BOARD(
    BID NUMBER(6) PRIMARY KEY,                           -- 글번호
    MID VARCHAR2(30) REFERENCES MEMBER(MID) NOT NULL,    -- 고객 아이디
    BTITLE VARCHAR2(100) NOT NULL,                       -- 글제목
    BCONTENT VARCHAR2(4000),                             -- 글내용
    BIMAGE VARCHAR2(30),                                 -- 글 첨부 이미지
    BHIT NUMBER(6) DEFAULT 0 NOT NULL,                   -- 조회수
    BGROUP NUMBER(6) NOT NULL,                           --  답글위한 그룹
    BSTEP NUMBER(6) DEFAULT 0 NOT NULL,                  -- 글 순서
    BINDENT NUMBER(6) DEFAULT 0 NOT NULL,                -- 들여쓰기기
    BRDATE DATE DEFAULT SYSDATE,                         -- 글작성일
    ONO NUMBER(6));                                      -- 주문번호

 DROP SEQUENCE BOARD_SEQ;
 
 CREATE SEQUENCE BOARD_SEQ 
    MAXVALUE 9999999
    NOCACHE
    NOCYCLE;

-- ■■■■■ ORDER TABLE ■■■■■ --

DROP TABLE ORDERS CASCADE CONSTRAINTS;

CREATE TABLE ORDERS(
    ONO NUMBER(6) PRIMARY KEY,                            -- 주문번호
    ONAME VARCHAR2(30),                                   -- 주문 고객 이름
    OPHONE VARCHAR2(30),                                  -- 받는사람 이름                                       
    OADDRESS VARCHAR2(100),                               -- 배달 주소
    ODATE DATE DEFAULT SYSDATE,                           -- 주문일
    MID VARCHAR2(30) REFERENCES MEMBER(MID) );            --고객 아이디
    
DROP SEQUENCE ORDERNUM_SEQ;

CREATE SEQUENCE ORDERNUM_SEQ
    MAXVALUE 999999
    NOCYCLE
    NOCACHE;    

-- ■■■■■ ORDER_DETAIL TABLE ■■■■■ --

DROP TABLE ORDER_DETAIL CASCADE CONSTRAINTS;

CREATE TABLE ORDER_DETAIL(
    ONO NUMBER(6) PRIMARY KEY REFERENCES ORDERS(ONO),
    PID VARCHAR2(30) NOT NULL REFERENCES PRODUCT(PID),      
    PQUANTITY NUMBER(6) DEFAULT 1,                                 
    PPRICE NUMBER(9) NOT NULL,
    TOTCOST NUMBER(9) NOT NULL,
    DISCOUNT NUMBER(9),
    PAYAMOUNT NUMBER(9) NOT NULL);
     


-- ■■■■■ PRODUCT TABLE ■■■■■ --


DROP TABLE PRODUCT CASCADE CONSTRAINTS;

CREATE TABLE PRODUCT(
    PID VARCHAR2(30) PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    PPRICE NUMBER(9) NOT NULL,
    PDISCOUNT NUMBER(3) DEFAULT 0,
    PIMAGE VARCHAR2(30),
    PSTOCK NUMBER(6) NOT NULL,
    PDESCRIPTION VARCHAR2(1000),
    PRDATE DATE DEFAULT SYSDATE,
    PCUMSALES NUMBER(6) DEFAULT 0,
    PREVIEWCNT NUMBER(6) DEFAULT 0,
    PRATING NUMBER(4,2) DEFAULT -1
    );

DROP SEQUENCE PRODUCT_SEQ;

CREATE SEQUENCE PRODUCT_SEQ
    MAXVALUE 999999
    NOCYCLE
    NOCACHE;   


-- ■■■■■ PRODUCT REVIEW TABLE ■■■■■ --


DROP TABLE REVIEW CASCADE CONSTRAINTS;

CREATE TABLE REVIEW(
    RNO NUMBER(6) PRIMARY KEY,
    PID VARCHAR2(30) NOT NULL REFERENCES PRODUCT(PID), 
    MID VARCHAR2(30) NOT NULL REFERENCES MEMBER(MID),
    RCONTENT VARCHAR2(2000),
    RIMAGE VARCHAR2(30),
    RSTAR NUMBER(6),
    RRDATE DATE DEFAULT SYSDATE,
    RGROUP NUMBER(6) NOT NULL,
    RSTEP NUMBER(6) DEFAULT 0 NOT NULL,
    RINDENT NUMBER(6) DEFAULT 0 NOT NULL);
    

DROP SEQUENCE REVIEW_SEQ;

CREATE SEQUENCE REVIEW_SEQ
    MAXVALUE 999999
    NOCYCLE
    NOCACHE;   


-- ■■■■■ CART TABLE ■■■■■ --

DROP TABLE CART;

CREATE TABLE CART(
    CARTNO NUMBER(6) PRIMARY KEY,
    MID VARCHAR2(30) REFERENCES MEMBER(MID),
    PID VARCHAR2(30) REFERENCES PRODUCT(PID),
    PCNT NUMBER(6) NOT NULL);

DROP SEQUENCE CART_SEQ;

CREATE SEQUENCE CART_SEQ
    MAXVALUE 999999
    NOCYCLE
    NOCACHE;   


-- ■■■■■ ADMIN TABLE ■■■■■ --

DROP TABLE ADMIN;

CREATE TABLE ADMIN(
    AID   VARCHAR2(30) PRIMARY KEY,
    APW VARCHAR2(30) NOT NULL,
    ANAME VARCHAR2(30) NOT NULL);
    
SELECT * FROM ADMIN;

COMMIT;





