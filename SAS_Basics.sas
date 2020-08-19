
* SAS Basics;
* Data Entry;
* Array;



DATA demo_1;
INPUT id $ height weight gender $ age;
Weight_1=weight*0.45;
DATALINES;
001 68 144 M 23
002 78 202 M 34
003 62 99 F 37
004 61 101 F 45
;
RUN;
PROC CONTENTS DATA = work.demo_1;
RUN;
PROC PRINT DATA= demo_1;
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


DATA demo_3; *Problem-Second record won't be shown (will be fixed by adding @@ after age);
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
PROC PRINT DATA = demo_5;
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
FORMAT dob mmddyy10.;
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



DATA scores1;
LENGTH name $ 12;
INPUT name score1 score2;
DATALINES;
Riley 1132 1187
Henderson 1015 1102
;
RUN;
PROC PRINT DATA = Scores1; 
RUN;

/* Modified List Input 
A more flexible version of list input, called modified list input, includes format modifiers.
The : (colon) format modifier enables you to use list input but also to specify an informat after a variable name, 
whether character or numeric.
The ~ (tilde) format modifier enables you to read and retain single quotation marks, double quotation marks, 
and delimiters within character values. 
DSD: The following is an example of the : and ~ format modifiers. You must use the DSD option in the INFILE statement. 
Otherwise, the INPUT statement ignores the ~ format modifier. */

DATA scores2;
INFILE DATALINES DSD; * DSD stands for delimiter separated data;
INPUT Name : $9. Score1-Score3 Team ~ $25. Div $;
DATALINES;
Smith,12,22,46,"Green Hornets, Atlanta",AAA 
Mitchel,23,19,25,"High Volts, Portland",AAA 
Jones,09,17,54,"Vulcans, Las Vegas",AA 
;
PROC PRINT; RUN;


DATA scores3;
INFILE DATALINES DELIMITER = ","; 
INPUT name $ x y z;
DATALINES;
 "MM", 2.1,   2.2, 5.91
 F, 6.85, 3.44, 
  , 7.56, 6.57, 5.77
 "XOX", , , 10
 ;
PROC PRINT; RUN;

 
DATA scores4;
INFILE DATALINES DSD ; 
INPUT name $ x y z;
DATALINES;
 "MM", 2.1,   2.2, 5.91
 F, 6.85, 3.44, 
  , 7.56, 6.57, 5.77
   "XOX", , , 10
 ;
PROC PRINT; RUN;


/* Column Input */
DATA scores5;
INFILE DATALINES TRUNCOVER;
INPUT name $ 1-12 score2 17-20 score1 27-30;

CARDS;
Riley           1132       987
Henderson       1015      1102
;
PROC PRINT; RUN;


/* Formatted Input */
DATA scores6;
INPUT name $12. +4 score1 comma5. +6 score2 comma5.;

CARDS;
Riley           1,132      1,187
Henderson       1,015      1,102
;
PROC PRINT; RUN;




* Reading an external file;
DATA participants; 
INFILE 'C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\participant.csv' DLM= ',' FIRSTOBS=2;
LENGTH ID 6 Date $10 DOB $10 SEX $1;
INPUT ID  Date  DOB  SEX  PAID;
 *KEEP ID SEX PAID;
RUN;
PROC PRINT DATA=participants;
RUN;


DATA Gardener;
INFILE 'C:\Users\Administrator\Desktop\KatiSAS\Gardener.txt' DLM=',' FIRSTOBS=2;
INPUT Name $ Tomatos Zucchinis Peas Grapes;
Zone = 14;
Type = 'Home';
Total1 = Tomatos+Zucchinis+Peas+Grapes;
Total2 = SUM(Tomatos, Zucchinis, Peas, Grapes);
PerTom = (Tomatos/Total2)*100;
RUN;
PROC PRINT DATA=Gardener;
RUN;


*PROC IMPORT;
PROC IMPORT DATAFILE='C:\Users\Rayan\Desktop\Kati\Data Science\SASFile\participant.csv'
OUT = participants 
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
PROC PRINT DATA = participants NOOBS LABEL;
	VAR ID Sex DOB;
	LABEL DOB='Date of Birth';
RUN;

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
PROC SORT DATA = demo_1;
BY gender;
RUN;
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
TITLE;
FOOTNOTE;

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

PROC SORT DATA = test OUT=test_sorted NODUPKEY;
	BY DESCENDING id;
RUN;
PROC PRINT DATA = test_sorted;
RUN;

PROC SORT DATA = test OUT=test_2 NODUPKEY DUPOU = option;
	BY id;
RUN;
PROC PRINT DATA = test_2;
RUN;


DATA person;
   INFILE DATALINES DELIMITER = ','; 
   INPUT name $ dept $ salary;
   DATALINES;                      
John,Sales,33000
Mary,Accounting,35000
Raza,Accounting,37000
Stephanie,HR,28000
Mohammad,IT,45000
Rayan,Data,40000
Kati,Data,40000
;
RUN;
PROC PRINT DATA = person;
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
	12,,,6
; 
RUN;
PROC PRINT DATA = Special;
RUN;


*Arrays;

DATA arr_test1;
INPUT x1 x2 x3 x4 x5 x6 x7;
ARRAY f(7) X1 X2 X3 X4 X5 X6 X7;
DO i = 1 TO 7;
	IF f(i) = 9 THEN f(i) = .;
END;
DROP i;

DATALINES;
1 2 2 1 3 2 1
1 1 9 2 1 1 9
2 4 1 9 0 9 3
1 2 2 2 9 4 1
1 1 1 2 1 2 4
; 
RUN;


DATA arr_test2;
INPUT x1 - x7;
ARRAY X(*) X1 - X7;
DO i = 1 TO DIM(X);
	IF X(i) = 9 THEN X(i) = .;
END;
DROP i;
CARDS;
1 2 2 1 3 2 1
1 1 9 2 1 1 9
2 4 1 9 0 9 3
1 2 2 2 9 4 1
1 1 1 2 1 2 4
; 
RUN;


DATA arr_test3;
INPUT x1 - x7;
ARRAY X X1 - X7;
DO OVER X;
	IF X = 9 THEN X = .;
END;
CARDS;
1 2 2 1 3 2 1
1 1 9 2 1 1 9
2 4 1 9 0 9 3
1 2 2 2 9 4 1
1 1 1 2 1 2 4
; 
RUN;
