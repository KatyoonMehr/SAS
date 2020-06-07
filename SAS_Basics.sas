
* SAS Basics;
* Data Entry;



DATA demo_1;
 INPUT id $ height weight gender $ age;
 *Wight_1=weight*0.45;
DATALINES;
001 68 144 M 23
002 78 202 M 34
003 62 99 F 37
004 61 101 F 45
;
RUN;
PROC CONTENTS DATA = work.demo_1;
RUN;


DATA demo_2;
	INPUT id $ height weight gender $ age;
DATALINES;
001 68 144 M 23 99999
002 78          202 M 34
;
RUN;
PROC PRINT DATA = demo_2;
RUN;

DATA demo_3; *Problem-Second record won't be shown;
	INPUT id $ height weight gender $ age;
DATALINES;
001 68 144 M 23 002
78 202 M 34
;
RUN;
PROC PRINT DATA = demo_3;
RUN;


DATA demo_4; *Problem-Second record won't be shown;
	INPUT id $ height weight gender $ age;
DATALINES;
001 68 144 M 23
002 78 202 M 34;
RUN;
PROC PRINT DATA = demo_4;
RUN;


*Length Statement;
DATA demo_5;
	LENGTH id $3 gender $1 height 3;
	INPUT id height weight gender age;
DATALINES;
001 68 144 M 23
002 78 202 M 34
;
RUN;
PROC CONTENTS DATA = demo_5;
RUN;


*Informat Statement;
DATA demo_6;
    INFORMAT id $3. gender $1. height 1.2;
	INPUT id $ height weight gender $ age;
DATALINES;
001 68 144 M 23
002 78 202 M 34
;
RUN;
PROC CONTENTS DATA = demo_6;
RUN;


DATA demo_7;
	INFORMAT id $3.  gender $1.  dob mmddyy8.;
	INPUT id  gender  dob;
DATALINES;
001 M 12/31/65
002 F 06/07/66
;
RUN;
PROC CONTENTS DATA = demo_7;
RUN;
PROC PRINT DATA = demo_7;
FORMAT dob mmddyy.;
RUN;


*Column Input;
DATA demo_8;
  INPUT id $1-3
		name $ 5-19
		gender $21
		age 23-25;
DATALINES;
001 Alex Mark       M 35 
002 Max X Bush      F 45
;
RUN;
PROC CONTENTS DATA = demo_8;
RUN;
PROC PRINT DATA = demo_8;
RUN;


*Formatted Input;
DATA demo_9;
	INPUT 	@1	id 	$3.
			@4	name $4.
			@8 	age  	2.
			@10 	gender $1.;
DATALINES;
001Alex30M 
002Max 45F
;
RUN;
PROC CONTENTS DATA = demo_9;
RUN;
PROC PRINT DATA = demo_9;
RUN;

* Reading an external file;
DATA participants; 
INFILE 'C:\Users\tjaber\Desktop\SAS Fundamental_Final\Examples\participant.csv' DLM= ',' FIRSTOBS=1;
LENGTH ID $10 Date $10 DOB $10 SEX $1;
INPUT ID  Date  DOB  SEX  PAID;
 *KEEP ID SEX PAID;
RUN;

*PROC IMPORT;
PROC IMPORT DATAFILE='C:\Users\tjaber\Desktop\SAS Fundamental_Final\Examples\participant.csv'
OUT = participants = (ID = ID2 Gender = Sex))
DBMS=CSV
REPLACE;
GUESSINGROWS= 100;
GETNAMES=YES;
RUN;

*PROC PRINT;
PROC PRINT DATA = demo_1;
	VAR id gender age;
RUN;

*Procedure Options;
Proc print data =demo_10 noobs label;
	var id gender dob;
	label dob='Date of birth';
Run;

*Restriction to observations;
PROC PRINT DATA = demo_1(OBS=3);
	VAR id gender age;
RUN;

*Restriction using WHERE;
PROC PRINT DATA = demo_1;
	VAR id gender age;
 	WHERE gender='M' and age>25;
RUN;


*BY statement (Group value), Sort first;
PROC PRINT DATA = demo_1;
	VAR id gender age;
 	BY gender;
RUN;


PROC PRINT DATA = demo_1;
	VAR id age;
 	BY gender;
RUN;


*Format Statement;
PROC PRINT DATA = demo_7;
	VAR id gender dob;
	FORMAT dob date9.;
	/* date9. – 31Dec1965*/
RUN;

PROC PRINT DATA = demo_7;
	TITLE 'This is an example';
	FOOTNOTE 'helloooooooooo';
RUN;

DATA test;
	INPUT id age income;
DATALINES;
001 50 50000
002 40 40000
002 40 30000
002 40 30000
003 30 60000
;
RUN;

PROC SORT DATA = test;
	BY id;
	*By DESCENDING id;
RUN;

PROC SORT DATA = test OUT=test2 NODUPKEY;
	BY DESCENDING id;
RUN;

PROC SORT DATA = test OUT=test2 NODUPKEY DUPOU = option;
	BY id;
RUN;
PROC PRINT DATA = test2;
RUN;



DATA person;
   INFILE DATALINES DELIMITER = ','; 
   INPUT name $ dept $;
   DATALINES;                      
John,Sales
Mary,Acctng
;
RUN;


*Special Comma delimiter format DSD; 
DATA Special;    
	INFILE DATALINES DSD;
	INPUT X Y A $ Z;
	DATALINES;
	1,2,HELLO,3 
	4  ,   5  ,   GOODBYE ,  6 
	7,,"HI THERE",8 
	9,10,"HI,THERE",11 
; 
RUN;
PROC PRINT DATA = Special;
RUN;


