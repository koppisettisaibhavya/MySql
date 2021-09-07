create database guvi;
use guvi;
/* 1. creating tables  */
create table mentor(ment_id int primary key,ment_name varchar(10));
create table user1(usr_id int primary key,usr_name varchar(10),ment_id int,foreign key (ment_id) references mentor(ment_id));
create table courses(course_id int primary key,course_name varchar(10));
create table stud_act_course(course_id int,usr_id int,primary key (course_id,usr_id),foreign key (course_id) references courses(course_id),
foreign key (usr_id) references user1(usr_id));

create table comp_drive(comp_name varchar(10),usr_id int,primary key (comp_name,usr_id),foreign key (usr_id) references user1(usr_id));
create table attend(usr_id int,ustatus char(1) check (ustatus in ('P','A')),date1 date,foreign key (usr_id) references user1(usr_id));
create table topics(domain varchar(10) primary key,tot_prob int);
create table codekata(usr_id int,domain varchar(10),sol_prob int,primary key (usr_id,domain),foreign key (usr_id) references user1(usr_id),
foreign key (domain) references topics(domain));
create table task(usr_id int,domain varchar(10),todo_prob int,adate date,primary key (usr_id,domain),foreign key (usr_id) references user1(usr_id),
foreign key (domain) references topics(domain));

/* 2.inserting rows into tables */
insert into mentor(ment_id,ment_name) values(1,'Ram'),(2,'Siva'),(3,'Sita'),(4,'Parvathi'),(5,'Eshwar');
insert into user1(usr_id,usr_name,ment_id) values(1,'preethi',2),(2,'ish',2),(3,'bhavya',4),(4,'sai',1),(5,'sagar',5);
insert into courses(course_id,course_name) values(1,'java'),(2,'python'),(3,'sql'),(4,'.net'),(5,'c++');
insert into stud_act_course(course_id,usr_id) values(1,1),(1,2),(2,3),(2,4),(3,2),(3,5),(4,1),(4,3),(5,3),(5,5);
insert into comp_drive(comp_name,usr_id) values('chubb',1),('tcs',1),('chubb',2),('wipro',3),('chubb',4),('tcs',5),('chubb',5),('tcs',3);
insert into attend(usr_id,ustatus,date1) values(1,'P','2021-09-06'),(2,'P','2021-09-06'),(3,'A','2021-09-06'),(4,'P','2021-09-06'),(5,'A','2021-09-06');
insert into topics(domain,tot_prob) values('arrays',1000),('strings',1022),('numbers',1010),('basics',1000),('maths',1000);
insert into codekata(usr_id,domain,sol_prob) values(1,'arrays',3),(2,'arrays',10),(3,'arrays',12),(4,'arrays',13),(5,'arrays',33),
(1,'strings',13),(2,'strings',63),(3,'strings',93),(4,'strings',73),(5,'strings',76),
(1,'numbers',13),(2,'numbers',63),(3,'numbers',93),(4,'numbers',73),(5,'numbers',76),
(1,'basics',173),(2,'basics',653),(3,'basics',943),(4,'basics',713),(5,'basics',767),
(1,'maths',173),(2,'maths',653),(3,'maths',943),(4,'maths',713),(5,'maths',767);

insert into task(usr_id,domain,todo_prob,adate) values(1,'arrays',3,'2021-09-06'),(2,'arrays',10,'2021-09-06'),(3,'arrays',12,'2021-09-06'),(4,'arrays',13,'2021-09-06'),(5,'arrays',33,'2021-09-06'),
(1,'strings',13,'2021-09-04'),(2,'strings',63,'2021-09-04'),(3,'strings',93,'2021-09-04'),(4,'strings',73,'2021-09-04'),(5,'strings',76,'2021-09-04'),
(1,'numbers',13,'2021-09-03'),(2,'numbers',63,'2021-09-03'),(3,'numbers',93,'2021-09-03'),(4,'numbers',73,'2021-09-03'),(5,'numbers',76,'2021-09-03');

/* 3.get number problems solved in codekata by combining the users */
select u.usr_name,c.sol_prob from user1 u,codekata c where u.usr_id=c.usr_id and c.domain='numbers';

/* 4. display the no of company drives attended by a user */
select u.usr_name,count(c.comp_name) from user1 u,comp_drive c where u.usr_id=c.usr_id group by u.usr_id;

/* 5. combine and display students_activated_courses and courses for a specific user groping them based on the course */
select u.usr_name,c.course_name from user1 u,stud_act_course s,courses c where u.usr_id=s.usr_id and c.course_id=s.course_id;

/* 6. list all the mentors */
select ment_name from mentor;

/* 7.  list the number of students that are assigned for a mentor */
select m.ment_name,count(u.usr_id) from mentor m,user1 u where u.ment_id=m.ment_id group by m.ment_id;
