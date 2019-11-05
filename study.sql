sqlplus system/1234

CREATE USER study identified by 1234;
GRANT CONNECT, DBA, RESOURCE TO study;

conn study/1234
sqlplus study/1234@70.12.115.55:1521/xe

	
drop table STUDYMEMBER;
CREATE TABLE STUDYMEMBER (
	studyno NUMBER REFERENCES studyroom(studyno),
	userid VARCHAR2(15) REFERENCES userinfo(userid),
	status VARCHAR2(1) CONSTRAINTS status_ck CHECK ( status IN ('0', '1'))
	);
	
	
drop table USERINFO;
CREATE TABLE USERINFO (
	userid VARCHAR2(15) CONSTRAINT userinfo_pk PRIMARY KEY ,
	username VARCHAR2(10) NOT NULL ,
	userpw VARCHAR2(15)  NOT NULL,
	email VARCHAR2(30) ,
	address VARCHAR2(50),
	phone VARCHAR2(20)
	);	
	
	
drop table CATEGORY;
CREATE TABLE CATEGORY (
	categorycode NUMBER CONSTRAINT category_pk PRIMARY KEY ,
	categoryname VARCHAR2(50)  NOT NULL
	);	
	
drop table SUBCATEGORY;
CREATE TABLE SUBCATEGORY (
	subjectcode NUMBER CONSTRAINT subcategory_pk PRIMARY KEY ,
	categorycode NUMBER REFERENCES category(categorycode),
	subjectname VARCHAR2(20) NOT NULL
	);	
	
	
drop table LOCATION;
CREATE TABLE LOCATION (
	locationcode NUMBER CONSTRAINT location_pk PRIMARY KEY ,
	loc1 VARCHAR2(20),
	loc2 VARCHAR2(20),
	loc3 VARCHAR2(20)
	);	
	
ALTER TABLE LOCATION MODIFY (loc1 VARCHAR2(20));
ALTER TABLE LOCATION MODIFY (loc2 VARCHAR2(20));
ALTER TABLE LOCATION MODIFY (loc3 VARCHAR2(20));

drop table STUDYROOM;
CREATE TABLE STUDYROOM (
	studyno NUMBER CONSTRAINT study_pk PRIMARY KEY,
	studytitle VARCHAR2(50) NOT NULL,
	subjectcode NUMBER REFERENCES subcategory(subjectcode),
	membercnt NUMBER default 0,
	locationcode NUMBER REFERENCES location(locationcode),
	managerid VARCHAR2(15) REFERENCES userinfo(userid),
	regdate Date DEFAULT SYSDATE,
	state VARCHAR2(2) CONSTRAINTS state_ck CHECK ( state IN ('0', '1')),
	content VARCHAR2(3000)
	viewcnt NUMBER default 0
	);

	
drop table NOTIFY;
CREATE TABLE NOTIFY (
	seq NUMBER CONSTRAINT notify_pk PRIMARY KEY ,
	userid VARCHAR2(15) REFERENCES userinfo(userid),
	target_userid VARCHAR2(15) REFERENCES userinfo(userid),
	notifytype VARCHAR2(20),
	studyno NUMBER REFERENCES studyroom(studyno),
	notifydate Date DEFAULT SYSDATE,
	notifycheck VARCHAR2(2) CONSTRAINTS notify_ck CHECK ( notifycheck IN ('0', '1'))
	);	
	
	
select r.studytitle,  s.subjectname, (select loc1 ||' ' || loc2 from location where locationcode = 1168064000), r.content
from subcategory s, studyroom r
where r.subjectcode = s.subjectcode and s.subjectname='TOEIC';


