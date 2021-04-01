DROP SEQUENCE INDIVIDUALSEQ;
DROP TABLE INDIVIDUAL;

CREATE SEQUENCE INDIVIDUALSEQ;

CREATE TABLE INDIVIDUAL(
	INDIVIDUAL_NO NUMBER PRIMARY KEY,
	INDIVIDUAL_ID VARCHAR2(500) NOT NULL,
	INDIVIDUAL_TITLE VARCHAR2(1000)  NOT NULL,
	INDIVIDUAL_TIME NUMBER NOT NULL,
	INDIVIDUAL_CONTENT VARCHAR2(4000)  NOT NULL,
	INDIVIDUAL_MDATE VARCHAR2(12)  NOT NULL,
	INDIVIDUAL_REGDATE DATE  NOT NULL
);


INSERT INTO INDIVIDUAL
VALUES(INDIVIDUALSEQ.NEXTVAL, 'kwg940930', 'cine입니다', 30, '프로젝트 화이팅!!', '202104010110', SYSDATE);


SELECT INDIVIDUAL_NO, INDIVIDUAL_ID, INDIVIDUAL_TITLE, INDIVIDUAL_TIME, INDIVIDUAL_CONTENT, INDIVIDUAL_MDATE, INDIVIDUAL_REGDATE
FROM INDIVIDUAL
WHERE INDIVIDUAL_ID = 'kwg940930'
AND SUBSTR(INDIVIDUAL_MDATE, 1, 8) = '20210401'
ORDER BY INDIVIDUAL_NO DESC;



SELECT COUNT(*) 
FROM INDIVIDUAL 
WHERE INDIVIDUAL_ID = 'cine'
AND SUBSTR(INDIVIDUAL_MDATE, 1, 8) = '20210401';


