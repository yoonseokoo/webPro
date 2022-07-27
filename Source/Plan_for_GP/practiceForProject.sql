
-- [1] MEMBER TABLE --
DROP TABLE MEMBER CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
    MID VARCHAR2(100) PRIMARY KEY,
    MPW VARCHAR2(100) NOT NULL,
    MNAME VARCHAR2(100) NOT NULL,
    MMAIL VARCHAR2(100) NOT NULL,
    MPOST VARCHAR2(100),
    MADDR VARCHAR2(100),
    MTEL VARCHAR(30));


--[2] GROUP TABLE --

DROP SEQUENCE GROUP_SEQ;

CREATE SEQUENCE GROUP_SEQ MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP TABLE GROUPS CASCADE CONSTRAINTS;

CREATE TABLE GROUPS(
    GID NUMBER(6) PRIMARY KEY,
    GNAME VARCHAR2(30),
    GRDATE DATE DEFAULT SYSDATE,
    GIMG VARCHAR2(50),
    GCONTENT VARCHAR2(4000));
    
-- [3] GROUP DETAIL -- �׷� �ɹ� ����

DROP SEQUENCE GROUPDETAIL_SEQ;

CREATE SEQUENCE GROUPDETAIL_SEQ MAXVALUE 99999999 NOCYCLE NOCACHE;
    
DROP TABLE GROUPDETAIL;

CREATE TABLE GROUPDETAIL( -- info about the members in the group
    GDID NUMBER(6) PRIMARY KEY,
    GID NUMBER(6),
    MID VARCHAR2(100),
    GDRDATE DATE DEFAULT SYSDATE, --date member joined
    FOREIGN KEY (GID) REFERENCES GROUPS(GID),
    FOREIGN KEY (MID) REFERENCES MEMBER(MID));

-- [4] PAY -- ���� ������ (����: Ŀ�� ��, ����...)

DROP SEQUENCE PAY_SEQ;

CREATE SEQUENCE PAY_SEQ MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP TABLE PAY CASCADE CONSTRAINTS;

CREATE TABLE PAY(
    PID NUMBER(6) PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    PCONTENT VARCHAR(4000),
    PIMAGE VARCHAR2(30),
    PAMOUNT NUMBER(10) NOT NULL,
    PRDATE DATE DEFAULT SYSDATE, -- ������ ��¥
    PPAYER VARCHAR2(100) NOT NULL, --�� ���
    GID NUMBER(6) NOT NULL,
    FOREIGN KEY (GID) REFERENCES GROUPS(GID),
    FOREIGN KEY (PPAYER) REFERENCES MEMBER(MID));

-- [5] PAY DETAIL --  (���� �̺�Ʈ�� �����ߴ���)

DROP SEQUENCE PAYDETAIL_SEQ;

CREATE SEQUENCE PAYDETAIL_SEQ MAXVALUE 99999999 NOCYCLE NOCACHE;

CREATE TABLE PAYDETAIL(
    PDID NUMBER(6) PRIMARY KEY, --UNIQUE KEY
    PID NUMBER(6) NOT NULL, -- DETAIL ������ �ش�Ǵ� ����
    MID VARCHAR2(100)  NOT NULL,
    PDAMOUNT NUMBER(10) NOT NULL, --���õ� ������� �� ���ߵǴ���
    FOREIGN KEY (MID) REFERENCES MEMBER(MID),
    FOREIGN KEY (PID) REFERENCES PAY(PID));

COMMIT;


-- [6] MEMBER DETAIL --  (�׷� �� ����� +/-)

DROP SEQUENCE MEMBERDETAIL_SEQ;

CREATE SEQUENCE MEMBERDETAIL_SEQ MAXVALUE 99999999 NOCYCLE NOCACHE;

