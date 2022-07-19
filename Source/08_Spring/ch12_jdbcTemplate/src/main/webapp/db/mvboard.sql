DROP TABLE MVC_BOARD CASCADE CONSTRAINTS;
DROP SEQUENCE MVC_BOARD_SEQ;
CREATE SEQUENCE MVC_BOARD_SEQ MAXVALUE 999999 NOCACHE NOCYCLE;
CREATE TABLE MVC_BOARD(
    bID NUMBER(6),
    bNAME VARCHAR2(50) NOT NULL,
    bTITLE VARCHAR2(100) NOT NULL,
    bCONTENT VARCHAR2(1000),
    bDATE DATE DEFAULT SYSDATE NOT NULL,
    bHIT NUMBER(6) DEFAULT 0 NOT NULL,
    bGROUP NUMBER(6) NOT NULL,
    bSTEP NUMBER(3) NOT NULL,
    bINDENT NUMBER(3) NOT NULL,
    bIP VARCHAR2(20) NOT NULL,
    PRIMARY KEY(bID)
);
INSERT INTO MVC_BOARD (bID, bNAME, bTITLE, bCONTENT, bGROUP, bSTEP, bINDENT, bIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, '홍길동','제목','본문',MVC_BOARD_SEQ.CURRVAL, 0, 0, '127.0.0.1');


COMMIT;
select * from MVC_BOARD;
-- 글목록 (startRow ~ endRow까지)
SELECT * FROM MVC_BOARD ORDER BY BGROUP DESC, BSTEP;
SELECT * FROM (SELECT ROWNUM RN, A.* 
            FROM (SELECT * FROM MVC_BOARD ORDER BY BGROUP DESC, BSTEP) A)
        WHERE RN BETWEEN 1 AND 3;

-- 전체 글 갯수
SELECT COUNT(*) FROM MVC_BOARD;

-- 원글쓰기
INSERT INTO MVC_BOARD (bID, bNAME, bTITLE, bCONTENT, bGROUP, bSTEP, bINDENT, bIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, '홍길동','제목2','본문2',MVC_BOARD_SEQ.CURRVAL, 0, 0, '127.0.0.1');

-- bID글 조회수 1회 올리기
UPDATE MVC_BOARD SET bHIT = bHIT+1 WHERE bID=2;

-- bID로 DTO가져오기(상세글 보기)
SELECT * FROM MVC_BOARD WHERE BID=2;

-- 답변글 쓰기전 step A
UPDATE MVC_BOARD SET BSTEP=BSTEP+1 WHERE BGROUP=2 AND BSTEP>0;

-- 답변글 쓰기(2번글의 답변)
INSERT INTO MVC_BOARD (bID, bNAME, bTITLE, bCONTENT, bGROUP, bSTEP, bINDENT, bIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, '답변자','글2첫답','본문2답변',2,1,1,'127.0.0.1');

-- 글 수정하기
UPDATE MVC_BOARD SET BNAME='김김김',
                    BTITLE = '바뀐제목',
                    BCONTENT = '바뀐내용',
                    BIP = '192.168.20.44'
        WHERE BID=2;
-- 글삭제하기
DELETE FROM MVC_BOARD WHERE BID=1;
COMMIT;
SELECT to_char(bdate,'yyyy/mm/dd hh:mi') FROM MVC_BOARD ORDER BY BGROUP DESC, BSTEP;


rollback;