CREATE TABLE MEMBERDETAIL(
    MDID NUMBER(6) PRIMARY KEY, -- �׷� �� ����� UNIQUE KEY
    MID VARCHAR2(100)  NOT NULL,
    MDCUM NUMBER(10) NOT NULL, -- �׷� �� ��� owe amount/ amount to be reimbursed 
    GID NUMBER(6) NOT NULL,
    FOREIGN KEY (GID) REFERENCES GROUPS(GID),
    FOREIGN KEY (MID) REFERENCES MEMBER(MID));

COMMIT;


SELECT * FROM  GROUPS;

    INSERT INTO GROUPS (GID, GNAME, GIMG, GCONTENT)
        VALUES (GROUP_SEQ.NEXTVAL, '���ؿ���', 'namhae.jpg' , '�츮 ��̰� ��ƺ���!');
        
        
SELECT * FROM  GROUPDETAIL;
    INSERT INTO GROUPDETAIL (GDID, GID, MID)
        VALUES (GROUPDETAIL_SEQ.NEXTVAL, 1 , 'aaa');
        
    INSERT INTO GROUPDETAIL (GDID, GID, MID)
        VALUES (GROUPDETAIL_SEQ.NEXTVAL, 1 , 'bbb');
    
    SELECT GD.MID, MNAME, MMAIL, G.GID FROM GROUPS G, GROUPDETAIL GD, MEMBER M WHERE G.GID=GD.GID AND GD.MID = M.MID AND G.GID=1;

SELECT * FROM  PAY;

    INSERT INTO PAY (PID, PNAME, PCONTENT, PIMAGE, PAMOUNT, PPAYER, GID)
        VALUES (PAY_SEQ.NEXTVAL, '����', '���ֽĴ� ���� ������', '', 55000, 'aaa', 1);
    

    

SELECT * FROM  PAYDETAIL;

     INSERT INTO PAYDETAIL (PDID, PID, MID, PDAMOUNT)
        VALUES (PAYDETAIL_SEQ.NEXTVAL, 1, 'aaa', 35000);
        
    INSERT INTO PAYDETAIL (PDID, PID, MID, PDAMOUNT)
        VALUES (PAYDETAIL_SEQ.NEXTVAL, 1, 'bbb', -20000);
        
    
    SELECT PDAMOUNT  FROM PAYDETAIL PD, PAY P WHERE PD.PID=P.PID AND GID=1 AND MID='aaa';
    
     SELECT PDAMOUNT  FROM PAYDETAIL PD, PAY P WHERE PD.PID=P.PID AND GID=1 AND MID='bbb';
    
SELECT * FROM  MEMBER;

    INSERT INTO MEMBER 
        VALUES ('aaa', '111', 'unie', 'yoonseokoo@gmail.com', '01234', '����� ��걸', '010-1234-4321');
     INSERT INTO MEMBER 
        VALUES ('bbb', '222', 'dk', 'dk@gmail.com', '01235', '����� ������', '010-2345-5432');
     INSERT INTO MEMBER 
        VALUES ('ccc', '333', 'bin', 'bin@gmail.com', '01236', '����� ������', '010-3456-6543');
     INSERT INTO MEMBER 
        VALUES ('ddd', '444', 'kim', 'kim@gmail.com', '01237', '����� ���ı�', '010-4567-7654');
        
COMMIT;
    
SELECT * FROM  MEMBERDETAIL;

     INSERT INTO MEMBERDETAIL 
        VALUES (MEMBERDETAIL_SEQ.NEXTVAL, 'aaa', 0, '1');
     INSERT INTO MEMBERDETAIL 
        VALUES (MEMBERDETAIL_SEQ.NEXTVAL, 'bbb', 0, '1');
        
        
        
        
        
    UPDATE MEMBERDETAIL 
        SET MDCUM= (SELECT PDAMOUNT  FROM PAYDETAIL PD, PAY P WHERE PD.PID=P.PID AND GID=1 AND MID='aaa')
        WHERE MID='aaa';
    
    UPDATE MEMBERDETAIL 
        SET MDCUM= (SELECT PDAMOUNT  FROM PAYDETAIL PD, PAY P WHERE PD.PID=P.PID AND GID=1 AND MID='bbb')
        WHERE MID='bbb';
    
    
    







